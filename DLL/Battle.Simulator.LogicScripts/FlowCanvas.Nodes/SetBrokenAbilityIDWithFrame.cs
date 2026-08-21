using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连招打断(带起始帧数)", 0)]
[Category("Logic/Abilities")]
[Description("设置中断的技能ID")]
public class SetBrokenAbilityIDWithFrame : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("新技能ID");
		ValueInput<int> frameInput = AddValueInput<int>("起始帧数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityIDInput.value, forceBroken: true);
			entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = frameInput.value;
			output.Call(f);
		});
	}
}
