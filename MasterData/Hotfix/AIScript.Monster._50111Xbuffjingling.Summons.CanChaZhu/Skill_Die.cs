using System.Collections;
using TrueSync;

namespace AIScript.Monster._50111Xbuffjingling.Summons.CanChaZhu;

public class Skill_Die : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override IEnumerator DoMainLogic()
	{
		RemoveShield();
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

	private void RemoveShield()
	{
		if (GetTargetByTeammateIndex(0) != null && GetTargetByTeammateIndex(0).Count > 0)
		{
			LogicEntity target = GetTargetByTeammateIndex(0).get_Item(0);
			RemoveShieldById(target, 501110000);
		}
	}
}
