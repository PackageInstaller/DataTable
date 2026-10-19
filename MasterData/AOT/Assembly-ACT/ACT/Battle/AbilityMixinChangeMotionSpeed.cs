using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinChangeMotionSpeed : BaseAbilityMixin
{
	private ConfigMixinChangeMotionSpeed m_Config;

	private List<TimeSpeedTimer> _timers = new List<TimeSpeedTimer>();

	public AbilityMixinChangeMotionSpeed(ConfigMixinChangeMotionSpeed config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinChangeMotionSpeed)config;
	}

	internal override void ResetForPool()
	{
		_timers.Clear();
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility()?.AddListener(typeof(EvtMotionChange), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtMotionChange), this);
		ClearMotionScale();
	}

	internal override void OnSilentRemove()
	{
		ClearMotionScale();
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtMotionChange))
		{
			return;
		}
		EvtMotionChange evtMotionChange = evt as EvtMotionChange;
		ClearMotionScale();
		CompMotion compMotion = owner.GetCompMotion();
		if (m_Config.motionTypes != null && m_Config.motionTypes.Length != 0)
		{
			for (int i = 0; i < m_Config.motionTypes.Length; i++)
			{
				if (compMotion.curMotionState.ToString() == m_Config.motionTypes[i])
				{
					FixMotionScale();
				}
			}
			return;
		}
		for (int j = 0; j < m_Config.motionStates.Length; j++)
		{
			if (evtMotionChange.toState.name == m_Config.motionStates[j])
			{
				FixMotionScale();
			}
		}
	}

	private void FixMotionScale()
	{
		TimeSpeedTimer timeSpeedTimer = GameManager.timeSystem.timerPool.Get();
		timeSpeedTimer.InitTimer(m_Config.value, -1f);
		timeSpeedTimer.Type = TimeType.Motion;
		owner.GetCompTime().AddSpeedTimer(timeSpeedTimer.Type, timeSpeedTimer);
		_timers.Add(timeSpeedTimer);
	}

	private void ClearMotionScale()
	{
		if (owner.TryGetCompTime(out CompTime component))
		{
			for (int i = 0; i < _timers.Count; i++)
			{
				TimeSpeedTimer timeSpeedTimer = _timers[i];
				component.RemoveSpeedTimer(timeSpeedTimer.Type, timeSpeedTimer);
			}
		}
		_timers.Clear();
	}
}
