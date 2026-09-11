using System;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取触发器黑板变量(渲染)", 0)]
[Category("Variables/Blackboard")]
[Description("获取触发器实体的黑板变量")]
[ContextDefinedInputs(new Type[] { typeof(Wild) })]
public class GetTriggerBlackboardVariable<T> : FlowNode
{
	[HideInInspector]
	public string nodeName;

	[NonSerialized]
	public T value;

	public override string name => $"{nodeName} 渲染";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(nodeName);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		nodeName = reader.ReadString();
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> triggerEntityIDInput = AddValueInput<int>("触发器实体ID");
		AddValueOutput("value", delegate
		{
			IBlackboard blackboard = base.mMapTriggers[triggerEntityIDInput.value].blackboard;
			if (!blackboard.variables.ContainsKey(nodeName))
			{
				Debug.Log("变量名:" + nodeName + " 不存在, 返回默认值");
				return default(T);
			}
			value = blackboard.GetValue<T>(nodeName);
			return value;
		});
	}

	public void SetTargetVariableName(string name)
	{
		nodeName = name;
	}
}
