using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("隐藏技能指示器UI", 0)]
[Category("✫ Entity")]
[Description("隐藏或显示实体的特定技能指示器UI，或者隐藏所有技能指示器UI。")]
public class HideSkillAimer : ActionTaskBase
{
	[RequiredField]
	[Name("技能类型", 0)]
	[Description("要隐藏或显示其指示器UI的技能类型。")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	[RequiredField]
	[Name("隐藏所有", 0)]
	[Description("指示是否隐藏所有技能指示器UI。")]
	public BBParameter<bool> hideAll = false;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity && heroEntity.BattleHeroData.IsSelf)
		{
			if (hideAll.value)
			{
				ownerEntity.GetSystem<TouchSystem>().HideSkillAimerAll();
			}
			else
			{
				ownerEntity.GetSystem<TouchSystem>().HideSkillAimer(skillType.value);
			}
		}
		EndAction();
	}
}
