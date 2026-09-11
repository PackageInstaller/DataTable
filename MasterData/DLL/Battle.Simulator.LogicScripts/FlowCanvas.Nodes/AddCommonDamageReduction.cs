using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加通用减伤", 0)]
[Category("Logic/Attribute")]
[Description("添加通用减伤")]
public class AddCommonDamageReduction : FlowNode
{
	public static int CalcCommonDamageReduction(Dictionary<int, int> dict)
	{
		int num = 1000;
		Dictionary<int, int>.Enumerator enumerator = dict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			num *= 1000 - enumerator.Current.Value;
			num /= 1000;
		}
		return 1000 - num;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> idInput = AddValueInput<int>("key");
		ValueInput<int> valueInput = AddValueInput<int>("变化值");
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
					commonDamageReductions[idInput.value] = valueInput.value;
					int num = CalcCommonDamageReduction(commonDamageReductions);
					int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityWithEntityID.creationIndex);
					int varName = 500;
					AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, varName, out var baseValue, out var _, out var tempPlusValue);
					AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, varName, baseValue, num, tempPlusValue);
				}
			}
		});
	}
}
