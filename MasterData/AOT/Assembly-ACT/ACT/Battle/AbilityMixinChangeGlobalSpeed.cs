using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinChangeGlobalSpeed : BaseAbilityMixin
{
	private struct AppliedTimer
	{
		public Entity target;

		public TimeType type;

		public TimeSpeedTimer timer;
	}

	private static readonly Array TimeTypeValues = Enum.GetValues(typeof(TimeType));

	private ConfigMixinChangeGlobalSpeed _config;

	private readonly List<AppliedTimer> _appliedTimers = new List<AppliedTimer>();

	private readonly EntityAction _applyTimerAction;

	private TimeSpeedTimer _worldRuntimeTimer;

	public AbilityMixinChangeGlobalSpeed(ConfigMixinChangeGlobalSpeed config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
		_applyTimerAction = ApplyTimerFromMajorFilter;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		_config = (ConfigMixinChangeGlobalSpeed)config;
	}

	internal override void ResetForPool()
	{
		_appliedTimers.Clear();
		_worldRuntimeTimer = null;
		_config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		RemoveTimers();
		if (_config.affectWorldRuntime)
		{
			_worldRuntimeTimer = GameManager.timeSystem.AddWorldRuntimeSpeedTimer(_config.configChangeGlobalSpeed);
		}
		GameManager.timeSystem.MajorFilter.ForEach(_applyTimerAction);
		ApplyAdditionalFindTargets();
	}

	internal override void OnRemove()
	{
		RemoveTimers();
	}

	internal override void OnSilentRemove()
	{
		RemoveTimers();
	}

	internal override void OnInheritRemove()
	{
	}

	internal override void OnInheritAdd()
	{
	}

	internal override void FixedUpdate()
	{
		GameManager.timeSystem?.MajorFilter.ForEach(_applyTimerAction);
	}

	private void ApplyTimerFromMajorFilter(Entity target)
	{
		ApplyTimerToTarget(target, checkEntityType: true);
	}

	private void ApplyAdditionalFindTargets()
	{
		if (_config.additionalFindTargets == null)
		{
			return;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		try
		{
			ActionMemory memory = new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner), null, ability);
			_config.additionalFindTargets.FindTargets(memory, owner, list);
			for (int i = 0; i < list.Count; i++)
			{
				ApplyTimerToTarget(list[i].entity, checkEntityType: false);
			}
		}
		finally
		{
			ListPool<FindTargetResult>.Release(list);
		}
	}

	private void ApplyTimerToTarget(Entity target, bool checkEntityType)
	{
		Alliance alliance = GameUtility.GetAlliance(_config.alliance, owner.GetCompAlliance().alliance);
		if (!target.IsValid || (target.GetCompAlliance().alliance & alliance) == 0 || (checkEntityType && !_config.filterEntityType.HasEntityType(target.GetEntityType())) || !target.TryGetCompTime(out CompTime component) || HasAppliedTimer(target))
		{
			return;
		}
		SystemTime timeSystem = GameManager.timeSystem;
		foreach (TimeType timeTypeValue in TimeTypeValues)
		{
			if ((_config.timeType & timeTypeValue) != 0)
			{
				TimeSpeedTimer timeSpeedTimer = timeSystem.timerPool.Get();
				timeSpeedTimer.InitTimer(_config.configChangeGlobalSpeed.speed, -1f, Mathf.Max(0f, _config.configChangeGlobalSpeed.easeTime));
				timeSpeedTimer.Type = timeTypeValue;
				component.AddSpeedTimer(timeTypeValue, timeSpeedTimer);
				_appliedTimers.Add(new AppliedTimer
				{
					target = target,
					type = timeTypeValue,
					timer = timeSpeedTimer
				});
			}
		}
	}

	private bool HasAppliedTimer(Entity target)
	{
		for (int i = 0; i < _appliedTimers.Count; i++)
		{
			if (_appliedTimers[i].target == target)
			{
				return true;
			}
		}
		return false;
	}

	private void RemoveAppliedTimers()
	{
		for (int num = _appliedTimers.Count - 1; num >= 0; num--)
		{
			AppliedTimer appliedTimer = _appliedTimers[num];
			if (appliedTimer.target.TryGetCompTime(out CompTime component))
			{
				component.RemoveSpeedTimer(appliedTimer.type, appliedTimer.timer);
				component.UpdateTimeScale(appliedTimer.type);
			}
		}
		_appliedTimers.Clear();
	}

	private void RemoveTimers()
	{
		RemoveAppliedTimers();
		if (_worldRuntimeTimer != null)
		{
			GameManager.timeSystem.RemoveWorldRuntimeSpeedTimer(_worldRuntimeTimer);
			_worldRuntimeTimer = null;
		}
	}
}
