using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using Bamboo.ECS;

namespace ACT.UI;

public class OperateBtnUtility
{
	public static OperateBtnBindSkillInfo GetSkillInfo(Entity entity, OperateBtnStateConfigData stateConfigData)
	{
		Skill skill = entity.GetCompMotion()?.GetSkill(stateConfigData.MotionName);
		if (skill != null && entity.GetCompCharacter() != null)
		{
			return new OperateBtnBindSkillInfo(entity.Id, stateConfigData.MotionName, skill);
		}
		return null;
	}

	public static bool HasDurationAbility(List<OperateBtnDisplayData> btnDisplayData, string abilityName)
	{
		for (int i = 0; i < btnDisplayData.Count; i++)
		{
			OperateBtnDisplayData operateBtnDisplayData = btnDisplayData[i];
			if (operateBtnDisplayData.ShowDuration && operateBtnDisplayData.AbilityName == abilityName)
			{
				return true;
			}
		}
		return false;
	}

	[Obsolete]
	public static int GetEnergyStageState(int characterId)
	{
		if (Model<CharacterOperateBtnModel>.Interface.characterEnergyStage2State.TryGetValue(characterId, out var value))
		{
			return value;
		}
		return 0;
	}

	[Obsolete]
	public static void SetEnergyStageState(int characterId, int state)
	{
		if (!Model<CharacterOperateBtnModel>.Interface.characterEnergyStage2State.TryGetValue(characterId, out var value) || value != state)
		{
			Model<CharacterOperateBtnModel>.Interface.characterEnergyStage2State[characterId] = state;
		}
	}
}
