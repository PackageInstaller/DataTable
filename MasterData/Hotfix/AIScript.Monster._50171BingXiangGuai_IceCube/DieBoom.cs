using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_IceCube;

public class DieBoom : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		PlayAreaEffect("Area_IceCube_Boom", GetPosition());
		PlayAreaEffect("Area_IceCube_Warning", GetPosition(), GetTSVectToAngle(GetForward(), 0));
		SetHideModelEnable();
		yield return WaitTime(2);
	}
}
