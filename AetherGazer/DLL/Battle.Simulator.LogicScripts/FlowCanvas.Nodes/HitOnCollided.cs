using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物检定接触命中(过时)", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物碰撞后,检查行为参数,发送创建抛掷物实体事件")]
public class HitOnCollided : FlowControlNode
{
	private ValueInput<int> m_thrownBehaviourOnCollisionInput;

	private ValueInput<int> m_thrownIDInput;

	private ValueInput<int> m_collidedEntityIDInput;

	private ValueInput<int> m_collisionInfoIndexInput;

	private FlowOutput m_execution;

	private FlowOutput m_nonexecution;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_thrownBehaviourOnCollisionInput = AddValueInput<int>("接触行为参数", "thrownBehaviourOnCollision");
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		m_collidedEntityIDInput = AddValueInput<int>("接触实体ID", "collidedEntityID");
		m_collisionInfoIndexInput = AddValueInput<int>("第几次判定", "collisionInfoIndex");
		m_execution = AddFlowOutput("执行", "execute");
		m_nonexecution = AddFlowOutput("未执行", "nonexecute");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate
		{
		});
	}
}
