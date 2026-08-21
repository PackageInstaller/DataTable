using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class SummonedDamageProgress : DamageProgressBase
{
	private readonly FormulaZoneBase[] _damageFormulaZones = new FormulaZoneBase[13]
	{
		new BaseDamageFormulaZone(),
		new CritFormulaZone(),
		new WeaponSkillAdditionFormulaZone(),
		new AttributeAdditionFormulaZone(),
		new MonsterMechanismFormulaZone(),
		new DefenceFormulaZone(),
		new ResistanceFormulaZone(),
		new TeamFormulaZone(),
		new AttributeRestraintFormulaZone(),
		new WeaponMechanismFormulaZone(),
		new SpecialFormulaZone(),
		new AIDamageFormulaZone(),
		new HeroLevelFormulaZone()
	};

	private readonly FormulaZoneBase[] _tenacityFormulaZones = new FormulaZoneBase[6]
	{
		new BaseTenacityFormulaZone(),
		new SkillTenacityFormulaZone(),
		new IntensifyTenacityFormulaZone(),
		new SpecialTenacityFormulaZone(),
		new StateTenacityFormulaZone(),
		new AITenacityFormulaZone()
	};

	protected TenacityFormulaDataParams tenacityParams;

	protected override void OnExecuteProgressStart()
	{
		InitFormulaParams();
		SendBeforeBuffMessage();
	}

	protected override void OnExecuteProgressLogic()
	{
		OnExcuteDamageProcess();
		ExecuteDamageLog();
		OnExcuteTenacityProcess();
		ExecuteTenacityLog();
	}

	protected override void OnExecuteProgressDisplay()
	{
		base.OnExecuteProgressDisplay();
		ShowHpBar();
	}

	protected void InitFormulaParams()
	{
		bool isImmuneState = CheckImmuneState();
		BaseWeaknessData weaknessData = GetWeaknessData();
		bool flag = dataDamage.bulletAttackData != null && dataDamage.bulletAttackData.BulletParentPropertyData != null;
		if (flag)
		{
			flag = defender.GetComponent<EntityDefenceComponent>()?.CheckAttackAngle(dataDamage.bulletAttackData.BulletParentPropertyData.AttackerPos, dataDamage.bulletAttackData.BulletPos, dataDamage.IsMelee) ?? false;
		}
		damageParams = new DamageFormulaDataParams
		{
			attacker = attacker,
			defender = defender,
			dataDamage = dataDamage,
			weaknessData = weaknessData,
			isImmuneState = isImmuneState,
			isAttackAngleDenfense = flag
		};
		tenacityParams = new TenacityFormulaDataParams
		{
			attacker = attacker,
			defender = defender,
			dataDamage = dataDamage,
			damage = 0,
			weaknessData = weaknessData,
			isImmuneState = isImmuneState,
			isAttackAngleDenfense = flag
		};
	}

	public override void SendBeforeBuffMessage()
	{
		if (dataDamage.bulletAttackData != null && dataDamage.bulletAttackData.bulletData.cfg.IsIgnoreHit)
		{
			return;
		}
		BattleObserverSystem system = defender.GetSystem<BattleObserverSystem>();
		if (system == null)
		{
			return;
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("SkillId", dataDamage.BelongToSkillId);
		if (dataDamage.bulletAttackData != null)
		{
			dictionary.Add("BulletId", dataDamage.bulletAttackData.bulletId);
			dictionary.Add("BulletConfigId", dataDamage.bulletAttackData.bulletData.cfg.Id);
			dictionary.Add("BulletLabel", dataDamage.bulletAttackData.bulletData.cfg.BulletLabel);
			if (dataDamage.bulletAttackData.HitColliderVariableData != null)
			{
				dictionary.Add("SiteLevel", dataDamage.bulletAttackData.HitColliderVariableData.SiteLevel);
				dictionary.Add("PartName", dataDamage.bulletAttackData.HitColliderVariableData.partName);
			}
		}
		dictionary.Add("WeakNessLv", damageParams.weaknessData?.Level ?? 0);
		dictionary.Add("ImmuneState", damageParams.isImmuneState);
		ObserverDamageProgressParams observerDamageProgressParams = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams.Init(attacker, defender, dictionary, BattleObserverEventEnum.DamageBefore);
		system.Notify(BattleObserverEventEnum.DamageBefore, observerDamageProgressParams);
		ObserverDamageProgressParams observerDamageProgressParams2 = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams2.Init(attacker, defender, dictionary, BattleObserverEventEnum.AttackBefore);
		system.Notify(BattleObserverEventEnum.AttackBefore, observerDamageProgressParams2);
		if (attacker.Parent != null)
		{
			observerDamageProgressParams.Clear();
			observerDamageProgressParams.Init(attacker.Parent, defender, dictionary, BattleObserverEventEnum.DamageBefore);
			system.Notify(BattleObserverEventEnum.DamageBefore, observerDamageProgressParams);
			observerDamageProgressParams2.Clear();
			observerDamageProgressParams2.Init(attacker.Parent, defender, dictionary, BattleObserverEventEnum.AttackBefore);
			system.Notify(BattleObserverEventEnum.AttackBefore, observerDamageProgressParams);
		}
		ReferencePool.Release(observerDamageProgressParams);
		ReferencePool.Release(observerDamageProgressParams2);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	protected override void SendBattleMsg()
	{
		if (dataDamage.bulletAttackData != null && dataDamage.bulletAttackData.bulletData.cfg.IsIgnoreHit)
		{
			return;
		}
		BattleObserverSystem system = defender.GetSystem<BattleObserverSystem>();
		if (system == null)
		{
			return;
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("Damage", resultData.damage);
		dictionary.Add("Tenacity", resultData.tenacity);
		dictionary.Add("EnergyChanged", resultData.energy);
		dictionary.Add("SkillId", dataDamage.BelongToSkillId);
		dictionary.Add("Critical", GetDamageFormulaData<CritFormulaData>()?.isCrit ?? false);
		dictionary.Add("WeakNessLv", damageParams.weaknessData?.Level ?? 0);
		dictionary.Add("DefendState", (defender.GetComponent<StateComponent>()?.GetCurrentState()?.Id).GetValueOrDefault());
		dictionary.Add("KnockDown", resultData.hitDown);
		dictionary.Add("BossDownState", resultData.hitDownState);
		dictionary.Add("ImmuneState", damageParams.isImmuneState);
		dictionary.Add("MonsterPhase", resultData.monsterPhaseEnum);
		dictionary.Add("IsKillDown", resultData.isKillDown);
		if (dataDamage.bulletAttackData != null)
		{
			dictionary.Add("BulletId", dataDamage.bulletAttackData.bulletId);
			dictionary.Add("BulletConfigId", dataDamage.bulletAttackData.bulletData.cfg.Id);
			dictionary.Add("BulletLabel", dataDamage.bulletAttackData.bulletData.cfg.BulletLabel);
			if (dataDamage.bulletAttackData.HitColliderVariableData != null)
			{
				dictionary.Add("SiteLevel", dataDamage.bulletAttackData.HitColliderVariableData.SiteLevel);
				dictionary.Add("PartName", dataDamage.bulletAttackData.HitColliderVariableData.partName);
			}
		}
		ObserverDamageProgressParams observerDamageProgressParams = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams.Init(attacker, defender, dictionary, BattleObserverEventEnum.Damage);
		system.Notify(BattleObserverEventEnum.Damage, observerDamageProgressParams);
		ObserverDamageProgressParams observerDamageProgressParams2 = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams2.Init(attacker, defender, dictionary, BattleObserverEventEnum.Attack);
		system.Notify(BattleObserverEventEnum.Attack, observerDamageProgressParams2);
		if (attacker.Parent != null)
		{
			observerDamageProgressParams.Init(attacker.Parent, defender, dictionary, BattleObserverEventEnum.Damage);
			system.Notify(BattleObserverEventEnum.Damage, observerDamageProgressParams);
			observerDamageProgressParams2.Init(attacker.Parent, defender, dictionary, BattleObserverEventEnum.Attack);
			system.Notify(BattleObserverEventEnum.Attack, observerDamageProgressParams2);
		}
		ReferencePool.Release(observerDamageProgressParams);
		ReferencePool.Release(observerDamageProgressParams2);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	protected override void OnExcuteDamageProcess()
	{
		base.OnExcuteDamageProcess();
		if (damageParams.isImmuneState)
		{
			resultData.damage = 0;
			return;
		}
		for (int i = 0; i < _damageFormulaZones.Length; i++)
		{
			FormulaZoneDataBase item = _damageFormulaZones[i].CalcFormulaZone(damageParams);
			damageFormulaDataList.Add(item);
		}
		double num = damageFormulaDataList[0].result;
		for (int j = 1; j < damageFormulaDataList.Count; j++)
		{
			num *= (double)damageFormulaDataList[j].result;
		}
		resultData.damage = Mathf.Max(0, num.CeilToInt());
	}

	protected override void ExecuteDamageLog()
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"召唤物伤害公式计算流程： 攻击者实体ID:{attacker.Id} => 受击者实体ID:{defender.Id} 是否免疫伤害:{damageParams.isImmuneState} ------------>", attacker);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId("召唤物伤害公式计算流程结束 ------------>", attacker);
		}
	}

	protected override void OnExcuteTenacityProcess()
	{
		base.OnExcuteTenacityProcess();
		if (damageParams.isImmuneState)
		{
			resultData.tenacity = 0;
			return;
		}
		tenacityParams.damage = resultData.damage;
		for (int i = 0; i < _tenacityFormulaZones.Length; i++)
		{
			FormulaZoneDataBase item = _tenacityFormulaZones[i].CalcFormulaZone(tenacityParams);
			tenacityFormulaDataList.Add(item);
		}
		double num = tenacityFormulaDataList[0].result;
		for (int j = 1; j < tenacityFormulaDataList.Count; j++)
		{
			num *= (double)tenacityFormulaDataList[j].result;
		}
		resultData.tenacity = Mathf.Max(0, num.CeilToInt());
	}

	protected override void ExecuteTenacityLog()
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"削韧公式计算流程： 攻击者实体ID:{attacker.Id} => 受击者实体ID:{defender.Id} ------------>", attacker);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId("削韧公式计算流程结束 ------------>", attacker);
		}
	}

	protected override void OnExcuteProcessSettlement()
	{
		bool flag = false;
		StateComponent component = defender.GetComponent<StateComponent>();
		if (component != null)
		{
			resultData.hitDownState = component.IsDownState();
			flag = component.IsNearDeathState();
			resultData.damageBeforeState = component.GetCurrentState()?.Id ?? 0;
		}
		TenacityComponent component2 = defender.GetComponent<TenacityComponent>();
		if (component2 != null)
		{
			int realTenacityValue = 0;
			component2.DealTenacityHit(resultData.tenacity, attacker, ref resultData.hitDown, ref realTenacityValue);
			resultData.tenacity = realTenacityValue;
		}
		int weaknessLevel = 1;
		BaseWeaknessData weaknessData = damageParams.weaknessData;
		if (weaknessData != null)
		{
			weaknessLevel = weaknessData.Level;
		}
		HarmIncreaseProperty(resultData.damage, resultData.hitDown, weaknessLevel);
		DealEntityParadoxData();
		HandleVirtualHp();
		bool flag2 = GetDamageFormulaData<DefenceFormulaData>()?.isExtraReduceDamage ?? false;
		if (!dataDamage.IsIgnoreHit)
		{
			RecodeHitData(weaknessData, resultData.damage, flag2);
		}
		if (!flag)
		{
			SwitchState();
			HandleBulletState();
			RecordEntityDamageState();
		}
		float value = AccountDamage(resultData.damage, flag, out resultData.isKillDown);
		resultData.damage = value.CeilToInt();
		SendBattleMsg();
		SendBattleAddEnergy();
		HandleDamageText();
		AttackBossWeakNotify();
		HandleEntityShake();
		PlayWeaknessEffect();
		if (!flag)
		{
			PlayHitEffect(flag2);
		}
		OnBattleSettlement();
	}

	protected void HarmIncreaseProperty(int damage, bool isHitDown, int weaknessLevel)
	{
		defender.GetComponent<MonsterPhaseComponent>()?.OnHitChangeAnger(damage, attacker);
		HandleBulletProperty(isHitDown, weaknessLevel);
		attacker.GetComponent<HeroAngerComponent>()?.RefreshHeroAngerLifeTime();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"怪物是否击倒  {isHitDown}", attacker);
		}
		if (!isHitDown)
		{
			return;
		}
		List<int> teamEntityId = attacker.GetSystem<EntitySystem>().GetTeamEntityId(0, isIncludeEntity: true, EntityLogicType.Logic);
		float monsterKnockDownEnergy = attacker.GetWorld().BattleConfig.MonsterKnockDownEnergy;
		for (int i = 0; i < teamEntityId.Count; i++)
		{
			BaseEntity entity = attacker.GetSystem<EntitySystem>().GetEntity(teamEntityId[i]);
			if (entity != null)
			{
				if (entity.Id == attacker.Id)
				{
					float property = entity.GetProperty("Energy");
					entity.ChangeProperty("Energy", monsterKnockDownEnergy);
					attacker.GetSystem<BattleSystem>()?.OnEnergyChangeStat(attacker.Id, EnergyRecoverEnum.MonsterKonckDown, entity.GetProperty("Energy") - property);
				}
				else
				{
					entity.ChangeProperty("Energy", monsterKnockDownEnergy);
				}
			}
		}
		CollectionPool<List<int>, int>.Release(teamEntityId);
	}

	protected override bool HandleBulletProperty(bool isHitDown, int weaknessLevel)
	{
		if (!base.HandleBulletProperty(isHitDown, weaknessLevel))
		{
			return false;
		}
		if (resultData.hitDownState)
		{
			OnBulletKnockDownProperty();
		}
		OnBulletWeaknessProperty(weaknessLevel);
		OnBulletHitBoxProperty();
		return true;
	}

	protected BaseWeaknessData GetWeaknessData()
	{
		if (defender != null)
		{
			WeaknessComponent component = defender.GetComponent<WeaknessComponent>();
			if (component != null)
			{
				return component.GetUsageWeakness();
			}
		}
		return null;
	}

	protected void HandleVirtualHp()
	{
		attacker.GetComponent<HpComponent>()?.VirtualHpConvertHp(dataDamage.virtualHpScale);
	}

	protected void HandleEntityShake()
	{
		int attackPower = dataDamage.attackPower;
		float shakeTime = dataDamage.shakeTime;
		if (attackPower > 0 && !(shakeTime <= 0f))
		{
			BaseEntity baseEntity = attacker;
			bool? obj;
			if (baseEntity == null)
			{
				obj = null;
			}
			else
			{
				BaseEntity parent = baseEntity.Parent;
				obj = ((parent != null) ? new bool?(!parent.IsActorEntity) : ((bool?)null));
			}
			bool? flag = obj;
			if (flag == true)
			{
				defender.GetComponent<EntityShakeComponent>()?.ShakeEntity(shakeTime, attackPower, 0.3f);
				return;
			}
			defender.GetComponent<EntityShakeComponent>()?.ShakeEntity(shakeTime, attackPower, 1f);
			int weaknessLevel = damageParams.weaknessData?.Level ?? 1;
			defender.GetComponent<EntityGoldBodyComponent>()?.AddGoldBodyData(attackPower, weaknessLevel);
		}
	}

	protected void PlayWeaknessEffect()
	{
		if (dataDamage == null || dataDamage.bulletAttackData == null)
		{
			return;
		}
		BaseWeaknessData weaknessData = damageParams.weaknessData;
		int weaknessAttackPower = dataDamage.bulletAttackData.weaknessAttackPower;
		BaseEntity parent = attacker.Parent;
		if ((parent == null || parent.IsActorEntity) && weaknessData != null && weaknessData.CurrentState() != -1 && !weaknessData.EffectList.IsNullOrEmpty() && !weaknessData.EffectCoolingList.IsNullOrEmpty())
		{
			if (weaknessData.EffectList.Count > weaknessAttackPower)
			{
				defender.GetSystem<EffectSystem>()?.PlayEffect(defender, defender, weaknessData.EffectList[weaknessAttackPower], defender.transform.position, defender.transform.eulerAngles);
			}
			if (weaknessData.EffectCoolingList.Count > weaknessAttackPower && weaknessData.EffectCoolingList[weaknessAttackPower] != 0)
			{
				defender.GetSystem<EffectSystem>()?.PlayEffect(defender, defender, weaknessData.EffectCoolingList[weaknessAttackPower], defender.transform.position, defender.transform.eulerAngles);
			}
		}
	}

	protected void OnBattleSettlement()
	{
		BattleSystem system = attacker.GetSystem<BattleSystem>();
		if (system != null)
		{
			system.Account(AccountType.Damage, resultData.damage, attacker.Id);
			system.Account(AccountType.Tenacity, resultData.tenacity, attacker.Id);
			if (attacker.Parent != null && attacker.Parent.IsSurvival)
			{
				system.Account(AccountType.Damage, resultData.damage, attacker.Parent.Id);
				system.Account(AccountType.Tenacity, resultData.tenacity, attacker.Parent.Id);
			}
		}
	}

	protected void ShowHpBar()
	{
		if (defender is MonsterEntity { IsBoss: false })
		{
			defender.GetComponent<HpComponent>().ShowHpBar();
		}
	}

	public override void Clear()
	{
		base.Clear();
		tenacityParams = null;
	}
}
