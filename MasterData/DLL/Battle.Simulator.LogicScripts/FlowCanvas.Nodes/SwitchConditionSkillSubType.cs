using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断二级技能类型", 0)]
[Category("Logic/Abilities")]
[Description("判断二级技能类型, 两个类型随便填一个")]
public class SwitchConditionSkillSubType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<SkillSubType> valueInput = AddValueInput<SkillSubType>("类型");
		ValueInput<int> valueIntInput = AddValueInput<int>("类型(int)");
		FlowOutput trueOutput = AddFlowOutput("true");
		FlowOutput falseOutput = AddFlowOutput("false");
		AddFlowInput("直接查表", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(value);
			int num = valueIntInput.value;
			SkillSubType value2 = valueInput.value;
			if (value2 != SkillSubType.Normal)
			{
				num = (int)value2;
			}
			if (config.SkillSubType == num)
			{
				trueOutput.Call(f);
			}
			else
			{
				falseOutput.Call(f);
			}
		});
		AddFlowInput("先找根技能", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			DamageFormula.GetRootAbilityID(value, thrownIDInput.value, base.mSimContext, out var rootabilityID);
			value = rootabilityID;
			public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(value);
			int num = valueIntInput.value;
			SkillSubType value2 = valueInput.value;
			if (value2 != SkillSubType.Normal)
			{
				num = (int)value2;
			}
			if (config.SkillSubType == num)
			{
				trueOutput.Call(f);
			}
			else
			{
				falseOutput.Call(f);
			}
		});
	}
}
