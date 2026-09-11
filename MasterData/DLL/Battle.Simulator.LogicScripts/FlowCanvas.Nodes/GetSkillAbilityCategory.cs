using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到技能行为分组(Pure)", 0)]
[Category("Logic/Abilities")]
[Description("行为分组\n0无\n1移动、待机、休闲相关\n2普攻\n3技能\n4奥义\n5取根源的子弹\n6根源为自己但是被判定为技能的子弹\n7受击相关\n8死亡\n9闪避\n10出场\n11剧情动作\n12一技能\n13二技能\n14三技能")]
public class GetSkillAbilityCategory : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityInput = AddValueInput<int>("技能ID");
		AddValueOutput("行为分组", () => ConfigHelper.GetInstance().GetConfig<public_skill>(abilityInput.value).AbilityCategory);
	}
}
