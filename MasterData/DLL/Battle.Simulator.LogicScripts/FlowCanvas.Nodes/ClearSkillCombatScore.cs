using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除技能战斗评分记录(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("将被使用过的【技能】造成的战斗评分标记为【完成】即可统一清理")]
public class ClearSkillCombatScore : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else if (!simEntity.hasEntityActionModifyCombatScore)
			{
				m_error.Call(f);
			}
			else
			{
				int num = 3;
				List<ModifyCombatScoreInfo> mModifyInfoList = simEntity.entityActionModifyCombatScore.mModifyInfoList;
				for (int i = 0; i < mModifyInfoList.Count; i++)
				{
					ModifyCombatScoreInfo value = mModifyInfoList[i];
					if (value.mModifyTypeEnumValue == num && value.mState == EntityActionStatus.E_DELAY)
					{
						value.mState = EntityActionStatus.E_SUCCESS;
					}
					mModifyInfoList[i] = value;
				}
			}
		});
	}
}
