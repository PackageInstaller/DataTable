using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Obsolete("Execute Function now supports static functions as well")]
public class ExecuteStaticFunction_Multiplatform : ActionTask
{
	[SerializeField]
	protected SerializedMethodInfo method;

	[SerializeField]
	protected List<BBObjectParameter> parameters = new List<BBObjectParameter>();

	[SerializeField]
	[BlackboardOnly]
	protected BBObjectParameter returnValue;

	private MethodInfo targetMethod => method;

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
			string text = ((targetMethod.ReturnType == typeof(void)) ? "" : (returnValue.ToString() + " = "));
			string text2 = "";
			for (int i = 0; i < parameters.Count; i++)
			{
				text2 = text2 + ((i != 0) ? ", " : "") + parameters[i].ToString();
			}
			return $"{text}{targetMethod.DeclaringType.FriendlyName()}.{targetMethod.Name} ({text2})";
		}
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
			return "No methMethodd selected";
		}
		if (targetMethod == null)
		{
			return $"Missing Method '{method.AsString()}'";
		}
		return null;
	}

	protected override void OnExecute()
	{
		object[] array = parameters.Select((BBObjectParameter p) => p.value).ToArray();
		returnValue.value = targetMethod.Invoke(base.agent, array);
		EndAction();
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
			BBObjectParameter bBObjectParameter = new BBObjectParameter(parameterInfo.ParameterType)
			{
				bb = base.blackboard
			};
			if (parameterInfo.IsOptional)
			{
				bBObjectParameter.value = parameterInfo.DefaultValue;
			}
			parameters.Add(bBObjectParameter);
		}
		if (method.ReturnType != typeof(void))
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
