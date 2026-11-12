using AdventureBehaviour;
using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/主控角色释放指定槽位技能", 1)]
public class Task_PlayerCastSkill : TaskCellBase
{
	public enum SkillType
	{
		[InspectorName("技能")]
		skill,
		[InspectorName("大招")]
		ultimate
	}

	public SkillType skillType;

	protected override void OnExecute()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor == null)
		{
			EndAction();
			return;
		}
		if (skillType == SkillType.skill)
		{
			ILRuntimeAPI.CreateSkill(activedPlayerActor.playerAIInfo.SkillId, activedPlayerActor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: false, isBreakable: true, SkillCountdownTiming.Start, null, null, ingoreCDAndEnergy: true);
		}
		else
		{
			ILRuntimeAPI.CreateSkill(activedPlayerActor.playerAIInfo.UltimateId, activedPlayerActor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, null, null, ingoreCDAndEnergy: true);
		}
		EndAction();
	}
}
