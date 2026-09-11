using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物接触配置", 0)]
[Category("Logic/抛掷物")]
[Description("得到本次接触使用的接触配置")]
public class CurCollidedInfo : FlowControlNode
{
	private ThrownCollisionCheckInfo m_thrownCollisionCheckInfo;

	protected override void RegisterPorts()
	{
		FlowOutput abnormal = AddFlowOutput("异常退出");
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else
			{
				m_thrownCollisionCheckInfo = null;
				if (!ThrownHelper.TryGetThrownCollisionCheckInfo(thrownState.mAbilityID, thrownState.mConllisionCheckIndex, out m_thrownCollisionCheckInfo))
				{
					abnormal.Call(f);
				}
				else
				{
					output.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.GetValue());
		AddValueOutput("接触行为配置", () => (m_thrownCollisionCheckInfo != null) ? m_thrownCollisionCheckInfo.ThrownBehaviourOnCollision : 0);
		AddValueOutput("创建抛掷物TimelineID", () => (m_thrownCollisionCheckInfo != null) ? m_thrownCollisionCheckInfo.SpawnThrownTimelineID : 0);
		AddValueOutput("切换目标上限", () => (m_thrownCollisionCheckInfo != null) ? m_thrownCollisionCheckInfo.ChangeTargetCountLimit : 0);
	}
}
