using System.Collections;
using AIScript.Monster.Trap;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Skill_BlackHole : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private readonly string FXAlias = "Actor/Monster/99051FlameTrap/FX/fx_99051FlameTrap_Attack_start_Prologue";

	private TSVector2 FXPosition;

	private FP FXRotation;

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1f);
		string fxAlias = "Misc/BreakOut/Gear/Gear_BlackHole_1";
		Singleton<BrickBreakerManager>.Instance.GetGearToScence(fxAlias, _actor.tsTransform.Position);
		yield return WaitTime(99999);
	}
}
