using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionWeaponEnum : BuffConditionBase
{
	protected WeaponEnum weaponEnum;

	protected bool compare;

	public override BuffConditionType BuffConditionType => BuffConditionType.DestinyLevel;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		weaponEnum = Utility.Convert.StringToEnum<WeaponEnum>(paramList[0]);
		compare = Utility.Convert.StringToBool(paramList[1]);
	}

	protected override string OnGetDataString()
	{
		return $"{weaponEnum},{compare}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (entityTarget == null || !(entityTarget is HeroEntity heroEntity))
		{
			return false;
		}
		return heroEntity.BattleHeroData.WeaponEnum == weaponEnum == compare;
	}
}
