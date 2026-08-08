using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要你死(执行死亡动作)", 0)]
[Category("Logic/我要")]
[Description("让实体直接执行死亡动作导致的死亡,该节点不会执行【血量归0】相关行为")]
public class INeedYouDead : FlowControlNode
{
	private FlowOutput m_succeedOutput;

	private FlowOutput m_failedOutput;

	private FlowOutput m_abnormalOutput;

	private FlowOutput m_forceOutput;

	private ValueInput<int> m_entityIDVar;

	protected override void RegisterPorts()
	{
		m_entityIDVar = AddValueInput<int>("实体ID");
		m_succeedOutput = AddFlowOutput("成功", "succeedOutput");
		m_failedOutput = AddFlowOutput("失败", "failedOutput");
		m_abnormalOutput = AddFlowOutput("异常", "abnormalOutput");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDVar.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				m_abnormalOutput.Call(f);
			}
			else
			{
				Int3 targetPostion = entityWithEntityID.entityPositon.mPosition + entityWithEntityID.entityPositon.mForward;
				int mDeathSlot = entityWithEntityID.entityBlackboard.var.mDeathSlot;
				if (mDeathSlot == -1)
				{
					m_failedOutput.Call(f);
				}
				else
				{
					AIProcessor.AIStartAttack(m_entityIDVar.GetValue(), targetPostion, mDeathSlot, isForce: true);
					m_succeedOutput.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityIDVar.GetValue());
	}
}
