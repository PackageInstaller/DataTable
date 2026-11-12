using System.Collections;
using AIScript.Monster.Trap;
using TrueSync;

namespace AIScript.Monster._99071CircleTrap;

public class Skill_NormalAttack : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private readonly string FXAlias = "Actor/Monster/99071CircleAreaTrap/FX/CircleTrap_frost_nova";

	private TSVector2 FXPosition;

	private FP FXRotation;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		if (_actor == null)
		{
			FXPosition = TSVector2.zero;
		}
		else
		{
			FXPosition = GetEntityPositionObsoleted(_actor);
		}
		if (_actor == null)
		{
			FXRotation = 0;
		}
		else
		{
			FXRotation = GetEntityAngle(_actor);
		}
		yield return WaitTime(14);
		CancelAttack();
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
