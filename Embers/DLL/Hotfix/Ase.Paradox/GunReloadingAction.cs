using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("双枪换弹时间更新", 0)]
[Category("✫ Entity")]
[Description("更新英雄实体双枪换弹的剩余时长百分比。")]
public class GunReloadingAction : ActionTaskBase
{
	[RequiredField]
	[Name("换弹剩余时长百分比", 0)]
	[Description("换弹剩余时长的百分比，取值范围为0到1。")]
	public BBParameter<float> reloadingTime;

	[Name("跟随行为树结束重置", 0)]
	[Description("指示是否在行为树结束时重置换弹时间。")]
	public bool followTreeRecovery = true;

	private WeaponMechanismGunViewModel Data;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity)
		{
			Data = heroEntity.BattleHeroData.WeaponMechanismData as WeaponMechanismGunViewModel;
			Data.ReloadingMax = reloadingTime.value;
			Data.Reloading = reloadingTime.value;
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		if (followTreeRecovery && Data != null)
		{
			Data.SetReloading(0f, Vector3.zero);
			Data.ReloadingMax = 0f;
		}
	}
}
