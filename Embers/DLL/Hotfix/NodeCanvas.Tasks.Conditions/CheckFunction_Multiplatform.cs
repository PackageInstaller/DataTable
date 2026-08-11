using System;
using System.Collections.Generic;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Function", 10)]
[Category("✫ Reflected")]
[Description("Call a function on a component and return whether or not the return value is equal to the check value")]
public class CheckFunction_Multiplatform : ConditionTask, IReflectedWrapper
{
	[SerializeField]
	protected SerializedMethodInfo method;

	[SerializeField]
	protected List<BBObjectParameter> parameters = new List<BBObjectParameter>();

	[SerializeField]
	protected CompareMethod comparison;

	[SerializeField]
	[BlackboardOnly]
	protected BBObjectParameter checkValue;

	private object[] args;

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
			string text = "";
			for (int i = 0; i < parameters.Count; i++)
			{
				text = text + ((i != 0) ? ", " : "") + parameters[i].ToString();
			}
			string text2 = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{text2}.{targetMethod.Name}({text}){OperationTools.GetCompareString(comparison) + checkValue}";
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
			return "No Method Selected";
		}
		if (targetMethod == null)
		{
			return method.AsString();
		}
		if (args == null)
		{
			ParameterInfo[] array = targetMethod.GetParameters();
			args = new object[array.Length];
			parameterIsByRef = new bool[array.Length];
			for (int i = 0; i < parameters.Count; i++)
			{
				parameterIsByRef[i] = array[i].ParameterType.IsByRef;
			}
		}
		return null;
	}

	protected override bool OnCheck()
	{
		for (int i = 0; i < parameters.Count; i++)
		{
			args[i] = parameters[i].value;
		}
		Component obj = (targetMethod.IsStatic ? null : base.agent);
		bool result = ((checkValue.varType == typeof(float)) ? OperationTools.Compare((float)targetMethod.Invoke(obj, args), (float)checkValue.value, comparison, 0.05f) : ((!(checkValue.varType == typeof(int))) ? ObjectUtils.AnyEquals(targetMethod.Invoke(obj, args), checkValue.value) : OperationTools.Compare((int)targetMethod.Invoke(obj, args), (int)checkValue.value, comparison)));
		for (int j = 0; j < parameters.Count; j++)
		{
			if (parameterIsByRef[j])
			{
				parameters[j].value = args[j];
			}
		}
		return result;
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
		checkValue = new BBObjectParameter(method.ReturnType)
		{
			bb = base.blackboard
		};
		comparison = CompareMethod.EqualTo;
	}
}
