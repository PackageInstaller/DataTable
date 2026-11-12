#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_Tag_FMTrace : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagToggleValue(_actor, "SkillTag_FMTrace", value: true);
		yield return null;
		NovaLogger.Debug("打开追踪风魔标签");
	}
}
