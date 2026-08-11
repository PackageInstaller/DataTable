using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("比较输入优先级", 0)]
[Description("比较两个输入的优先级，将优先级高的输入作为结果返回。")]
[Category("✫ DragonLost/Entity")]
public class CompareInputPriority : ActionTaskBase
{
	[Name("输入 A", 0)]
	[Description("要比较的输入 A 的优先级。")]
	public BBParameter<HeroSkillTypeEnum> a;

	[Name("输入 B", 0)]
	[Description("要比较的输入 B 的优先级。")]
	public BBParameter<HeroSkillTypeEnum> b;

	[Name("结果", 0)]
	[Description("比较后优先级高的输入。")]
	public BBParameter<HeroSkillTypeEnum> result;

	protected override void OnExecute()
	{
		base.OnExecute();
		result.value = ((a.value > b.value) ? a.value : HeroSkillTypeEnum.None);
		OnActionFinish();
	}
}
