using ACT.Battle;
using ACT.Config;
using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Model;

public class CharacterTutorialTargetMatcher
{
	private readonly CharacterTutorialTargetType _targetType;

	private readonly int _characterId;

	private readonly int _teamSlot;

	public CharacterTutorialTargetMatcher(CharacterTutorialTargetType targetType, int characterId, int teamSlot)
	{
		_targetType = targetType;
		_characterId = characterId;
		_teamSlot = teamSlot;
	}

	public bool Matches(int characterId)
	{
		switch (_targetType)
		{
		case CharacterTutorialTargetType.CurrentControlled:
		{
			if (TryGetCurrentControlledCharacterId(out var characterId3))
			{
				return characterId3 == characterId;
			}
			return false;
		}
		case CharacterTutorialTargetType.TeamSlot:
		{
			if (TryGetTeamSlotCharacterId(_teamSlot, out var characterId2))
			{
				return characterId2 == characterId;
			}
			return false;
		}
		case CharacterTutorialTargetType.AnyTeamMember:
			return IsTeamCharacter(characterId);
		default:
			return _characterId == characterId;
		}
	}

	public bool HasAbility(string abilityName)
	{
		switch (_targetType)
		{
		case CharacterTutorialTargetType.CurrentControlled:
			if (MonoECS.instance.mainEntity.IsValid)
			{
				return MonoECS.instance.mainEntity.GetCompAbility().HasAbility(abilityName);
			}
			return false;
		case CharacterTutorialTargetType.TeamSlot:
		{
			if (_teamSlot < 0)
			{
				return false;
			}
			Entity teamCharacter2 = MPPlayer.local.GetTeamCharacter(_teamSlot);
			if (teamCharacter2.IsValid)
			{
				return teamCharacter2.GetCompAbility().HasAbility(abilityName);
			}
			return false;
		}
		case CharacterTutorialTargetType.AnyTeamMember:
		{
			for (int j = 0; j < BattleConsts.TEAMCAPITAL; j++)
			{
				Entity teamCharacter3 = MPPlayer.local.GetTeamCharacter(j);
				if (teamCharacter3.IsValid && teamCharacter3.GetCompAbility().HasAbility(abilityName))
				{
					return true;
				}
			}
			return false;
		}
		default:
		{
			for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
			{
				Entity teamCharacter = MPPlayer.local.GetTeamCharacter(i);
				if (teamCharacter.IsValid && teamCharacter.IsCharacter() && teamCharacter.GetCompCharacter().characterSource.Id() == _characterId)
				{
					return teamCharacter.GetCompAbility().HasAbility(abilityName);
				}
			}
			if (MonoECS.instance.mainEntity.IsValid && MonoECS.instance.mainEntity.IsCharacter() && MonoECS.instance.mainEntity.GetCompCharacter().characterSource.Id() == _characterId)
			{
				return MonoECS.instance.mainEntity.GetCompAbility().HasAbility(abilityName);
			}
			return false;
		}
		}
	}

	private static bool TryGetCurrentControlledCharacterId(out int characterId)
	{
		characterId = 0;
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid || !mainEntity.IsCharacter())
		{
			return false;
		}
		characterId = mainEntity.GetCompCharacter().characterSource.Id();
		return true;
	}

	private static bool TryGetTeamSlotCharacterId(int teamSlot, out int characterId)
	{
		characterId = 0;
		if (teamSlot < 0)
		{
			return false;
		}
		Entity teamCharacter = MPPlayer.local.GetTeamCharacter(teamSlot);
		if (!teamCharacter.IsValid || !teamCharacter.IsCharacter())
		{
			return false;
		}
		characterId = teamCharacter.GetCompCharacter().characterSource.Id();
		return true;
	}

	private static bool IsTeamCharacter(int characterId)
	{
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			Entity teamCharacter = MPPlayer.local.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.IsCharacter() && teamCharacter.GetCompCharacter().characterSource.Id() == characterId)
			{
				return true;
			}
		}
		return false;
	}
}
