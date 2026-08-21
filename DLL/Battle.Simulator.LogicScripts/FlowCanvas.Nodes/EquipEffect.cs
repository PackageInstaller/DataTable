using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断装备效果", 0)]
[Category("Logic/装备")]
[Description("装备效果ID对应 equip_effect 表中的 id 列")]
public class EquipEffect : FlowNode
{
	public const int MaxEffectNumber = 20;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> idInput = AddValueInput<int>("装备效果ID", "装备效果ID");
		int equipID = 0;
		AddValueOutput("装备ID", () => equipID);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = idInput.value;
			int num = 2100;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				f.Call(falseOut);
			}
			else
			{
				bool flag = false;
				for (int i = 0; i < 20; i++)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num, out var baseValue, out var _, out var _);
					num++;
					if (baseValue == 0L)
					{
						break;
					}
					if (value2 == baseValue)
					{
						equipID = (int)baseValue;
						f.Call(trueOut);
						flag = true;
					}
				}
				if (!flag)
				{
					f.Call(falseOut);
				}
			}
		});
	}
}
