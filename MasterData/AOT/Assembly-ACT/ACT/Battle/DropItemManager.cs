using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.StateObject;
using Bamboo.AssetField;
using Bamboo.ECS;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;

namespace ACT.Battle;

public class DropItemManager : Singleton<DropItemManager>
{
	private struct CollectionDropRequest
	{
		public Vector3 dropPos;

		public ACT.World.StateObject.StateObjectType StateObjectType;

		public bool directGet;
	}

	private List<DropItemStaticNode> dropItemStaticNodes = new List<DropItemStaticNode>();

	public bool curDropFromHitDownMonster;

	public bool DropFromMonster;

	private const int _playerExpItemId = 93;

	private bool _dropEffectFlyOnleft;

	private HashSet<uint> m_DropPackageCache = new HashSet<uint>();

	private List<AssetLoadHandle> m_DropEffectsHandles = new List<AssetLoadHandle>();

	private DropItemAddNtf _curDropNtfData;

	private Dictionary<int, DropItemAddNtf> _collectionPendingNtfs = new Dictionary<int, DropItemAddNtf>();

	private Dictionary<int, CollectionDropRequest> _collectionPendingRequests = new Dictionary<int, CollectionDropRequest>();

	private Dictionary<int, Entity> m_DropItemEbs = new Dictionary<int, Entity>();

	private Dictionary<int, Vector3> m_DropPos = new Dictionary<int, Vector3>();

	private readonly List<int> _canNotSpawnEffectItemTypeList = new List<int> { 1, 19, 20, 22, 23 };

