using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Execute Function", 10)]
[Category("✫ Reflected")]
[Description("Execute a function on a script and save the return if any.\nIf function is an IEnumerator it will execute as a coroutine.")]
public class ExecuteFunction_Multiplatform : ActionTask, IReflectedWrapper
{
	[SerializeField]
	protected SerializedMethodInfo method;

	[SerializeField]
	protected List<BBObjectParameter> parameters = new List<BBObjectParameter>();

	[SerializeField]
	[BlackboardOnly]
	protected BBObjectParameter returnValue;

	private object[] args;

	private bool routineRunning;

	private bool[] parameterIsByRef;

	private MethodInfo targetMethod => method;

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
			if (method == null)
			{
				return "No Method Selected";
			}
			if (targetMethod == null)
			{
				return method.AsString().FormatError();
			}
			string text = ((targetMethod.ReturnType == typeof(void) || targetMethod.ReturnType == typeof(IEnumerator)) ? "" : (returnValue.ToString() + " = "));
			string text2 = "";
			for (int i = 0; i < parameters.Count; i++)
			{
				text2 = text2 + ((i != 0) ? ", " : "") + parameters[i].ToString();
			}
			string text3 = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{text}{text3}.{targetMethod.Name}({text2})";
		}
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return method;
	}

	public override void OnValidate(ITaskSystem ownerSystem)
	{
		if (method != null && method.HasChanged())
		{
			SetMethod(method);
		}
	}

	protected override string OnInit()
	{
		if (method == null)
		{
			return "No Method selected";
		}
		if (targetMethod == null)
		{
			return $"Missing Method '{method.AsString()}'";
		}
		if (args == null)
		{
			ParameterInfo[] array = targetMethod.GetParameters();
			args = new object[array.Length];
			parameterIsByRef = new bool[array.Length];
			for (int i = 0; i < array.Length; i++)
			{
				parameterIsByRef[i] = array[i].ParameterType.IsByRef;
			}
		}
		return null;
	}

	protected override void OnExecute()
	{
		for (int i = 0; i < parameters.Count; i++)
		{
			args[i] = parameters[i].value;
		}
		Component obj = (targetMethod.IsStatic ? null : base.agent);
		if (targetMethod.ReturnType == typeof(IEnumerator))
		{
			StartCoroutine(InternalCoroutine((IEnumerator)targetMethod.Invoke(obj, args)));
			return;
		}
		returnValue.value = targetMethod.Invoke(obj, args);
		for (int j = 0; j < parameters.Count; j++)
		{
			if (parameterIsByRef[j])
			{
				parameters[j].value = args[j];
			}
		}
		EndAction();
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
		if (method == null)
		{
			return;
		}
		this.method = new SerializedMethodInfo(method);
		parameters.Clear();
		ParameterInfo[] array = method.GetParameters();
		foreach (ParameterInfo parameterInfo in array)
		{
			Type parameterType = parameterInfo.ParameterType;
			BBObjectParameter bBObjectParameter = new BBObjectParameter(parameterType.IsByRef ? parameterType.GetElementType() : parameterType)
			{
				bb = base.blackboard
			};
			if (parameterInfo.IsOptional)
			{
				bBObjectParameter.value = parameterInfo.DefaultValue;
			}
			parameters.Add(bBObjectParameter);
		}
		if (method.ReturnType != typeof(void) && targetMethod.ReturnType != typeof(IEnumerator))
		{
			returnValue = new BBObjectParameter(method.ReturnType)
			{
				bb = base.blackboard
			};
		}
		else
		{
			returnValue = null;
		}
	}
}
