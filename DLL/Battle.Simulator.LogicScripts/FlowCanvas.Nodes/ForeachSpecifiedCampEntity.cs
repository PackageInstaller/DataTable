using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历指定阵营实体", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历指定阵营的实体")]
public class ForeachSpecifiedCampEntity : FlowControlNode
{
	private FlowOutput m_do;

	private FlowOutput m_done;

	private ValueInput<RoleType> m_camp;

	private int m_entityID;

	protected override void RegisterPorts()
	{
		m_do = AddFlowOutput("Do", "do");
		m_done = AddFlowOutput("Done", "done");
		m_camp = AddValueInput<RoleType>("阵营", "camp");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			uint value = (uint)m_camp.GetValue();
			SimEntity[] entities = base.mSimContext.GetEntities();
			foreach (SimEntity simEntity in entities)
			{
				if (simEntity.hasEntityBlackboard && simEntity.hasEntityCamp && simEntity.hasEntityRemotePlayer && RoleCampProcessor.Is(simEntity.entityCamp.mRoleTypeCamp, value))
				{
					m_entityID = simEntity.creationIndex;
					m_do.Call(f);
				}
			}
			m_done.Call(f);
		});
		AddValueOutput("实体ID", "entityID", () => m_entityID);
	}
}
