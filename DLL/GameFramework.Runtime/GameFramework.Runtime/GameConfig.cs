using System.Collections.Generic;

namespace GameFramework.Runtime;

public class GameConfig
{
	public int BattleTime { get; set; }

	public int weaknessMaxLevel { get; set; }

	public int keennessMaxInfluence { get; set; }

	public float oneKeennessInfluence { get; set; }

	public float oneWeaknessDataTimer { get; set; }

	public float oneLevelOverDraft { get; set; }

	public float twoLevelOverDraft { get; set; }

	public float oneLevelOverDraftInfluence { get; set; }

	public float twoLevelOverDraftInfluence { get; set; }

	public float ratioOverDraft { get; set; }

	public float clickDeviation { get; set; }

	public float dragSkillJudge { get; set; }

	public int chat_RepeatedMsgInterval { get; set; }

	public List<int[]> chat_MsgInterval { get; set; }

	public int chat_MsgMaxCount { get; set; }

	public float minimap_UISceneRatio { get; set; }

	public int TeamRebornValue { get; set; }

	public int PropCopyWeekly { get; set; }

	public float HpBarShowDura { get; set; }

	public float KillLowMonsterEnergy { get; set; }

	public float MonsterKnockDownEnergy { get; set; }

	public int IgnoreDamage { get; set; }

	public float WeaknessEffectCooling { get; set; }
}
