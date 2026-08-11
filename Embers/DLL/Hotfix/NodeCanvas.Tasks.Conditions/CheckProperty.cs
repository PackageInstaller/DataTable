using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Property (Desktop Only)", 0)]
[Category("✫ Reflected/Faster Versions (Desktop Platforms Only)")]
[Description("This version works in destop/JIT platform only.\n\nCheck a property on a script and return if it's equal or not to the check value")]
public class CheckProperty : ConditionTask
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
				return "No Property Selected";
			}
			if (targetMethod == null)
			{
				return functionWrapper.AsString().FormatError();
			}
			string arg = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{arg}.{targetMethod.Name}{OperationTools.GetCompareString(comparison) + checkValue.ToString()}";
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
			return "Missing Property";
		}
		try
		{
			functionWrapper.Init(targetMethod.IsStatic ? null : base.agent);
			return null;
		}
		catch
		{
			return "CheckProperty Error";
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
