using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改属性", 0)]
[Category("Logic/Attribute")]
[Description("修改某个实体属性, 只会修改战斗内那部分")]
public class SetAttributeByID : FlowNode
{
	[HideInInspector]
	public OperationMethod operation;

	public override string name => string.Format("{0}{1}{2}", base.name, OperationTools.GetOperationString(operation), "Value");

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write((int)operation);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		operation = (OperationMethod)reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> attrIDInput = AddValueInput<int>("属性ID");
		ValueInput<int> v = AddValueInput<int>("Value");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				if (operation != OperationMethod.Set)
				{
					_ = v;
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, out var baseValue, out var plusValue, out var tempPlusValue);
					plusValue = OperationTools.Operate(plusValue, v.value, operation);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, baseValue, plusValue, tempPlusValue);
				}
				else
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, out var baseValue2, out var _, out var tempPlusValue2);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, baseValue2, v.value, tempPlusValue2);
				}
			}
			o.Call(f);
		});
	}
}
