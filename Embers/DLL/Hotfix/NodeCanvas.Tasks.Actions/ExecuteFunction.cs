using System;
using System.Collections;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Execute Function (Desktop Only)", 10)]
[Category("✫ Reflected/Faster Versions (Desktop Platforms Only)")]
[Description("This version works in destop/JIT platform only.\n\nExecute a function on a script, of up to 6 parameters and save the return if any. If function is an IEnumerator it will execute as a coroutine.")]
public class ExecuteFunction : ActionTask, IReflectedWrapper
{
	[SerializeField]
	protected ReflectedWrapper functionWrapper;

	private bool routineRunning;

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

	public override Type agentType
	{
		get
		{
			if (targetMethod == null)
			{
				return typeof(Transform);
			}
			if (!targetMethod.IsStatic)
			{
				return targetMethod.RTReflectedOrDeclaredType();
			}
			return null;
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
				text = ((targetMethod.ReturnType == typeof(void) || targetMethod.ReturnType == typeof(IEnumerator) || variables[0].isNone) ? "" : (variables[0]?.ToString() + " = "));
				for (int j = 1; j < variables.Length; j++)
				{
					text2 = text2 + ((j != 1) ? ", " : "") + variables[j].ToString();
				}
			}
			string text3 = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{text}{text3}.{targetMethod.Name}({text2})";
		}
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return functionWrapper?.GetSerializedMethod();
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
		if (functionWrapper == null)
		{
			return "No Method selected";
		}
		if (targetMethod == null)
		{
			return $"Missing Method '{functionWrapper.AsString()}'";
		}
		try
		{
			functionWrapper.Init(targetMethod.IsStatic ? null : base.agent);
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
		if (targetMethod.ReturnType == typeof(IEnumerator))
		{
			StartCoroutine(InternalCoroutine((IEnumerator)((ReflectedFunctionWrapper)functionWrapper).Call()));
			return;
		}
		if (targetMethod.ReturnType == typeof(void))
		{
			((ReflectedActionWrapper)functionWrapper).Call();
		}
		else
		{
			((ReflectedFunctionWrapper)functionWrapper).Call();
		}
		EndAction(success: true);
	}

	protected override void OnStop()
	{
		routineRunning = false;
	}

	private IEnumerator InternalCoroutine(IEnumerator routine)
	{
		routineRunning = true;
		while (routineRunning && routine.MoveNext())
		{
			if (!routineRunning)
			{
				yield break;
			}
			yield return routine.Current;
		}
		if (routineRunning)
		{
			EndAction();
		}
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			functionWrapper = ReflectedWrapper.Create(method, base.blackboard);
		}
	}
}
