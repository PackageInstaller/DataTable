using System;
using System.Collections.Generic;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置触发器黑板变量(渲染)", 0)]
[Category("Variables/Blackboard")]
[Description("设置触发器实体的黑板变量")]
[ContextDefinedInputs(new Type[] { typeof(Wild) })]
public class SetTriggerBlackboardVariable<T> : FlowNode
{
	public string nodeName;

	private Variable<T> value;

	[HideInInspector]
	public OperationMethod operation;

	[HideInInspector]
	public bool perSecond;

	public override string name => string.Format("{0}{1}{2} 渲染", nodeName, OperationTools.GetOperationString(operation), "Value");

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(nodeName);
		writer.Write((int)operation);
		writer.Write(perSecond);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		nodeName = reader.ReadString();
		operation = (OperationMethod)reader.ReadInt32();
		perSecond = reader.ReadBoolean();
	}

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("Out");
		ValueInput<int> triggerEntityIDInput = AddValueInput<int>("触发器实体ID");
		ValueInput<T> v = AddValueInput<T>("Value");
		AddValueOutput("Value", () => value.value);
		AddFlowInput("In", delegate(Flow f)
		{
			Dictionary<int, MapTrigger> dictionary = base.mMapTriggers;
			value = dictionary[triggerEntityIDInput.value].blackboard.GetVariable(nodeName) as Variable<T>;
			if (value == null)
			{
				value = (Variable<T>)dictionary[triggerEntityIDInput.value].blackboard.AddVariable(nodeName, typeof(T));
			}
			if (operation != OperationMethod.Set)
			{
				if (typeof(T) == typeof(float))
				{
					Variable<float> obj = value as Variable<float>;
					obj.value = OperationTools.Operate(b: (v as ValueInput<float>).value, a: obj.value, om: operation);
				}
				else if (typeof(T) == typeof(int))
				{
					Variable<int> obj2 = value as Variable<int>;
					obj2.value = OperationTools.Operate(b: (v as ValueInput<int>).value, a: obj2.value, om: operation);
				}
				else if (typeof(T) == typeof(Vector3))
				{
					Variable<Vector3> obj3 = value as Variable<Vector3>;
					obj3.value = OperationTools.Operate(b: (v as ValueInput<Vector3>).value, a: obj3.value, om: operation);
				}
				else
				{
					value.value = v.value;
				}
			}
			else
			{
				value.value = v.value;
			}
			o.Call(f);
		});
	}

	public void SetTargetVariableName(string name)
	{
		nodeName = name;
	}
}
