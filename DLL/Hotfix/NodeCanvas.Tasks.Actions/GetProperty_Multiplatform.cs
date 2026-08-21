using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Get Property", 8)]
[Category("✫ Reflected")]
[Description("Get a property of a script and save it to the blackboard")]
public class GetProperty_Multiplatform : ActionTask, IReflectedWrapper
{
	[SerializeField]
	protected SerializedMethodInfo method;

	[SerializeField]
	[BlackboardOnly]
	protected BBObjectParameter returnValue;

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
			return $"{returnValue.ToString()} = {arg}.{targetMethod.Name}";
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
			return "No Property selected";
		}
		if (targetMethod == null)
		{
			return $"Missing Property '{method.AsString()}'";
		}
		return null;
	}

	protected override void OnExecute()
	{
		returnValue.value = targetMethod.Invoke(targetMethod.IsStatic ? null : base.agent, null);
		EndAction();
	}

	private void SetMethod(MethodInfo method)
	{
		if (method != null)
		{
			this.method = new SerializedMethodInfo(method);
			returnValue.SetType(method.ReturnType);
		}
	}
}
