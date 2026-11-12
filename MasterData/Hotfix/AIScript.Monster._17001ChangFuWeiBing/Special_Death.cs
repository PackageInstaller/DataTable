using System.Collections;
using TrueSync;

namespace AIScript.Monster._17001ChangFuWeiBing;

public class Special_Death : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override void OnSkillEnable()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		if (DieWithAirBorne() && !_actor.IsBossMonster())
		{
			_actor.PlayHurtAnim();
			PlayEffect(airBorneDeathEffectAlias, 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, (_actor.killer != null) ? _actor.killer.tsTransform.Rotation : _actor.tsTransform.Rotation);
			yield return WaitTime(1);
		}
		else if (GetTargetsByFaction(isFriend: true).Count <= 1)
		{
			_actor.PlayIdleAnim();
			PlayEffect("Actor/Monster/50801QiEBaoXiang/FX/fx_m50801_loop_QiEBaoXiang_Run");
			TriggerOpLisener("Bubble");
			TSVector2 position = GetPosition();
			TSVector2 placeHolderPosition = GetPlaceHolderPosition("RunAwayPoint_1");
			TSVector2 placeHolderPosition2 = GetPlaceHolderPosition("RunAwayPoint_2");
			TSVector2 position2 = ((Distance(position, placeHolderPosition) >= Distance(position, placeHolderPosition2)) ? placeHolderPosition2 : placeHolderPosition);
			MoveToPosition(position2, 0, AdventureActor.MovementMode.Run, 6);
			yield return WaitMoveStatus();
			yield return WaitTime(0.3f);
			_actor.ClearMonsterSelf();
		}
		else
		{
			_actor.PlayDeathAnim();
			BeginAttack(1, actionKeys);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private bool DieWithAirBorne()
	{
		if (_actor.movementState == ActorState.Jump)
		{
			return true;
		}
		if (_actor.killerHitBox == null)
		{
			return false;
		}
		if ((_actor.killerHitBox.featureFlags & HitBox.FeatureFlag.KnockBack) == HitBox.FeatureFlag.KnockBack)
		{
			return true;
		}
		return (_actor.killerHitBox.featureFlags & HitBox.FeatureFlag.AirBorne) == HitBox.FeatureFlag.AirBorne;
	}
}
