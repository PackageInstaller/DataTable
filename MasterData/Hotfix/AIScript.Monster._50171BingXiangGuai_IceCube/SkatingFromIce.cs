using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_IceCube;

public class SkatingFromIce : SkillSimpleBase
{
	private static readonly FP DashSpeed = 15;

	private static readonly FP DashDistance = 20;

	private TSVector2 DashDirection;

	private long IceHitArea;

	protected override void OnSkillEnable()
	{
		DashDirection = GetPosition() - GetEntityPosition(GetTargetByTeammateIndex(1).get_Item(0));
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect(IceHitArea);
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayWwiseSound("mon_50171_ice_mov");
		Dash();
		IceHitArea = PlayAreaEffect("Area_IceBuffFromCube_IceDash", GetPosition(), GetTSVectToAngle(DashDirection, 0));
		yield return WaitDashFinish();
		yield return WaitFrame(1);
	}

	private void Dash()
	{
		BeginDash(1, DashDirection, DashSpeed, DashDistance, 0, comboWithAttack: false, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: true, 0.1);
	}
}
