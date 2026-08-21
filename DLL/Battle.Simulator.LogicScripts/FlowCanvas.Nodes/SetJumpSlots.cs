using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置跳跃动作", 0)]
[Category("Logic/Abilities")]
[Description("设置跳跃动作")]
public class SetJumpSlots : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<int> jumpStartIDInput = AddValueInput<int>("起跳动作");
		ValueInput<int> jumpUpLoopIDInput = AddValueInput<int>("上升循环");
		ValueInput<int> jumpAirIDInput = AddValueInput<int>("拐点动作");
		ValueInput<int> jumpDownLoopInput = AddValueInput<int>("降落循环");
		ValueInput<int> jumpLandIDInput = AddValueInput<int>("落地动作");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mJumpStartSlot = jumpStartIDInput.value;
				entityWithEntityID.entityBlackboard.var.mJumpUpLoopSlot = jumpUpLoopIDInput.value;
				entityWithEntityID.entityBlackboard.var.mJumpAirSlot = jumpAirIDInput.value;
				entityWithEntityID.entityBlackboard.var.mJumpDownLoopSlot = jumpDownLoopInput.value;
				entityWithEntityID.entityBlackboard.var.mJumpLandSlot = jumpLandIDInput.value;
				output.Call(f);
			}
		});
	}
}
