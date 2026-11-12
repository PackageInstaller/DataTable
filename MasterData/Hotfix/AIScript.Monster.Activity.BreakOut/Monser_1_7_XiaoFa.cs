using System.Collections;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_1_7_XiaoFa : SkillSimpleBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private TSVector2 targetPosition1;

	private TSVector2 targetPosition2;

	private string tag1 = "Monster1";

	private string tag2 = "Monster2";

	private string tag3 = "Monster3";

	private int time = 10000;

	protected override IEnumerator DoMainLogic()
	{
		while (time > 0)
		{
			BeginLookAtCameraDir(DirectionType.Down, default, 400);
			BeginRotateAngle(GetRandomValue(-40, 40), 80);
			yield return WaitTime(1);
			BeginAttack(1, startKey);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(10);
			time--;
		}
		yield return WaitTime(99999);
	}
}
