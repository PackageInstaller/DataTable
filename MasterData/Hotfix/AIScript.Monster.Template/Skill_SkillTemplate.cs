#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster.Template;

public class Skill_SkillTemplate : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] NullKey = new ComboInputBuffer.ActionKey[1];

	private CoroutineNode testnode;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("技能打断结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		NovaLogger.Debug("技能打断开始");
		yield return WaitTime(3);
	}
}
