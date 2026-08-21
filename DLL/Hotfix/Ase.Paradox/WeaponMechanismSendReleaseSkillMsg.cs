using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("向武器发送技能释放消息", 0)]
[Category("✫ DragonLost/Weapon")]
[Description("向英雄实体的武器机制发送释放指定技能类型的消息。")]
public class WeaponMechanismSendReleaseSkillMsg : ActionTaskBase
{
	[RequiredField]
	[Name("技能类型", 0)]
	[Description("要释放的技能类型。")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity)
		{
			heroEntity.BattleHeroData.WeaponMechanismBase.SendReleaseSkill(heroEntity, skillType.value);
		}
		OnActionFinish();
	}
}
