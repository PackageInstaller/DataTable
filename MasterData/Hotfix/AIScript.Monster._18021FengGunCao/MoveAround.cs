using System.Collections;
using TrueSync;

namespace AIScript.Monster._18021FengGunCao;

public class MoveAround : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		CoroutineNode checkdie = StartCoroutine(CheckDie());
		MoveToPosition(GetPlaceHolderPosition("FengGunCao_1"), 0.5, AdventureActor.MovementMode.Walk);
		PlayEffect("Actor/Monster/18021FengGunCao/FX/fx_m18021_loop_walk", 1f, default, default, default, 1f, actorScale: true);
		yield return WaitMoveStatus();
		yield return WaitTime(1);
		MoveToPosition(GetPlaceHolderPosition("FengGunCao_2"), 0.5, AdventureActor.MovementMode.Walk);
		yield return WaitMoveStatus();
		yield return WaitTime(0.3f);
		StopCoroutine(checkdie);
		_actor.DestroySelf();
	}

	private IEnumerator CheckDie()
	{
		FP t = 10000;
		FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		while (t > 0 && distanceWithTarget >= 2)
		{
			yield return WaitTime(0.1f);
			t -= (FP)0.1;
			distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		}
		TriggerOpLisener("Bubble6");
		_actor.DestroySelf();
	}
}
