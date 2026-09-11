using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("是否有管理员芯片(逻辑)", 0)]
[Category("Logic/装备")]
[Description("判断装载的芯片类型是否为管理员芯片(typeID 为 4 类型)")]
public class HasMasterAIChip : FlowControlNode
{
	private int roleID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput hasOut = AddFlowOutput("有", "has");
		FlowOutput noneOut = AddFlowOutput("无", "none");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("修正者ID", "roleID", () => roleID);
		AddFlowInput("", delegate(Flow f)
		{
			roleID = 0;
			int value = entityIDInput.value;
			int num = 2130;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				bool flag = false;
				int num2 = 20;
				for (int i = 0; i < num2; i++)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num + i, out var baseValue, out var _, out var _);
					if (baseValue == 0L)
					{
						break;
					}
					if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>((int)baseValue, out var config))
					{
						Debug.LogError($"图：{base.graph.name}里【是否有管理员芯片】节点的芯片ID在ai_chip表里查询不到,id 为{baseValue}");
					}
					else if (config.TypeId == 4)
					{
						roleID = config.SpecChar;
						if (roleID > 1999)
						{
							roleID /= 100;
						}
						flag = true;
						break;
					}
				}
				if (flag)
				{
					f.Call(hasOut);
				}
				else
				{
					f.Call(noneOut);
				}
			}
		});
	}
}
