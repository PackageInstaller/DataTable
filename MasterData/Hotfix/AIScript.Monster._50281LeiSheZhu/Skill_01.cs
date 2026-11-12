using System.Collections;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private LogicEntity AttackTarget;

	private TSVector2 OneselfPosition;

	private TSVector2 targetPosition;

	private static readonly string BulletFxPath = "bulletFX";

	private static readonly string Attack_01 = "Attack_01";

	private static readonly string Attack_02 = "Attack_02";

	private static readonly string Attack_03 = "Attack_03";

	private static readonly string Attack_04 = "Attack_04";

	private static readonly string AreaEffectAlias = "50281LeiSheZhu_Skill_01_Boom";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 5.5, 1800);
		yield return WaitCustomEvent(Attack_01);
		yield return StartCor(Attack());
		yield return WaitCustomEvent(Attack_02);
		yield return StartCor(Attack());
		yield return WaitCustomEvent(Attack_03);
		yield return StartCor(Attack());
		yield return WaitCustomEvent(Attack_04);
		yield return StartCor(Attack());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator Attack()
	{
		targetPosition = GetEntityPositionObsoleted(AttackTarget);
		OneselfPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0));
		PlayAreaEffect(AreaEffectAlias, GetEntityPositionObsoleted(AttackTarget));
		yield return WaitTime(0.4);
		PlayLinkEffect(BulletFxPath, useCustomSource: true, null, OneselfPosition, 3, null, targetPosition, 0);
	}
}
