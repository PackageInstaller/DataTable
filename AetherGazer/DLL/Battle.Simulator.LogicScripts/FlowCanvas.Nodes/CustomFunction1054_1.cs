using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[无常]增加技能三标识", 0)]
[Category("Logic/角色定制/无常")]
[Description("1054无常技能三标识用的节点")]
public class CustomFunction1054_1 : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> blackboardValueIDInput = AddValueInput<int>("黑板值ID", "blackboardValueID");
		ValueInput<int> flagIndexInput = AddValueInput<int>("标记索引", "flagIndex");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput falseOut = AddFlowOutput("不再添加", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, blackboardValueIDInput.value, out var baseValue, out var _, out var _);
				uint num = (uint)baseValue;
				int num2 = (int)(num & 0xF);
				int num3 = (int)((num >> 4) & 0xF);
				int num4 = (int)((num >> 8) & 0xF);
				int num5 = (int)((num >> 12) & 0xF);
				if (num2 + num3 + num4 + num5 >= 4)
				{
					if (num2 > 1 && flagIndexInput.value != 0)
					{
						num--;
					}
					else if (num3 > 1 && flagIndexInput.value != 1)
					{
						num -= 16;
					}
					else if (num5 > 1 && flagIndexInput.value != 3)
					{
						num -= 4096;
					}
					else
					{
						if (num4 <= 1 || flagIndexInput.value == 2)
						{
							falseOut.Call(f);
							return;
						}
						num -= 256;
					}
				}
				int num6 = flagIndexInput.value * 4;
				num += (uint)(1 << num6);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, blackboardValueIDInput.value, num, 0L, 0L);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
