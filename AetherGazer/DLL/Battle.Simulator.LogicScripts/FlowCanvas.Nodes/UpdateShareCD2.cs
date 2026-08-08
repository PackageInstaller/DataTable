using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]更新共享CD技能(过时)", 0)]
[Category("Logic/Attribute")]
[Description("设置共享CD列表,找到传入源,修改所有共享CD的技能")]
public class UpdateShareCD2 : FlowControlNode
{
	private List<int> m_sharedCDAbilityIDList;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<int> srcAbilityIDVar = AddValueInput<int>("CD源技能ID", "srcAbilityIDVar");
		ValueInput<List<int>> sharedCDListVar = AddValueInput<List<int>>("共享CD技能列表", "sharedCDListVar");
		AddValueOutput("实体ID", "entityID", () => entityIDVar.GetValue());
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput abnormal = AddFlowOutput("异常", "abnormal");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_sharedCDAbilityIDList = sharedCDListVar.GetValue();
			if (m_sharedCDAbilityIDList == null || m_sharedCDAbilityIDList.Count == 0)
			{
				abnormal.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
				if (entityWithEntityID == null)
				{
					abnormal.Call(f);
				}
				else
				{
					if (CDProcessor.GetCD(entityWithEntityID, srcAbilityIDVar.GetValue(), out var abilityCD))
					{
						bool flag = false;
						for (int i = 0; i < m_sharedCDAbilityIDList.Count; i++)
						{
							flag = false;
							for (int j = 0; j < entityWithEntityID.entityCD.mAbilityCD.Count; j++)
							{
								if (entityWithEntityID.entityCD.mAbilityCD[j].AbilityID == srcAbilityIDVar.GetValue())
								{
									flag = true;
								}
								else if (entityWithEntityID.entityCD.mAbilityCD[j].AbilityID == m_sharedCDAbilityIDList[i])
								{
									AbilityCD value = entityWithEntityID.entityCD.mAbilityCD[j];
									value.CD = abilityCD.CD;
									entityWithEntityID.entityCD.mAbilityCD[j] = value;
									flag = true;
									break;
								}
							}
							if (!flag)
							{
								AbilityCD item = abilityCD;
								item.AbilityID = m_sharedCDAbilityIDList[i];
								entityWithEntityID.entityCD.mAbilityCD.Add(item);
							}
						}
					}
					else
					{
						for (int k = 0; k < m_sharedCDAbilityIDList.Count; k++)
						{
							CDProcessor.RemoveCD(entityWithEntityID, m_sharedCDAbilityIDList[k]);
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
