using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置弓箭觉醒值是否自动衰减（英雄）", 0)]
[Category("✫ DragonLost/Weapon")]
[Description("设置英雄实体的弓箭觉醒值是否自动衰减。")]
public class WeaponMechanismSetBowStopReduce : ActionTaskBase
{
	[RequiredField]
	[Name("是否自动衰减", 0)]
	[Description("指示是否自动衰减弓箭觉醒值。")]
	public BBParameter<bool> isAutoStop;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity && heroEntity.BattleHeroData.WeaponMechanismBase is WeaponMechanismBow weaponMechanismBow)
		{
			weaponMechanismBow?.SetStopReduce(isAutoStop.value);
		}
		OnActionFinish();
	}
}
