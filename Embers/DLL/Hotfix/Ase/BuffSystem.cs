using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class BuffSystem : BaseSystem
{
	public static class Constant
	{
		public const int BULLET_DAMAGE_BUFF = 1;

		public const int BULLET_HEAL_BUFF = 2;

		public const int BULLET_MODVEL_BUFF = 3;

		public const string SINGLE_MODE = "SINGLE_MODE";

		public const string BATTLE = "Battle";
	}

	private LinkedList<Buff> globalBuffs;

	private Dictionary<int, LinkedList<Buff>> entityBuffDic;

	private LinkedList<Buff> entityBuffList;

	private LinkedListNode<Buff> current;

	private LinkedListNode<Buff> next;

	private LinkedListNode<Buff> currentFind;

	private Dictionary<int, List<BuffChangeLabelData>> buffChangeLabelDataDic = new Dictionary<int, List<BuffChangeLabelData>>();

	private Dictionary<int, List<BuffRecordInfo>> recordDic = new Dictionary<int, List<BuffRecordInfo>>();

	protected override bool IsLogicSystem => true;

	private void OnInitConstant()
	{
	}

	public static BuffDataBase GetBuffData(BuffOperationType effectType)
	{
		return effectType switch
		{
			BuffOperationType.Empty => ReferencePool.Acquire<BuffDataEmpty>(), 
			BuffOperationType.Damage => ReferencePool.Acquire<BuffDataDamage>(), 
			BuffOperationType.DamageRatio => ReferencePool.Acquire<BuffDataDamageRatio>(), 
			BuffOperationType.ModifyVelocity => ReferencePool.Acquire<BuffDataModifyVelocity>(), 
			BuffOperationType.Property => ReferencePool.Acquire<BuffDataProperty>(), 
			BuffOperationType.PropertyTarget => ReferencePool.Acquire<BuffDataPropertyTarget>(), 
			BuffOperationType.PropertyRuntime => ReferencePool.Acquire<BuffDataPropertyRuntime>(), 
			BuffOperationType.PropertyConvert => ReferencePool.Acquire<BuffDataPropertyConvert>(), 
			BuffOperationType.PropertyIgnoreBind => ReferencePool.Acquire<BuffDataPropertyIgnoreBind>(), 
			BuffOperationType.PropertyTargetLayer => ReferencePool.Acquire<BuffDataPropertyTargetLayer>(), 
			BuffOperationType.State => ReferencePool.Acquire<BuffDataState>(), 
			BuffOperationType.StateAbnormal => ReferencePool.Acquire<BuffDataStateAbnormal>(), 
			BuffOperationType.StateAbnormalTime => ReferencePool.Acquire<BuffDataStateAbnormalTime>(), 
			BuffOperationType.StateImmune => ReferencePool.Acquire<BuffDataStateImmune>(), 
			BuffOperationType.BuffLayer => ReferencePool.Acquire<BuffDataBuffLayer>(), 
			BuffOperationType.Paradox => ReferencePool.Acquire<BuffDataParadox>(), 
			BuffOperationType.ParadoxParams => ReferencePool.Acquire<BuffDataParadoxParams>(), 
			BuffOperationType.ParadoxModifyParams => ReferencePool.Acquire<BuffDataParadoxModifyParams>(), 
			BuffOperationType.Heal => ReferencePool.Acquire<BuffDataHeal>(), 
			BuffOperationType.HealExtra => ReferencePool.Acquire<BuffDataHealExtra>(), 
			BuffOperationType.SkillConsume => ReferencePool.Acquire<BuffDataSkillConsume>(), 
			BuffOperationType.SkillLayer => ReferencePool.Acquire<BuffDataSkillLayer>(), 
			BuffOperationType.SkillCooling => ReferencePool.Acquire<BuffDataSkillCooling>(), 
			BuffOperationType.SkillStrengthState => ReferencePool.Acquire<BuffDataSkillStrengthState>(), 
			BuffOperationType.SkillConsumeByTag => ReferencePool.Acquire<BuffDataSkillConsumeByTag>(), 
			BuffOperationType.SkillConsumeById => ReferencePool.Acquire<BuffDataSkillConsumeById>(), 
			BuffOperationType.CreateBuff => ReferencePool.Acquire<BuffDataCreateBuff>(), 
			BuffOperationType.CreateRuntimeBuff => ReferencePool.Acquire<BuffDataCreateRuntimeBuff>(), 
			BuffOperationType.Mark => ReferencePool.Acquire<BuffDataMark>(), 
			BuffOperationType.PropertyVice => ReferencePool.Acquire<BuffDataPropertyVice>(), 
			BuffOperationType.PropertyViceIgnoreBind => ReferencePool.Acquire<BuffDataPropertyViceIgnoreBind>(), 
			BuffOperationType.Addition => ReferencePool.Acquire<BuffDataAddition>(), 
			BuffOperationType.SkillAddition => ReferencePool.Acquire<BuffDataSkillAddition>(), 
			BuffOperationType.SkillLabelModify => ReferencePool.Acquire<BuffDataSkillLabel>(), 
			BuffOperationType.SkillLabelAddition => ReferencePool.Acquire<BuffDataSkillLabelAddition>(), 
			BuffOperationType.SkillBind => ReferencePool.Acquire<BuffDataSkillBind>(), 
			BuffOperationType.Weapon => ReferencePool.Acquire<BuffDataWeapon>(), 
			BuffOperationType.WeaponKeenness => ReferencePool.Acquire<BuffDataWeaponKeenness>(), 
			BuffOperationType.BuffDuration => ReferencePool.Acquire<BuffDataBuffDuration>(), 
			BuffOperationType.BuffUpdate => ReferencePool.Acquire<BuffDataUpdate>(), 
			BuffOperationType.BuffChangeBullet => ReferencePool.Acquire<BuffDataChangeBullet>(), 
			BuffOperationType.BuffChangeCreateBullet => ReferencePool.Acquire<BuffDataChangeCreateBullet>(), 
			BuffOperationType.BuffOpenTeach => ReferencePool.Acquire<BuffDataOpenTeach>(), 
			BuffOperationType.BuffFinsihTeach => ReferencePool.Acquire<BuffDataFinishTeach>(), 
			BuffOperationType.BuffSkillComboFail => ReferencePool.Acquire<BuffDataSkillComboFail>(), 
			BuffOperationType.BuffSetTeachTimeTask => ReferencePool.Acquire<BuffDataSetTimeTask>(), 
			BuffOperationType.BuffCloseTeachTask => ReferencePool.Acquire<BuffDataCloseTeachTask>(), 
			BuffOperationType.RecoverEnergyEnabled => ReferencePool.Acquire<BuffDataRecoverEnergyEnabled>(), 
			BuffOperationType.ExecuteBulletHit => ReferencePool.Acquire<BuffDataExecuteBulletHit>(), 
			BuffOperationType.SkillExecuteState => ReferencePool.Acquire<BuffDataSkillExecuteState>(), 
			BuffOperationType.ModifyBulletTagByTag => ReferencePool.Acquire<BuffDataModifyBulletTagByTag>(), 
			BuffOperationType.ModifyBulletTagByConfigId => ReferencePool.Acquire<BuffDataModifyBulletTagByConfigId>(), 
			BuffOperationType.ModifyBulletAdditionByTag => ReferencePool.Acquire<BuffDataModifyBulletAdditionByTag>(), 
			BuffOperationType.ModifyBulletAdditionByConfigId => ReferencePool.Acquire<BuffDataModifyBulletAdditionByConfigId>(), 
			BuffOperationType.ModifyBulletConfigBuff => ReferencePool.Acquire<BuffDataModifyBulletConfigBuff>(), 
			BuffOperationType.ModifyBulletHitSiteLevelByTag => ReferencePool.Acquire<BuffDataModifyBulletHitSiteLevelByTag>(), 
			BuffOperationType.ModifyBulletHitSiteLevelByConfigId => ReferencePool.Acquire<BuffDataModifyBulletHitSiteLevelByConfigId>(), 
			BuffOperationType.ModifyBulletHitSiteLevel => ReferencePool.Acquire<BuffDataModifyBulletHitSiteLevel>(), 
			BuffOperationType.ModifyBuffLabelByLabel => ReferencePool.Acquire<BuffDataModifyBuffLabelByLabel>(), 
			BuffOperationType.ModifyBuffLabelByConfigId => ReferencePool.Acquire<BuffDataModifyBuffLabelByConfigId>(), 
			BuffOperationType.SkillBtnActive => ReferencePool.Acquire<BuffDataSkillBtnActive>(), 
			BuffOperationType.SkillBtnActiveById => ReferencePool.Acquire<BuffDataSkillBtnActiveById>(), 
			BuffOperationType.SkillBtnHighLightById => ReferencePool.Acquire<BuffDataSkillBtnHighLightById>(), 
			BuffOperationType.SkillBtnHighLightBySkillType => ReferencePool.Acquire<BuffDataSkillBtnHighLightBySkillType>(), 
			_ => null, 
		};
	}

	public static IBuffOperation GetBuffOperation(BuffOperationType effectType)
	{
		return effectType switch
		{
			BuffOperationType.Empty => ReferencePool.Acquire<EmptyBuff>(), 
			BuffOperationType.Damage => ReferencePool.Acquire<DamageBuff>(), 
			BuffOperationType.DamageRatio => ReferencePool.Acquire<DamageRatioBuff>(), 
			BuffOperationType.ModifyVelocity => ReferencePool.Acquire<ModVelBuff>(), 
			BuffOperationType.Property => ReferencePool.Acquire<PropertyBuff>(), 
			BuffOperationType.PropertyTarget => ReferencePool.Acquire<PropertyTargetBuff>(), 
			BuffOperationType.PropertyRuntime => ReferencePool.Acquire<PropertyRuntimeBuff>(), 
			BuffOperationType.PropertyConvert => ReferencePool.Acquire<PropertyConvertBuff>(), 
			BuffOperationType.PropertyIgnoreBind => ReferencePool.Acquire<PropertyIgnoreBindBuff>(), 
			BuffOperationType.PropertyTargetLayer => ReferencePool.Acquire<PropertyTargetLayerBuff>(), 
			BuffOperationType.State => ReferencePool.Acquire<StateBuff>(), 
			BuffOperationType.StateAbnormal => ReferencePool.Acquire<StateAbnormalBuff>(), 
			BuffOperationType.StateAbnormalTime => ReferencePool.Acquire<StateAbnormalTimeBuff>(), 
			BuffOperationType.StateImmune => ReferencePool.Acquire<StateImmuneBuff>(), 
			BuffOperationType.BuffLayer => ReferencePool.Acquire<BuffLayerBuff>(), 
			BuffOperationType.Paradox => ReferencePool.Acquire<ParadoxBuff>(), 
			BuffOperationType.ParadoxParams => ReferencePool.Acquire<ParadoxParamsBuff>(), 
			BuffOperationType.ParadoxModifyParams => ReferencePool.Acquire<ParadoxModifyParamsBuff>(), 
			BuffOperationType.Heal => ReferencePool.Acquire<HealBuff>(), 
			BuffOperationType.HealExtra => ReferencePool.Acquire<HealExtraBuff>(), 
			BuffOperationType.SkillConsume => ReferencePool.Acquire<SkillConsumeBuff>(), 
			BuffOperationType.SkillLayer => ReferencePool.Acquire<SkillLayerBuff>(), 
			BuffOperationType.SkillCooling => ReferencePool.Acquire<SkillCoolingBuff>(), 
			BuffOperationType.SkillStrengthState => ReferencePool.Acquire<SkillStrengthStateBuff>(), 
			BuffOperationType.SkillConsumeByTag => ReferencePool.Acquire<SkillConsumeByTagBuff>(), 
			BuffOperationType.SkillConsumeById => ReferencePool.Acquire<SkillConsumeByIdBuff>(), 
			BuffOperationType.CreateBuff => ReferencePool.Acquire<CreateBuffBuff>(), 
			BuffOperationType.CreateRuntimeBuff => ReferencePool.Acquire<CreateBuffRuntimeBuff>(), 
			BuffOperationType.Mark => ReferencePool.Acquire<MarkBuff>(), 
			BuffOperationType.PropertyVice => ReferencePool.Acquire<PropertyViceBuff>(), 
			BuffOperationType.PropertyViceIgnoreBind => ReferencePool.Acquire<PropertyViceIgnoreBindBuff>(), 
			BuffOperationType.Addition => ReferencePool.Acquire<AdditionBuff>(), 
			BuffOperationType.SkillAddition => ReferencePool.Acquire<SkillAdditionBuff>(), 
			BuffOperationType.SkillLabelAddition => ReferencePool.Acquire<SkillLabelAdditionBuff>(), 
			BuffOperationType.SkillLabelModify => ReferencePool.Acquire<SkillLabelModifyBuff>(), 
			BuffOperationType.SkillBind => ReferencePool.Acquire<SkillBindBuff>(), 
			BuffOperationType.Weapon => ReferencePool.Acquire<WeaponBuff>(), 
			BuffOperationType.WeaponKeenness => ReferencePool.Acquire<WeaponKeennessBuff>(), 
			BuffOperationType.BuffDuration => ReferencePool.Acquire<BuffDurationBuff>(), 
			BuffOperationType.BuffUpdate => ReferencePool.Acquire<UpdateBuff>(), 
			BuffOperationType.BuffChangeBullet => ReferencePool.Acquire<ChangeBulletBuff>(), 
			BuffOperationType.BuffChangeCreateBullet => ReferencePool.Acquire<ChangeCreateBulletBuff>(), 
			BuffOperationType.BuffOpenTeach => ReferencePool.Acquire<OpenTeachBuff>(), 
			BuffOperationType.BuffFinsihTeach => ReferencePool.Acquire<FinishTeachBuff>(), 
			BuffOperationType.BuffSkillComboFail => ReferencePool.Acquire<SkillComboFailBuff>(), 
			BuffOperationType.BuffSetTeachTimeTask => ReferencePool.Acquire<SetTimeTaskBuff>(), 
			BuffOperationType.BuffCloseTeachTask => ReferencePool.Acquire<CloseTeachTaskBuff>(), 
			BuffOperationType.RecoverEnergyEnabled => ReferencePool.Acquire<RecoverEnergyEnabledBuff>(), 
			BuffOperationType.ExecuteBulletHit => ReferencePool.Acquire<ExecuteBulletHitBuff>(), 
			BuffOperationType.SkillExecuteState => ReferencePool.Acquire<SkillExecuteStateBuff>(), 
			BuffOperationType.ModifyBulletTagByTag => ReferencePool.Acquire<ModifyBulletTagByTagBuff>(), 
			BuffOperationType.ModifyBulletTagByConfigId => ReferencePool.Acquire<ModifyBulletTagByConfigIdBuff>(), 
			BuffOperationType.ModifyBulletAdditionByTag => ReferencePool.Acquire<ModifyBulletAdditionByTagBuff>(), 
			BuffOperationType.ModifyBulletAdditionByConfigId => ReferencePool.Acquire<ModifyBulletAdditionByConfigIdBuff>(), 
			BuffOperationType.ModifyBulletConfigBuff => ReferencePool.Acquire<ModifyBulletConfigBuffBuff>(), 
			BuffOperationType.ModifyBulletHitSiteLevelByTag => ReferencePool.Acquire<ModifyBulletHitSiteLevelByTagBuff>(), 
			BuffOperationType.ModifyBulletHitSiteLevelByConfigId => ReferencePool.Acquire<ModifyBulletHitSiteLevelByConfigIdBuff>(), 
			BuffOperationType.ModifyBulletHitSiteLevel => ReferencePool.Acquire<ModifyBulletHitSiteLevelBuff>(), 
			BuffOperationType.ModifyBuffLabelByLabel => ReferencePool.Acquire<ModifyBuffLabelByLabelBuff>(), 
			BuffOperationType.ModifyBuffLabelByConfigId => ReferencePool.Acquire<ModifyBuffLabelByConfigIdBuff>(), 
			BuffOperationType.SkillBtnActive => ReferencePool.Acquire<SkillBtnActiveBuff>(), 
			BuffOperationType.SkillBtnActiveById => ReferencePool.Acquire<SkillBtnActiveByIdBuff>(), 
			BuffOperationType.SkillBtnHighLightById => ReferencePool.Acquire<SkillBtnHighLightByIdBuff>(), 
			BuffOperationType.SkillBtnHighLightBySkillType => ReferencePool.Acquire<SkillBtnHighLightBySkillTypeBuff>(), 
			_ => null, 
		};
	}

	public static BuffConditionBase GetBuffCondition(BuffConditionType conditionType)
	{
		return conditionType switch
		{
			BuffConditionType.Property => ReferencePool.Acquire<BuffConditionProperty>(), 
			BuffConditionType.PropertyCompare => ReferencePool.Acquire<BuffConditionPropertyCompare>(), 
			BuffConditionType.Event => ReferencePool.Acquire<BuffConditionEvent>(), 
			BuffConditionType.ObserverParam => ReferencePool.Acquire<BuffConditionObserverParam>(), 
			BuffConditionType.EventDamage => ReferencePool.Acquire<BuffConditionEventDamage>(), 
			BuffConditionType.EventDamageTimer => ReferencePool.Acquire<BuffConditionEventDamageTimer>(), 
			BuffConditionType.BuffLayer => ReferencePool.Acquire<BuffConditionBuffLayer>(), 
			BuffConditionType.WeaknessLv => ReferencePool.Acquire<BuffConditionWeaknessLv>(), 
			BuffConditionType.WeaknessLvEvent => ReferencePool.Acquire<BuffConditionWeaknessLvEvent>(), 
			BuffConditionType.EventSkill => ReferencePool.Acquire<BuffConditionEventSkill>(), 
			BuffConditionType.EventSkillByTag => ReferencePool.Acquire<BuffConditionEventSkillByTag>(), 
			BuffConditionType.Mark => ReferencePool.Acquire<BuffConditionMark>(), 
			BuffConditionType.PropertyPercent => ReferencePool.Acquire<BuffConditionPropertyPercent>(), 
			BuffConditionType.PropertyPercentTarget => ReferencePool.Acquire<BuffConditionPropertyPercentTarget>(), 
			BuffConditionType.State => ReferencePool.Acquire<BuffConditionState>(), 
			BuffConditionType.StateBuff => ReferencePool.Acquire<BuffConditionStateBuff>(), 
			BuffConditionType.StateAbnormal => ReferencePool.Acquire<BuffConditionStateAbnormal>(), 
			BuffConditionType.TeamType => ReferencePool.Acquire<BuffConditionTeamType>(), 
			BuffConditionType.HitSiteLevel => ReferencePool.Acquire<BuffConfitionHitSiteLevel>(), 
			BuffConditionType.HitSiteLevelEvent => ReferencePool.Acquire<BuffConfitionHitSiteLevelEvent>(), 
			BuffConditionType.MonsterOD => ReferencePool.Acquire<BuffConditionMonsterOD>(), 
			BuffConditionType.SkillRelease => ReferencePool.Acquire<BuffConditionSkillRelease>(), 
			BuffConditionType.TeamSameNum => ReferencePool.Acquire<BuffConditionTeamSameNum>(), 
			BuffConditionType.DelayExcute => ReferencePool.Acquire<BuffConditionDelayExcute>(), 
			BuffConditionType.TeamCountByDistance => ReferencePool.Acquire<BuffConditionTeamCountByDistance>(), 
			BuffConditionType.BuffConditionTriggerBuffCount => ReferencePool.Acquire<BuffConditionTriggerBuffCount>(), 
			BuffConditionType.PropertyChanged => ReferencePool.Acquire<BuffConditionPropertyChanged>(), 
			BuffConditionType.PropertyChangedTimer => ReferencePool.Acquire<BuffConditionPropertyChangedTimer>(), 
			BuffConditionType.PropertyChangedCompareTimer => ReferencePool.Acquire<BuffConditionPropertyChangedCompareTimer>(), 
			BuffConditionType.PropertyChangedFactor => ReferencePool.Acquire<BuffConditionPropertyChangedFactor>(), 
			BuffConditionType.PropertyChangedCompareTimerEnd => ReferencePool.Acquire<BuffConditionPropertyChangedCompareTimerEnd>(), 
			BuffConditionType.SkillBreakWindow => ReferencePool.Acquire<BuffConditionSkillBreakWindow>(), 
			BuffConditionType.Tinder => ReferencePool.Acquire<BuffConditionTinder>(), 
			BuffConditionType.DestinyLevel => ReferencePool.Acquire<BuffConditionDestinyLevel>(), 
			BuffConditionType.CheckBattleState => ReferencePool.Acquire<BuffConditionCheckBattleState>(), 
			BuffConditionType.WeaponEnum => ReferencePool.Acquire<BuffConditionWeaponEnum>(), 
			BuffConditionType.SkillDeriveState => ReferencePool.Acquire<BuffConditionSkillDeriveState>(), 
			BuffConditionType.CheckSkillLayer => ReferencePool.Acquire<BuffConditionCheckSkillLayer>(), 
			_ => null, 
		};
	}

	private void OnDisposeConstant()
	{
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		OnInitConstant();
		OnInitDataManager();
		OnInitMessager();
	}

	public override void OnAwake(object data = null)
	{
		OnAwakeDataManager();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		OnDisposeConstant();
		OnDisposeDataManager();
		OnDisposeMessager();
		OnDisposeRecord();
		OnDisposeDataReplace();
	}

	public void CheckAndAcquireBuff(int fromEntityId, int targetEntityId, int buffId)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(buffId);
		if (dataRow != null && !dataRow.Operations.IsNullOrEmpty())
		{
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(fromEntityId);
			BaseEntity entity2 = GetSystem<EntitySystem>().GetEntity(targetEntityId);
			if (entity != null && entity2 != null)
			{
				CheckAndAcquireBuff(entity, entity2, dataRow);
			}
		}
	}

	public Buff CheckAndAcquireBuff(BaseEntity from, BaseEntity unitTarget, int buffId)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(buffId);
		if (dataRow == null)
		{
			return null;
		}
		return CheckAndAcquireBuff(from, unitTarget, dataRow);
	}

	public void CheckAndAcquireCreateBuff(BaseEntity from, BaseEntity unitTarget, BuffDataCreateBuff createBuffData)
	{
		if (!createBuffData.isCheakAddCondition || CheckBuffAddCondition(from, unitTarget, createBuffData.buffConfig))
		{
			Buff buff = CreateBuff(from, unitTarget, createBuffData.buffConfig);
			buff.SetDuration(createBuffData.duration);
			buff.SetLayer(createBuffData.buffLayer, isUpdate: false);
			AddEntityBuff(unitTarget, buff);
		}
	}

	public void CheckAndAcquireCreateTargetBuff(BaseEntity from, BaseEntity unitTarget, BuffDataCreateRuntimeBuff createBuffData)
	{
		if (!createBuffData.isCheakAddCondition || CheckBuffAddCondition(from, unitTarget, createBuffData.buffConfig))
		{
			Buff buff = CreateBuff(from, unitTarget, createBuffData.buffConfig);
			buff.SetDuration(createBuffData.duration);
			buff.SetLayer(createBuffData.buffLayer, isUpdate: false);
			AddEntityBuff(unitTarget, buff);
		}
	}

	public Buff CheckAndAcquireBuff(BaseEntity from, BaseEntity unitTarget, DRBuff drBuff)
	{
		if (!CheckBuffAddCondition(from, unitTarget, drBuff))
		{
			return null;
		}
		return AcquireBuff(from, unitTarget, drBuff);
	}

	public void CheckAndAcquireBuff(Buff buff)
	{
		if (!buff.CheckAddCondition())
		{
			ReferencePool.Release(buff);
		}
		else
		{
			AcquireBuff(buff);
		}
	}

	public Buff AcquireBuff(BaseEntity from, BaseEntity unitTarget, int buffId)
	{
		Buff buff = CreateBuff(from, unitTarget, buffId);
		if (!AddEntityBuff(unitTarget, buff))
		{
			return null;
		}
		return buff;
	}

	public Buff AcquireBuff(BaseEntity from, BaseEntity unitTarget, DRBuff drBuff)
	{
		Buff buff = CreateBuff(from, unitTarget, drBuff);
		if (!AddEntityBuff(unitTarget, buff))
		{
			return null;
		}
		return buff;
	}

	public Buff AcquireResetParamBuff(BaseEntity from, BaseEntity unitTarget, DRBuff config, params object[] args)
	{
		Buff buff = CreateResetParamsBuff(from, unitTarget, config, args);
		if (!AddEntityBuff(unitTarget, buff))
		{
			return null;
		}
		return buff;
	}

	public bool AcquireBuff(BaseEntity target, Buff buff)
	{
		if (target == null || buff == null)
		{
			return false;
		}
		return AddEntityBuff(target, buff);
	}

	public bool AcquireBuff(Buff buff)
	{
		if (buff == null || buff.BuffOwner == null)
		{
			return false;
		}
		return AddEntityBuff(buff.BuffOwner, buff);
	}

	private bool CheckBuffAddCondition(BaseEntity from, BaseEntity target, DRBuff buffData)
	{
		ConditionList<BuffConditionBase> conditionList = BuffExtension.GenerateBuffConditions(from, target, buffData.AddCondition);
		if (conditionList == null)
		{
			AddRecord(target.Id, buffData.Id, BuffRecordEnum.State, "添加Buff失败, 检测添加条件错误");
			return false;
		}
		bool num = Buff.CheckConditions(null, conditionList, emptyCheck: true);
		ConditionListPool<BuffConditionBase>.Release(conditionList);
		if (!num)
		{
			AddRecord(target.Id, buffData.Id, BuffRecordEnum.State, "添加Buff失败, 条件未通过");
		}
		return num;
	}

	public void AcquireBulletModifyVelBuff(BaseEntity unitOwner, BaseEntity unitTarget, float vel, Vector3 direct)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(3);
		if (dataRow != null)
		{
			Buff buff = CreateResetParamsBuff(unitOwner, unitTarget, dataRow, vel, direct);
			AcquireBuff(buff);
		}
	}

	public void AcquireBuffByModifyNode(BaseEntity from, BaseEntity target, DRBuff buffConfig, float duration, int layer)
	{
		if (CheckBuffAddCondition(from, target, buffConfig))
		{
			Buff buff = CreateBuff(from, target, buffConfig);
			buff.SetDuration(duration);
			buff.SetLayer(layer, isUpdate: false);
			AddEntityBuff(target, buff);
		}
	}

	public void FinishEntityBuff(int entityId, int buffId)
	{
		FindEntityBuff(entityId, buffId)?.Finish();
	}

	public void FinishEntityBuff(Buff buff)
	{
		buff?.Finish();
	}

	public void FinishEntityBuffByTag(int entityId, string buffTag)
	{
		LinkedList<Buff> entityBuffs = GetEntityBuffs(entityId);
		if (entityBuffs == null)
		{
			return;
		}
		for (currentFind = entityBuffs.Last; currentFind != null; currentFind = next)
		{
			next = currentFind.Previous;
			List<string> list = currentFind.Value.RuntimeConfigData?.BuffLabel;
			if (list != null)
			{
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i] == buffTag)
					{
						currentFind.Value.Finish();
						break;
					}
				}
			}
		}
	}

	public void FinishEntityAllBuff(int entityId)
	{
		LinkedList<Buff> entityBuffs = GetEntityBuffs(entityId);
		if (entityBuffs == null)
		{
			return;
		}
		foreach (Buff item in entityBuffs)
		{
			item.Dispose();
			item.Release();
			globalBuffs.Remove(item);
		}
		entityBuffs.Clear();
	}

	public Buff CreateBulletDamageBuff(BaseEntity from, BaseEntity target, BulletAttackData bulletAttackData)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(1);
		if (dataRow == null)
		{
			return null;
		}
		return CreateResetParamsBuff(from, target, dataRow, bulletAttackData);
	}

	public Buff CreateBulletHealBuff(BaseEntity unitOwner, BaseEntity unitTarget, DRBullet drBullet)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(2);
		if (dataRow == null)
		{
			return null;
		}
		return CreateResetParamsBuff(unitOwner, unitTarget, dataRow, drBullet);
	}

	public Buff CreateModifyBuff(BaseEntity from, BaseEntity target, int buffId, BulletAttackData bulletAttackData)
	{
		return CreateBuff(from, target, buffId);
	}

	public Buff CreateBulletModifyVelBuff(BaseEntity from, BaseEntity target, float vel, Vector3 direct)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(3);
		if (dataRow == null)
		{
			return null;
		}
		return CreateResetParamsBuff(from, target, dataRow, vel, direct);
	}

	public Buff CreateBuff(BaseEntity from, BaseEntity target, int buffId)
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(buffId);
		if (dataRow == null)
		{
			return null;
		}
		return CreateBuff(from, target, dataRow);
	}

	public Buff CreateBuff(BaseEntity from, BaseEntity target, DRBuff buffConfig)
	{
		Buff buff = ReferencePool.Acquire<Buff>();
		buff.InitRuntimeConfigData(CreateBuffRuntimeConfigData(target?.Id ?? 0, buffConfig));
		buff.Init(from, target, buffConfig);
		return buff;
	}

	public Buff CreateResetParamsBuff(BaseEntity from, BaseEntity target, DRBuff config, params object[] args)
	{
		Buff buff = ReferencePool.Acquire<Buff>();
		buff.InitRuntimeConfigData(CreateBuffRuntimeConfigData(target?.Id ?? 0, config));
		buff.Init(from, target, config);
		buff.ResetOperationParams(args);
		return buff;
	}

	private void OnInitDataManager()
	{
		globalBuffs = new LinkedList<Buff>();
		entityBuffDic = new Dictionary<int, LinkedList<Buff>>();
	}

	private void OnAwakeDataManager()
	{
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		for (current = globalBuffs.First; current != null; current = current.Next)
		{
			Buff value = current.Value;
			if (value.BuffOwner != null)
			{
				value.Update(deltaTime);
			}
			UpdateEntityBuffUI(value);
		}
	}

	private bool AddEntityBuff(BaseEntity entity, Buff newBuff, bool isIgnoreStateImmune = false)
	{
		if (newBuff == null)
		{
			return false;
		}
		if (!CheckEntityAddValid(entity, isIgnoreStateImmune))
		{
			AddRecord(entity.Id, newBuff.BuffId, BuffRecordEnum.State, "添加Buff失败, 实体未存活or免疫Buff添加");
			return false;
		}
		if (CheckMutex(newBuff))
		{
			AddRecord(entity.Id, newBuff.BuffId, BuffRecordEnum.State, "添加Buff失败, Buff互斥");
			return false;
		}
		Buff entitySameBuff = GetEntitySameBuff(entity.Id, newBuff);
		if (entitySameBuff == null)
		{
			InternalAddEntityBuff(entity, newBuff);
			newBuff.Start();
			return true;
		}
		if (entitySameBuff.Config.StackType == 1)
		{
			entitySameBuff.AddLayer(newBuff.GetLayer());
			entitySameBuff.AddDuration(newBuff.MaxLifeTime);
		}
		else if (entitySameBuff.Config.StackType == 2)
		{
			entitySameBuff.AddLayer(newBuff.GetLayer());
			entitySameBuff.SetDuration(entitySameBuff.GetLifeTime() + newBuff.MaxLifeTime);
			entitySameBuff.ResetLifeTime();
		}
		else
		{
			if (entitySameBuff.Config.StackType != 3)
			{
				if (entitySameBuff.Config.StackType == 4)
				{
					newBuff.AddLayer(entitySameBuff.GetLayer(), isUpdate: false);
					FinishEntityBuff(entitySameBuff);
					InternalAddEntityBuff(entity, newBuff);
					newBuff.Start();
					return true;
				}
				ReferencePool.Release(newBuff);
				return false;
			}
			entitySameBuff.AddLayer(newBuff.GetLayer());
			entitySameBuff.SetDuration(newBuff.MaxLifeTime);
			entitySameBuff.ResetLifeTime();
		}
		ReferencePool.Release(newBuff);
		newBuff = entitySameBuff;
		return true;
	}

	private Buff GetEntitySameBuff(int entityId, Buff newBuff)
	{
		if (newBuff.Config.Coexist)
		{
			return null;
		}
		LinkedList<Buff> entityBuffs = GetEntityBuffs(entityId);
		if (entityBuffs != null)
		{
			foreach (Buff item in entityBuffs)
			{
				if (newBuff.BuffId == item.BuffId)
				{
					return item;
				}
			}
		}
		return null;
	}

	public LinkedList<Buff> GetEntityBuffs(int entityId)
	{
		entityBuffDic.TryGetValue(entityId, out var value);
		return value;
	}

	public Buff FindEntityBuff(int entityId, int buffId)
	{
		LinkedList<Buff> entityBuffs = GetEntityBuffs(entityId);
		if (entityBuffs == null)
		{
			return null;
		}
		for (currentFind = entityBuffs.First; currentFind != null; currentFind = currentFind.Next)
		{
			if (currentFind.Value.BuffId == buffId)
			{
				return currentFind.Value;
			}
		}
		return null;
	}

	public List<Buff> FindAllBuffByMutexTag(Buff buff)
	{
		if (buff == null)
		{
			return null;
		}
		if (buff.BuffOwner == null)
		{
			return null;
		}
		return FindAllBuffByMutexTag(buff.BuffOwner.Id, buff.GetMutexTag());
	}

	public List<Buff> FindAllBuffByMutexTag(int entityId, string mutexTag)
	{
		LinkedList<Buff> entityBuffs = GetEntityBuffs(entityId);
		if (entityBuffs == null || entityBuffs.Count == 0)
		{
			return null;
		}
		List<Buff> list = CollectionPool<List<Buff>, Buff>.Get();
		for (currentFind = entityBuffs.First; currentFind != null; currentFind = currentFind.Next)
		{
			if (currentFind.Value.GetMutexTag() == mutexTag)
			{
				list.Add(currentFind.Value);
			}
		}
		return list;
	}

	public void RemoveBuff(int entityId, int buffId)
	{
		Buff buff = FindEntityBuff(entityId, buffId);
		if (buff != null)
		{
			RemoveBuff(buff);
		}
	}

	public void RemoveBuff(Buff buff)
	{
		if (buff != null)
		{
			globalBuffs.Remove(buff);
			if (entityBuffDic.TryGetValue(buff.BuffOwner.Id, out entityBuffList))
			{
				entityBuffList.Remove(buff);
			}
			ObserverRemoveBuffParams observerRemoveBuffParams = ReferencePool.Acquire<ObserverRemoveBuffParams>();
			observerRemoveBuffParams.Init(buff);
			GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.RemoveBuff, observerRemoveBuffParams);
			ReferencePool.Release(observerRemoveBuffParams);
			RemoveEntityBuffUI(buff);
		}
	}

	private void RemoveAllBuffs()
	{
		foreach (Buff globalBuff in globalBuffs)
		{
			globalBuff.Dispose();
			ReferencePool.Release(globalBuff);
		}
		globalBuffs.Clear();
		entityBuffDic.Clear();
	}

	private void DisposeAllBuffs()
	{
		foreach (Buff globalBuff in globalBuffs)
		{
			ReferencePool.Release(globalBuff);
		}
		globalBuffs.Clear();
		entityBuffDic.Clear();
	}

	private void InternalAddEntityBuff(BaseEntity entity, Buff buff)
	{
		if (!entityBuffDic.TryGetValue(entity.Id, out var value))
		{
			value = new LinkedList<Buff>();
			entityBuffDic.Add(entity.Id, value);
		}
		Buff entitySameBuff = GetEntitySameBuff(entity.Id, buff);
		int entityBuffIndex = GetEntityBuffIndex(entity, entitySameBuff);
		if (entityBuffIndex == -1)
		{
			AddEntityBuffUI(entity, buff);
		}
		else
		{
			ReplaceEntityBuffUI(buff.BuffOwner, buff, entityBuffIndex);
		}
		value.AddLast(buff);
		globalBuffs.AddLast(buff);
		ObserverAddBuffParams observerAddBuffParams = ReferencePool.Acquire<ObserverAddBuffParams>();
		observerAddBuffParams.Init(buff);
		GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.AddBuff, observerAddBuffParams);
		ReferencePool.Release(observerAddBuffParams);
	}

	private int GetEntityBuffIndex(BaseEntity entity, Buff buff)
	{
		if (buff == null)
		{
			return -1;
		}
		if (entity == null || entity.EntityViewModel == null)
		{
			return -1;
		}
		return entity.EntityViewModel.GetBuffIndex(buff);
	}

	private void AddEntityBuffUI(BaseEntity entity, Buff buff)
	{
		if (buff.ShowUI)
		{
			entity?.EntityViewModel?.AddBuff(buff);
		}
	}

	private void ReplaceEntityBuffUI(BaseEntity entity, Buff buff, int index)
	{
		if (buff.ShowUI)
		{
			entity?.EntityViewModel.ReplaceBuff(buff, index);
		}
	}

	private void UpdateEntityBuffUI(Buff buff)
	{
		if (buff.ShowUI)
		{
			buff.BuffOwner?.EntityViewModel?.UpdateBuff(buff);
		}
	}

	private void RemoveEntityBuffUI(Buff buff)
	{
		if (buff.ShowUI)
		{
			buff.BuffOwner?.EntityViewModel?.RemoveBuff(buff);
		}
	}

	private bool CheckEntityAddValid(BaseEntity entity, bool isIgnoreStateImmune = false)
	{
		if (!entity.IsSurvival)
		{
			return false;
		}
		if (isIgnoreStateImmune)
		{
			StateComponent component = entity.GetComponent<StateComponent>();
			if (component != null)
			{
				_ = !component.IsImmuneBuff();
			}
			else
				_ = 0;
			return true;
		}
		return true;
	}

	private bool CheckMutex(Buff buff)
	{
		List<Buff> list = FindAllBuffByMutexTag(buff);
		if (list == null)
		{
			return false;
		}
		if (list.Count == 0)
		{
			CollectionPool<List<Buff>, Buff>.Release(list);
			return false;
		}
		int mutexPriority = buff.GetMutexPriority();
		if (mutexPriority == -1)
		{
			CollectionPool<List<Buff>, Buff>.Release(list);
			return true;
		}
		foreach (Buff item in list)
		{
			int mutexPriority2 = item.GetMutexPriority();
			if (mutexPriority2 == -1)
			{
				return true;
			}
			if (mutexPriority > mutexPriority2)
			{
				FinishEntityBuff(item);
			}
			else if (mutexPriority < mutexPriority2)
			{
				CollectionPool<List<Buff>, Buff>.Release(list);
				return true;
			}
		}
		CollectionPool<List<Buff>, Buff>.Release(list);
		return false;
	}

	private void OnDisposeDataManager()
	{
		DisposeAllBuffs();
		entityBuffList?.Clear();
		current = null;
		next = null;
		currentFind = null;
		ConditionListPool<BuffConditionBase>.Clear();
	}

	public void AddChangeBuffLabelData(int entityId, BuffChangeLabelData data)
	{
		if (!buffChangeLabelDataDic.TryGetValue(entityId, out var value))
		{
			value = new List<BuffChangeLabelData>();
			buffChangeLabelDataDic.Add(entityId, value);
		}
		value.Add(data);
	}

	public void RemoveChangeBuffLabelData(int entityId, BuffChangeLabelData data)
	{
		if (buffChangeLabelDataDic.TryGetValue(entityId, out var value))
		{
			value.Remove(data);
		}
	}

	public List<BuffChangeLabelData> GetChangeBuffLabelDataList(int entityId)
	{
		if (buffChangeLabelDataDic.TryGetValue(entityId, out var value))
		{
			return value;
		}
		return null;
	}

	private BuffRuntimeConfigData CreateBuffRuntimeConfigData(int entityId, DRBuff config)
	{
		BuffRuntimeConfigData buffRuntimeConfigData = new BuffRuntimeConfigData();
		buffRuntimeConfigData.InitConfig(config);
		CheckHandleBuffLabelData(entityId, config?.Id ?? 0, buffRuntimeConfigData);
		return buffRuntimeConfigData;
	}

	private void CheckHandleBuffLabelData(int entityId, int buffId, BuffRuntimeConfigData runtimeConfigData)
	{
		if (!buffChangeLabelDataDic.TryGetValue(entityId, out var value))
		{
			return;
		}
		foreach (BuffChangeLabelData item3 in value)
		{
			if (item3.IsVaild() || !CheckContainsBuffToModify(item3, buffId, runtimeConfigData))
			{
				continue;
			}
			if (item3.changeType == ChangeType.Add)
			{
				foreach (string modifyLabel in item3.modifyLabelList)
				{
					if (!runtimeConfigData.BuffLabel.Contains(modifyLabel))
					{
						runtimeConfigData.BuffLabel.Add(modifyLabel);
					}
				}
			}
			else
			{
				if (item3.changeType != ChangeType.Dec)
				{
					continue;
				}
				foreach (string modifyLabel2 in item3.modifyLabelList)
				{
					runtimeConfigData.BuffLabel.Remove(modifyLabel2);
				}
			}
		}
	}

	private bool CheckContainsBuffToModify(BuffChangeLabelData data, int buffId, BuffRuntimeConfigData runtimeConfigData)
	{
		if (!data.checkLabelList.IsNullOrEmpty() && data.checkLabelList.HasCommonWith(runtimeConfigData.BuffLabel))
		{
			return true;
		}
		if (!data.checkConfigIdList.IsNullOrEmpty() && data.checkConfigIdList.Contains(buffId))
		{
			return true;
		}
		return false;
	}

	private void OnDisposeDataReplace()
	{
		buffChangeLabelDataDic.Clear();
	}

	public void AddRecord(int entityId, int buffId, BuffRecordEnum recordEnum, string record)
	{
		GetRecordInfo(entityId, buffId)?.Record(recordEnum, GetRecordFormat(record));
	}

	public void AddRecord(int entityId, int buffId, bool isSurvival)
	{
		BuffRecordInfo recordInfo = GetRecordInfo(entityId, buffId, isSurvival);
		if (recordInfo != null)
		{
			recordInfo.ChangeState(isSurvival);
			if (isSurvival)
			{
				recordInfo.Record(BuffRecordEnum.State, GetRecordFormat("Buff流程开始"));
			}
			else
			{
				recordInfo.Record(BuffRecordEnum.State, GetRecordFormat("Buff流程结束"));
			}
		}
	}

	public void UpdateRecordInfo(int entityId, int buffId, BuffUpdateRecordEnum updateRecordEnum, float value)
	{
		GetRecordInfo(entityId, buffId)?.UpdateRecord(updateRecordEnum, value);
	}

	private BuffRecordInfo GetRecordInfo(int entityId, int buffId, bool isCreate = false)
	{
		if (!recordDic.TryGetValue(entityId, out var value))
		{
			value = new List<BuffRecordInfo>();
			recordDic.Add(entityId, value);
		}
		DRBuff config = GameEntry.DataTable.GetDataRow<DRBuff>(buffId);
		if (config == null)
		{
			return null;
		}
		BuffRecordInfo buffRecordInfo = value.Find((BuffRecordInfo b) => b.buffId == config.Id);
		if (isCreate)
		{
			value.Remove(buffRecordInfo);
			buffRecordInfo = null;
		}
		if (buffRecordInfo == null)
		{
			buffRecordInfo = new BuffRecordInfo();
			buffRecordInfo.Init(config);
			value.Add(buffRecordInfo);
		}
		return buffRecordInfo;
	}

	public List<BuffRecordInfo> GetEntityBuffRecordInfos(int entityId)
	{
		if (recordDic.TryGetValue(entityId, out var value))
		{
			return value;
		}
		return null;
	}

	private string GetRecordFormat(string msg)
	{
		return $"当前帧: {world?.Tick}\t{msg}";
	}

	private void OnInitRecord()
	{
	}

	private void OnDisposeRecord()
	{
		ClearBuffRecord();
	}

	public void ClearBuffRecord()
	{
		if (recordDic.IsNullOrEmpty())
		{
			return;
		}
		foreach (List<BuffRecordInfo> value in recordDic.Values)
		{
			if (value.IsNullOrEmpty())
			{
				continue;
			}
			foreach (BuffRecordInfo item in value)
			{
				item.Clear();
			}
			value.Clear();
		}
		recordDic.Clear();
	}

	private void OnInitMessager()
	{
	}

	private void OnDisposeMessager()
	{
	}
}
