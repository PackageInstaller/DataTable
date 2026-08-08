using System;
using BilliardGame.Spell;
using UnityEngine;

namespace AINodes;

public class BTLogicOp : BDecoratorNode
{
	public enum Op
	{
		[InspectorName("与")]
		And,
		[InspectorName("或")]
		Or,
		[InspectorName("仅1为真")]
		XOr
	}

	public string field;

	public Op operation;

	public bool defaultValue;

	public BDecoratorNode[] conditions;

	private bool And(BTEnv env)
	{
		BDecoratorNode[] array = conditions;
		for (int i = 0; i < array.Length; i++)
		{
			if (!array[i].CanExecute(env))
			{
				return false;
			}
		}
		return true;
	}

	private bool Or(BTEnv env)
	{
		BDecoratorNode[] array = conditions;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].CanExecute(env))
			{
				return true;
			}
		}
		return false;
	}

	private bool XOr(BTEnv env)
	{
		int num = 0;
		BDecoratorNode[] array = conditions;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].CanExecute(env))
			{
				num++;
			}
			if (num > 1)
			{
				return false;
			}
		}
		return num == 1;
	}

	public override bool CanExecute(BTEnv env)
	{
		if (conditions != null && conditions.Length != 0)
		{
			switch (operation)
			{
			case Op.And:
				return And(env);
			case Op.Or:
				return Or(env);
			case Op.XOr:
				return XOr(env);
			}
		}
		return defaultValue;
	}

	public override void OnChildExecuted(BTEnv env, BTNodeStatus childStatus)
	{
		throw new NotImplementedException();
	}
}
