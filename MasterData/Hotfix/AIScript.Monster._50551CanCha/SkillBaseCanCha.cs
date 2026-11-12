using System.Collections.Generic;

namespace AIScript.Monster._50551CanCha;

public class SkillBaseCanCha : SkillSimpleBase
{
	protected void KillTeamMate(List<int> maeIndex)
	{
		List<LogicEntity> targetByTeammateIndexes = GetTargetByTeammateIndexes(maeIndex);
		if (targetByTeammateIndexes != null && targetByTeammateIndexes.Count > 0)
		{
			KillActors(targetByTeammateIndexes);
		}
	}
}
