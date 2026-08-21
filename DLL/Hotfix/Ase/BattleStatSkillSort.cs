using System.Collections.Generic;

namespace Ase;

public class BattleStatSkillSort : Comparer<BattleStatSkillItemViewModel>
{
	public override int Compare(BattleStatSkillItemViewModel x, BattleStatSkillItemViewModel y)
	{
		if (y.Data.SkillType.CompareTo(x.Data.SkillType) != 0)
		{
			return x.Data.SkillType.CompareTo(y.Data.SkillType);
		}
		if (y.Data.IsTotalItem.CompareTo(x.Data.IsTotalItem) != 0)
		{
			return y.Data.IsTotalItem.CompareTo(x.Data.IsTotalItem);
		}
		if (y.Data.SkillId.CompareTo(x.Data.SkillId) != 0)
		{
			return x.Data.SkillId.CompareTo(y.Data.SkillId);
		}
		return 0;
	}
}
