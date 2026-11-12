using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_Die : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override IEnumerator DoMainLogic()
	{
		DispatchCustomEvent("CanChaIsDead", isSelfEvent: false);
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction != null && targetsByFaction.Count > 0)
		{
			KillActors(GetTargetsByFaction(isFriend: true));
		}
		targetsByFaction.Clear();
		targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction != null && targetsByFaction.Count > 0)
		{
			ClearActors(targetsByFaction);
		}
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		if (DieWithAirBorne() && !_actor.IsBossMonster())
		{
			_actor.PlayHurtAnim();
			PlayEffect(airBorneDeathEffectAlias, 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, (_actor.killer != null) ? _actor.killer.tsTransform.Rotation : _actor.tsTransform.Rotation);
			yield return WaitTime(1);
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
