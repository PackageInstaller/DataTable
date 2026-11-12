using System.Collections.Generic;
using TrueSync;

namespace AIScript.Utils;

public class SkillPool
{
	protected AdventureActor _actor;

	protected List<SkillVariable> _skillVariables;

	protected FP _checkInterval;

	public FP checkInterval => _checkInterval;

	public void Init(AdventureActor actor, List<SkillVariable> skillVariables, FP checkInterval)
	{
		_actor = actor;
		_skillVariables = skillVariables;
		_checkInterval = checkInterval;
	}

	public SkillVariable CheckQualifiedSkill(FP currentTime)
	{
		if (_skillVariables == null || _skillVariables.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < _skillVariables.Count; i++)
		{
			SkillVariable skillVariable = _skillVariables.get_Item(i);
			FP fP = skillVariable.cdExpireTime - currentTime;
			if (fP < 0f)
			{
				fP = 0f;
			}
			if (!(fP > 0f) && (skillVariable.ConditionFunc == null || skillVariable.ConditionFunc()) && (skillVariable.immBondage || !(_actor != null) || !_actor.isBondage))
			{
				return skillVariable;
			}
		}
		return null;
	}

	public SkillVariable GetSkill(int skillId)
	{
		if (_skillVariables == null || _skillVariables.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < _skillVariables.Count; i++)
		{
			if (_skillVariables.get_Item(i).id == skillId)
			{
				return _skillVariables.get_Item(i);
			}
		}
		return null;
	}
}
