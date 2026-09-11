using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic/Attribute")]
[Description("修改某个实体属性, 只会修改战斗内那部分")]
public class SetAttribute2 : FlowNode
{
	[HideInInspector]
	public string nodeName;

	[HideInInspector]
	public int value;

	[HideInInspector]
	public OperationMethod operation;

	public override string name => string.Format("{0}{1}{2}", nodeName, OperationTools.GetOperationString(operation), "Value");

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> v = AddValueInput<int>("Value");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				if (operation != OperationMethod.Set)
				{
					_ = v;
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value, out var baseValue, out var plusValue, out var tempPlusValue);
					plusValue = OperationTools.Operate(plusValue, v.value, operation);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value, baseValue, plusValue, tempPlusValue);
				}
				else
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value, out var baseValue2, out var _, out var tempPlusValue2);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value, baseValue2, v.value, tempPlusValue2);
				}
			}
			o.Call(f);
		});
	}
}
