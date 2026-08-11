using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Property", 7)]
[Category("✫ Reflected")]
[Description("Set a property on a script")]
public class SetProperty_Multiplatform : ActionTask, IReflectedWrapper
{
	[SerializeField]
	protected SerializedMethodInfo method;

	[SerializeField]
	protected BBObjectParameter parameter;

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
				return "No Property Selected";
			}
			if (targetMethod == null)
			{
				return method.AsString().FormatError();
			}
			string arg = (targetMethod.IsStatic ? targetMethod.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{arg}.{targetMethod.Name} = {parameter.ToString()}";
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
			return "No property selected";
		}
		if (targetMethod == null)
		{
			return $"Missing property '{method.AsString()}'";
		}
		return null;
	}

	protected override void OnExecute()
	{
		targetMethod.Invoke(targetMethod.IsStatic ? null : base.agent, ReflectionTools.SingleTempArgsArray(parameter.value));
		EndAction();
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			this.method = new SerializedMethodInfo(method);
			parameter.SetType(method.GetParameters()[0].ParameterType);
		}
	}
}
