#define LOG_DEBUG
using System.Collections;

namespace AIScript.DynamicLevel;

public class SkinTrialLevelProcess_155_Main : TrialLevelProcessBase
{
	private string waveName_taskA = "Monster_Wave_1";

	private string waveName_taskB = "Monster_Wave_2";

	private string waveName_taskD = "Monster_Wave_0";

	private readonly int interactiveId_Wall = 2011;

	private readonly string teleportName = "LevelExit_Gizmo";

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		StartLogicCoroutine(Logic());
	}

	private IEnumerator Logic()
	{
		yield return null;
		ActiveMonsterSpawnWave(waveName_taskA);
		RefreshAllskillandFullEngergy();
	}

	private void RefreshAllskillandFullEngergy()
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.dataID == actorId)
			{
				PlayerSkillCd playerSkillCd = playerAdventureActor.playerSkillCd;
				playerSkillCd.ResetAllSkillCD();
				int totalEnergy = playerSkillCd.GetTotalEnergy();
				playerSkillCd.AddEnergy(totalEnergy);
			}
		}
	}

	protected override void OnRoomWaveMonsterCleared(AdventureLevelRoomWaveMonsterClearedEvent ievent)
	{
		base.OnRoomWaveMonsterCleared(ievent);
		string wave = ievent.wave;
		if (string.Equals(wave, waveName_taskA) && taskProcess <= 2)
		{
			ActiveMonsterSpawnWave(waveName_taskA);
		}
		if (string.Equals(wave, waveName_taskB) && taskProcess <= 3)
		{
			ActiveMonsterSpawnWave(waveName_taskB);
		}
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		if (taskProcess == 2)
		{
			RefreshAllskillandFullEngergy();
			DropItemEnegy();
		}
		if (taskProcess == 3)
		{
			RefreshAllskillandFullEngergy();
			KillMonsterSpawnWave(waveName_taskA);
			ActiveMonsterSpawnWave(waveName_taskB);
		}
		if (taskProcess == 4)
		{
			SendTaskProcessToServer();
			ActiveMonsterSpawnWave(waveName_taskD);
			InteractiveManager instance = Singleton<InteractiveManager>.Instance;
			if (instance != null)
			{
				int num = interactiveId_Wall;
				instance.setInteractiveObjActiveState(num.ToString(), InteractiveManager.processState.state1, null);
			}
			OpenTeleporters(teleportName);
		}
	}

	public override void OnTaskTargetSuccess(int taskId, int taskTargetId, bool isLasTaskTarget = false)
	{
		base.OnTaskTargetSuccess(taskId, taskTargetId, isLasTaskTarget);
		NovaLogger.Debug($"试玩关目标完成,目标Id:{taskTargetId},是否为最后一个目标:{isLasTaskTarget}");
	}

	public override void OnLevelEnd()
	{
		base.OnLevelEnd();
	}
}
