using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送玩家方AI攻击事件", 0)]
[Category("Logic/AI")]
[Description("发送玩家方AI攻击事件")]
public class SendPlayerAIAttackEvent : FlowNode
{
	public int interval;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddFlowInput("", delegate
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(base.mSimContext.GetEntityWithEntityID(entityIDInput.value).entityBlackboard.var.mAimTarget);
			if (simEntityByMultiColliders != null && simEntityByMultiColliders.entityBlackboard.var.mHP > 0 && simEntityByMultiColliders.hasEntityAIThink && base.mSimContext.GetSimInterface().mPlayerAIAttackEvent != null)
			{
				if (interval != 0 && simEntityByMultiColliders.entityAIThink.mThinkTimer % interval == 0)
				{
					base.mSimContext.GetSimInterface().mPlayerAIAttackEvent(entityIDInput.value);
				}
				else if (interval == 0)
				{
					base.mSimContext.GetSimInterface().mPlayerAIAttackEvent(entityIDInput.value);
				}
			}
		});
	}
}
