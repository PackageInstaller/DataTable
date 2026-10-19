using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class StateAttackController : StateController, INode<ConfigAttackStateMachine>
{
	public new ConfigAttackStateMachine value { get; protected set; }

	public List<StateFromTransition> fromTransitions { get; protected set; } = new List<StateFromTransition>();

	public StateAttackController(StateController fromStateController, ConfigAttackStateMachine config)
		: base(config)
	{
		value = config;
		FromMotionTransition[] fromTrans = config.fromTrans;
		foreach (FromMotionTransition fromMotionTransition in fromTrans)
		{
			try
			{
				fromTransitions.Add(new StateFromTransition(fromStateController, fromMotionTransition, statesDic, stateMachinesDic));
			}
			catch (Exception ex)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("fromTran[" + fromMotionTransition.name + "]出错");
				}
				throw ex;
			}
		}
	}

	public void Reset(StateController fromStateController, ConfigAttackStateMachine config)
	{
		value = config;
		fromTransitions.Clear();
		FromMotionTransition[] fromTrans = config.fromTrans;
		foreach (FromMotionTransition fromMotionTransition in fromTrans)
		{
			try
			{
				fromTransitions.Add(new StateFromTransition(fromStateController, fromMotionTransition, statesDic, stateMachinesDic));
			}
			catch (Exception ex)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("fromTran[" + fromMotionTransition.name + "]出错");
				}
				throw ex;
			}
		}
	}

	public override string ToString(int padLeft = 0)
	{
		StringBuilder stringBuilder = new StringBuilder(base.ToString());
		foreach (StateFromTransition fromTransition in fromTransitions)
		{
			stringBuilder.Append("\n" + fromTransition.ToString(padLeft + 3));
		}
		return stringBuilder.ToString();
	}
}
