using System;
using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改全局速度", "Action", new string[] { "change", "global", "speed", "move", "movement", "position", "velocity" })]
public class ActionChangeGlobalSpeed : ConfigAction
{
	[Tooltip("持续时间,变速的过渡时间,TimeScale的大小")]
	public SystemTime.ConfigChangeGlobalSpeed configChangeGlobalSpeed;

	public bool forAlliance;

	public Alliance alliance;

	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	public BaseFindTargets additionalFindTargets;

	public TimeType timeType;

	public bool affectWorldRuntime;

	private static readonly Array TimeTypeValues = Enum.GetValues(typeof(TimeType));

	[NonSerialized]
	private EntityAction _changeGlobalSpeedAction;

	[NonSerialized]
	private HashSet<Entity> _currentAppliedTargets;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		if (affectWorldRuntime)
		{
			GameManager.timeSystem.ChangeWorldRuntimeSpeed(configChangeGlobalSpeed);
		}
		if (_changeGlobalSpeedAction == null)
		{
			_changeGlobalSpeedAction = ChangeGlobalSpeedEntity;
		}
		if (additionalFindTargets == null)
		{
			GameManager.timeSystem.MajorFilter.ForEach(_changeGlobalSpeedAction);
			return;
		}
		_currentAppliedTargets = HashSetPool<Entity>.Get();
		try
		{
			GameManager.timeSystem.MajorFilter.ForEach(_changeGlobalSpeedAction);
			ApplyAdditionalFindTargets(memory);
		}
		finally
		{
			HashSetPool<Entity>.Release(_currentAppliedTargets);
			_currentAppliedTargets = null;
		}
	}

	private void ChangeGlobalSpeedEntity(Entity entity)
	{
		ApplyTimerToTarget(entity, checkEntityType: true);
	}

	private void ApplyAdditionalFindTargets(ActionMemory memory)
	{
		if (additionalFindTargets == null)
		{
			return;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		try
		{
			additionalFindTargets.FindTargets(memory, memory.owner, list);
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

	private void ApplyTimerToTarget(Entity entity, bool checkEntityType)
	{
		if (!entity.IsValid || (checkEntityType && !filterEntityType.HasEntityType(entity.GetEntityType())) || !entity.TryGetCompTime(out CompTime component) || (_currentAppliedTargets != null && !_currentAppliedTargets.Add(entity)))
		{
			return;
		}
		SystemTime timeSystem = GameManager.timeSystem;
		foreach (TimeType timeTypeValue in TimeTypeValues)
		{
			if ((timeType & timeTypeValue) != 0)
			{
				TimeSpeedTimer timeSpeedTimer = timeSystem.timerPool.Get();
				timeSpeedTimer.InitTimer(configChangeGlobalSpeed);
				component.AddSpeedTimer(timeTypeValue, timeSpeedTimer);
			}
		}
	}
}
