using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置连携奥义播放模式(渲染)", 0)]
[Category("Render/Asset")]
[Description("设置连携奥义播放模式,理论上应该是会覆盖玩家设置（除非玩家自己又覆盖回去）node为不跳过，all为全跳")]
public class SetCooperateUniqueSkillType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<En_CooperateUniqueSkillPlayControlledType> typeInput = AddValueInput<En_CooperateUniqueSkillPlayControlledType>("连携奥义播放模式").SetDefaultAndSerializedValue(En_CooperateUniqueSkillPlayControlledType.None);
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("in", delegate(Flow f)
		{
			BattleScene.PlayControlledType = typeInput.value;
			output.Call(f);
		});
	}
}
