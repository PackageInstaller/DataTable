using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Function (Desktop Only)", 0)]
[Category("✫ Reflected/Faster Versions (Desktop Platforms Only)")]
[Description("This version works in destop/JIT platform only.\n\nCall a function with none or up to 6 parameters on a component and return whether or not the return value is equal to the check value")]
public class CheckFunction : ConditionTask
{
	[SerializeField]
	protected ReflectedFunctionWrapper functionWrapper;

	[SerializeField]
	protected BBParameter checkValue;

	[SerializeField]
	protected CompareMethod comparison;

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
			for (int i = 1; i < variables.Length; i++)
			{
				text = text + ((i != 1) ? ", " : "") + variables[i].ToString();
			}
			string text2 = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{text2}.{targetMethod.Name}({text}){OperationTools.GetCompareString(comparison) + checkValue}";
		}
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
			functionWrapper.Init(targetMethod.IsStatic ? null : base.agent);
			return null;
		}
		catch
		{
			return "CheckFunction Error";
		}
	}

	protected override bool OnCheck()
	{
		if (functionWrapper == null)
		{
			return true;
		}
		if (checkValue.varType == typeof(float))
		{
			return OperationTools.Compare((float)functionWrapper.Call(), (float)checkValue.value, comparison, 0.05f);
		}
		if (checkValue.varType == typeof(int))
		{
			return OperationTools.Compare((int)functionWrapper.Call(), (int)checkValue.value, comparison);
		}
		return ObjectUtils.AnyEquals(functionWrapper.Call(), checkValue.value);
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			functionWrapper = ReflectedFunctionWrapper.Create(method, base.blackboard);
			checkValue = BBParameter.CreateInstance(method.ReturnType, base.blackboard);
			comparison = CompareMethod.EqualTo;
		}
	}
}
