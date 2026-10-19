using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class EntityStatePlayMixerBehaviour : PlayableBehaviour
{
	private const float ActiveWeightThreshold = 0.0001f;

	private Entity _entity;

	private bool _exclusiveApplied;

	private bool _lockNormalFsmTransition;

	private bool _allowRootMotionInTimeline;

	private readonly List<int> _activeClipHashes = new List<int>(4);

	private readonly List<ConfigAnimParameter> _activeExitParameters = new List<ConfigAnimParameter>(4);

	private readonly List<int> _frameClipHashes = new List<int>(4);

	private readonly List<ConfigAnimParameter> _frameExitParameters = new List<ConfigAnimParameter>(4);

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		Entity entity = EntityControlPlayableUtility.ResolveEntity(playerData);
		if (entity == null)
		{
			return;
		}
		_entity = entity;
		SystemBehave behaveSystem = GameManager.behaveSystem;
		if (behaveSystem == null)
		{
			return;
		}
		int inputCount = playable.GetInputCount();
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		_frameClipHashes.Clear();
		_frameExitParameters.Clear();
		List<(EntityStatePlayBehaviour.StateSource, string, int, float, float)> list = ListPool<(EntityStatePlayBehaviour.StateSource, string, int, float, float)>.Get();
		try
		{
			for (int i = 0; i < inputCount; i++)
			{
				ScriptPlayable<EntityStatePlayBehaviour> scriptPlayable = (ScriptPlayable<EntityStatePlayBehaviour>)playable.GetInput(i);
				EntityStatePlayBehaviour behaviour = scriptPlayable.GetBehaviour();
				if (behaviour != null && !string.IsNullOrWhiteSpace(behaviour.stateName))
				{
					int hashCode = scriptPlayable.GetHashCode();
					float inputWeight = playable.GetInputWeight(i);
					if (!(inputWeight <= 0.0001f) && !behaveSystem.IsTimelineLayer0StateFinished(_entity, hashCode))
					{
						flag = true;
						flag2 |= behaviour.lockNormalFsmTransition;
						flag3 |= behaviour.allowRootMotionInTimeline;
						_frameClipHashes.Add(hashCode);
						_frameExitParameters.Add(behaviour.exitParameter);
						list.Add((behaviour.stateSource, behaviour.stateName, hashCode, inputWeight, behaviour.blendOffset));
					}
				}
			}
			FireInactiveClipExitParameters();
			SyncActiveClipExitParameters();
			if (!flag)
			{
				ClearTimelineLayer0States();
				ReleaseExclusiveWindow();
			}
			else
			{
				ApplyExclusiveWindow(flag2, flag3);
				behaveSystem.UpdateTimelineLayer0States(_entity, list);
			}
		}
		finally
		{
			ListPool<(EntityStatePlayBehaviour.StateSource, string, int, float, float)>.Release(list);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		FireAllActiveClipExitParameters();
		ClearTimelineLayer0States();
		ReleaseExclusiveWindow();
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		FireAllActiveClipExitParameters();
		ClearTimelineLayer0States();
		ReleaseExclusiveWindow();
		_entity = default;
	}

	public override void OnGraphStop(Playable playable)
	{
		FireAllActiveClipExitParameters();
		ClearTimelineLayer0States();
		ReleaseExclusiveWindow();
	}

	private void FireInactiveClipExitParameters()
	{
		for (int i = 0; i < _activeClipHashes.Count; i++)
		{
			if (!ContainsFrameClip(_activeClipHashes[i]))
			{
				FireExitParameter(_activeExitParameters[i]);
			}
		}
	}

	private void FireAllActiveClipExitParameters()
	{
		for (int i = 0; i < _activeExitParameters.Count; i++)
		{
			FireExitParameter(_activeExitParameters[i]);
		}
		_activeClipHashes.Clear();
		_activeExitParameters.Clear();
		_frameClipHashes.Clear();
		_frameExitParameters.Clear();
	}

	private bool ContainsFrameClip(int clipHash)
	{
		for (int i = 0; i < _frameClipHashes.Count; i++)
		{
			if (_frameClipHashes[i] == clipHash)
			{
				return true;
			}
		}
		return false;
	}

	private void SyncActiveClipExitParameters()
	{
		_activeClipHashes.Clear();
		_activeExitParameters.Clear();
		for (int i = 0; i < _frameClipHashes.Count; i++)
		{
			_activeClipHashes.Add(_frameClipHashes[i]);
			_activeExitParameters.Add(_frameExitParameters[i]);
		}
	}

	private void FireExitParameter(ConfigAnimParameter exitParameter)
	{
		if (_entity == null || exitParameter == null || string.IsNullOrWhiteSpace(exitParameter.name))
		{
			return;
		}
		CompMotion compMotion = _entity.GetCompMotion();
		if (compMotion != null)
		{
			switch (exitParameter.type)
			{
			case ConfigAnimParameterType.Trigger:
				compMotion.SetTrigger(exitParameter.name);
				break;
			case ConfigAnimParameterType.Bool:
				compMotion.SetBool(exitParameter.name, exitParameter.defaultBool);
				break;
			case ConfigAnimParameterType.Float:
				compMotion.SetFloat(exitParameter.name, exitParameter.defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				compMotion.SetInt(exitParameter.name, exitParameter.defaultInt);
				break;
			}
		}
	}

	private void ApplyExclusiveWindow(bool lockNormalFsmTransition, bool allowRootMotionInTimeline)
	{
		if (_entity == null)
		{
			return;
		}
		CompMotion compMotion = _entity.GetCompMotion();
		if (compMotion != null && (!_exclusiveApplied || _lockNormalFsmTransition != lockNormalFsmTransition || _allowRootMotionInTimeline != allowRootMotionInTimeline))
		{
			ReleaseExclusiveWindow();
			_lockNormalFsmTransition = lockNormalFsmTransition;
			_allowRootMotionInTimeline = allowRootMotionInTimeline;
			if (_lockNormalFsmTransition)
			{
				compMotion.montageExclusiveRefCount++;
			}
			if (_allowRootMotionInTimeline)
			{
				compMotion.AddRuntimeMotionTag(MotionTag_backUp.TimelineAllowRootMotion);
			}
			_entity.SetBool("InTimeline", value: true);
			_exclusiveApplied = true;
		}
	}

	private void ReleaseExclusiveWindow()
	{
		if (!_exclusiveApplied)
		{
			return;
		}
		if (_entity != null)
		{
			CompMotion compMotion = _entity.GetCompMotion();
			if (compMotion != null)
			{
				if (_lockNormalFsmTransition)
				{
					compMotion.montageExclusiveRefCount = Math.Max(0, compMotion.montageExclusiveRefCount - 1);
				}
				if (_allowRootMotionInTimeline)
				{
					compMotion.RemoveRuntimeMotionTag(MotionTag_backUp.TimelineAllowRootMotion);
				}
				_entity.SetBool("InTimeline", value: false);
			}
		}
		_exclusiveApplied = false;
		_lockNormalFsmTransition = false;
		_allowRootMotionInTimeline = false;
	}

	private void ClearTimelineLayer0States()
	{
		if (!(_entity == null))
		{
			GameManager.behaveSystem?.ClearTimelineLayer0States(_entity);
		}
	}
}
