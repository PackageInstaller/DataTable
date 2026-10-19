using System.Collections.Generic;
using System.Runtime.CompilerServices;
using ACT;
using ACT.Battle;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.ECS;
using UnityEngine;

namespace Runtime.Utility;

public class EntityHelper
{
	private sealed class CharacterReferenceComparer : IEqualityComparer<Character>
	{
		public static readonly CharacterReferenceComparer Instance = new CharacterReferenceComparer();

		public bool Equals(Character x, Character y)
		{
			return x == y;
		}

		public int GetHashCode(Character obj)
		{
			return RuntimeHelpers.GetHashCode(obj);
		}
	}

	private static readonly Dictionary<Character, Entity> BattleCharacterEntities = new Dictionary<Character, Entity>(CharacterReferenceComparer.Instance);

	public static bool TryGetBattleEntityByCharacter(Character character, out Entity entity)
	{
		if (character == null)
		{
			entity = default;
			return false;
		}
		if (BattleCharacterEntities.TryGetValue(character, out entity) && entity.IsValid)
		{
			CompCharacter compCharacter = entity.GetCompCharacter();
			if (compCharacter != null && compCharacter.characterSource == character)
			{
				return true;
			}
		}
		BattleCharacterEntities.Remove(character);
		entity = default;
		return false;
	}

	public static void RegisterBattleEntity(Character character, Entity entity)
	{
		if (character != null && entity.IsValid)
		{
			BattleCharacterEntities[character] = entity;
		}
	}

	public static void UnregisterBattleEntity(Character character, Entity entity)
	{
		if (character != null && BattleCharacterEntities.TryGetValue(character, out var value) && !(value != entity))
		{
			BattleCharacterEntities.Remove(character);
		}
	}

	public static bool IsCharacterRuntimeAlive(Character character)
	{
		if (character == null)
		{
			return false;
		}
		if (TryGetRuntimeBattleAbility(character, out var compAbility))
		{
			if (compAbility.alive)
			{
				return compAbility.hp > 0;
			}
			return false;
		}
		CharacterStatus status = GetRuntimeStatusCharacter(character).Status;
		if (status == null)
		{
			return false;
		}
		return status.Hp > 0;
	}

	public static int GetCharacterRuntimeStatusHp(Character character)
	{
		if (character == null)
		{
			return 0;
		}
		if (TryGetRuntimeBattleAbility(character, out var compAbility) && compAbility.maxHP > 0)
		{
			return Mathf.CeilToInt((float)compAbility.hp * 1f / (float)compAbility.maxHP * (float)RuntimeConfigs.data.game.hpSync);
		}
		return GetRuntimeStatusCharacter(character).Status?.Hp ?? 0;
	}

	public static void WriteRuntimeAbilityToWorldStatus(Character character, CompAbility compAbility)
	{
		if (character != null && compAbility != null)
		{
			CharacterStatus status = GetRuntimeStatusCharacter(character).Status;
			if (status != null)
			{
				status.Hp = ((compAbility.maxHP > 0) ? Mathf.CeilToInt((float)compAbility.hp * 1f / (float)compAbility.maxHP * (float)RuntimeConfigs.data.game.hpSync) : 0);
				status.ExPower = compAbility.CurrentUltimateSkillValue;
				status.EnergyPower = compAbility.EnergyValue;
				status.SpecialEnergyPower = compAbility.SpecialEnergyValue;
				status.AssistPower = compAbility.AssistValue;
			}
		}
	}

	private static Character GetRuntimeStatusCharacter(Character character)
	{
		return CharacterDataHelper.GetCurCharacterByCharacterId(character.Id) ?? character;
	}

	private static bool TryGetRuntimeBattleAbility(Character character, out CompAbility compAbility)
	{
		compAbility = null;
		if (character == null)
		{
			return false;
		}
		if (TryGetBattleEntityByCharacter(character, out var entity) && entity.TryGetCompAbility(out compAbility))
		{
			return true;
		}
		Character curCharacterByCharacterId = CharacterDataHelper.GetCurCharacterByCharacterId(character.Id);
		if (curCharacterByCharacterId != null && curCharacterByCharacterId != character && TryGetBattleEntityByCharacter(curCharacterByCharacterId, out entity) && entity.TryGetCompAbility(out compAbility))
		{
			return true;
		}
		return false;
	}
}
