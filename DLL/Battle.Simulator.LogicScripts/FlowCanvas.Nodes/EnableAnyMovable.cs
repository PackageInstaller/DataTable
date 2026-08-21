using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用移动(包括技能)", 0)]
[Category("Logic/Buff/效果/移动")]
[Description("启用移动,黑板中的禁止移动计数会-1,并启用本次移动")]
public class EnableAnyMovable : FlowControlNode
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
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2022, out baseValue, out plusValue, out tempPlusValue);
				baseValue--;
				baseValue = IntMath.Max(baseValue, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2022, baseValue, 0L, 0L);
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2021, out baseValue, out plusValue, out tempPlusValue);
				baseValue--;
				baseValue = IntMath.Max(baseValue, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2021, baseValue, 0L, 0L);
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
