using System;
using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[GraphInfo(packageName = "NodeCanvas", docsURL = "https://nodecanvas.paradoxnotion.com/documentation/", resourcesURL = "https://nodecanvas.paradoxnotion.com/downloads/", forumsURL = "https://nodecanvas.paradoxnotion.com/forums-page/")]
[CreateAssetMenu(menuName = "ParadoxNotion/NodeCanvas/FSM Asset")]
public class FSM : Graph
{
	public enum TransitionCallMode
	{
		Normal,
		Stacked,
		Clean
	}

	private bool _enterStartStateFlag;

	private IStateCallbackReceiver[] callbackReceivers;

	private Stack<FSMState> stateStack;

	private List<IUpdatable> updatableNodes;

	public FSMState currentState { get; private set; }

	public FSMState previousState { get; private set; }

	public string currentStateName
	{
		get
		{
			if (currentState == null)
			{
				return null;
			}
			return currentState.name;
		}
	}

	public string previousStateName
	{
		get
		{
			if (previousState == null)
			{
				return null;
			}
			return previousState.name;
		}
	}

	public override Type baseNodeType => typeof(FSMNode);

	public override bool requiresAgent => true;

	public override bool requiresPrimeNode => true;

	public override bool isTree => false;

	public override bool allowBlackboardOverrides => true;

	public sealed override bool canAcceptVariableDrops => false;

	public event Action<IState> onStateEnter;

	public event Action<IState> onStateUpdate;

	public event Action<IState> onStateExit;

	public event Action<IState> onStateTransition;

	protected override void OnGraphInitialize()
	{
		ThreadSafeInitCall(GatherCallbackReceivers);
		updatableNodes = new List<IUpdatable>();
		for (int i = 0; i < base.allNodes.Count; i++)
		{
			if (base.allNodes[i] is IUpdatable)
			{
				updatableNodes.Add((IUpdatable)base.allNodes[i]);
			}
		}
	}

	protected override void OnGraphStarted()
	{
		base.OnGraphStarted();
		stateStack = new Stack<FSMState>();
		_enterStartStateFlag = true;
	}

	protected override void OnGraphUpdate()
	{
		if (_enterStartStateFlag)
		{
			_enterStartStateFlag = false;
			EnterState((FSMState)base.primeNode, TransitionCallMode.Normal);
		}
		if (currentState != null)
		{
			bool flag = true;
			for (int i = 0; i < updatableNodes.Count; i++)
			{
				updatableNodes[i]?.Update();
				IUpdatable updatable = updatableNodes[i];
				if (updatable != null && updatable.status == Status.Running)
				{
					flag = false;
				}
			}
			if (currentState == null)
			{
				Stop(success: false);
				return;
			}
			currentState.Execute(base.agent, base.blackboard);
			if (onStateUpdate != null && currentState.status == Status.Running)
			{
				onStateUpdate(currentState);
			}
			if (currentState == null)
			{
				Stop(success: false);
				return;
			}
			if (currentState.status != Status.Running && currentState.outConnections.Count == 0)
			{
				if (stateStack.Count > 0)
				{
					FSMState newState = stateStack.Pop();
					EnterState(newState, TransitionCallMode.Normal);
					return;
				}
				if (flag)
				{
					Stop(success: false);
					return;
				}
			}
		}
		if (currentState == null)
		{
			Stop(success: false);
		}
	}

	protected override void OnGraphStopped(bool isExecuteStopLogic)
	{
		if (currentState != null && onStateExit != null)
		{
			onStateExit(currentState);
		}
		previousState = null;
		currentState = null;
		stateStack = null;
		_enterStartStateFlag = true;
	}

	public bool EnterState(FSMState newState, TransitionCallMode callMode)
	{
		if (!base.isRunning)
		{
			return false;
		}
		if (newState == null)
		{
			return false;
		}
		if (currentState != null)
		{
			onStateExit?.Invoke(currentState);
			currentState.Reset(recursively: false);
			if (callMode == TransitionCallMode.Stacked)
			{
				stateStack.Push(currentState);
				_ = stateStack.Count;
				_ = 5;
			}
		}
		if (callMode == TransitionCallMode.Clean)
		{
			stateStack.Clear();
		}
		previousState = currentState;
		currentState = newState;
		onStateTransition?.Invoke(currentState);
		onStateEnter?.Invoke(currentState);
		currentState.Execute(base.agent, base.blackboard);
		return true;
	}

	public FSMState TriggerState(string stateName, TransitionCallMode callMode)
	{
		FSMState stateWithName = GetStateWithName(stateName);
		if (stateWithName != null)
		{
			EnterState(stateWithName, callMode);
			return stateWithName;
		}
		return null;
	}

	public string[] GetStateNames()
	{
		return (from n in base.allNodes
			where n is FSMState
			select n.name).ToArray();
	}

	public FSMState GetStateWithName(string name)
	{
		return (FSMState)base.allNodes.Find((Node n) => n is FSMState && n.name == name);
	}

	private void GatherCallbackReceivers()
	{
		if (base.agent == null)
		{
			return;
		}
		callbackReceivers = base.agent.gameObject.GetComponents<IStateCallbackReceiver>();
		if (callbackReceivers.Length == 0)
		{
			return;
		}
		onStateEnter += delegate(IState x)
		{
			IStateCallbackReceiver[] array = callbackReceivers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].OnStateEnter(x);
			}
		};
		onStateUpdate += delegate(IState x)
		{
			IStateCallbackReceiver[] array = callbackReceivers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].OnStateUpdate(x);
			}
		};
		onStateExit += delegate(IState x)
		{
			IStateCallbackReceiver[] array = callbackReceivers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].OnStateExit(x);
			}
		};
	}

	public FSMState PeekStack()
	{
		if (stateStack == null || stateStack.Count <= 0)
		{
			return null;
		}
		return stateStack.Peek();
	}
}
