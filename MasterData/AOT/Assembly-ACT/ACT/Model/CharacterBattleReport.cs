using System.Collections.Generic;
using ACT.Game.Data;
using Fundamental;

namespace ACT.Model;

public sealed class CharacterBattleReport
{
	public int CharacterId;

	public int CharacterLevel;

	public int CurrentHP;

	public int MaxHP;

	public float Damage;

	public float ActualDamage;

	public int PotionUseCount;

	public int UltralSkillUseCount;

	public int DodgeCount;

	public int WitchDodge;

	public int PerfectDodge;

	public int DieCount;

	public int TrapCount;

	public int TriggeredTrapCount;

	public Dictionary<int, int> TriggeredNodeCount;

	public Dictionary<int, int> BreakDiffTypeMonsterShieldCount;

	public Dictionary<int, int> KillDiffTypeMonsterOnShieldBrokenCount;

	public CharacterBattleReport()
	{
		TriggeredNodeCount = DictionaryPool<int, int>.Get();
		BreakDiffTypeMonsterShieldCount = DictionaryPool<int, int>.Get();
		KillDiffTypeMonsterOnShieldBrokenCount = DictionaryPool<int, int>.Get();
	}

	public CharacterBattleReport(Character character)
	{
		CharacterId = character.Id;
		CharacterLevel = character.Level;
		CurrentHP = character.Hp;
		MaxHP = character.Hp;
		TriggeredNodeCount = DictionaryPool<int, int>.Get();
		BreakDiffTypeMonsterShieldCount = DictionaryPool<int, int>.Get();
		KillDiffTypeMonsterOnShieldBrokenCount = DictionaryPool<int, int>.Get();
	}

	public void Release()
	{
		DictionaryPool<int, int>.Release(TriggeredNodeCount);
		DictionaryPool<int, int>.Release(BreakDiffTypeMonsterShieldCount);
		DictionaryPool<int, int>.Release(KillDiffTypeMonsterOnShieldBrokenCount);
	}
}
