using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Any State", 0)]
[Description("The transitions of this node will be constantly checked. If any becomes true, that transition will take place. This is not a state.")]
[Color("b3ff7f")]
public class AnyState : FSMNode, IUpdatable, IGraphElement
{
	[Tooltip("If enabled, a transition to an already running state will not happen.")]
	public bool dontRetriggerStates;

	public override string name => "FROM ANY STATE";

	public override int maxInConnections => 0;

	public override int maxOutConnections => -1;

	public override bool allowAsPrime => false;

	public override void OnGraphStarted()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			(base.outConnections[i] as FSMConnection).EnableCondition(base.graphAgent, base.graphBlackboard);
		}
	}

	public override void OnGraphStoped()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			(base.outConnections[i] as FSMConnection).DisableCondition();
		}
	}

	void IUpdatable.Update()
	{
		if (base.outConnections.Count == 0)
		{
			return;
		}
		base.status = Status.Running;
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			FSMConnection fSMConnection = (FSMConnection)base.outConnections[i];
			ConditionTask condition = fSMConnection.condition;
			if (fSMConnection.isActive && condition != null && (!dontRetriggerStates || base.FSM.currentState != (FSMState)fSMConnection.targetNode || base.FSM.currentState.status != Status.Running))
			{
				if (condition.Check(base.graphAgent, base.graphBlackboard))
				{
					base.FSM.EnterState((FSMState)fSMConnection.targetNode, fSMConnection.transitionCallMode);
					fSMConnection.status = Status.Success;
					break;
				}
				fSMConnection.status = Status.Failure;
			}
		}
	}
}
