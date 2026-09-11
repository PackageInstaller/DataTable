using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取源技能", 0)]
[Category("Logic/Abilities")]
[Description("获取源技能, 抛掷物的发起技能, abilityconfig的源技能")]
public class GetGetRootAbilityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("abilityID");
		ValueInput<int> thronwnIDInput = AddValueInput<int>("抛掷物ID");
		AddValueOutput("id", delegate
		{
			DamageFormula.GetRootAbilityID(abilityIDInput.value, thronwnIDInput.value, base.mSimContext, out var rootabilityID);
			return rootabilityID;
		});
	}
}
