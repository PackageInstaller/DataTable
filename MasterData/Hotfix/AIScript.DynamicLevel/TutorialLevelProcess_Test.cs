#define LOG_DEBUG
using System.Collections;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_Test : TutorialLevelProcessBase
{
	public override void OnLevelStart()
	{
		base.OnLevelStart();
		StartLogicCoroutine(Logic());
	}

	private IEnumerator Logic()
	{
		yield return StartLogicCoroutine(WaitTime(10));
		ActiveMonsterSpawnWave("Wave_1");
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		NovaLogger.Debug($"测试教学关任务完成,任务Id:{taskId},是否为最后一个任务:{isLastTask}");
	}

	public override void OnLevelEnd()
	{
		base.OnLevelEnd();
	}
}
