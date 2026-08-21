using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除通用减伤", 0)]
[Category("Logic/Attribute")]
[Description("移除通用减伤")]
public class RemoveCommonDamageReduction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> idInput = AddValueInput<int>("key");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				output.Call(f);
			}
			else
			{
				Dictionary<int, int> commonDamageReductions = entityWithEntityID.entityBlackboard.var.commonDamageReductions;
				if (commonDamageReductions == null)
				{
					output.Call(f);
				}
				else
				{
					commonDamageReductions.Remove(idInput.value);
					int num = AddCommonDamageReduction.CalcCommonDamageReduction(commonDamageReductions);
					int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityWithEntityID.creationIndex);
					int varName = 500;
					AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, varName, out var baseValue, out var _, out var tempPlusValue);
					AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, varName, baseValue, num, tempPlusValue);
				}
			}
		});
	}
}
