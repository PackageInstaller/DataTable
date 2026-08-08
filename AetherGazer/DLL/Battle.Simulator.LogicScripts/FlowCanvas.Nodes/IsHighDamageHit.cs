using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断是不是高伤害Hit", 0)]
[Category("Logic/Config")]
[Description("判断是不是高伤害Hit")]
public class IsHighDamageHit : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		ValueInput<int> hitIndexInput = AddValueInput<int>("HitIndex");
		ValueInput<DamageType> damageTypeInput = AddValueInput<DamageType>("伤害类型");
		DamageType damageType = DamageType.None;
		AddValueOutput("伤害类型", () => damageType);
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			damageType = damageTypeInput.value;
			if (value == 0)
			{
				f.Call(falseOut);
			}
			else if (ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.value).HighDamageIndex.Contains(hitIndexInput.value + 1))
			{
				if (damageType == DamageType.Crit)
				{
					damageType = DamageType.HighDamageCrit;
				}
				else if (damageType == DamageType.Damage)
				{
					damageType = DamageType.HighDamage;
				}
				f.Call(trueOut);
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
