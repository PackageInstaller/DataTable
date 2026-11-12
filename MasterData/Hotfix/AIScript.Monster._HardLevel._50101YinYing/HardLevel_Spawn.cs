#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetInvincibleEnable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		SetHideOutEnable();
		yield return null;
	}

	protected void BuffAdd01()
	{
		if (GetTargetByDataID(5001511) != null)
		{
			NovaLogger.Debug("触发11");
		}
		else
		{
			AddBuffToTarget(_actor, 501010001);
		}
	}

	protected void BuffAdd02()
	{
		if (GetTargetByTeammateIndex(2) != null)
		{
			NovaLogger.Debug("触发22");
		}
		else
		{
			AddBuffToTarget(_actor, 501010002);
		}
	}
}
