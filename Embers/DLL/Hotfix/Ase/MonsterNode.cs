#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class MonsterNode : BaseMapDataNode
{
	public int monsterConfigId;

	public int monsterAttackCtrlId;

	public bool dropConfig = true;

	public bool openAnimation;

	public bool FirstHitShowHpBar;

	public bool HalfBloodTeachGuide;

	public bool FirstShowWeak;

	public bool FirstShowHpBar;

	private List<int> calledMonsterIds = new List<int>();

	private MonsterGroup monsterGroup;

	private bool isBoss;

	private bool openBloodBar;

	private Vector3 deadDropPos;

	private Vector3 deadDropRotation;

	private MonsterNodeLife _monsterNodeLife;

	public MonsterNodeLife MonsterNodeLife => _monsterNodeLife;

	public bool CheckMonsterState(MapDataNodeState monsterState)
	{
		return mapDataNodeState == monsterState;
	}

	public override void OnInited(object data = null)
	{
		calledMonsterIds = new List<int>();
	}

	public override void OnDisposed()
	{
		AddEntityToSystemRelease(isLevelReset: false);
		ReleaseCalledMonster();
	}

	protected override bool CheckLoadingCondition()
	{
		if (base.isKilled || !base.TaskConditionResult || !monsterGroup.Active || entity != null)
		{
			return false;
		}
		return true;
	}

	public override void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		base.OnReceiveMapDataEvent(eventType, otherEntity);
		if (eventType == LevelMapDataEvent.RestLevel)
		{
			OnRestLevel();
		}
	}

	public void OnRestLevel()
	{
		ReleaseCalledMonster();
		if (mapDataNodeState != MapDataNodeState.DeadNoRelease)
		{
			if (mapDataNodeState == MapDataNodeState.Dead)
			{
				mapDataNodeState = MapDataNodeState.DeadNoRelease;
				return;
			}
			AddEntityToSystemRelease(isLevelReset: true);
			_monsterNodeLife = MonsterNodeLife.None;
		}
	}

	public void ReleaseMonster()
	{
		AddEntityToSystemRelease(isLevelReset: false);
		ReleaseCalledMonster();
	}

	private void SetTeachData()
	{
		if (FirstHitShowHpBar)
		{
			entity.SetData("TEACHOBSERVER", FirstHitShowHpBar);
		}
		if (HalfBloodTeachGuide)
		{
			entity.SetData("TEACHHALFBLOOD", HalfBloodTeachGuide);
		}
		if (FirstShowWeak)
		{
			entity.SetData("TEACHSHOWWEAK", FirstShowWeak);
		}
		if (FirstShowHpBar)
		{
			entity.GetSystem<BattleSystem>().OpenTeachShowHp();
		}
	}

	public void BindMonsterGroup(MonsterGroup monsterGroup)
	{
		this.monsterGroup = monsterGroup;
	}

	public void AddCallMonster(int monsterEntityId)
	{
		if (!calledMonsterIds.Contains(monsterEntityId))
		{
			calledMonsterIds.Add(monsterEntityId);
		}
	}

	private void ReleaseCalledMonster()
	{
		List<int>.Enumerator enumerator = calledMonsterIds.GetEnumerator();
		while (enumerator.MoveNext())
		{
			BaseEntity baseEntity = base.World.GetSystem<EntitySystem>().GetEntity(enumerator.Current);
			if (baseEntity != null && baseEntity.IsSurvival)
			{
				baseEntity.DoEntityRelease();
			}
		}
		enumerator.Dispose();
		calledMonsterIds.Clear();
	}

	public float GetAlertAreaRange()
	{
		return monsterGroup?.GetAlertAreaRange() ?? 0f;
	}

	public float GetActivityAreaRange()
	{
		return monsterGroup?.GetActivityAreaRange() ?? 0f;
	}

	public void KillMonsterSelf()
	{
		if (base.isCreating)
		{
			if (!base.isKilled)
			{
				mapDataNodeState = MapDataNodeState.Dead;
			}
			IsNeedDestory = true;
			return;
		}
		if (entity != null && (entity.IsStandby || entity.IsSurvival))
		{
			entity.DoEntityRelease();
		}
		entity = null;
		if (!base.isKilled)
		{
			mapDataNodeState = MapDataNodeState.Dead;
		}
		ReleaseCalledMonster();
	}

	public void OpenBossBloodBar(bool value)
	{
		if (isBoss)
		{
			openBloodBar = true;
		}
	}

	public float? GetProperty(string propertyKey)
	{
		if (entity != null)
		{
			return entity.GetProperty(propertyKey);
		}
		return null;
	}

	public void ChangeNorlmalProperty(string propertykey, float propertyValue)
	{
		if (entity != null)
		{
			entity.SetProperty(propertykey, propertyValue);
		}
	}

	public void ChangePropertyMax(string propertykey, float propertyValue)
	{
		if (entity != null)
		{
			entity.SetPropertyMax(propertykey, propertyValue);
		}
	}

	public void OnReBorn()
	{
		AddEntityToSystemRelease(isLevelReset: false);
		ReleaseCalledMonster();
	}

	public void ForceBattleStart()
	{
		if (entity != null)
		{
			entity.GetSystem<BattleStateSystem>().ForceBattleMonsterHandle(entity);
		}
	}

	private async Task<BaseEntity> LoadMonster()
	{
		if (IsNeedDestory)
		{
			IsNeedDestory = false;
		}
		if (mapDataNodeState == MapDataNodeState.Summoning)
		{
			return null;
		}
		if (mapDataNodeState == MapDataNodeState.Destorying)
		{
			IsNeedCreate = true;
			return null;
		}
		if (base.SaveNode)
		{
			long monsterLastDieTime = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMonsterLastDieTime(sceneSystem.GetLevelId(), base.Uid);
			if (monsterLastDieTime != 0L)
			{
				DateTime dateTime = TimeHelper.GetDateTimeSeconds(monsterLastDieTime).ToLocalTime();
				DateTime dateTime2 = TimeHelper.GetDateTimeSeconds(TimeHelper.ClientNowSeconds()).ToLocalTime();
				if (dateTime.Date == dateTime2.Date)
				{
					return null;
				}
			}
		}
		if (monsterConfigId != 0)
		{
			DRMonsterAttr drMonsterAttr = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterConfigId);
			if (drMonsterAttr == null)
			{
				Log.Error($"没有找到怪物ID = {monsterConfigId}的怪物配置..");
				return null;
			}
			DRMonster drMonster = GameEntry.DataTable.GetDataRow<DRMonster>(drMonsterAttr.MonsterType);
			if (drMonster == null)
			{
				Log.Error($"没有找到怪物种类 {drMonsterAttr.MonsterType} 的怪物配置..");
				return null;
			}
			mapDataNodeState = MapDataNodeState.Summoning;
			if (!(await sceneSystem.GetSystem<ParadoxSystem>().PreLoadParadoxGraph(drMonster.AIParadoxId)))
			{
				mapDataNodeState = MapDataNodeState.Unsummoned;
				return null;
			}
			isBoss = drMonster.IsBoss;
			GameObject entityObject = await LoadEntityView(drMonster.Id, drMonster.AssetPath);
			entity = CreateMonsterEntity(drMonster.Id, entityObject, callbacks, drMonster.IsBoss, drMonster, drMonsterAttr);
			if (base.isInitState)
			{
				OnDispose();
				return null;
			}
			SetTeachData();
			entity.SetData(MonsterGroup.MONSTERGROUP_KEY, monsterGroup);
			entity.SetData(MonsterGroup.MONSTERNODE_KEY, this);
		}
		if (monsterGroup.ForceBattle)
		{
			entity.GetSystem<BattleStateSystem>().ForceBattleMonsterHandle(entity);
		}
		return entity;
	}

	protected MonsterEntity CreateMonsterEntity(int entityId, GameObject entityObject, EntityCallbacks callbacks, bool isBoss, object userData, object userDataPam)
	{
		return base.World.GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(entityId, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)(object)this).transform.position,
				scale = entityObject.transform.localScale,
				rotation = ((Component)(object)this).transform.eulerAngles
			},
			callbacks = callbacks,
			entityObject = entityObject,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			collisionLayer = (isBoss ? CollisionSetting.CollisionLayer.Boss : CollisionSetting.CollisionLayer.Monster),
			collisionMass = 2,
			userData = userData,
			userDataPam = userDataPam,
			campType = CampType.Monster
		});
	}

	protected override void OnForceLoadNode()
	{
		base.OnForceLoadNode();
		LoadMonster();
	}

	protected override void OnLoadNode()
	{
		base.OnLoadNode();
		LoadMonster();
	}

	public override void OnUnLoadNode()
	{
		base.OnUnLoadNode();
		ReleaseMonster();
	}

	protected override void OnEntityCreated()
	{
		if (!((UnityEngine.Object)(object)monsterGroup == null))
		{
			if (isBoss)
			{
				sceneSystem.OnBossCreate();
				DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterConfigId);
				sceneSystem.GetSystem<BattleSystem>().SetBattleTimeConfig(dataRow.BattleDuration);
			}
			SetParadoxMessage(MonsterGroup.LOW_MONSTER_ALERTRANGE_KEY, MapDataNodeParadoxParameter.CreateFloatParameter(monsterGroup.GetAlertAreaRange()));
			SetParadoxMessage(MonsterGroup.LOW_MONSTER_HAVEALERT_KEY, MapDataNodeParadoxParameter.CreateBoolParameter(monsterGroup.GetAlertAreaRange() > 0f));
			SetParadoxMessage(MonsterGroup.LOW_MONSTER_BORNANIMATION_KEY, MapDataNodeParadoxParameter.CreateBoolParameter(openAnimation));
			SetParadoxMessage("s_bornPos", MapDataNodeParadoxParameter.CreateVector3Parameter(((Component)(object)this).transform.position));
			mapDataNodeState = MapDataNodeState.Summoned;
			_monsterNodeLife = MonsterNodeLife.Created;
			monsterGroup.OnEntityCreated();
		}
	}

	protected override void OnEntityStart()
	{
		base.OnEntityStart();
		WorldBase world = sceneSystem.GetWorld();
		if (world != null && sceneSystem != null && world.IsSoftPaused && entity != null)
		{
			entity.GetComponent<StateComponent>()?.AddState(4001, entity.Id);
		}
	}

	protected override void OnEntityDead(bool isNormal)
	{
		if (dropConfig)
		{
			int playerRank = sceneSystem.GetPlayerRank();
			deadDropPos = ((Component)(object)this).transform.position;
			deadDropRotation = ((Component)(object)this).transform.rotation.eulerAngles;
			if (entity != null)
			{
				EntityBoneComponent component = entity.GetComponent<EntityBoneComponent>();
				if (component == null)
				{
					Log.Error($"怪物{monsterConfigId}-{playerRank}-没有配置绑定组件");
				}
				deadDropPos = (component?.GetBoneLocalPosition("middle") + entity.transform.position) ?? entity.transform.position;
				deadDropRotation = entity.transform.rotation.eulerAngles;
			}
		}
		entity = null;
		mapDataNodeState = MapDataNodeState.Dead;
		base.World.GetSystem<EntitySystem>()?.GetEntity(base.World.ActorId)?.ChangeProperty("Energy", GameEntry.Base.GameConfig.KillLowMonsterEnergy);
		base.World.GetSystem<BattleSystem>()?.OnEnergyChangeStat(base.World.ActorId, EnergyRecoverEnum.KillMonster, GameEntry.Base.GameConfig.KillLowMonsterEnergy);
		_monsterNodeLife = MonsterNodeLife.Dead;
		monsterGroup.OnEntityDead();
	}

	private void ShowKillReward(List<DropSystem.DropGoodEffectData> dropGoodEffectDatas)
	{
		if (dropGoodEffectDatas == null || dropGoodEffectDatas.Count <= 0)
		{
			return;
		}
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterConfigId);
		if (dataRow == null)
		{
			Log.Error($"没有找到怪物ID = {monsterConfigId}的怪物配置..");
			return;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 == null)
		{
			Log.Error($"没有找到怪物种类 {dataRow.MonsterType} 的怪物配置..");
		}
		else
		{
			if (dataRow2.MobPower != 4 && !isBoss)
			{
				return;
			}
			new List<DropData>(4);
			List<int> list = new List<int>(4);
			List<int> list2 = new List<int>(4);
			List<int> list3 = new List<int>(4);
			List<long> list4 = new List<long>(4);
			for (int i = 0; i < dropGoodEffectDatas.Count; i++)
			{
				int dropItemId = dropGoodEffectDatas[i].dropInfo.dropItemId;
				int dropType = dropGoodEffectDatas[i].dropInfo.dropType;
				long dropCount = dropGoodEffectDatas[i].dropInfo.dropCount;
				long uuid = dropGoodEffectDatas[i].dropInfo.Uuid;
				if (dropGoodEffectDatas[i].dropInfo.dropItemTpye == 0)
				{
					if (list.Contains(dropItemId))
					{
						list3[list.IndexOf(dropItemId)] += (int)dropCount;
						continue;
					}
					list.Add(dropItemId);
					list2.Add(dropType);
					list3.Add((int)dropCount);
					list4.Add(0L);
				}
				else if (dropGoodEffectDatas[i].dropInfo.dropItemTpye == 1)
				{
					list.Add(dropItemId);
					list2.Add(dropType);
					list3.Add((int)dropCount);
					list4.Add(uuid);
				}
			}
			sceneSystem.GetSystem<TaskSystem>().ShowKillRewardWindow(isBoss ? KillRewardType.KillBoss : KillRewardType.KillMonster, list, list2, list3, list4, dataRow2.IsBoss ? dataRow2.Head : string.Empty);
		}
	}

	protected override async void OnEntityRelease(bool isnormal)
	{
		base.OnEntityRelease(isnormal);
		if (isBoss)
		{
			sceneSystem.OnBossRelease(openBloodBar);
		}
		if (mapDataNodeState == MapDataNodeState.DeadNoRelease)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
			_monsterNodeLife = MonsterNodeLife.None;
			return;
		}
		if (mapDataNodeState == MapDataNodeState.Dead)
		{
			mapDataNodeState = MapDataNodeState.ReleaseFinish;
		}
		else
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
		if (_monsterNodeLife == MonsterNodeLife.Dead)
		{
			if (dropConfig)
			{
				sceneSystem.GetPlayerRank();
				ShowKillReward(await base.World.GetSystem<DropSystem>().DropMonster(base.World.ActorId, "center", monsterConfigId, sceneSystem.GetPlayerRank(), sceneSystem.GetLevelId(), deadDropPos, deadDropRotation));
				base.World.GetSystem<TaskSystem>()?.UpdateTaskProcess(3, monsterConfigId, 1);
			}
			if (base.SaveNode)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMonsterDieTime(sceneSystem.GetLevelId(), base.Uid);
			}
			_monsterNodeLife = MonsterNodeLife.DeadRelease;
			monsterGroup.BattleDataKillMonster(isBoss);
		}
		else
		{
			_monsterNodeLife = MonsterNodeLife.NoDeadRelease;
		}
		monsterGroup.OnEnrityRelease();
	}

	private void AddEntityToSystemRelease(bool isLevelReset)
	{
		if (base.isCreating)
		{
			IsNeedDestory = true;
		}
		else if (entity != null && entity.IsSurvival)
		{
			entity.DoEntityRelease();
			entity = null;
			if (!base.isKilled | isLevelReset)
			{
				mapDataNodeState = MapDataNodeState.Destorying;
			}
		}
		else if (!base.isKilled | isLevelReset)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
	}
}
