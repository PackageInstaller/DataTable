using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_Shui;

public class Skill_Death_LD : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		yield return StartCor(KillTeammate());
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		if (DieWithAirBorne() && !_actor.IsBossMonster())
		{
			_actor.PlayHurtAnim();
			PlayEffect(airBorneDeathEffectAlias, 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, (_actor.killer != null) ? _actor.killer.tsTransform.Rotation : _actor.tsTransform.Rotation);
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

	protected IEnumerator KillTeammate()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		for (int i = 0; i < targetsByFaction.Count; i++)
		{
			KillActors(targetsByFaction);
		}
		yield return null;
	}
}
