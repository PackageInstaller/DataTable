using Ase.ECS;

namespace Ase;

public class SkillBindBuff : BuffOperationBase<BuffDataSkillBind>
{
	private HeroSkillTypeEnum heroSkillType;

	private HeroSkillData heroSkillData;

	private SkillComponent skillComponent;

	protected override void OnExecute()
	{
		if (!(base.buffOwner is HeroEntity heroEntity))
		{
			return;
		}
		skillComponent = heroEntity.GetComponent<SkillComponent>();
		if (skillComponent == null)
		{
			return;
		}
		if (dataBase.isClose)
		{
			skillComponent.HideSkillDeriveWindow(dataBase.deriveSkillId);
			return;
		}
		heroSkillType = GetHeroSkillTypeEnum(dataBase.skillType);
		if (heroSkillType == HeroSkillTypeEnum.None)
		{
			Toast.ShowError("修改技能配置Buff，无效的技能类型 " + dataBase.skillType);
			return;
		}
		heroSkillData = skillComponent.GetSkillData(heroSkillType);
		if (heroSkillData != null)
		{
			skillComponent.OpenSkillDeriveWindow(heroSkillType, dataBase.skillId, dataBase.deriveSkillId, dataBase.deriveTime, dataBase.restoreDeriveTime, dataBase.deriveNumber, dataBase.isStateDriver);
		}
	}

	protected override void OnDispose()
	{
		if (!dataBase.isClose)
		{
			skillComponent?.HideSkillDeriveWindow(dataBase.deriveSkillId);
		}
	}

	private HeroSkillTypeEnum GetHeroSkillTypeEnum(InputOptionEnum specificDataSkillType)
	{
		return specificDataSkillType switch
		{
			InputOptionEnum.Attack => HeroSkillTypeEnum.Attack, 
			InputOptionEnum.Skill1 => HeroSkillTypeEnum.Skill1, 
			InputOptionEnum.Skill2 => HeroSkillTypeEnum.Skill2, 
			InputOptionEnum.Skill3 => HeroSkillTypeEnum.Skill3, 
			InputOptionEnum.Skill4 => HeroSkillTypeEnum.Skill4, 
			InputOptionEnum.Dodge => HeroSkillTypeEnum.Roll, 
			_ => HeroSkillTypeEnum.None, 
		};
	}
}
