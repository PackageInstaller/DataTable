using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("添加武器机制层数（英雄）", 0)]
[Category("✫ DragonLost/Weapon")]
[Description("为英雄实体的武器机制添加指定层数。")]
public class AddWeaponMechanismLayer : ActionTaskBase
{
	[RequiredField]
	[Name("新增层数", 0)]
	[Description("要添加到武器机制的层数。")]
	public BBParameter<int> layer;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity)
		{
			heroEntity.BattleHeroData.WeaponMechanismBase.AddLayer(layer.value);
		}
		OnActionFinish();
	}
}
