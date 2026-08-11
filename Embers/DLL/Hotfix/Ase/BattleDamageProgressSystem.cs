using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class BattleDamageProgressSystem : BaseSystem, IObserverHandler
{
	public class DamageProgressInfo : IReference
	{
		public DamageProgressBase damageProgress;

		public List<Buff> beforeBuffList;

		public List<Buff> afterBuffList;

		public void Clear()
		{
			ReferencePool.Release(damageProgress);
			if (beforeBuffList != null)
			{
				CollectionPool<List<Buff>, Buff>.Release(beforeBuffList);
			}
			if (afterBuffList != null)
			{
				CollectionPool<List<Buff>, Buff>.Release(afterBuffList);
			}
		}
	}

	public class DamageResultStateInfo : IReference
	{
		public int damageState;

		public bool isWaitCache;

		public void Clear()
		{
			damageState = 0;
			isWaitCache = false;
		}
	}

	public class BulletDamageResultInfo : IReference
	{
		public int bulletId;

		public int bulletConfigId;

		public int damage;

		public int tenacity;

		public int defensePowerLevel;

		public List<float> bulletDamageRatio;

		public float bulletTenacityRatio;

		public float bulletFixedTenacity;

		public int bulletPowerLevel;

		public int skillId;

		public int defenderId;

		public EntityType defenderEntityType;

		public int siteLevel;

		public int weaknessLevel;

		public List<int> immuneStateList;

		public List<string> bulletLabelList;

		public void Clear()
		{
		}
	}

	private List<DamageProgressInfo> damageProgressInfoList = new List<DamageProgressInfo>();

	private Dictionary<int, DamageResultStateInfo> damageResultInfoDic = new Dictionary<int, DamageResultStateInfo>();

	private List<BulletDamageResultInfo> bulletDamageResultInfoList = new List<BulletDamageResultInfo>();

	protected override bool IsLogicSystem => true;

	public override void OnStart(object data = null)
	{
		GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.EntityDead, this);
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (damageProgressInfoList.Count > 0)
		{
			for (int i = 0; i < damageProgressInfoList.Count; i++)
			{
				ExecuteBulletDamageProgress(damageProgressInfoList[i]);
			}
			damageProgressInfoList.Clear();
		}
		if (damageResultInfoDic.Count <= 0)
		{
			return;
		}
		List<int> list = CollectionPool<List<int>, int>.Get();
		foreach (KeyValuePair<int, DamageResultStateInfo> item in damageResultInfoDic)
		{
			if (item.Value.isWaitCache)
			{
				list.Add(item.Key);
			}
		}
		foreach (int item2 in list)
		{
			damageResultInfoDic.Remove(item2);
		}
		CollectionPool<List<int>, int>.Release(list);
	}

	public void OnNotify(IObserverParams param)
	{
		if (param is ObserverEntityDeadParams { DeadEntity: not null } observerEntityDeadParams && damageResultInfoDic.TryGetValue(observerEntityDeadParams.DeadEntity.Id, out var value))
		{
			value.isWaitCache = true;
		}
	}

	private DamageProgressInfo GetBulletDamageProgressInfo(BaseEntity attacker, BaseEntity defener, BulletAttackData bulletAttackData)
	{
		DamageProgressInfo damageProgressInfo = new DamageProgressInfo();
		BuffDataDamage buffDataDamage = ReferencePool.Acquire<BuffDataDamage>();
		buffDataDamage.ResetParams(bulletAttackData);
		DamageProgressBase damageProgress = BattleFormulaUtility.GetDamageProgress(attacker?.GetEntityType() ?? EntityType.Unknown, buffDataDamage);
		if (damageProgress == null)
		{
			return null;
		}
		damageProgress.ProgressStart(attacker, defener, buffDataDamage);
		damageProgressInfo.damageProgress = damageProgress;
		DistributaryBuffList(bulletAttackData.addBuffList, ref damageProgressInfo.beforeBuffList, ref damageProgressInfo.afterBuffList);
		return damageProgressInfo;
	}

	public void EnterBulletDamageProgress(BaseEntity attacker, BaseEntity defener, BulletAttackData bulletAttackData)
	{
		if (attacker == null || defener == null || bulletAttackData == null)
		{
			return;
		}
		AddGameSpeedInfo(attacker, bulletAttackData);
		if (!CheckIsDamageBullet(bulletAttackData))
		{
			ExecuteAddBulletBuffProgress(attacker, defener, bulletAttackData);
			return;
		}
		DamageProgressInfo bulletDamageProgressInfo = GetBulletDamageProgressInfo(attacker, defener, bulletAttackData);
		if (bulletDamageProgressInfo != null)
		{
			damageProgressInfoList.Add(bulletDamageProgressInfo);
		}
	}

	private void AddGameSpeedInfo(BaseEntity attacker, BulletAttackData bulletAttackData)
	{
		if (bulletAttackData == null || bulletAttackData == null)
		{
			return;
		}
		DRBullet cfg = bulletAttackData.bulletData.cfg;
		if (cfg == null || !cfg.IsHitSetGlobalTime)
		{
			return;
		}
		BattleWorldMode battleMode = attacker.GetSystem<BattleSystem>().BattleMode;
		if (battleMode == BattleWorldMode.SyncBattle || battleMode == BattleWorldMode.GameBack)
		{
			if (cfg.GlobalTimeIsCtrlGlobal)
			{
				attacker.GetWorld().AddGameSpeedInfo(cfg.GlobalTimePriority, cfg.GlobalTimeScale, cfg.GlobalTimeFrame, cfg.GlobalTimeIsCtrlWeakness, null, attacker);
			}
		}
		else if (!cfg.GlobalTimeIsAIEffect)
		{
			if (attacker.Id == attacker.GetWorld().ActorId)
			{
				attacker.GetWorld().AddGameSpeedInfo(cfg.GlobalTimePriority, cfg.GlobalTimeScale, cfg.GlobalTimeFrame, cfg.GlobalTimeIsCtrlWeakness, null, attacker);
			}
		}
		else
		{
			attacker.GetWorld().AddGameSpeedInfo(cfg.GlobalTimePriority, cfg.GlobalTimeScale, cfg.GlobalTimeFrame, cfg.GlobalTimeIsCtrlWeakness, null, attacker);
		}
	}

	private void DistributaryBuffList(List<Buff> buffList, ref List<Buff> beforeList, ref List<Buff> afterList)
	{
		if (buffList == null || buffList.Count == 0)
		{
			return;
		}
		beforeList = CollectionPool<List<Buff>, Buff>.Get();
		afterList = CollectionPool<List<Buff>, Buff>.Get();
		List<BuffConditionEvent> outAddConditions = CollectionPool<List<BuffConditionEvent>, BuffConditionEvent>.Get();
		foreach (Buff buff in buffList)
		{
			bool flag = false;
			outAddConditions.Clear();
			if (buff.GetAddConditions(in outAddConditions) && outAddConditions.Count > 0)
			{
				foreach (BuffConditionEvent item in outAddConditions)
				{
					if (item.CheckConditionEvent(BattleObserverEventEnum.AttackBefore))
					{
						flag = true;
						beforeList.Add(buff);
					}
				}
			}
			if (!flag)
			{
				afterList.Add(buff);
			}
		}
		CollectionPool<List<BuffConditionEvent>, BuffConditionEvent>.Release(outAddConditions);
	}

	private void ExecuteAddBulletBuffProgress(BaseEntity attacker, BaseEntity defener, BulletAttackData bulletAttackData)
	{
		if (bulletAttackData.addBuffList == null)
		{
			return;
		}
		BuffSystem system = GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		foreach (Buff addBuff in bulletAttackData.addBuffList)
		{
			system.CheckAndAcquireBuff(addBuff);
		}
	}

	private void ExecuteBulletDamageProgress(DamageProgressInfo info)
	{
		if (info == null)
		{
			return;
		}
		BuffSystem system = GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		if (info.beforeBuffList != null && info.beforeBuffList.Count > 0)
		{
			foreach (Buff beforeBuff in info.beforeBuffList)
			{
				system.CheckAndAcquireBuff(beforeBuff);
			}
		}
		ExecuteDamageProgress(info.damageProgress);
		if (info.afterBuffList != null && info.afterBuffList.Count > 0)
		{
			foreach (Buff afterBuff in info.afterBuffList)
			{
				system.CheckAndAcquireBuff(afterBuff);
			}
		}
		ReferencePool.Release(info);
	}

	private void ExecuteDamageProgress(DamageProgressBase damageProgress)
	{
		damageProgress.OnExcuteProgress();
		FormulaResultData resultData = damageProgress.GetResultData();
		BaseEntity defender = damageProgress.GetDefender();
		BuffDataDamage dataDamage = damageProgress.GetDataDamage();
		BaseWeaknessData weaknessData = ((damageProgress is HeroDamageProgress heroDamageProgress) ? heroDamageProgress.GetWeaknessData() : null);
		HandleDamageStateData(defender, resultData.damageState);
		HandleDamageBulletData(defender, dataDamage.bulletAttackData, weaknessData, resultData);
	}

	private void HandleDamageStateData(BaseEntity defender, int state)
	{
		if (!damageResultInfoDic.TryGetValue(defender.Id, out var value))
		{
			value = ReferencePool.Acquire<DamageResultStateInfo>();
			damageResultInfoDic.Add(defender.Id, value);
		}
		value.damageState = state;
	}

	private void HandleDamageBulletData(BaseEntity defender, BulletAttackData bulletAttackData, BaseWeaknessData weaknessData, FormulaResultData resultData)
	{
		if (bulletAttackData != null && bulletAttackData.HitColliderVariableData != null)
		{
			BulletDamageResultInfo bulletDamageResultInfo = ReferencePool.Acquire<BulletDamageResultInfo>();
			BulletData bulletData = bulletAttackData.bulletData;
			BulletRuntimeConfigData runtimeConfigData = bulletData.extraData.runtimeConfigData;
			DRBullet dRBullet = bulletData?.cfg;
			bulletDamageResultInfo.bulletId = bulletAttackData.bulletId;
			bulletDamageResultInfo.bulletConfigId = dRBullet.Id;
			bulletDamageResultInfo.damage = resultData.damage;
			bulletDamageResultInfo.tenacity = resultData.tenacity;
			bulletDamageResultInfo.defensePowerLevel = resultData.defensePowerLevel;
			bulletDamageResultInfo.bulletDamageRatio = runtimeConfigData.DamageRatio.ToList();
			bulletDamageResultInfo.bulletTenacityRatio = runtimeConfigData.AffectTenacity;
			bulletDamageResultInfo.bulletFixedTenacity = runtimeConfigData.FixedAffectTenacity;
			bulletDamageResultInfo.bulletPowerLevel = dRBullet.AttackPower;
			bulletDamageResultInfo.skillId = dRBullet.SkillId;
			bulletDamageResultInfo.defenderId = defender.Id;
			bulletDamageResultInfo.defenderEntityType = defender.GetEntityType();
			bulletDamageResultInfo.siteLevel = bulletAttackData.HitColliderVariableData.SiteLevel;
			bulletDamageResultInfo.weaknessLevel = weaknessData?.Level ?? (-1);
			bulletDamageResultInfo.immuneStateList = defender.GetComponent<StateComponent>()?.GetImmuneBuffIdList();
			bulletDamageResultInfo.bulletLabelList = runtimeConfigData.BulletLabel?.ToList();
			bulletDamageResultInfoList.Add(bulletDamageResultInfo);
		}
	}

	private void ExecuteBulletDamageProgress(BaseEntity attacker, BaseEntity defender, BulletAttackData bulletAttackData)
	{
		BuffDataDamage buffDataDamage = ReferencePool.Acquire<BuffDataDamage>();
		buffDataDamage.ResetParams(bulletAttackData);
		DamageProgressBase damageProgress = BattleFormulaUtility.GetDamageProgress(attacker?.GetEntityType() ?? EntityType.Unknown, buffDataDamage);
		if (damageProgress != null)
		{
			damageProgress.ProgressStart(attacker, defender, buffDataDamage);
			damageProgress.OnExcuteProgress();
			ReferencePool.Release(damageProgress);
		}
	}

	public void DirectExecuteBulletHealProgress(BaseEntity unitOwner, BaseEntity unitTarget, DRBullet drBullet)
	{
		BuffDataHeal buffDataHeal = ReferencePool.Acquire<BuffDataHeal>();
		buffDataHeal.ResetParams(drBullet);
		CureProgressBase cureProgressNonAlloc = BattleFormulaUtility.GetCureProgressNonAlloc();
		if (cureProgressNonAlloc != null)
		{
			CureFormulaDataParams cureFormulaDataParams = CureFormulaDataParams.Create(unitOwner, unitTarget, isLayerEffect: false, 1, buffDataHeal.healRatioList, buffDataHeal.healPropertyList, buffDataHeal.healAdditionFromList, buffDataHeal.healAddTypeList, buffDataHeal.healFixAddition, 0f, 0f, buffDataHeal.skillId, isExcuteFormula: true);
			cureFormulaDataParams.isCreateByBullet = buffDataHeal.isCreateByBullet;
			cureProgressNonAlloc.ProgressStart(cureFormulaDataParams);
			BattleFormulaUtility.ReleaseCureProgress(cureProgressNonAlloc);
		}
	}

	private bool CheckIsDamageBullet(BulletAttackData bulletAttackData)
	{
		BulletBuffTypeEnum valueOrDefault = (bulletAttackData?.bulletData?.cfg.BulletBuffTypeEnum).GetValueOrDefault();
		if (valueOrDefault != BulletBuffTypeEnum.None)
		{
			return valueOrDefault == BulletBuffTypeEnum.Damage;
		}
		return true;
	}

	public DamageResultStateInfo GetDamageResultInfo(int entityId)
	{
		damageResultInfoDic.TryGetValue(entityId, out var value);
		return value;
	}

	public BulletDamageResultInfo GetBulletDamageResultInfoByBulletId(int bulletId)
	{
		if (bulletDamageResultInfoList.Count > 0)
		{
			foreach (BulletDamageResultInfo bulletDamageResultInfo in bulletDamageResultInfoList)
			{
				if (bulletDamageResultInfo.bulletId == bulletId)
				{
					return bulletDamageResultInfo;
				}
			}
		}
		return null;
	}

	public BulletDamageResultInfo GetBulletDamageResultInfoByConfigId(int configId)
	{
		if (bulletDamageResultInfoList.Count > 0)
		{
			foreach (BulletDamageResultInfo bulletDamageResultInfo in bulletDamageResultInfoList)
			{
				if (bulletDamageResultInfo.bulletConfigId == configId)
				{
					return bulletDamageResultInfo;
				}
			}
		}
		return null;
	}

	public List<BulletDamageResultInfo> GetAllBulletDamageResultInfo()
	{
		return bulletDamageResultInfoList;
	}

	public bool CheckBulletDamageResultInfo()
	{
		return bulletDamageResultInfoList.Count > 0;
	}

	public void ClearBulletDamageResultInfo()
	{
		if (bulletDamageResultInfoList.Count > 0)
		{
			for (int i = 0; i < bulletDamageResultInfoList.Count; i++)
			{
				ReferencePool.Release(bulletDamageResultInfoList[i]);
			}
		}
		bulletDamageResultInfoList.Clear();
	}

	public override void OnDispose()
	{
		GetSystem<BattleObserverSystem>()?.Detach(BattleObserverEventEnum.EntityDead, this);
		base.OnDispose();
		damageProgressInfoList.Clear();
		damageResultInfoDic.Clear();
		ClearBulletDamageResultInfo();
	}
}
