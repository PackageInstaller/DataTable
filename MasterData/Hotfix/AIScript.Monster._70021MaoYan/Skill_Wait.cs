#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Wait : SkillSimpleBase
{
	private readonly FP Time = 2;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		NovaLogger.Debug("等待" + Time.ToString() + "秒");
		yield return WaitTime(Time);
		NovaLogger.Debug("等待结束");
	}
}
