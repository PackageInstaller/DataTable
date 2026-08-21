using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Property (Desktop Only)", 7)]
[Category("✫ Reflected/Faster Versions (Desktop Platforms Only)")]
[Description("This version works in destop/JIT platform only.\n\nSet a property on a script.")]
public class SetProperty : ActionTask, IReflectedWrapper
{
	[SerializeField]
	protected ReflectedActionWrapper functionWrapper;

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
			return $"{arg}.{targetMethod.Name} = {functionWrapper.GetVariables()[0]}";
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
			return "Missing Property";
		}
		try
		{
			functionWrapper.Init(targetMethod.IsStatic ? null : base.agent);
			return null;
		}
		catch
		{
			return "SetProperty Error";
		}
	}

	protected override void OnExecute()
	{
		if (functionWrapper == null)
		{
			EndAction(success: false);
			return;
		}
		functionWrapper.Call();
		EndAction();
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			functionWrapper = ReflectedActionWrapper.Create(method, base.blackboard);
		}
	}
}
