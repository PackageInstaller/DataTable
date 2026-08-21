using Ase.ECS;
using UnityEngine;

namespace Ase;

public class WeaponKeennessBuff : BuffOperationBase<BuffDataWeaponKeenness>
{
	private WeaponMechanismSwordViewModel vm;

	private BattleSystem battleSystem;

	protected override void OnInit()
	{
		base.OnInit();
		if (base.buffOwner is HeroEntity heroEntity)
		{
			vm = heroEntity.BattleHeroData.WeaponMechanismData as WeaponMechanismSwordViewModel;
		}
		battleSystem = base.buffOwner.GetSystem<BattleSystem>();
	}

	protected override void OnExecute()
	{
		if (vm != null)
		{
			float keennessRatio = vm.KeennessRatio;
			vm.KeennessRatio = Mathf.Clamp01(1f - base.buff.CurLifeTime / base.buff.MaxLifeTime);
			battleSystem?.OnWeaponChangeStat(base.buffOwner.Id, WeaponStatEnum.SwordKeennessTime, vm.KeennessRatio - keennessRatio);
		}
	}

	protected override void OnDispose()
	{
		if (vm != null)
		{
			vm.KeennessRatio = 0f;
		}
	}

	protected override void OnClear()
	{
		battleSystem = null;
	}
}
