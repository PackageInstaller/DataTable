using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("使闪避效果CD(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("使闪避技能进入CD")]
public class EnableUltimateAvoidCD : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "out");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else
			{
				int ultimateAvoidCD = 0;
				if (!AttributeProcessor.TryGetUltimateAvoidCD(base.mSimContext, m_entityIDInput.GetValue(), out ultimateAvoidCD))
				{
					m_error.Call(f);
				}
				else
				{
					if (entityWithEntityID.hasEntityUltimateAvoidCD)
					{
						if (entityWithEntityID.entityUltimateAvoidCD.mLeftUseCount <= 0)
						{
							Debug.LogError("极限闪避已经在cd中了");
							m_error.Call(f);
							return;
						}
						entityWithEntityID.entityUltimateAvoidCD.mLeftUseCount--;
					}
					else
					{
						entityWithEntityID.AddEntityUltimateAvoidCD(ultimateAvoidCD, entityWithEntityID.entityBlackboard.var.mUltimateAvoidMaxUseCount - 1);
					}
					m_out.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
