using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Color("ff6d53")]
public abstract class FSMState : FSMNode, IState
{
	public enum TransitionEvaluationMode
	{
		CheckContinuously,
		CheckAfterStateFinished,
		CheckManually
	}

	[SerializeField]
	private TransitionEvaluationMode _transitionEvaluation;

	private bool _hasInit;

	public override bool allowAsPrime => true;

	public override bool canSelfConnect => true;

	public override int maxInConnections => -1;

	public override int maxOutConnections => -1;

	public TransitionEvaluationMode transitionEvaluation
	{
		get
		{
			return _transitionEvaluation;
		}
		set
		{
			_transitionEvaluation = value;
		}
	}

	public FSMConnection[] GetTransitions()
	{
		FSMConnection[] array = new FSMConnection[base.outConnections.Count];
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			array[i] = (FSMConnection)base.outConnections[i];
		}
		return array;
	}

	public void Finish()
	{
		Finish(Status.Success);
	}

	public void Finish(bool inSuccess)
	{
		Finish(inSuccess ? Status.Success : Status.Failure);
	}

	public void Finish(Status status)
	{
		base.status = status;
	}

	public override void OnGraphPaused()
	{
		if (base.status == Status.Running)
		{
			OnPause();
		}
	}

	protected override bool CanConnectFromSource(Node sourceNode)
	{
		if (IsChildOf(sourceNode))
		{
			return false;
		}
		return true;
	}

	protected override bool CanConnectToTarget(Node targetNode)
	{
		if (IsParentOf(targetNode))
		{
			return false;
		}
		return true;
	}

	protected sealed override Status OnExecute(Component agent, IBlackboard bb)
	{
		if (!_hasInit)
		{
			_hasInit = true;
			OnInit();
		}
		if (base.status == Status.Resting)
		{
			base.status = Status.Running;
			for (int i = 0; i < base.outConnections.Count; i++)
			{
				((FSMConnection)base.outConnections[i]).EnableCondition(agent, bb);
			}
			OnEnter();
		}
		else
		{
			bool num = transitionEvaluation == TransitionEvaluationMode.CheckContinuously;
			bool flag = transitionEvaluation == TransitionEvaluationMode.CheckAfterStateFinished && base.status != Status.Running;
			if (num | flag)
			{
				CheckTransitions();
			}
			if (base.status == Status.Running)
			{
				OnUpdate();
			}
		}
		return base.status;
	}

	public bool CheckTransitions()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			FSMConnection fSMConnection = (FSMConnection)base.outConnections[i];
			ConditionTask condition = fSMConnection.condition;
			if (fSMConnection.isActive)
			{
				if ((condition != null && condition.Check(base.graphAgent, base.graphBlackboard)) || (condition == null && base.status != Status.Running))
				{
					base.FSM.EnterState((FSMState)fSMConnection.targetNode, fSMConnection.transitionCallMode);
					fSMConnection.status = Status.Success;
					return true;
				}
				fSMConnection.status = Status.Failure;
			}
		}
		return false;
	}

	protected sealed override void OnReset()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			((FSMConnection)base.outConnections[i]).DisableCondition();
		}
		OnExit();
	}

	protected virtual void OnInit()
	{
	}

	protected virtual void OnEnter()
	{
	}

	protected virtual void OnUpdate()
	{
	}

	protected virtual void OnExit()
	{
	}

	protected virtual void OnPause()
	{
	}
}
