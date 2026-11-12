#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_Jump_3 : SkillSimpleBase
{
	protected readonly TSVector2 LookAtJumpTarget = new TSVector2(0, 0);

	protected readonly FP rotateSpeed = 480;

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_K = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.R };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected FP dis;

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
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = actionKey_Dark;
		}
		else
		{
			_actionKey = actionKey_Water;
		}
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		SetCloseBlockEnable();
		FP fP = _actor.DistanceWithRadius(target);
		if (fP <= 6f)
		{
			dis = fP + 8f;
		}
		else
		{
			dis = fP + 1f;
		}
		NovaLogger.Debug($"距离值: {dis}");
		FP dash_spd = dis / 0.8;
		doDash(dis, dash_spd);
		yield return WaitTime(1.1);
		CancelAttack();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5f);
	}

	private void doDash(FP dis, FP dash_spd)
	{
		BeginDashActorForward(1, dash_spd, dis, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
