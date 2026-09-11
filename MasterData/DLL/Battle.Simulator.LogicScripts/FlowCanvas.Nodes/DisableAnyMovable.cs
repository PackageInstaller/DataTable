using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用移动（包括技能）", 0)]
[Category("Logic/Buff/效果/移动")]
[Description("禁止移动,黑板中的禁止移动计数会+1,并清除本次移动,如果需要持续清除,则请每帧调用【清除移动】")]
public class DisableAnyMovable : FlowControlNode
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
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2022, out baseValue, out plusValue, out tempPlusValue);
				baseValue++;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2022, baseValue, 0L, 0L);
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2021, out baseValue, out plusValue, out tempPlusValue);
				baseValue++;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2021, baseValue, 0L, 0L);
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
