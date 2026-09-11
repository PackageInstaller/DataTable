using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("同步黑板值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("将实体A指定的黑板属性同步至实体B，覆盖实体B对应的黑板属性\n只有指定的属性会同步。包括基础值与临时加成值\nError：实体A与实体B二者其中之一不存在、或黑板不存在时")]
public class TransferAttributeToEntity : FlowNode
{
	[Name("指定的属性", 0)]
	public List<int> attributes = new List<int>();

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<int>>().Serialize(ref writer, attributes, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		attributes = options.Resolver.GetFormatterWithVerify<List<int>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> vInEntA = AddValueInput<int>("实体A(来源)", "entA");
		ValueInput<int> vInEntB = AddValueInput<int>("实体B", "entB");
		FlowOutput fOut = AddFlowOutput("Out");
		FlowOutput fError = AddFlowOutput("Error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(vInEntA.value);
			if (entityWithEntityID != null)
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(vInEntB.value);
				if (entityWithEntityID2 != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID2.hasEntityBlackboard)
				{
					for (int i = 0; i < attributes.Count; i++)
					{
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attributes[i], out var baseValue, out var plusValue, out var tempPlusValue);
						AttributeProcessor.SetAttributeWithIntName(entityWithEntityID2.entityBlackboard.var.mAttributeID, attributes[i], baseValue, plusValue, tempPlusValue);
					}
					fOut.Call(f);
					return;
				}
			}
			fError.Call(f);
		});
		AddValueOutput("实体A(来源)", () => vInEntA.value);
		AddValueOutput("实体B", () => vInEntB.value);
	}
}
