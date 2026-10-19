using System;
using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinAnomaly : BaseAbilityMixin
{
	private ConfigMixinAnomaly m_Config;

	private AnomalyData m_AnomalyData;

	public AbilityMixinAnomaly(ConfigMixinAnomaly configMixinAnomaly, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = configMixinAnomaly;
	}

	public static int GetAnomalyLimit(AnomalyType anomalyType, Entity entity)
	{
		if (anomalyType == AnomalyType.Penetrate)
		{
			return 20;
		}
		anomalyConfig[] array = entity.GetConfig().anomalyConfig;
		for (int i = 0; i < array.Length; i++)
		{
			anomalyConfig anomalyConfig2 = array[i];
			if (anomalyConfig2.type == anomalyType)
			{
				return anomalyConfig2.limit;
			}
		}
		return 0;
	}

	internal override void OnAdd()
	{
		m_AnomalyData = Singleton<GameManager>.instance.ecsManager.systemAbility.GetAnomalyData();
		for (int i = 0; i < 2; i++)
		{
			m_AnomalyData.anomalyAbilities[i] = m_Config.anomalyAbilityName[(AnomalyType)i];
		}
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.AddListener(typeof(EvtAnomaly), this);
		compAbility.anomalyData = m_AnomalyData;
		compAbility.onDie += new Action<Entity>(RemovalAnomaly);
		compAbility.onRelase += new Action<Entity>(RelaseAnomaly);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtAnomaly evtAnomaly && owner.IsAlive() && FillingOrFull(evtAnomaly.anomalyValue, evtAnomaly.anomalyType) && m_Config.anomalyAbilityName[evtAnomaly.anomalyType] != null)
		{
			owner.GetCompAbility().AddAbility(caster, m_Config.anomalyAbilityName[evtAnomaly.anomalyType], AbilitySource.Ability, (ability != null) ? ability.skillLevelInfo : default(MPSkill), 1);
		}
	}

	internal override void FixedUpdate()
	{
		if (m_AnomalyData.isAnomaly && !owner.GetCompAbility().HasAbility(m_AnomalyData.anomalyAbilities[(int)m_AnomalyData.currAnomaly]))
		{
			m_AnomalyData.isShowUI[(int)m_AnomalyData.currAnomaly] = false;
			m_AnomalyData.isOver?.Invoke(m_AnomalyData.currAnomaly, owner);
			m_AnomalyData.isAnomaly = false;
			m_AnomalyData.currAnomaly = AnomalyType.count;
		}
	}

	private bool FillingOrFull(int value, AnomalyType anomalyType)
	{
		int anomalyLimit = GetAnomalyLimit(anomalyType, owner);
		if (anomalyLimit <= 0)
		{
			return false;
		}
		if (m_AnomalyData.isAnomaly)
		{
			return false;
		}
		m_AnomalyData.isShowUI[(int)anomalyType] = true;
		int num = m_AnomalyData.anomalyValue[(int)anomalyType] + value;
		m_AnomalyData.anomalyValue[(int)anomalyType] = Mathf.Min(num, anomalyLimit);
		m_AnomalyData.onValueChange[(int)anomalyType]?.Invoke();
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.anomalyValue = num;
		compAbility.anomalyLimit = anomalyLimit;
		if (num >= anomalyLimit)
		{
			m_AnomalyData.anomalyValue[(int)anomalyType] = 0;
			m_AnomalyData.isAnomaly = true;
			m_AnomalyData.currAnomaly = anomalyType;
			m_AnomalyData.isFull?.Invoke(anomalyType);
			return true;
		}
		return false;
	}

	internal override void OnRemove()
	{
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.RemoveListener(typeof(EvtAnomaly), this);
		compAbility.onDie -= new Action<Entity>(RemovalAnomaly);
		compAbility.onRelase -= new Action<Entity>(RelaseAnomaly);
		RemovalAnomaly(owner);
		RelaseAnomaly(owner);
	}

	private void RemovalAnomaly(Entity entity)
	{
		CompAbility compAbility = entity.GetCompAbility();
		if (compAbility.anomalyData != null && compAbility.anomalyData.isAnomaly)
		{
			compAbility.RemoveAbility(m_AnomalyData.anomalyAbilities[(int)m_AnomalyData.currAnomaly]);
			compAbility.anomalyData.isShowUI[(int)m_AnomalyData.currAnomaly] = false;
			compAbility.anomalyData.isOver?.Invoke(m_AnomalyData.currAnomaly, entity);
			compAbility.anomalyData.isAnomaly = false;
			compAbility.anomalyData.currAnomaly = AnomalyType.count;
		}
	}

	private void RelaseAnomaly(Entity entity)
	{
		GameManager.abilitySystem.ReleaseAnomalyData(m_AnomalyData);
		CompAbility compAbility = entity.GetCompAbility();
		if (compAbility != null)
		{
			compAbility.anomalyData = null;
		}
	}
}
