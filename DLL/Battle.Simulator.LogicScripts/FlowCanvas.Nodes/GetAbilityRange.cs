using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能连续索敌范围", 0)]
[Category("Logic/Abilities")]
[Description("根据技能id获取技能范围")]
public class GetAbilityRange : PureFunctionNode<int, int>
{
	public override int Invoke(int abilityID)
	{
		return ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID)?.Range ?? 0;
	}
}
