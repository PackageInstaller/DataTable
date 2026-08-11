using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示技能指示器", 0)]
[Category("✫ DragonLost/Skill")]
[Description("显示技能指示器")]
public class ShowSkillIndicatorAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	protected override void OnExecute()
	{
		base.OnExecute();
		SkillComponent component = ownerEntity.GetComponent<SkillComponent>();
		if (component != null)
		{
			HeroSkillData skillData = component.GetSkillData(SkillId.value);
			HeroSkillTypeEnum skillBindCommand = component.GetSkillBindCommand(SkillId.value);
			if (skillData.GetSkillLabelList().Contains("DraggablePropSkill"))
			{
				ownerEntity.GetSystem<TouchSystem>().ShowSkillIndicator(ownerEntity, skillData, skillBindCommand);
			}
		}
		EndAction();
	}
}
