using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Obsolete("Execute Function now supports static functions as well")]
public class ExecuteStaticFunction : ActionTask, ISubParametersContainer
{
	[SerializeField]
	protected ReflectedWrapper functionWrapper;

	private MethodInfo targetMethod
	{
		get
		{
			if (functionWrapper == null)
			{
				return null;
			}
			return functionWrapper.GetMethod();
		}
	}

	protected override string info
	{
		get
		{
			if (functionWrapper == null)
			{
				return "No Method Selected";
			}
			if (targetMethod == null)
			{
				return functionWrapper.AsString().FormatError();
			}
			BBParameter[] variables = functionWrapper.GetVariables();
			string text = "";
			string text2 = "";
			if (targetMethod.ReturnType == typeof(void))
			{
				for (int i = 0; i < variables.Length; i++)
				{
					text2 = text2 + ((i != 0) ? ", " : "") + variables[i].ToString();
				}
			}
			else
			{
				text = (variables[0].isNone ? "" : (variables[0]?.ToString() + " = "));
				for (int j = 1; j < variables.Length; j++)
				{
					text2 = text2 + ((j != 1) ? ", " : "") + variables[j].ToString();
				}
			}
			return $"{text}{targetMethod.DeclaringType.FriendlyName()}.{targetMethod.Name} ({text2})";
		}
	}

	BBParameter[] ISubParametersContainer.GetSubParameters()
	{
		if (functionWrapper == null)
		{
			return null;
		}
		return functionWrapper.GetVariables();
	}

	public override void OnValidate(ITaskSystem ownerSystem)
	{
		if (functionWrapper != null && functionWrapper.HasChanged())
		{
			SetMethod(functionWrapper.GetMethod());
		}
	}

	protected override string OnInit()
	{
		if (targetMethod == null)
		{
			return "Missing Method";
		}
		try
		{
			functionWrapper.Init(null);
			return null;
		}
		catch
		{
			return "ExecuteFunction Error";
		}
	}

	protected override void OnExecute()
	{
		if (targetMethod == null)
		{
			EndAction(success: false);
			return;
		}
		if (functionWrapper is ReflectedActionWrapper)
		{
			(functionWrapper as ReflectedActionWrapper).Call();
		}
		else
		{
			(functionWrapper as ReflectedFunctionWrapper).Call();
		}
		EndAction();
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			functionWrapper = ReflectedWrapper.Create(method, base.blackboard);
		}
	}
}
