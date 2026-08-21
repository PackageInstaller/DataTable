using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置技能移动的方向的获取方式", 0)]
[Category("Logic/Attribute")]
[Description("设置技能移动的方向获取方式,输入True则摇杆相对角色方向,输入False则摇杆相对相机方向")]
public class SetAbilityMoveMod : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<bool> enableInput = AddValueInput<bool>("是否相对角色方向");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2226, enableInput.value ? 1 : 0, 0L, 0L);
				output.Call(f);
			}
		});
	}
}
