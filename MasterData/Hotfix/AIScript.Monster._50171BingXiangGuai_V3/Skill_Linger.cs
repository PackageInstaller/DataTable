using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill_Linger : SkillSimpleBase
{
	private string Move = "Move";

	private string TurnLeft = "TurnLeft";

	private string TurnRight = "TurnRight";

	private FP PointY;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		CancelAim();
		CancelBezierPathMove();
		StopMove();
	}

	protected override IEnumerator DoMainLogic()
	{
		FP fP = AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true);
		if (fP >= 30)
		{
			PointY = 0.5;
			BeginAttack(1, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
			BeginBezierPathMove(1, new TSVector2(0, 0), 0.5, PointY, comboWithAttack: true, default, AdventureActor.MovementMode.Walk, 80, 20);
			AimAtPosition(new TSVector2(0, 0), 30);
			yield return WaitBezierPathMoveFinish();
			CancelAttack();
			CancelAim();
		}
		else if (fP <= -30)
		{
			PointY = -0.5;
			BeginAttack(2, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
			BeginBezierPathMove(1, new TSVector2(0, 0), 0.5, PointY, comboWithAttack: true, default, AdventureActor.MovementMode.Walk, 80, 20);
			AimAtPosition(new TSVector2(0, 0), 30);
			yield return WaitBezierPathMoveFinish();
			CancelAttack();
			CancelAim();
		}
		else
		{
			MoveToPosition(new TSVector2(0, 0), 0.5, AdventureActor.MovementMode.Walk, 10);
			yield return WaitMoveStatus();
		}
	}
}
