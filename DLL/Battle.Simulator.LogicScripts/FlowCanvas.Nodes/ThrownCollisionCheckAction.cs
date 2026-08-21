using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检定抛掷物接触(过时)(失效)", 0)]
[Category("Logic/抛掷物")]
[Description("用于检查抛掷物在范围内是否接触到对象")]
public class ThrownCollisionCheckAction : FlowControlNode
{
	private ThrownCollisionCheckInfo m_thrownCollisionCheckInfo;

	private int m_index;

	protected override void RegisterPorts()
	{
		m_thrownCollisionCheckInfo = null;
		AddFlowOutput("接触");
		AddFlowOutput("未接触");
		AddFlowOutput("其他情况");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<int> timelineIDVar = AddValueInput<int>("TimelineID");
		ValueInput<List<int>> collisionsVar = AddValueInput<List<int>>("存放碰撞到的实体ID");
		AddFlowInput("In", delegate
		{
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
		AddValueOutput("TimelineID", () => timelineIDVar.value);
		AddValueOutput("事件索引", () => m_index);
		AddValueOutput("接触List：", () => collisionsVar.value);
		AddValueOutput("接触行为:", () => (m_thrownCollisionCheckInfo != null) ? m_thrownCollisionCheckInfo.ThrownBehaviourOnCollision : 0);
		AddValueOutput("产生的抛掷物TiemlineID:", () => (m_thrownCollisionCheckInfo != null) ? m_thrownCollisionCheckInfo.SpawnThrownTimelineID : 0);
	}
}
