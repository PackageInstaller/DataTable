using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取英雄武器类型", 0)]
[Category("✫ DragonLost/BattleEntity")]
[Description("用于获取英雄实体的武器类型")]
public class GetHeroWeaponType : ActionTaskBase
{
	[Name("实体id", 0)]
	[Description("要获取武器类型的英雄实体的ID")]
	public BBParameter<int> entityId;

	[Name("返回的层数", 0)]
	[Description("用于存储获取到的武器类型")]
	public BBParameter<WeaponEnum> weaponType;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity != null && entity is HeroEntity heroEntity)
		{
			weaponType.value = heroEntity.BattleHeroData.WeaponEnum;
		}
		else
		{
			weaponType.value = WeaponEnum.None;
		}
		OnActionFinish();
	}
}
