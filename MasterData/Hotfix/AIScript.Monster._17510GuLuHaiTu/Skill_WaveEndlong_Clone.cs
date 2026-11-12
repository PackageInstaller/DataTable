#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_WaveEndlong_Clone : SkillScript_Base
{
	private List<LogicEntity> mateList = new List<LogicEntity>();

	private CoroutineNode WaveCor;

	private List<long> warningFxList = new List<long>();

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔分身.潮汐.开始");
	}

	protected override void OnSkillDisable()
	{
		if (warningFxList != null && warningFxList.Count > 0)
		{
			for (int i = 0; i < warningFxList.Count; i++)
			{
				StopEffect(warningFxList.get_Item(i));
			}
			warningFxList.Clear();
		}
		if (mateList != null && mateList.Count > 0)
		{
			mateList.Clear();
		}
		StopCor(WaveCor);
		NovaLogger.Debug("咕噜海兔分身.潮汐.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(EndCondition());
		TSVector2 beginPOS = new TSVector2(-8, 8);
		yield return StartCor(WaveAttack(beginPOS, TSVector2.right));
	}

	protected IEnumerator EndCondition()
	{
		for (int i = 0; i < 20; i++)
		{
			mateList = GetTargetsByFaction(isFriend: true);
			if (mateList != null && mateList.Count == 0)
			{
				break;
			}
			yield return WaitTime(0.5);
		}
		InterruptSkill();
	}
}
