using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("对比指令优先级", 0)]
[Category("✫ DragonLost/Skill")]
[Description("检查两个技能指令的优先级。")]
public class CheckCommandPriority : ConditionTaskBase
{
	[BlackboardOnly]
	[Name("技能指令A", 0)]
	[Description("要比较优先级的第一个技能指令。")]
	public BBParameter<HeroSkillTypeEnum> valueA;

	[BlackboardOnly]
	[Name("技能指令B", 0)]
	[Description("要比较优先级的第二个技能指令。")]
	public BBParameter<HeroSkillTypeEnum> valueB;

	protected override string info => valueA?.ToString() + " > " + valueB;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (valueA.value == HeroSkillTypeEnum.None && valueB.value == HeroSkillTypeEnum.None)
		{
			return false;
		}
		return valueA.value > valueB.value;
	}
}
