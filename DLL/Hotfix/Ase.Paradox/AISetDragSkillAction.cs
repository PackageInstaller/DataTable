using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("AI模拟技能在拖拽", 0)]
[Category("✫ DragonLost/Skill")]
[Description("AI模拟技能在拖拽")]
public class AISetDragSkillAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> HeroSkillTypeEnum;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().RecodeIsDragSkill(HeroSkillTypeEnum.value);
		OnActionFinish();
	}
}
