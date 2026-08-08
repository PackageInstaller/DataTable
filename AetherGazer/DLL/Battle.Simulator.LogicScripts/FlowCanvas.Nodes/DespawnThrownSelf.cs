using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物检定自我销毁", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物碰撞后,检查行为参数,执行自我销毁,并发送自我销毁事件")]
public class DespawnThrownSelf : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput abnormal = AddFlowOutput("异常退出");
		FlowOutput execution = AddFlowOutput("执行");
		FlowOutput nonexecution = AddFlowOutput("未执行");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<int> collisionIDVar = AddValueInput<int>("接触实体ID");
		ValueInput<int> thrownBehaviourOnCollisionVar = AddValueInput<int>("接触行为参数(可选)").SetDefaultAndSerializedValue(-1);
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else
			{
				int num = thrownBehaviourOnCollisionVar.GetValue();
				if (num == -1)
				{
					ThrownCollisionCheckInfo thrownCollisionCheckInfo = null;
					if (!ThrownHelper.TryGetThrownCollisionCheckInfo(thrownState.mAbilityID, thrownState.mConllisionCheckIndex, out thrownCollisionCheckInfo))
					{
						abnormal.Call(f);
						return;
					}
					num = thrownCollisionCheckInfo.ThrownBehaviourOnCollision;
				}
				if (num <= 0 || (num & 1) != 1)
				{
					nonexecution.Call(f);
				}
				else
				{
					ThrownProcessor.DestoryThrown(base.mSimContext, thrownState);
					execution.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.GetValue());
		AddValueOutput("接触实体ID", () => collisionIDVar.GetValue());
	}
}