	private readonly List<int> _extraCanNotSpawnEffectItem = new List<int> { 2, 6, 93 };

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterHpHitDownToZero, OnMonsterDieChangeParam);
		foreach (KeyValuePair<int, YooAssetReference> monsterDropExtraEffect in GameLoader.meta.monsterDropExtraEffects)
		{
			PrecacheManager.Instance.Preload(monsterDropExtraEffect.Value.GUID);
		}
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterHpHitDownToZero, OnMonsterDieChangeParam);
	}

	public DropItemManager()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		worldManager.RegisterOnWorldChangedCallback(OnSceneChanged);
		worldManager.RegisterOnWorldReleaseCallback(OnSceneReleased);
	}

	private void OnSceneChanged(IConfigWorldPartition configWorld)
	{
		dropItemStaticNodes.ForEach((DropItemStaticNode x) =>
		{
			DropItemStaticNode.dropItemPool.Release(x);
		});
		dropItemStaticNodes.Clear();
		_collectionPendingNtfs.Clear();
		_collectionPendingRequests.Clear();
		m_DropPos.Clear();
	}

	private void OnSceneReleased(IConfigWorldPartition configWorld)
	{
		foreach (AssetLoadHandle dropEffectsHandle in m_DropEffectsHandles)
		{
			if (AssetLoadHandleExtensions.IsValid(dropEffectsHandle))
			{
				AssetStationManager.BattleStation.ReleaseInstance(dropEffectsHandle);
			}
		}
		m_DropEffectsHandles.Clear();
	}

	public DropItemStaticNode CreateDropItemNode(DropItem dropItem, int dropSourceUid, Bounds bounds)
	{
		DropItemStaticNode dropItemStaticNode = DropItemStaticNode.dropItemPool.Get();
		dropItemStaticNode.dropData = dropItem;
		dropItemStaticNode.dropSourceUid = dropSourceUid;
		dropItemStaticNodes.Add(dropItemStaticNode);
		Singleton<GameManager>.instance.worldManager.SceneNodeModule.AddRuntimeStaticNode(dropItemStaticNode);
		return dropItemStaticNode;
	}

	public void ReleaseDropItemNode(DropItemStaticNode node)
	{
		Singleton<GameManager>.instance.worldManager.SceneNodeModule.RemoveRuntimeStaticNode(node);
		dropItemStaticNodes.Remove(node);
		DropItemStaticNode.dropItemPool.Release(node);
	}

	public static async UniTask DropItem(DropItemAddNtf msg)
	{
		if (msg == null)
		{
			return;
		}
		List<int> autoPickList = ListPool<int>.Get();
		foreach (DropItem ditem in msg.Ditems)
		{
			if (RuntimeConfigs.data.itemDatas[ditem.ItemId].canAutoPick)
			{
				autoPickList.Add(ditem.Uid);
				continue;
			}
			int dropSourceUid = msg.DropSoureUid;
			Vector3 center = await Singleton<DropItemManager>.instance.GetDropPos(dropSourceUid);
			Singleton<DropItemManager>.instance.CreateDropItemNode(ditem, dropSourceUid, new Bounds(center, GameLoader.meta.dropNodeSize));
		}
		if (autoPickList.Count > 0)
		{
			G.service.GetDropItem(autoPickList, (DropItemPickItemAck x) =>
			{
			});
		}
		ListPool<int>.Release(autoPickList);
	}

	public async void DropEffect(DropItemAddNtf msg, uint playerId, ACT.World.StateObject.StateObjectType stateObjectType = ACT.World.StateObject.StateObjectType.None)
	{
		if (msg == null)
		{
			return;
		}
		bool flag = true;
		foreach (DropItem ditem in msg.Ditems)
		{
			if (ditem != null && IsCanSpawnDropEffectItem(ditem.ItemId))
			{
				int dropSoureUid = msg.DropSoureUid;
				Vector3 position = await GetDropPos(dropSoureUid);
				SpawnDropEffect(ditem.ItemId, msg.PackageId, position, playerId, stateObjectType);
				flag = false;
			}
		}
		if (flag)
		{
			PickupPackage(msg.PackageId, stateObjectType);
		}
	}

	public void PickupPackage(uint packageId, ACT.World.StateObject.StateObjectType stateObjectType = ACT.World.StateObject.StateObjectType.None)
	{
		if (!m_DropPackageCache.Contains(packageId))
		{
			return;
		}
		m_DropPackageCache.Remove(packageId);
		G.service.PickDropPack(packageId, (DropItemPickPackageAck _) =>
		{
			if (G.localPlayer.Maps.TryGetValue(_.Wid, out var value))
			{
				List<Item> list = Model<InventoryModel>.Interface.InventoryOverflowHandle(_.GotRewards).ToList();
				for (int num = list.Count - 1; num >= 0; num--)
				{
					if (list[num].Id == 93)
					{
						list.RemoveAt(num);
					}
				}
				PropPickingUtility.DispatchPropPickingEvt(list, (stateObjectType switch
				{
					ACT.World.StateObject.StateObjectType.SmallSupplyBox => true, 
					ACT.World.StateObject.StateObjectType.MediumSupplyBox => true, 
					ACT.World.StateObject.StateObjectType.LargeSupplyBox => true, 
					ACT.World.StateObject.StateObjectType.WildBossTreasureChest => true, 
					_ => false, 
				}) ? PropPickingWay.TreasureChest : PropPickingWay.Normal, stateObjectType);
				ListPool<Item>.Release(list);
				foreach (DropItemPickInfo dropRe in _.DropRes)
				{
					value.DropItems.Remove(dropRe.Uid);
				}
			}
		});
	}

	public void RequestCollectionDrop(int uid, Vector3 dropPos, int stateObjectType, bool directGet)
	{
		if (_collectionPendingNtfs.Remove(uid, out var value))
		{
			ExecuteCollectionDrop(value, dropPos, (ACT.World.StateObject.StateObjectType)stateObjectType, directGet);
			return;
		}
		_collectionPendingRequests[uid] = new CollectionDropRequest
		{
			dropPos = dropPos,
			StateObjectType = (ACT.World.StateObject.StateObjectType)stateObjectType,
			directGet = directGet
		};
	}

	private void ExecuteCollectionDrop(DropItemAddNtf ntf, Vector3 dropPos, ACT.World.StateObject.StateObjectType stateObjectType, bool directGet)
	{
		RegisterDropPos(ntf.DropSoureUid, dropPos);
		if (directGet)
		{
			PickupPackage(ntf.PackageId, stateObjectType);
		}
		else
		{
			DropEffect(ntf, 0u, stateObjectType);
		}
	}

	public void CleanupCollectionDrop(int uid)
	{
		_collectionPendingNtfs.Remove(uid);
		_collectionPendingRequests.Remove(uid);
		m_DropPos.Remove(uid);
	}

	public void RegisterDropPackage(DropItemAddNtf ntf)
	{
		_curDropNtfData = ntf;
		m_DropPackageCache.Add(ntf.PackageId);
		if (ntf.DropSoureUid != 0)
		{
			if (_collectionPendingRequests.Remove(ntf.DropSoureUid, out var value))
			{
				ExecuteCollectionDrop(ntf, value.dropPos, value.StateObjectType, value.directGet);
			}
			else
			{
				_collectionPendingNtfs[ntf.DropSoureUid] = ntf;
			}
		}
	}

	public void SpawnDropEffect(int itemId, uint packageId, Vector3 position, uint playerId, ACT.World.StateObject.StateObjectType stateObjectType = ACT.World.StateObject.StateObjectType.None, string addressPath = "")
	{
		AssetLoadHandle item = AssetStationManager.BattleStation.InstantiateAsync(GameLoader.meta.dropItemReferenceAssetID, position, default, (AssetLoadHandle result) =>
		{
			result.AsGameObject().GetComponent<DropEffect>().Init(itemId, packageId, playerId, () =>
			{
				m_DropEffectsHandles.Remove(result);
				AssetStationManager.BattleStation.ReleaseInstance(result);
				PickupPackage(packageId, stateObjectType);
			}, addressPath);
		});
		m_DropEffectsHandles.Add(item);
	}

	public Vector3 DropDir()
	{
		if (curDropFromHitDownMonster && DropFromMonster)
		{
			float num = Random.Range(GameLoader.meta.monsterDropControlRandomRotationRange.x, GameLoader.meta.monsterDropControlRandomRotationRange.y);
			Vector2 monsterDropHasDirVelocity = GameLoader.meta.monsterDropHasDirVelocity;
			return Quaternion.Euler(0f, 0f, num * (float)(_dropEffectFlyOnleft ? 1 : (-1))) * Vector3.up * Random.Range(monsterDropHasDirVelocity.x, monsterDropHasDirVelocity.y);
		}
		float x = Random.Range(0f - GameLoader.meta.dropControlRandomRotationRange.x, GameLoader.meta.dropControlRandomRotationRange.x);
		float y = Random.Range(0f - GameLoader.meta.dropControlRandomRotationRange.y, GameLoader.meta.dropControlRandomRotationRange.y);
		float z = Random.Range(0f - GameLoader.meta.dropControlRandomRotationRange.z, GameLoader.meta.dropControlRandomRotationRange.z);
		Vector2 vector = (DropFromMonster ? GameLoader.meta.monsterDropHasNoDirVelocity : GameLoader.meta.dropControlRandomVelocity);
		return Quaternion.Euler(x, y, z) * Vector3.up * Random.Range(vector.x, vector.y);
	}

	private void OnMonsterDieChangeParam(BaseEventContent obj)
	{
		if (obj is OnMonsterHpDownToZero onMonsterHpDownToZero)
		{
			_dropEffectFlyOnleft = onMonsterHpDownToZero.lastOnHitDirIsLeft;
		}
		curDropFromHitDownMonster = true;
	}

	public void RegisterDropPos(int dropSourceUid, Vector3 dropPos)
	{
		if (dropSourceUid != 0)
		{
			m_DropPos[dropSourceUid] = dropPos;
		}
	}

	public async UniTask<Vector3> GetDropPos(int dropSourceUid)
	{
		Vector3 value;
		while (!m_DropPos.TryGetValue(dropSourceUid, out value))
		{
			await UniTask.DelayFrame(10);
		}
		return value;
	}

	public Entity AddDropItem(DropItem dropItem)
	{
		Entity entity = GameManager.entities.factory.CreateStateEntity();
		if (!m_DropItemEbs.TryGetValue(dropItem.Uid, out var _))
		{
			m_DropItemEbs.Add(dropItem.Uid, entity);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("重复生成掉落物实体，动画帧事件GetOrDrop可能有重复的");
		}
		return entity;
	}

	public void RemoveDropItem(int uid)
	{
		m_DropItemEbs[uid].GetCompStateObject().StateObjectBase.ReleaseStateObject();
		MonoECS.instance.TryRemoveBehave(m_DropItemEbs[uid]);
		m_DropItemEbs.Remove(uid);
	}

	public void RemoveDropItems(DropItemPickItemAck ack)
	{
		for (int num = ack.DropRes.Count - 1; num >= 0; num--)
		{
			DropItemPickInfo dropItemPickInfo = ack.DropRes[num];
			if (dropItemPickInfo.Err != PickErr.PickBagFullErr)
			{
				RemoveDropItem(dropItemPickInfo.Uid);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("背包满了？？？");
			}
		}
	}

	public void MonsterDropExtraEffect(Entity monsterEb, DropItemAddNtf msg)
	{
		if (!monsterEb.IsValid)
		{
			return;
		}
		Dictionary<int, ItemData> itemData = RuntimeConfigs.data.itemDatas;
		DropItem dropItem = msg.Ditems.Aggregate(msg.Ditems.First(), (DropItem max, DropItem next) => (itemData[next.ItemId].quality <= itemData[max.ItemId].quality) ? max : next);
		if (dropItem == null || !IsCanSpawnDropEffectItem(dropItem.ItemId))
		{
			return;
		}
		int quality = itemData[dropItem.ItemId].quality;
		if (!GameLoader.meta.monsterDropExtraEffects.TryGetValue(quality, out var value))
		{
			return;
		}
		Vector3 effectPosition = monsterEb.GetBip001()?.position ?? monsterEb.GetRootTransform().position;
		PrecacheManager.Instance.GetInstanceHandle(value.GUID).Completed += async (InstanceHandle handle) =>
		{
			handle.Result.transform.position = effectPosition;
			ParticleSystem particleSystem = handle.Result.GetComponent<ParticleSystem>();
			if (!(particleSystem == null))
			{
				particleSystem.Play();
				await UniTask.WaitForSeconds(particleSystem.main.duration);
				particleSystem.Stop();
				PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			}
		};
	}

	private bool IsCanSpawnDropEffectItem(int itemId)
	{
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return false;
		}
		int type = data.type;
		if (!_canNotSpawnEffectItemTypeList.Contains(type))
		{
			return !_extraCanNotSpawnEffectItem.Contains(itemId);
		}
		return false;
	}
}
