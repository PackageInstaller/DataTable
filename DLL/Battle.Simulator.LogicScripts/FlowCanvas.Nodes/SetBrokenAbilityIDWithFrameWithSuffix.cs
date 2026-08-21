using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连招打断(带起始帧数，后三位)", 0)]
[Category("Logic/Abilities")]
[Description("设置中断的技能ID")]
public class SetBrokenAbilityIDWithFrameWithSuffix : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("新技能ID（后三位）");
		ValueInput<int> frameInput = AddValueInput<int>("起始帧数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int abilityID = (entityWithEntityID.entityConfig.mConfig as RoleConfig).ID * 1000 + abilityIDInput.value;
			AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, forceBroken: true);
			entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = frameInput.value;
			output.Call(f);
		});
	}
}
