using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断AI芯片效果", 0)]
[Category("Logic/装备")]
[Description("判断AI芯片ID对应 ai_chip 表中的 id 列")]
public class AIChipEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> idInput = AddValueInput<int>("AI芯片ID");
		ValueInput<int> maxInput = AddValueInput<int>("最大芯片数量").SetDefaultAndSerializedValue(20);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = idInput.value;
			int num = 2130;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				f.Call(falseOut);
			}
			else
			{
				bool flag = false;
				int value3 = maxInput.value;
				for (int i = 0; i < value3; i++)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num + i, out var baseValue, out var _, out var _);
					if (baseValue == 0L)
					{
						break;
					}
					if (value2 == baseValue)
					{
						flag = true;
						break;
					}
				}
				if (flag)
				{
					f.Call(trueOut);
				}
				else
				{
					f.Call(falseOut);
				}
			}
		});
	}
}
