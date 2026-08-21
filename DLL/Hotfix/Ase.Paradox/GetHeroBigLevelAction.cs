using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取燃点等级", 0)]
[Category("✫ DragonLost/BattleEntity")]
[Description("获取燃点等级。")]
public class GetHeroBigLevelAction : ActionTaskBase
{
	[Name("技能类型", 0)]
	[Description("技能类型。")]
	public HeroSkillTypeEnum SkillTypeEnum;

	[Name("燃点等级", 0)]
	[Description("返回的燃点等级。")]
	public BBParameter<int> BigLevel;

	private int originSkillID;

	protected override void OnExecute()
	{
		base.OnExecute();
		BigLevel.value = 0;
		if (ownerEntity is HeroEntity heroEntity)
		{
			int originSkillId = heroEntity.BattleHeroData.GetOriginSkillId(SkillTypeEnum);
			if (heroEntity.BattleHeroData.HeroModel.SkillBigLevel.TryGetValue(originSkillId, out var value))
			{
				BigLevel.value = value;
			}
		}
		EndAction();
	}
}
