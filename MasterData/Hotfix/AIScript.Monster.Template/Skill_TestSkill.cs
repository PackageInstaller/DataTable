using System.Collections;
using TrueSync;

namespace AIScript.Monster.Template;

public class Skill_TestSkill : SkillSimpleBase
{
	private static readonly TSVector2 LookAtPosition = new TSVector2(0, 0);

	private static readonly FP RotateSpeed = 50;

	private static readonly FP StopAngle = 5;

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos_NotWait(LookAtPosition, 999, RotateSpeed, StopAngle);
		yield return WaitTime(999);
	}
}
