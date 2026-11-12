using System.Collections;
using TrueSync;

namespace AIScript.Monster._30282ShengDanLiWuJi;

public class Skill_Area : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagToggleValue(_actor, "ShengDanTaLouSkill03_Area"))
		{
			PlayAreaEffect("Area_30282_SafeArea_01", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), GetRotation());
			SetLogicTagToggleValue(_actor, "ShengDanTaLouSkill03_Area", value: false);
		}
		if (GetLogicTagToggleValue(_actor, "ShengDanTaLouSkill09_Area"))
		{
			PlayAreaEffect("Area_30282_SafeArea_02", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), GetRotation());
			SetLogicTagToggleValue(_actor, "ShengDanTaLouSkill09_Area", value: false);
		}
		if (GetLogicTagToggleValue(_actor, "ShengDanQiEChe_Area"))
		{
			PlayAreaEffect("Area_30282_SafeArea_03", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), GetRotation());
			SetLogicTagToggleValue(_actor, "ShengDanQiEChe_Area", value: false);
		}
		yield return WaitTime(0.5);
	}
}
