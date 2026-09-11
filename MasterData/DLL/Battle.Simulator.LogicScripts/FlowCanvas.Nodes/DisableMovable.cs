using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用移动", 0)]
[Category("Logic/Buff/效果/移动")]
[Description("禁止移动")]
public class DisableMovable : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				long baseValue = 0L;
				long plusValue = 0L;
				long tempPlusValue = 0L;
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2016, out baseValue, out plusValue, out tempPlusValue);
				baseValue++;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2016, baseValue, 0L, 0L);
				MovementProcessor.EnableMovement(entityWithEntityID, isActive: false);
				ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
				entityWithEntityID.entityBlackboard.var.EnableAbility(entityWithEntityID.entityBlackboard.var.mMovementStopSlot, isEnable: false);
				entityWithEntityID.entityBlackboard.var.EnableAbility(entityWithEntityID.entityBlackboard.var.mRushStopIDSlot, isEnable: false);
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
