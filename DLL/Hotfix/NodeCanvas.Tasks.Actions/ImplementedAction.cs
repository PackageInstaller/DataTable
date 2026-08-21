using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Implemented Action (Desktop Only)", 9)]
[Category("✫ Reflected/Faster Versions (Desktop Platforms Only)")]
[Description("This version works in destop/JIT platform only.\n\nCalls a function that has signature of 'public Status NAME()' or 'public Status NAME(T)'. You should return Status.Success, Failure or Running within that function.")]
public class ImplementedAction : ActionTask, IReflectedWrapper
{
	[SerializeField]
	protected ReflectedFunctionWrapper functionWrapper;

	private Status actionStatus = Status.Resting;

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
				return "No Action Selected";
			}
			if (targetMethod == null)
			{
				return functionWrapper.AsString().FormatError();
			}
			string arg = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return string.Format("[ {0}.{1}({2}) ]", arg, targetMethod.Name, (functionWrapper.GetVariables().Length == 2) ? functionWrapper.GetVariables()[1].ToString() : "");
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
			return "ImplementedAction Error";
		}
	}

	protected override void OnUpdate()
	{
		if (functionWrapper == null)
		{
			EndAction(success: false);
			return;
		}
		actionStatus = (Status)functionWrapper.Call();
		if (actionStatus == Status.Success)
		{
			EndAction(success: true);
		}
		else if (actionStatus == Status.Failure)
		{
			EndAction(success: false);
		}
	}

	protected override void OnStop()
	{
		actionStatus = Status.Resting;
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			functionWrapper = ReflectedFunctionWrapper.Create(method, base.blackboard);
		}
	}
}
