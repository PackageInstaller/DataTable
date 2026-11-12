using System.Collections;
using TrueSync;

namespace AIScript.Monster._31601JiYiSuiPian_Guang;

public class Die : SkillSimpleBase
{
	private static readonly string fx_Eaten = "fx_StoryActivity_16_base_white_shiqu";

	private static readonly string fx_Explode = "fx_StoryActivity_16_base_white_boom";

	private static readonly string areaEffect_Wave = "Area_White";

	private static readonly FP fxPositionY = 1f;

	private static readonly FP fxDuration = 1f;

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		SetCloseBlockEnable();
		if (GetLogicTagToggleValue(_actor, "JiYiSuiPian_Eaten"))
		{
			PlayEffect(fx_Eaten, 1f, fxPositionY, GetPosition());
		}
		else
		{
			PlayEffect(fx_Explode, 1f, fxPositionY, GetPosition());
			PlayAreaEffect(areaEffect_Wave, GetPosition());
		}
		yield return WaitTime(fxDuration);
	}
}
