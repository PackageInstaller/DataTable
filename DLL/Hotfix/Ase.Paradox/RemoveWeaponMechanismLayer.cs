using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("减少武器机制层数（英雄）", 0)]
[Category("✫ DragonLost/Weapon")]
[Description("减少英雄实体武器机制的层数。")]
public class RemoveWeaponMechanismLayer : ActionTaskBase
{
	[RequiredField]
	[Name("减少层数", 0)]
	[Description("要减少的层数。")]
	public BBParameter<int> layer;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity)
		{
			heroEntity.BattleHeroData.WeaponMechanismBase.ReduceLayer(layer.value);
		}
		OnActionFinish();
	}
}
