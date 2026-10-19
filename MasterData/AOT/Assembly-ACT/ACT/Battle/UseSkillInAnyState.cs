using System;
using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("不考虑状态机转出，必定执行当前动作，相当于一个anystate。\n指定动作：播放 motionName。\n列表依次匹配：按 motionNameList 顺序、忽略大小写找到状态机里存在的第一个动作；都没有时，从移动状态机找一个名字包含 idle 的状态播放。")]
public class UseSkillInAnyState : BehaviorDesigner.Runtime.Tasks.Action
{
	public enum MotionSelectMode
	{
		Specified,
		FirstAvailableInList
	}

	public SharedString motionName;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("指定动作播放 motionName。列表依次匹配忽略大小写按顺序播放；都没有时从移动状态机找名字包含 idle 的状态")]
	public MotionSelectMode motionSelectMode;

	public List<SharedString> motionNameList = new List<SharedString>();

	private const string IdleKeyword = "idle";

	public override TaskStatus OnUpdate()
	{
		Entity entity = (Owner as ActBehaviorTree)?.Entity ?? default(Entity);
		if (!entity.TryGetCompMotion(out CompMotion component))
		{
			return TaskStatus.Success;
		}
		SystemBehave systemBehave = Singleton<GameManager>.instance.ecsManager.systemBehave;
		if (motionSelectMode == MotionSelectMode.FirstAvailableInList)
		{
			return PlayFirstAvailableMotion(entity, component, systemBehave);
		}
		return PlayMotionOrFail(entity, component, systemBehave, (motionName != null) ? motionName.Value : null);
	}

	private TaskStatus PlayFirstAvailableMotion(Entity entity, CompMotion compMotion, SystemBehave systemBehave)
	{
		if (motionNameList != null)
		{
			for (int i = 0; i < motionNameList.Count; i++)
			{
				SharedString sharedString = motionNameList[i];
				if (sharedString != null && !string.IsNullOrWhiteSpace(sharedString.Value) && TryPlayMotion(entity, compMotion, systemBehave, sharedString.Value))
				{
					return TaskStatus.Success;
				}
			}
		}
		if (TryPlayMoveStateContainingIdle(entity, compMotion, systemBehave))
		{
			return TaskStatus.Success;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{entity}的UseSkillInAnyState节点{ID}在动作列表中没找到可播放的Motion");
		}
		return TaskStatus.Failure;
	}

	private static bool TryPlayMoveStateContainingIdle(Entity entity, CompMotion compMotion, SystemBehave systemBehave)
	{
		if (TryPlayControllerState(entity, compMotion.moveController, systemBehave, "idle"))
		{
			return true;
		}
		State state = null;
		State state2 = null;
		foreach (StateLayer childrenStateLayer in compMotion.moveController.childrenStateLayers)
		{
			foreach (State state4 in childrenStateLayer.states)
			{
				if (!string.IsNullOrEmpty(state4.value.name) && state4.value.name.IndexOf("idle", StringComparison.OrdinalIgnoreCase) >= 0)
				{
					if (state2 == null)
					{
						state2 = state4;
					}
					if (state == null && CanExitToAttack(compMotion, state4))
					{
						state = state4;
					}
				}
			}
		}
		State state3 = state ?? state2;
		if (state3 == null)
		{
			return false;
		}
		systemBehave.ForcedChangeToMotionState(entity, state3);
		return true;
	}

	private TaskStatus PlayMotionOrFail(Entity entity, CompMotion compMotion, SystemBehave systemBehave, string targetMotionName)
	{
		if (TryPlayMotion(entity, compMotion, systemBehave, targetMotionName))
		{
			return TaskStatus.Success;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{entity}的UseSkillInAnyState节点{ID}没找{targetMotionName}");
		}
		return TaskStatus.Failure;
	}

	private static bool TryPlayMotion(Entity entity, CompMotion compMotion, SystemBehave systemBehave, string targetMotionName)
	{
		if (string.IsNullOrWhiteSpace(targetMotionName))
		{
			return false;
		}
		if (TryPlayControllerState(entity, compMotion.moveController, systemBehave, targetMotionName))
		{
			return true;
		}
		return TryPlayControllerState(entity, compMotion.attackController, systemBehave, targetMotionName);
	}

	private static bool TryPlayControllerState(Entity entity, StateController controller, SystemBehave systemBehave, string targetMotionName)
	{
		if (!TryGetStateIgnoreCase(controller, targetMotionName, out var state))
		{
			return false;
		}
		systemBehave.ForcedChangeToMotionState(entity, state);
		return true;
	}

	private static bool TryGetStateIgnoreCase(StateController controller, string targetMotionName, out State state)
	{
		state = null;
		if (controller?.statesDic == null)
		{
			return false;
		}
		if (controller.statesDic.TryGetValue(targetMotionName, out state))
		{
			return true;
		}
		foreach (KeyValuePair<string, State> item in controller.statesDic)
		{
			if (NameEquals(item.Key, targetMotionName))
			{
				state = item.Value;
				return true;
			}
		}
		return false;
	}

	private static bool CanExitToAttack(CompMotion compMotion, State state)
	{
		List<StateFromTransition> list = compMotion.attackController?.fromTransitions;
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			StateObject origin = list[i].origin;
			if (origin is State && origin == state)
			{
				return true;
			}
			if (origin is StateMachine && state.parentStateMachine == origin)
			{
				return true;
			}
		}
		return false;
	}

	private static bool NameEquals(string stateName, string targetMotionName)
	{
		return string.Equals(stateName, targetMotionName, StringComparison.OrdinalIgnoreCase);
	}
}
