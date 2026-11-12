using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Die : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	protected override IEnumerator DoMainLogic()
	{
		KillFriendlyForces();
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

	private void KillFriendlyForces()
	{
		List<LogicEntity> list = new List<LogicEntity>();
		list = GetTargetsByFaction(isFriend: true);
		if (list != null && list.Count > 0)
		{
			KillActors(list);
		}
	}
}
