using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取触发器黑板变量", 0)]
[Category("Variables/Blackboard")]
[Description("获取触发器实体的黑板变量")]
[ContextDefinedInputs(new Type[] { typeof(Wild) })]
public class GetTriggerEntityBlackboardVariable<T> : FlowNode
{
	[HideInInspector]
	public string nodeName;

	[NonSerialized]
	public T value;

	public override string name => $"{nodeName}";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(nodeName);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		nodeName = reader.ReadString();
	}

	public override void OnGraphStarted()
	{
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> triggerEntityIDInput = AddValueInput<int>("触发器实体ID");
		AddValueOutput("value", delegate
		{
			int key = triggerEntityIDInput.value;
			string varName = nodeName;
			T val = base.mMapTriggers[key].blackboard.GetValue<T>(varName);
			value = val;
			return value;
		});
	}

	public void SetTargetVariableName(string name)
	{
		nodeName = name;
	}
}
