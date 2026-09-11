using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更改实体阵营", 0)]
[Category("Logic/Trigger")]
[Description("更改实体的Lyaer")]
[ExposeAsDefinition]
public class SetEntityLayer : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<RoleType> m_campInput = AddValueInput<RoleType>("阵营", "roleType");
		FlowOutput m_out = AddFlowOutput("Out");
		FlowOutput m_error = AddFlowOutput("Error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else if (!simEntity.hasEntityCamp)
			{
				m_error.Call(f);
			}
			else
			{
				uint value = (uint)m_campInput.value;
				simEntity.entityCamp.mRoleTypeCamp = value;
				List<EntityShape> list = new List<EntityShape>();
				SimShapeProcessor.GetAllShapeWithUnable(simEntity, list);
				for (int i = 0; i < list.Count; i++)
				{
					list[i].mLayer = value;
					list[i].mShape.Layer = m_campInput.value;
				}
				m_out.Call(f);
			}
		});
	}
}
