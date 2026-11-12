using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_Jump_1 : SkillSimpleBase
{
	protected readonly TSVector2 LookAtJumpTarget = new TSVector2(0, 0);

	protected readonly FP rotateSpeed = 480;

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_K = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = actionKey_Dark;
		}
		else
		{
			_actionKey = actionKey_Water;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 240);
		yield return WaitTime(0.2);
		BeginAttack(1, actionKeys_K, flushInputedKeys: true);
		FP fP = _actor.DistanceWithRadius(target) + 1f;
		FP dash_spd = fP / 0.8;
		doDash(fP, dash_spd);
		yield return WaitTime(1.1);
		CancelAttack();
		yield return WaitTime(1.2);
	}

	private void doDash(FP dis, FP dash_spd)
	{
		BeginDashActorForward(1, dash_spd, dis, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
