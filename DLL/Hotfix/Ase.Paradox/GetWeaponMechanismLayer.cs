using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取武器机制层数（英雄）", 0)]
[Category("✫ DragonLost/Weapon")]
[Description("获取英雄实体的当前武器机制层数。")]
public class GetWeaponMechanismLayer : ActionTaskBase
{
	[RequiredField]
	[Name("层数", 0)]
	[Description("获取到的武器机制层数。")]
	public BBParameter<int> layer;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity)
		{
			layer.value = (int)heroEntity.BattleHeroData.GetPropertyData("KeennessLayer").CurValue;
		}
		OnActionFinish();
	}
}
