#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase.ECS;

public class DropSystem : BaseSystem
{
	public class DropInfo
	{
		public int dropItemId;

		public long dropCount;

		public int dropType;

		public int dropItemTpye;

		public long Uuid;
	}

	public class DropGoodEffectData
	{
		public int dropEffectId;

		public int targetEntityId;

		public string targetPointName;

		public DropInfo dropInfo;

		public DropInfo DropInfo => dropInfo;

		public static DropGoodEffectData CreateDropGoodEffect(int dropEffectId, int targetEntityId, string targetPointName, DropInfo dropInfo = null)
		{
			return new DropGoodEffectData
			{
				dropEffectId = dropEffectId,
				targetEntityId = targetEntityId,
				targetPointName = targetPointName,
				dropInfo = dropInfo
			};
		}
	}

	private List<GameObject> dropGoods = new List<GameObject>();

	protected override bool IsLogicSystem => false;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
	}

	public void SendDropNotify(List<DropGoodEffectData> dropGoodEffectDatas)
	{
		foreach (DropGoodEffectData dropGoodEffectData in dropGoodEffectDatas)
		{
			Context.GetApplicationContext().GetService<IMessenger>().Publish("DropMessageInfoChannel", dropGoodEffectData.DropInfo);
		}
	}

	public async void CreateDrop(int entityId, string boneKeyName, List<DropGoodEffectData> dropGoodEffectDatas, Vector3 bornPosition, Vector3 bornRotation)
	{
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(entityId);
		if (entity == null)
		{
			return;
		}
		Transform transform = entity.GetComponent<EntityBoneComponent>()?.GetBoneRoot(boneKeyName);
		float y;
		if (transform == null)
		{
			y = entity.transform.position.y;
			transform = entity.GetComponent<EntityViewComponent>().EntityView.transform;
		}
		else
		{
			y = transform.transform.position.y;
		}
		foreach (DropGoodEffectData dropGoodEffectData in dropGoodEffectDatas)
		{
			if (GetSystem<EntitySystem>().GetEntity(dropGoodEffectData.targetEntityId) != null)
			{
				DropGood dropGood = new GameObject().AddComponent<DropGood>();
				dropGood.transform.position = bornPosition;
				dropGood.transform.rotation = Quaternion.Euler(bornRotation);
				dropGood.Init(dropGoodEffectData, transform, y, OnDropEnd);
				dropGood.LoadEffect();
				dropGoods.Add(dropGood.gameObject);
			}
		}
	}

	private void OnDropEnd(object sender, DropGoodEffectData effectData)
	{
		if (effectData != null)
		{
			GameObject gameObject = (GameObject)sender;
			Context.GetApplicationContext().GetService<IMessenger>().Publish("DropMessageInfoChannel", effectData.DropInfo);
			dropGoods.Remove(gameObject);
			gameObject.GetComponent<DropGood>().DestroySelf();
		}
	}

	public async Task<(List<DropGoodEffectData>, int)> RequestCollectionDrop(int itemId, int dropItemType, int mapId, int mapItemUId)
	{
		List<DropGoodEffectData> result = new List<DropGoodEffectData>();
		C2H_GetDropGoodsRequest request = C2H_GetDropGoodsRequest.Create();
		request.ItemId = itemId;
		request.DropItemType = dropItemType;
		request.MapId = mapId;
		request.ChestUid = mapItemUId;
		H2C_GetDropGoodsResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetDropGoodsResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取掉落物", "获取掉落物失败"))
			{
				ApplyRoleDataChange(response.Roles.ToList());
				List<DropGoodEffectData> list = CreateDropEffectList(response.Drops);
				if (list != null)
				{
					result.AddRange(list);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("请求采集错误：" + ex.ToString());
			result = null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return (result, response?.Error ?? 0);
	}

	public async Task<List<DropGoodEffectData>> RequestKillMonsterDrop(int monsterId, int level)
	{
		List<DropGoodEffectData> result = new List<DropGoodEffectData>();
		List<int> list = new List<int>();
		foreach (HeroEntity item in GetSystem<EntitySystem>().GetTeamHero())
		{
			list.Add(item.GetHeroConfigId());
		}
		C2S_KillMonsterDropRequest request = C2S_KillMonsterDropRequest.Create();
		request.MonsterId = monsterId;
		request.MonsterLevel = level;
		request.RoleIds = list;
		S2C_KillMonsterDropResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_KillMonsterDropResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "怪物掉落", "怪物掉落失败"))
			{
				ApplyRoleDataChange(response.Roles.ToList());
				result.AddRange(CreateDropEffectList(response.Drops));
			}
		}
		catch (Exception)
		{
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return result;
	}

	private void ApplyRoleDataChange(List<PbNormalRoleInfo> roleChangeDatas)
	{
		if (roleChangeDatas == null)
		{
			return;
		}
		for (int i = 0; i < roleChangeDatas.Count; i++)
		{
			PbNormalRoleInfo pbNormalRoleInfo = roleChangeDatas[i];
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(pbNormalRoleInfo.RoleId);
			if (pbNormalRoleInfo.Exp == heroById.Exp)
			{
				_ = pbNormalRoleInfo.Level;
				_ = heroById.Level;
			}
			if (pbNormalRoleInfo.Exp != heroById.Exp)
			{
				heroById.Exp = pbNormalRoleInfo.Exp;
			}
			if (pbNormalRoleInfo.Level != heroById.Level)
			{
				heroById.Level = pbNormalRoleInfo.Level;
				heroById.RefreshBattleProperty();
			}
		}
	}

	private List<DropGoodEffectData> CreateDropEffectList(PbDropThing dropThing)
	{
		if (dropThing == null)
		{
			return null;
		}
		List<PbItemBase> items = dropThing.Items;
		List<PbEquipBase> equips = dropThing.Equips;
		List<DropGoodEffectData> list = new List<DropGoodEffectData>();
		List<PbItemBase>.Enumerator enumerator = items.GetEnumerator();
		while (enumerator.MoveNext())
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(enumerator.Current.ItemId);
			if (dataRow != null && enumerator.Current.ItemCount != 0L)
			{
				KnapsackPropData knapsackPropData = new KnapsackPropData(dataRow, (int)enumerator.Current.ItemCount);
				if (knapsackPropData.IsKnapsackType())
				{
					Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.AddProp(knapsackPropData);
				}
				else if (Enum.IsDefined(typeof(RoleMoneyEnum), knapsackPropData.Id))
				{
					MoneyDefinition.AddMoney((RoleMoneyEnum)knapsackPropData.Id, knapsackPropData.Amount);
				}
				if (dataRow.DropId != 0)
				{
					DropInfo dropInfo = new DropInfo
					{
						dropItemId = enumerator.Current.ItemId,
						dropItemTpye = 0,
						dropType = enumerator.Current.ItemType,
						dropCount = enumerator.Current.ItemCount
					};
					list.Add(DropGoodEffectData.CreateDropGoodEffect(dataRow.DropId, world.ActorId, "middle", dropInfo));
				}
			}
		}
		enumerator.Dispose();
		List<PbEquipBase>.Enumerator enumerator2 = equips.GetEnumerator();
		while (enumerator2.MoveNext())
		{
			if (enumerator2.Current.Type == 2 && enumerator2.Current.Count != 0L)
			{
				Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>()?.AddArmour(enumerator2.Current);
				DREquipment dataRow2 = GameEntry.DataTable.GetDataRow<DREquipment>(enumerator2.Current.EquipId);
				if (dataRow2.DropId == 0)
				{
					continue;
				}
				DropInfo dropInfo2 = new DropInfo
				{
					dropItemId = enumerator2.Current.EquipId,
					dropItemTpye = 1,
					dropType = enumerator2.Current.Type,
					dropCount = enumerator2.Current.Count,
					Uuid = enumerator2.Current.Uuid
				};
				list.Add(DropGoodEffectData.CreateDropGoodEffect(dataRow2.DropId, world.ActorId, "middle", dropInfo2));
			}
			if (enumerator2.Current.Type == 5)
			{
				Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>()?.AddWeapon(enumerator2.Current);
				DRWeapon dataRow3 = GameEntry.DataTable.GetDataRow<DRWeapon>(enumerator2.Current.EquipId);
				if (dataRow3.DropId != 0)
				{
					DropInfo dropInfo3 = new DropInfo
					{
						dropItemId = enumerator2.Current.EquipId,
						dropItemTpye = 1,
						dropType = enumerator2.Current.Type,
						dropCount = enumerator2.Current.Count,
						Uuid = enumerator2.Current.Uuid
					};
					list.Add(DropGoodEffectData.CreateDropGoodEffect(dataRow3.DropId, world.ActorId, "middle", dropInfo3));
				}
			}
		}
		enumerator2.Dispose();
		return list;
	}

	public async void DropCollection(int entityId, string boneKeyName, int collectionId, Vector3 bornPosition, Vector3 bornRotation, int mapId, int mapItemUId)
	{
		DRCollectionDrops dataRow = GameEntry.DataTable.GetDataRow<DRCollectionDrops>(collectionId);
		if (dataRow != null && dataRow.GroupId != null && dataRow.GroupId.Count != 0)
		{
			List<DropGoodEffectData> item = (await RequestCollectionDrop(collectionId, dataRow.Type, mapId, mapItemUId)).Item1;
			CreateDrop(entityId, boneKeyName, item, bornPosition, bornRotation);
		}
	}

	public async Task<(bool, int)> DropCollectionTask(int entityId, string boneKeyName, int collectionId, Vector3 bornPosition, Vector3 bornRotation, int mapId, int mapItemUId, bool openDropPerformance = true)
	{
		DRCollectionDrops dataRow = GameEntry.DataTable.GetDataRow<DRCollectionDrops>(collectionId);
		if (dataRow == null)
		{
			return (false, 0);
		}
		if (dataRow.GroupId == null || dataRow.GroupId.Count == 0)
		{
			return (false, 0);
		}
		(List<DropGoodEffectData>, int) tuple = await RequestCollectionDrop(collectionId, dataRow.Type, mapId, mapItemUId);
		var (list, _) = tuple;
		if (list == null)
		{
			return (false, tuple.Item2);
		}
		if (openDropPerformance)
		{
			CreateDrop(entityId, boneKeyName, list, bornPosition, bornRotation);
		}
		else
		{
			SendDropNotify(list);
		}
		return (true, tuple.Item2);
	}

	public async UniTask<List<DropGoodEffectData>> DropMonster(int entityId, string boneKeyName, int monsterId, int rank, int levelId, Vector3 bornPosition, Vector3 bornRotation)
	{
		DRMonsterDrops dataRow = GameEntry.DataTable.GetDataRow((DRMonsterDrops dt) => dt.MonsterId == monsterId && dt.Rank.Contains(rank));
		if (dataRow == null)
		{
			return null;
		}
		if (dataRow.GroupId.Count == 0 || dataRow.Rank.Count != dataRow.GroupId.Count)
		{
			return null;
		}
		List<DropGoodEffectData> list = await RequestKillMonsterDrop(monsterId, levelId);
		CreateDrop(entityId, boneKeyName, list, bornPosition, bornRotation);
		return list;
	}
}
