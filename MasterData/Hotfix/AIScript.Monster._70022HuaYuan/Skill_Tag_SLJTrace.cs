#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_Tag_SLJTrace : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagToggleValue(_actor, "SkillTag_SLJTrace", value: true);
		yield return null;
		NovaLogger.Debug("打开后跳回拉标签");
	}
}
