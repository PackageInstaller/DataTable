using System.Collections.Generic;
using System.Linq;
using ACT.Game.Data;

namespace ACT.Battle;

public class SkillLevel : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		if (param.Length == 0)
		{
			return 0;
		}
		return CharacterDataHelper.GetCharacterRepository(0).Characters.Values.Where((Character c) =>
		{
			foreach (KeyValuePair<int, int> skillGroupLevel in c.SkillGroupLevels)
			{
				if (skillGroupLevel.Value >= param[1])
				{
					return true;
				}
			}
			return false;
		}).Count();
	}

	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		return CharacterDataHelper.GetCharacterRepository(0).Characters.Values.Where((Character c) =>
		{
			foreach (KeyValuePair<int, int> skillGroupLevel in c.SkillGroupLevels)
			{
				if (skillGroupLevel.Value >= param[1])
				{
					return true;
				}
			}
			return false;
		}).Count() >= param[0];
	}
}
