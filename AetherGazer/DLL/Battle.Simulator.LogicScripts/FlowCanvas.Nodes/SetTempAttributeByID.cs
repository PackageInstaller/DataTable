using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改属性临时加成", 0)]
[Category("Logic/Attribute")]
[Description("修改某个实体临时属性, 只会修改战斗内那部分，临时属性会在伤害计算完后自动清理，注意只能在此次伤害计算过程中使用此节点，以防出现不可预期的结果！")]
public class SetTempAttributeByID : FlowNode
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
				long baseValue;
				long plusValue;
				long tempPlusValue;
				if (operation != OperationMethod.Set)
				{
					_ = v;
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, out baseValue, out plusValue, out tempPlusValue);
					tempPlusValue = OperationTools.Operate(tempPlusValue, v.value, operation);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, baseValue, plusValue, tempPlusValue);
				}
				else
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, out baseValue, out plusValue, out tempPlusValue);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, baseValue, plusValue, v.value);
				}
			}
			o.Call(f);
		});
	}
}
