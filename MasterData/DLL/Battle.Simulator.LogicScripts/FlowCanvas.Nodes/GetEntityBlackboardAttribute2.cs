using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic/Attribute")]
[Description("获取实体黑板属性,如果不存在的话,就加一个0(int)")]
public class GetEntityBlackboardAttribute2 : FlowNode
{
	[HideInInspector]
	[SerializeField]
	public string nodeName;

	[SerializeField]
	public int value;

	public override string name => $"{nodeName}";

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		nodeName = reader.ReadString();
		value = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(nodeName);
		writer.Write(value);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("值", () => AttributeProcessor.GetFinalAttributeByAttributeID(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), value, AttributeCalcType.Add));
	}
}
