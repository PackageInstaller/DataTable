using System.Collections;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_09 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1701336156,
		(ComboInputBuffer.ActionKey)1281320301,
		(ComboInputBuffer.ActionKey)1952999273
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1768846440,
		(ComboInputBuffer.ActionKey)1866622830,
		(ComboInputBuffer.ActionKey)1663988844
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey3 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)2020173428,
		(ComboInputBuffer.ActionKey)1769100380,
		(ComboInputBuffer.ActionKey)1919248231
	};

	private LogicEntity AttackTarget;

	private TSVector2 targetPosition;

	private static readonly string StartAttack = "StartAttack";

	private static readonly string StopAttack = "StopAttack";

	private static readonly string StartDash = "Dash";

	private static readonly string StartUP = "UP";

	private static readonly string Down = "Down";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 6, 1800);
		yield return WaitCustomEvent(StartUP);
		AddBuffToTarget(_actor, 505210310);
		AddBuffToTarget(_actor, 990010030);
		SetLockToughnessEnable();
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Fire"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Water"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Wind"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Light"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Dark"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Earth"));
		yield return WaitCustomEvent(StartDash);
		targetPosition = GetEntityPositionObsoleted(AttackTarget);
		Teleport(targetPosition);
		yield return WaitCustomEvent(Down);
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
		yield return WaitCustomEvent(StartAttack);
		StopLookAt();
		BeginAttack(2, _actionKey2, flushInputedKeys: true);
		yield return WaitCustomEvent(StopAttack);
		BeginAttack(3, _actionKey3, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
