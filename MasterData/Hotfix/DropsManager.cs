using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using PathologicalGames;
using TrueSync;
using UnityEngine;

public class DropsManager : SceneSingleton<DropsManager>
{
	private Dictionary<HotfixEnum.dropEntityType, FP> DicAdsorptionChange = new Dictionary<HotfixEnum.dropEntityType, FP>();

	public List<DropEntity> _dropsList = new List<DropEntity>();

	private Dictionary<string, string> _dropObjectName = new Dictionary<string, string>();

	protected override void Awake()
	{
		base.Awake();
		_dropsList.Clear();
		_dropObjectName.Clear();
	}

	public long PlayDrops(AdventureActor owner, GameObject dropPrefab, TSVector2 spawnPos = default(TSVector2), FP posY = default(FP))
	{
		if (dropPrefab.TryGetComponent<DropEntity>(out var dropEntityConfig))
		{
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle
			};
			float num = 0f;
			if (dropEntityConfig.isColliderAdaptive && owner != null)
			{
				DeterministicCollider logicComponent = owner.GetLogicComponent<DeterministicCollider>();
				if (logicComponent == null)
				{
					num = (float)logicComponent.Radius;
				}
			}
			TSVector2 zero = TSVector2.zero;
			shape.radius = (dropEntityConfig.isColliderAdaptive ? (dropEntityConfig.maxDropDis + num) : dropEntityConfig.maxDropDis);
			shape.innerRadius = (dropEntityConfig.isColliderAdaptive ? num : dropEntityConfig.minDropDis);
			if (spawnPos != TSVector2.zero)
			{
				shape.position = spawnPos;
				zero = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor).RandomActorReachablePointInsideShape(shape, 30);
			}
			else
			{
				shape.position = owner.tsTransform.Position;
				zero = owner.RandomActorReachablePointInsideShape(shape, 30);
			}
			if (zero != shape.position)
			{
				return Drop(zero);
			}
			if (owner.QueryClosestPositionWalkable(spawnPos, out var result))
			{
				return Drop(result);
			}
			Debug.Log("掉落物没有找到可用位置:" + dropPrefab.name);
		}
		else
		{
			Debug.LogError("未找到掉落物组件,预制体名称:" + dropPrefab.name);
		}
		return 0L;
		long Drop(TSVector2 dropPos)
		{
			if (CheckMaxCount(dropPrefab.name, dropEntityConfig.sameMaxCount))
			{
				Vector3 zero2 = Vector3.zero;
				Quaternion spawnRotation = Quaternion.identity;
				if (spawnPos != default(TSVector2))
				{
					zero2 = new Vector3((float)dropPos.x, (float)posY, (float)dropPos.y);
				}
				else
				{
					zero2 = new Vector3((float)dropPos.x, (float)owner.tsTransform.PositionY, (float)dropPos.y);
					spawnRotation = Quaternion.Euler(0f, 0f - (float)owner.tsTransform.Forward.GetAngle(), 0f);
				}
				Vector3 spawnPosition = zero2;
				if (dropEntityConfig.dbShow == DropEntity.DropBornShow.popUp)
				{
					spawnPosition = ((!(spawnPos != default(TSVector2))) ? new Vector3((float)owner.tsTransform.Position.x, (float)owner.tsTransform.PositionY + 2f, (float)owner.tsTransform.Position.y) : new Vector3((float)spawnPos.x, (float)posY + 2f, (float)spawnPos.y));
				}
				DropEntity dropEntity = Spawn(dropPrefab, spawnPosition, spawnRotation);
				dropEntity.Setup(owner, dropPrefab.name, zero2);
				return dropEntity.Id;
			}
			return 0L;
		}
	}

	public long PlayDropsByDropId(AdventureActor owner, int dropId, TSVector2 spawnPos = default(TSVector2), FP posY = default(FP))
	{
		DropObject dropObject = Singleton<HotfixDataController>.Instance.GetDropObject(dropId);
		if (dropObject != null)
		{
			string assetName = "Assets/AssetBundles/" + dropObject.DropObjectRes + ".prefab";
			GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			if (gameObject != null)
			{
				return PlayDrops(owner, gameObject, spawnPos, posY);
			}
		}
		return 0L;
	}

	public long PlayDropsVampire(AdventureActor owner, int dropId, Vector3 spawnPos, int expValue = 0, int specialType = 0, int dropWave = 0)
	{
		DropObject dropObject = Singleton<HotfixDataController>.Instance.GetDropObject(dropId);
		if (dropObject != null)
		{
			bool flag = false;
			if (expValue != 0)
			{
				for (int i = 0; i < _dropsList.Count; i++)
				{
					if (_dropsList.get_Item(i).isVampireExp() && (double)Vector3.Distance(spawnPos, _dropsList.get_Item(i).transform.position) < 0.5)
					{
						flag = true;
						_dropsList.get_Item(i).AddExperienceVal(expValue);
						break;
					}
				}
			}
			if (!flag)
			{
				string value = "";
				if (!_dropObjectName.TryGetValue(dropObject.DropObjectRes, out value))
				{
					value = dropObject.DropObjectRes.Substring(dropObject.DropObjectRes.LastIndexOf('/') + 1);
					_dropObjectName.set_Item(dropObject.DropObjectRes, value);
				}
				if (!CheckMaxCountDontRemove(value))
				{
					string assetName = "Assets/AssetBundles/" + dropObject.DropObjectRes + ".prefab";
					GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
					if (gameObject != null && gameObject.TryGetComponent<DropEntity>(out var component) && component.doType == DropEntity.DropObjType.vampire)
					{
						DropEntity dropEntity = Spawn(gameObject, spawnPos, Quaternion.identity);
						if (expValue != 0)
						{
							dropEntity.SetExperienceVal(expValue);
						}
						if (dropWave != 0)
						{
							dropEntity.SetDropWave(specialType, dropWave);
						}
						dropEntity.Setup(owner, gameObject.name, spawnPos);
						return dropEntity.Id;
					}
				}
			}
		}
		return 0L;
	}

	public DropEntity PlayBrickDrop(int dropId, TSVector2 spawnPos, FP posY = default(FP))
	{
		DropObject dropObject = Singleton<HotfixDataController>.Instance.GetDropObject(dropId);
		if (dropObject != null)
		{
			string assetName = "Assets/AssetBundles/" + dropObject.DropObjectRes + ".prefab";
			GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			if (gameObject != null && gameObject.TryGetComponent<DropEntity>(out var component) && CheckMaxCount(gameObject.name, component.sameMaxCount))
			{
				Vector3 vector = new Vector3((float)spawnPos.x, (float)posY, (float)spawnPos.y);
				Quaternion identity = Quaternion.identity;
				DropEntity dropEntity = Spawn(gameObject, vector, identity);
				dropEntity.Setup(null, gameObject.name, vector);
				return dropEntity;
			}
		}
		return null;
	}

	private bool CheckMaxCount(string prefabName, int maxCount)
	{
		if (GetDropsByPrefabName(prefabName).Count >= maxCount)
		{
			_dropsList.First((DropEntity x) => string.Equals(x.prefabName, prefabName)).Finish();
			return true;
		}
		return true;
	}

	private bool CheckMaxCountDontRemove(string prefabName)
	{
		int num = 9999;
		List<DropEntity> dropsByPrefabName = GetDropsByPrefabName(prefabName);
		if (dropsByPrefabName.Count > 0)
		{
			num = dropsByPrefabName.get_Item(0).sameMaxCount;
		}
		if (dropsByPrefabName.Count >= num)
		{
			return true;
		}
		return false;
	}

	private List<DropEntity> GetDropsByPrefabName(string Name)
	{
		return _dropsList.FindAll((DropEntity x) => string.Equals(x.prefabName, Name));
	}

	public List<DropEntity> GetAllDrops()
	{
		return _dropsList;
	}

	public DropEntity GetDropsEntity(long id)
	{
		if (id <= 0)
		{
			return null;
		}
		return _dropsList.Find((DropEntity x) => x.Id == id);
	}

	public List<DropEntity> GetDropsByTag(string tag)
	{
		if (tag == null)
		{
			return null;
		}
		return _dropsList.FindAll((DropEntity x) => string.Equals(x.dropTag, tag));
	}

	public void StopDropsById(long id)
	{
		if (id > 0)
		{
			DropEntity dropEntity = _dropsList.Find((DropEntity x) => x.Id == id);
			if (dropEntity != null)
			{
				dropEntity.Finish();
			}
		}
	}

	public void StopDropsByTag(string tag)
	{
		if (tag != null)
		{
			List<DropEntity> list = _dropsList.FindAll((DropEntity x) => string.CompareOrdinal(x.dropTag, tag) == 0);
			for (int num = 0; num < list.Count; num++)
			{
				list.get_Item(num).Finish();
			}
		}
	}

	public void StopAllDrops()
	{
		for (int i = 0; i < _dropsList.Count; i++)
		{
			_dropsList.get_Item(i).Finish();
		}
	}

	protected DropEntity Spawn(GameObject fxPrefab, Vector3 spawnPosition, Quaternion spawnRotation)
	{
		SpawnPool spawnPool = PoolManager.Pools.get_Item("Effect");
		Transform transform = ((!(spawnPool != null)) ? Object.Instantiate(fxPrefab, spawnPosition, spawnRotation).transform : spawnPool.Spawn(fxPrefab.transform, spawnPosition, spawnRotation));
		transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Effect"));
		if (transform.TryGetComponent<DropEntity>(out var component))
		{
			_dropsList.Add(component);
			return component;
		}
		spawnPool.Despawn(transform, spawnPool.group);
		return null;
	}

	public void Despawn(DropEntity entity)
	{
		_dropsList.Remove(entity);
		if (PoolManager.Pools.TryGetValue("Effect", out var spawnPool))
		{
			spawnPool.Despawn(entity.transform, spawnPool.group);
		}
	}

	protected void Update()
	{
		if (_dropsList.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _dropsList.Count; i++)
		{
			DropEntity dropEntity = _dropsList.get_Item(i);
			if (dropEntity.isBornEnd && dropEntity.isDelayAdsorptionEnd && !dropEntity.isCanFlyToActor && dropEntity.CheckTargetDistance(out var target))
			{
				dropEntity.SetFlyToActor(target);
			}
		}
	}

	public void DropsAllFlyToActor()
	{
		if (_dropsList.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _dropsList.Count; i++)
		{
			DropEntity dropEntity = _dropsList.get_Item(i);
			if (dropEntity.isBornEnd && dropEntity.isDelayAdsorptionEnd && !dropEntity.isCanFlyToActor)
			{
				dropEntity.SetFlyToActor(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor);
			}
			else
			{
				dropEntity.adsorptionRangeFP = 10000;
			}
		}
	}

	public int GetDropChestCount()
	{
		int num = 0;
		if (_dropsList.Count > 0)
		{
			for (int i = 0; i < _dropsList.Count; i++)
			{
				DropEntity dropEntity = _dropsList.get_Item(i);
				if (dropEntity.doType == DropEntity.DropObjType.vampire && dropEntity.GetDropEntityType() == HotfixEnum.dropEntityType.VampireBox)
				{
					num++;
				}
			}
		}
		return num;
	}

	public void DropsClear()
	{
		for (int num = _dropsList.Count - 1; num >= 0; num--)
		{
			DropEntity entity = _dropsList.get_Item(num);
			Despawn(entity);
		}
		_dropsList.Clear();
	}

	public void SetAdsorptionChangeValue(HotfixEnum.dropEntityType type, FP value)
	{
		DicAdsorptionChange.set_Item(type, GetAdsorptionChangeValue(type) + value);
		AdventureLevelDropAdsorptionChangeMsgEvent adventureLevelDropAdsorptionChangeMsgEvent = AdventureLevelDropAdsorptionChangeMsgEvent.Generate();
		adventureLevelDropAdsorptionChangeMsgEvent.dropType = type;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelDropAdsorptionChangeMsgEvent);
	}

	public FP GetAdsorptionChangeValue(HotfixEnum.dropEntityType type)
	{
		if (DicAdsorptionChange.TryGetValue(type, out var value))
		{
			return value;
		}
		return FP.Zero;
	}
}
