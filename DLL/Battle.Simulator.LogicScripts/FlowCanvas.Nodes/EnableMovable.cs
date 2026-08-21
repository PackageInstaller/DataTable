using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用移动", 0)]
[Category("Logic/Buff/效果/移动")]
[Description("启用移动,黑板中的禁止移动计数会-1,并启用本次移动")]
public class EnableMovable : FlowControlNode
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
				baseValue--;
				baseValue = IntMath.Max(baseValue, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2016, baseValue, 0L, 0L);
				if (baseValue == 0L)
				{
					MovementProcessor.EnableMovement(entityWithEntityID, isActive: true);
				}
				ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
				entityWithEntityID.entityBlackboard.var.EnableAbility(entityWithEntityID.entityBlackboard.var.mMovementStopSlot, isEnable: true);
				entityWithEntityID.entityBlackboard.var.EnableAbility(entityWithEntityID.entityBlackboard.var.mRushStopIDSlot, isEnable: true);
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
