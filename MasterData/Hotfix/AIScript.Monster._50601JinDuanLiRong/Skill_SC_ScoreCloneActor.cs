#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_SC_ScoreCloneActor : SkillSimpleBase
{
	private bool corState;

	private CoroutineNode ScoreCheckCor;

	private LogicEntity master;

	private List<LogicEntity> mateList = new List<LogicEntity>();

	private readonly string in_CheckBossScro_Tag1 = "In_CheckBossScro_Tag1";

	protected override void OnSkillEnable()
	{
		corState = false;
		master = GetMonsterCloner();
	}

	protected override void OnSkillDisable()
	{
		if (corState)
		{
			StopCor(ScoreCheckCor);
		}
		mateList.Clear();
		SetLogicTagToggleValue(master, in_CheckBossScro_Tag1, value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.3);
		FP mateCount = GetLogicTagFpValue(master, "SummonsCount");
		for (int i = 0; i < 10; i++)
		{
			if (GetTargetsByFaction(isFriend: true) != null && GetTargetsByFaction(isFriend: true).Count >= mateCount + 1)
			{
				foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
				{
					if (GetLogicTagToggleValue(item, "Summons"))
					{
						mateList.Add(item);
					}
				}
				break;
			}
			yield return WaitTime(0.2);
		}
		corState = true;
		ScoreCheckCor = StartCor(ScoreLogicTag());
		while (true)
		{
			if (mateList.get_Item(0).IsDead() || master.IsDead())
			{
				InterruptSkill();
			}
			yield return WaitTime(0.2);
		}
	}

	private IEnumerator ScoreLogicTag()
	{
		for (int i = 0; i < 1; i++)
		{
			SetLogicTagToggleValue(master, in_CheckBossScro_Tag1, value: true);
			yield return WaitTime(2.1);
			SetLogicTagToggleValue(master, in_CheckBossScro_Tag1, value: false);
			yield return WaitTime(1);
		}
		corState = false;
		NovaLogger.Debug("禁断丽容分身.得分协程结束");
	}
}
