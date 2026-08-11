using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检测角色天赋树", 0)]
[Description("检测指定角色的天赋树是否达到指定的层级和星级。")]
[Category("✫ DragonLost/Entity")]
public class CheckHeroTalentStarLevel : ConditionTaskBase
{
	[Name("层级", 0)]
	[Description("要检查的天赋树层级。")]
	public BBParameter<int> Layer;

	[Name("星级", 0)]
	[Description("要检查的天赋树星级。")]
	public BBParameter<int> Star;

	protected override bool OnCheck()
	{
		if (ownerEntity is HeroEntity heroEntity)
		{
			return heroEntity.CheckHeroTalentStarLevel(Layer.value, Star.value);
		}
		return false;
	}
}
