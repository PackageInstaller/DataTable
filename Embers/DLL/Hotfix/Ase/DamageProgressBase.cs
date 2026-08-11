#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public abstract class DamageProgressBase : IReference
{
	protected BaseEntity attacker;

	protected BaseEntity defender;

	protected BuffDataDamage dataDamage;

	protected FormulaResultData resultData;

	protected DamageFormulaDataParams damageParams;

	protected List<FormulaZoneDataBase> damageFormulaDataList;

	protected List<FormulaZoneDataBase> tenacityFormulaDataList;

	public BaseEntity GetAttacker()
	{
		return attacker;
	}

	public BaseEntity GetDefender()
	{
		return defender;
	}

	public BuffDataDamage GetDataDamage()
	{
		return dataDamage;
	}

	public FormulaResultData GetResultData()
	{
		return resultData;
	}

	public void ProgressStart(BaseEntity attacker, BaseEntity defender, BuffDataDamage dataDamage)
	{
		if (attacker != null && defender != null && dataDamage != null)
		{
			this.attacker = attacker;
			this.defender = defender;
			this.dataDamage = dataDamage;
			if (defender.GetEntityType() != EntityType.INTERACTIVE)
			{
				resultData = default(FormulaResultData);
				OnExecuteProgressStart();
			}
		}
	}

	protected virtual void OnExcuteDamageProcess()
	{
		damageFormulaDataList = CollectionPool<List<FormulaZoneDataBase>, FormulaZoneDataBase>.Get();
	}

	protected virtual void OnExcuteTenacityProcess()
	{
		tenacityFormulaDataList = CollectionPool<List<FormulaZoneDataBase>, FormulaZoneDataBase>.Get();
	}

	public void OnExcuteProgress()
	{
		if (attacker == null || defender == null)
		{
			Log.Error($"伤害流程出错，实体为空。attacker:{attacker != null} , defender:{defender != null}");
		}
		else
		{
			if (!defender.IsSurvival)
			{
				return;
			}
			if (defender.GetEntityType() == EntityType.INTERACTIVE)
			{
				OnInteractiveHit(defender, dataDamage);
				return;
			}
			if (attacker.IsCanExecuteLogic)
			{
				OnExecuteProgressLogic();
				if (!CheckProgressSettlementIsBreak())
				{
					OnExcuteProcessSettlement();
					OnExcuteProgressLogicEnd();
				}
			}
			if (attacker.IsCanExecuteDisPlay)
			{
				OnExecuteProgressDisplay();
			}
		}
	}

	protected virtual void OnExecuteProgressStart()
	{
		SendBeforeBuffMessage();
	}

	protected abstract void ExecuteDamageLog();

	protected abstract void ExecuteTenacityLog();

	protected abstract void OnExecuteProgressLogic();

	protected abstract void OnExcuteProcessSettlement();

	protected virtual void OnExcuteProgressLogicEnd()
	{
		ObserverHitParams observerHitParams = ReferencePool.Acquire<ObserverHitParams>();
		observerHitParams.Init(defender, attacker, dataDamage.BelongToSkillId, dataDamage.bulletAttackData?.bulletId ?? 0, resultData.damage, resultData.isKillDown, damageParams.weaknessData, dataDamage.bulletAttackData?.HitColliderVariableData ?? null, GetDamageFormulaData<CritFormulaData>()?.isCrit ?? false);
		defender.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.Hit, observerHitParams);
		ReferencePool.Release(observerHitParams);
	}

	protected virtual void OnExecuteProgressDisplay()
	{
		HandleAddFrozenAndChaseFrameLogic();
	}

	protected bool CheckProgressSettlementIsBreak()
	{
		if (defender is SummonedEntity summonedEntity && summonedEntity.SummonedConfig.SummonedHitTypeEnum == SummonedHitTypeEnum.Summoner)
		{
			ExcuteSummonedCreatorDamageProgress();
			return true;
		}
		return false;
	}

	protected void ExcuteSummonedCreatorDamageProgress()
	{
		BuffDataDamage buffDataDamage = ReferencePool.Acquire<BuffDataDamage>();
		buffDataDamage.fixedValue = resultData.damage;
		buffDataDamage.damageTextId = 10016;
		buffDataDamage.isExcuteFormula = false;
		DamageProgressBase damageProgress = BattleFormulaUtility.GetDamageProgress(attacker.GetEntityType(), buffDataDamage);
		damageProgress.ProgressStart(attacker, defender.Parent, buffDataDamage);
		damageProgress.OnExcuteProgress();
	}

	protected T GetDamageFormulaData<T>() where T : FormulaZoneDataBase
	{
		if (damageFormulaDataList != null)
		{
			foreach (FormulaZoneDataBase damageFormulaData in damageFormulaDataList)
			{
				if (damageFormulaData is T)
				{
					return (T)damageFormulaData;
				}
			}
		}
		return null;
	}

	protected T GetTenacityFormulaData<T>() where T : FormulaZoneDataBase
	{
		if (tenacityFormulaDataList != null)
		{
			foreach (FormulaZoneDataBase tenacityFormulaData in tenacityFormulaDataList)
			{
				if (tenacityFormulaData is T)
				{
					return (T)tenacityFormulaData;
				}
			}
		}
		return null;
	}

	public virtual void SendBeforeBuffMessage()
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
		dictionary.Add("ImmuneState", damageParams.isImmuneState);
		dictionary.Add("WeakNessLv", damageParams.weaknessData?.Level ?? 0);
		if (dataDamage.bulletAttackData != null)
		{
			dictionary.Add("BulletId", dataDamage.bulletAttackData.bulletId);
			dictionary.Add("BulletLabel", dataDamage.bulletAttackData.bulletData.cfg.BulletLabel);
			dictionary.Add("BulletConfigId", dataDamage.bulletAttackData.bulletData.cfg.Id);
			if (dataDamage.bulletAttackData.HitColliderVariableData != null)
			{
				dictionary.Add("SiteLevel", dataDamage.bulletAttackData.HitColliderVariableData.SiteLevel);
				dictionary.Add("PartName", dataDamage.bulletAttackData.HitColliderVariableData.partName);
			}
		}
		ObserverDamageProgressParams observerDamageProgressParams = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams.Init(attacker, defender, dictionary, BattleObserverEventEnum.DamageBefore);
		system.Notify(BattleObserverEventEnum.DamageBefore, observerDamageProgressParams);
		ReferencePool.Release(observerDamageProgressParams);
		ObserverDamageProgressParams observerDamageProgressParams2 = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams2.Init(attacker, defender, dictionary, BattleObserverEventEnum.AttackBefore);
		system.Notify(BattleObserverEventEnum.AttackBefore, observerDamageProgressParams2);
		ReferencePool.Release(observerDamageProgressParams2);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	protected virtual void SendBattleMsg()
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
		dictionary.Add("Critical", GetDamageFormulaData<CritFormulaData>()?.isCrit ?? false);
		dictionary.Add("WeakNessLv", damageParams.weaknessData?.Level ?? 0);
		dictionary.Add("DefendState", resultData.damageState);
		dictionary.Add("KnockDown", resultData.hitDown);
		dictionary.Add("BossDownState", resultData.hitDownState);
		dictionary.Add("ImmuneState", damageParams.isImmuneState);
		dictionary.Add("MonsterPhase", resultData.monsterPhaseEnum);
		dictionary.Add("IsKillDown", resultData.isKillDown);
		dictionary.Add("ParrySuccess", resultData.isParry);
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
		ReferencePool.Release(observerDamageProgressParams);
		ObserverDamageProgressParams observerDamageProgressParams2 = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams2.Init(attacker, defender, dictionary, BattleObserverEventEnum.Attack);
		system.Notify(BattleObserverEventEnum.Attack, observerDamageProgressParams2);
		ReferencePool.Release(observerDamageProgressParams2);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void SendBattleAddEnergy()
	{
		if (attacker != null && attacker.IsActorEntity && resultData.energy > 0f)
		{
			BattleObserverSystem system = attacker.GetSystem<BattleObserverSystem>();
			if (system != null)
			{
				ObserverActorAddEenergyParams observerActorAddEenergyParams = ReferencePool.Acquire<ObserverActorAddEenergyParams>();
				observerActorAddEenergyParams.Init(attacker);
				system.Notify(BattleObserverEventEnum.ActorAddEnergy, observerActorAddEenergyParams);
				ReferencePool.Release(observerActorAddEenergyParams);
			}
		}
	}

	protected void HandleDamageText()
	{
		if (resultData.damage <= 0)
		{
			return;
		}
		Vector3 zero = Vector3.zero;
		zero = ((dataDamage.bulletAttackData?.Volume == null || dataDamage.bulletAttackData.Volume.VolumeData == null) ? (defender.GetComponent<EntityBoneComponent>()?.GetBoneRoot("middle")?.localPosition ?? Vector3.zero) : (defender.transform.rotation * dataDamage.bulletAttackData.Volume.VolumeData.offset));
		int weaknessState = damageParams.weaknessData?.Level ?? (-1);
		int maxSiteLevel = dataDamage.bulletAttackData?.HitColliderVariableData?.SiteLevel ?? (-1);
		bool flag = defender.GetComponent<MonsterPhaseComponent>()?.GetMonsterPhaseIsBreak() ?? false;
		if (!IgnoreShowDamageText())
		{
			UIDamageTextSystem system = defender.GetSystem<UIDamageTextSystem>();
			TextDamageParam textDamageParam = ReferencePool.Acquire<TextDamageParam>();
			textDamageParam.OffsetPos = zero;
			textDamageParam.showContent = resultData.damage.ToString();
			if (defender.IsActorEntity)
			{
				system?.ShowStackDamageText(textDamageParam, defender, GetActorEntityDamageTextType(isDeadHit: false, ref textDamageParam.WeaknessLevel), dataDamage.BelongToSkillId);
				return;
			}
			textDamageParam.HitDownOrBreak = resultData.hitDownState | flag;
			textDamageParam.maxSiteLevel = maxSiteLevel;
			bool isCirt = GetDamageFormulaData<CritFormulaData>()?.isCrit ?? false;
			system?.ShowStackDamageText(textDamageParam, defender, GetDamageTextType(isCirt, weaknessState, resultData.hitDownState, flag, ref textDamageParam.WeaknessLevel), dataDamage.BelongToSkillId);
		}
	}

	protected void AttackBossWeakNotify()
	{
		if (defender is MonsterEntity { IsBoss: not false })
		{
			int level = damageParams.weaknessData?.Level ?? (-1);
			ObserverAttackBossWeakParams observerAttackBossWeakParams = ReferencePool.Acquire<ObserverAttackBossWeakParams>();
			observerAttackBossWeakParams.Init(defender, level, resultData.damage, resultData.tenacity);
			defender.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.AttackBossWeak, observerAttackBossWeakParams);
			ReferencePool.Release(observerAttackBossWeakParams);
		}
	}

	private bool IgnoreShowDamageText()
	{
		if (attacker.IsActorEntity)
		{
			return false;
		}
		if (defender.IsActorEntity)
		{
			return false;
		}
		if (defender is SummonedEntity summonedEntity)
		{
			BaseEntity parent = summonedEntity.Parent;
			if (parent != null && parent.IsActorEntity)
			{
				if (summonedEntity.IsSpecialSummoned)
				{
					return false;
				}
				return true;
			}
		}
		if (attacker is SummonedEntity)
		{
			BaseEntity parent2 = attacker.Parent;
			if (parent2 != null && parent2.IsActorEntity)
			{
				return false;
			}
		}
		return true;
	}

	private string GetActorEntityDamageTextType(bool isDeadHit, ref int weaknessLevel)
	{
		weaknessLevel = (isDeadHit ? 3 : 0);
		if (isDeadHit)
		{
			return "default";
		}
		return "injured";
	}

	private string GetDamageTextType(bool isCirt, int weaknessState, bool hitDown, bool hitBreak, ref int weaknessLevel)
	{
		weaknessLevel = Mathf.Clamp(weaknessState, 1, 3);
		if (dataDamage.damageTextId != 0)
		{
			return GetTextTypeByID(dataDamage.damageTextId);
		}
		if (isCirt && weaknessState < 0 && !hitDown && !hitBreak)
		{
			return "critical";
		}
		if (hitDown | hitBreak)
		{
			if (!isCirt)
			{
				return "default";
			}
			return "critical";
		}
		if (weaknessState >= 0)
		{
			if (!isCirt)
			{
				return "default";
			}
			return "critical";
		}
		return "default";
	}

	private string GetTextTypeByID(int textId)
	{
		DRDamageText dataRow = GameEntry.DataTable.GetDataRow<DRDamageText>(textId);
		if (dataRow == null)
		{
			return "injured";
		}
		return dataRow.DamageKey;
	}

	public virtual bool CheckImmuneState()
	{
		if (dataDamage.bulletAttackData?.bulletData?.isOnlyExecuteHit == true)
		{
			return false;
		}
		return defender.GetComponent<StateComponent>()?.ImmuneDamage(dataDamage.bulletAttackData?.bulletData?.cfg.IgnoreImmunityOnBulletHit) ?? false;
	}

	protected virtual void DealEntityParadoxData()
	{
		BulletAttackData bulletAttackData = dataDamage.bulletAttackData;
		if (bulletAttackData == null || !bulletAttackData.bulletData.cfg.IsIgnoreParadoxHit)
		{
			defender.GetComponent<AIParadoxComponent>()?.ChangeToHitState(dataDamage.hitDirect);
		}
	}

	public virtual bool SwitchState()
	{
		StateComponent component = defender.GetComponent<StateComponent>();
		if (component == null)
		{
			return false;
		}
		int attackPower = dataDamage.attackPower;
		int num = (int)defender.GetProperty("DefensePowerLevel");
		int num2 = (int)defender.GetProperty("DefensePowerLevelExtra");
		int entityAttackPowerById = GetEntityAttackPowerById();
		Dictionary<string, int> hitConfig = defender.GetSystem<HitSystem>().GetHitConfig(entityAttackPowerById);
		if (hitConfig == null)
		{
			return false;
		}
		resultData.defensePowerLevel = attackPower - (num + num2);
		string key = $"{attackPower}-{num + num2}";
		if (!hitConfig.ContainsKey(key))
		{
			return false;
		}
		component.AddState(hitConfig[key], attacker.Id);
		return true;
	}

	public void HandleBulletState()
	{
		DRBullet dRBullet = dataDamage.bulletAttackData?.bulletData?.cfg ?? null;
		if (dRBullet == null)
		{
			return;
		}
		for (int i = 0; i < dRBullet.State.Count; i++)
		{
			defender.GetComponent<StateComponent>()?.AddState(dRBullet.State[i], attacker.Id);
		}
		if (dRBullet.AbnormalState.Count == dRBullet.AbnormalStateValue.Count)
		{
			for (int j = 0; j < dRBullet.AbnormalState.Count; j++)
			{
				defender.GetComponent<AbnormalStateComponent>()?.AddAbnormalState(dRBullet.AbnormalState[j], attacker.Id, dRBullet.AbnormalStateValue[j]);
			}
		}
	}

	protected virtual void RecordEntityDamageState()
	{
		if (!dataDamage.IsIgnoreHit)
		{
			resultData.damageState = (defender.GetComponent<StateComponent>()?.GetCurrentState()?.Id).GetValueOrDefault();
		}
		else
		{
			resultData.damageState = 0;
		}
	}

	protected virtual bool HandleBulletProperty(bool isHitDown, int weaknessLevel)
	{
		if (dataDamage.bulletAttackData == null)
		{
			return false;
		}
		if (!dataDamage.bulletAttackData.bulletData.extraData.battleOnceData.IsUsedFrameProperty(attacker.GetWorld().Tick))
		{
			return false;
		}
		OnBulletHitProperty();
		return true;
	}

	protected virtual void OnBulletHitProperty()
	{
		List<List<string>> hitProperty = dataDamage.bulletAttackData.bulletData.cfg.HitProperty;
		if (hitProperty.IsNullOrEmpty())
		{
			return;
		}
		List<string> list = new List<string>();
		for (int i = 0; i < hitProperty.Count; i++)
		{
			List<string> list2 = hitProperty[i];
			if (list2.Count == 2)
			{
				list.AddRange(list2);
			}
		}
		HandlePropertyAddition(list);
	}

	protected virtual void OnBulletKnockDownProperty()
	{
		List<List<string>> knockDownProperty = dataDamage.bulletAttackData.bulletData.cfg.KnockDownProperty;
		if (knockDownProperty.IsNullOrEmpty())
		{
			return;
		}
		List<string> list = new List<string>();
		for (int i = 0; i < knockDownProperty.Count; i++)
		{
			List<string> list2 = knockDownProperty[i];
			if (list2.Count == 2)
			{
				list.AddRange(list2);
			}
		}
		HandlePropertyAddition(list);
	}

	protected virtual void OnBulletWeaknessProperty(int weaknessLevel)
	{
		List<List<string>> weaknessProperty = dataDamage.bulletAttackData.bulletData.cfg.WeaknessProperty;
		if (weaknessProperty.IsNullOrEmpty())
		{
			return;
		}
		List<string> list = new List<string>();
		for (int i = 0; i < weaknessProperty.Count; i++)
		{
			List<string> list2 = weaknessProperty[i];
			if (list2.Count == 3 && int.Parse(list2[0]) == weaknessLevel)
			{
				list.AddRange(list2);
			}
		}
		HandlePropertyAddition(list);
	}

	protected virtual void OnBulletHitBoxProperty()
	{
		List<List<string>> boxProperty = dataDamage.bulletAttackData.bulletData.cfg.BoxProperty;
		if (boxProperty.IsNullOrEmpty())
		{
			return;
		}
		List<string> list = new List<string>();
		for (int i = 0; i < boxProperty.Count; i++)
		{
			List<string> list2 = boxProperty[i];
			if (list2.Count == 3 && int.Parse(list2[0]) == dataDamage.bulletAttackData.HitColliderVariableData.SiteLevel)
			{
				list.AddRange(list2);
			}
		}
		HandlePropertyAddition(list);
	}

	protected void HandlePropertyAddition(List<string> propertyList)
	{
		PropertyAdditionData[] array = BattleFormulaUtility.PropertyStringListToAddition(propertyList);
		if (array != null)
		{
			HandlePropertyAddition(array);
		}
	}

	private void HandlePropertyAddition(PropertyAdditionData[] additions)
	{
		foreach (PropertyAdditionData propertyAdditionData in additions)
		{
			if (propertyAdditionData.propertyKey == "Energy")
			{
				HandleEnergyPropertyAddition(propertyAdditionData);
			}
			else
			{
				attacker.SetProperty(propertyAdditionData);
			}
		}
	}

	private void HandleEnergyPropertyAddition(PropertyAdditionData addition)
	{
		float attackerProperty = dataDamage.GetAttackerProperty("NormalAttackEnergyAmend");
		float attackerProperty2 = dataDamage.GetAttackerProperty("WeaknessEnergyAmend");
		addition.value *= 1f + attackerProperty + attackerProperty2;
		float attackerProperty3 = dataDamage.GetAttackerProperty(addition.propertyKey);
		attacker.SetProperty(addition);
		float attackerProperty4 = dataDamage.GetAttackerProperty(addition.propertyKey);
		resultData.energy += attackerProperty4 - attackerProperty3;
	}

	private int GetEntityAttackPowerById()
	{
		if (defender is ITargetEntity targetEntity)
		{
			return targetEntity.GetBallisticsCategory();
		}
		return 0;
	}

	protected virtual float AccountDamage(int finalDamage, bool isNearDeathState, out bool isStruckDown)
	{
		if (isNearDeathState)
		{
			defender.GetComponent<NearDeathRescueComponent>()?.OnNearDeathAttacked(finalDamage);
			isStruckDown = false;
			return 0f;
		}
		float result = defender.GetComponent<HpComponent>()?.ReduceHp(attacker, finalDamage, isDamageProduce: true) ?? 0f;
		isStruckDown = defender.GetProperty("Hp") == 0f;
		return result;
	}

	public void RecodeHitData(BaseWeaknessData weaknessData, int damage, bool isSubDamageSuccess)
	{
		int num = dataDamage.bulletAttackData?.weaknessAttackPower ?? 0;
		if (weaknessData != null)
		{
			weaknessData.RecodeWeaknessData(attacker);
			weaknessData.RecordWeaknessHitInfo(attacker, dataDamage.BelongToSkillId);
			weaknessData.weaknessAttackPower = num;
		}
		defender.GetComponent<AIParadoxComponent>()?.ChangeToWeaknessAttackPower(num);
		if (dataDamage.bulletAttackData != null)
		{
			HitData hitData = HitData.Create(attacker?.Id ?? 0, dataDamage.bulletAttackData.bulletId, defender?.Id ?? 0, dataDamage.bulletAttackData.bulletId, dataDamage.bulletAttackData.bulletData.BelongToSkillId, dataDamage.bulletAttackData.HitColliderVariableData?.SiteLevel ?? (-1), isSubDamageSuccess);
			hitData.SetHitData(defender.Id, weaknessData);
			dataDamage.bulletAttackData.bulletData.hitDataList?.Add(hitData);
			int bulletId = dataDamage.bulletAttackData.bulletId;
			int id = dataDamage.bulletAttackData.bulletData.cfg.Id;
			defender.GetComponent<HitComponent>()?.SetEntityInjuredData(attacker?.Id ?? 0, damage, bulletId, id);
			attacker.GetComponent<HitComponent>()?.SetBulletHitData(id, defender, dataDamage.bulletAttackData);
		}
	}

	protected void HandleAddFrozenAndChaseFrameLogic()
	{
		if (attacker != null && attacker.IsSurvival)
		{
			attacker.GetSystem<FrameFrozenSystem>()?.AddFrozenAndChaseFrame(1, attacker, dataDamage);
		}
	}

	protected void PlayHitEffect(bool isExtraReduceDamage)
	{
		if (dataDamage.effectId != 0)
		{
			if (string.IsNullOrEmpty(dataDamage.pointKey))
			{
				dataDamage.pointKey = "center";
			}
			defender.GetSystem<EffectSystem>()?.PlayEffect(attacker, defender, EffectType.FOLLOW_BONE, dataDamage.effectId, dataDamage.pointKey, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, followParentDispose: false);
		}
		if (dataDamage.bulletAttackData != null)
		{
			StateComponent component = defender.GetComponent<StateComponent>();
			if (component == null || !component.ImmuneHitEffect())
			{
				OnPlayHitEffect(defender, dataDamage.bulletAttackData.Volume, isExtraReduceDamage);
			}
		}
	}

	private void OnPlayHitEffect(BaseEntity entity, HitVolume hitVolume = null, bool isSubDamageSuccess = false)
	{
		if (isSubDamageSuccess)
		{
			return;
		}
		ParryComponent component = entity.GetComponent<ParryComponent>();
		if (component != null && component.OpenParry)
		{
			return;
		}
		Vector3 exactPosition = entity.transform.position;
		Vector3 exactEuler = entity.transform.eulerAngles;
		Vector3 bulletPos = dataDamage.bulletAttackData.BulletPos;
		List<float> hitEffectPositionYOffset = dataDamage.bulletAttackData.bulletData.cfg.HitEffectPositionYOffset;
		List<float> hitEffectRotateYOffset = dataDamage.bulletAttackData.bulletData.cfg.HitEffectRotateYOffset;
		if (entity is MonsterEntity monsterEntity)
		{
			CalculateEffectPosition(monsterEntity, dataDamage.bulletAttackData.BulletParentPropertyData.AttackerPos, hitVolume?.PrimitiveInfo.Center ?? exactPosition, bulletPos, ref exactPosition, ref exactEuler);
			Vector3 vector = (hitEffectPositionYOffset.IsNullOrEmpty() ? Vector3.zero : new Vector3(0f, hitEffectPositionYOffset[0], 0f));
			monsterEntity.GetComponent<MonsterHitEffectComponent>().PlayHitEffect(attacker, exactPosition + vector, exactEuler, resultData.damageBeforeState, resultData.damageState, dataDamage.bulletAttackData.HitColliderVariableData?.HitEffectIndex ?? 0, dataDamage.bulletAttackData.weaknessAttackPower);
		}
		List<int> hitSfx = dataDamage.bulletAttackData.bulletData.cfg.HitSfx;
		if (hitSfx == null)
		{
			return;
		}
		EffectSystem system = defender.GetSystem<EffectSystem>();
		if (system == null)
		{
			return;
		}
		for (int i = 0; i < hitSfx.Count; i++)
		{
			if (hitSfx[i] != 0)
			{
				Vector3 vector2 = ((hitEffectPositionYOffset != null && hitEffectPositionYOffset.Count > i) ? new Vector3(0f, hitEffectPositionYOffset[i], 0f) : Vector3.zero);
				Vector3 vector3 = ((hitEffectRotateYOffset != null && hitEffectRotateYOffset.Count > i) ? new Vector3(0f, hitEffectRotateYOffset[i], 0f) : Vector3.zero);
				system.PlayEffect(attacker, attacker, hitSfx[i], exactPosition + vector2, exactEuler + vector3, 1f, isHitEffect: true);
			}
		}
	}

	private void CalculateEffectPosition(MonsterEntity entity, Vector3 parentPos, Vector3 hitVolumeCenter, Vector3 bulletPosition, ref Vector3 exactPosition, ref Vector3 exactEuler)
	{
		bool isMelee = dataDamage.bulletAttackData.bulletData.cfg.IsMelee;
		float num = (isMelee ? entity.GetData<DRMonster>("MonsterConfig").NearPlayEffectRadius : entity.GetData<DRMonster>("MonsterConfig").FarPlayEffectRadius);
		bool isEffectRadius = entity.GetData<DRMonster>("MonsterConfig").IsEffectRadius;
		Vector3 zero = Vector3.zero;
		float y = TSUtil.Vector2Angle(new Vector2(hitVolumeCenter.x - parentPos.x, hitVolumeCenter.z - parentPos.z).normalized);
		exactEuler = new Vector3(0f, y, 0f);
		if (num == 0f || !isEffectRadius)
		{
			exactPosition = new Vector3(hitVolumeCenter.x, bulletPosition.y, hitVolumeCenter.z);
		}
		else if (isMelee)
		{
			if (attacker != null && attacker.IsSurvival)
			{
				zero = (new Vector3(attacker.transform.position.x, 0f, attacker.transform.position.z) - new Vector3(entity.transform.position.x, 0f, entity.transform.position.z)).normalized * num;
				exactPosition += zero;
				exactPosition.y = bulletPosition.y;
			}
		}
		else
		{
			zero = (new Vector3(bulletPosition.x, 0f, bulletPosition.z) - new Vector3(entity.transform.position.x, 0f, entity.transform.position.z)).normalized * num;
			exactPosition += zero;
			exactPosition.y = bulletPosition.y;
		}
	}

	protected virtual void OnInteractiveHit(BaseEntity defender, BuffDataDamage dataDamage)
	{
		defender.GetComponent<InteractiveLiftComponent>()?.OnHit(dataDamage.attackPower);
	}

	public virtual void Clear()
	{
		attacker = null;
		defender = null;
		damageParams = null;
		if (damageFormulaDataList != null)
		{
			damageFormulaDataList.Clear();
			CollectionPool<List<FormulaZoneDataBase>, FormulaZoneDataBase>.Release(damageFormulaDataList);
		}
		if (tenacityFormulaDataList != null)
		{
			tenacityFormulaDataList.Clear();
			CollectionPool<List<FormulaZoneDataBase>, FormulaZoneDataBase>.Release(tenacityFormulaDataList);
		}
		if (dataDamage != null)
		{
			ReferencePool.Release(dataDamage);
			dataDamage = null;
		}
		damageFormulaDataList = null;
		tenacityFormulaDataList = null;
	}
}
