using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要你死(生命归0)", 0)]
[Category("Logic/我要")]
[Description("让实体直接执行死亡动作导致的死亡,该节点会触发【血量归0】相关行为")]
public class INeedYouDead2 : FlowControlNode
{
	private FlowOutput m_succeedOutput;

	private FlowOutput m_failedOutput;

	private FlowOutput m_abnormalOutput;

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
			if (entityWithEntityID == null)
			{
				m_abnormalOutput.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mHP = 0L;
				m_succeedOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityIDVar.GetValue());
	}
}
