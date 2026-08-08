using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("二级技能类型", 0)]
[Category("Logic/Abilities")]
[Description("二级技能类型")]
public class GetSkillSubType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		int res = 0;
		AddValueOutput("结果(int)", () => res);
		AddValueOutput("结果(枚举)", () => (SkillSubType)res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("直接查表", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(value);
			res = config.SkillSubType;
			output.Call(f);
		});
		AddFlowInput("先找根技能", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			DamageFormula.GetRootAbilityID(value, thrownIDInput.value, base.mSimContext, out var rootabilityID);
			value = rootabilityID;
			public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(value);
			res = config.SkillSubType;
			output.Call(f);
		});
	}
}
