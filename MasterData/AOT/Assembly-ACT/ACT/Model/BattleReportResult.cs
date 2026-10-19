using System.Collections.Generic;
using ACT.Game.Data;
using Fundamental;

namespace ACT.Model;

public sealed class BattleReportResult
{
	public Dictionary<int, CharacterBattleReport> CharacterBattleReportDic;

	public float Duration;

	public SceneStatus SceneStatus;

	public int ParkourGoldCount;

	public int ParkourExpCount;

	public int RobotCount;

	public int AssistSkillCount;

	public Dictionary<int, int> KillDiffTypeMonsterByAssistSkillCount;

	public BattleReportResult()
	{
		CharacterBattleReportDic = DictionaryPool<int, CharacterBattleReport>.Get();
		KillDiffTypeMonsterByAssistSkillCount = DictionaryPool<int, int>.Get();
	}

	public BattleReportResult(List<Character> characters)
	{
		CharacterBattleReportDic = DictionaryPool<int, CharacterBattleReport>.Get();
		KillDiffTypeMonsterByAssistSkillCount = DictionaryPool<int, int>.Get();
		foreach (Character character in characters)
		{
			CharacterBattleReportDic.Add(character.Id, new CharacterBattleReport(character));
		}
	}

	public void Release()
	{
		foreach (KeyValuePair<int, CharacterBattleReport> item in CharacterBattleReportDic)
		{
			item.Value.Release();
		}
		DictionaryPool<int, CharacterBattleReport>.Release(CharacterBattleReportDic);
		CharacterBattleReportDic = null;
		DictionaryPool<int, int>.Release(KillDiffTypeMonsterByAssistSkillCount);
		KillDiffTypeMonsterByAssistSkillCount = null;
	}
}
