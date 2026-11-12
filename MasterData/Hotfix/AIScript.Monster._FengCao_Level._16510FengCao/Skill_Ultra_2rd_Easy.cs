using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_Level._16510FengCao;

public class Skill_Ultra_2rd_Easy : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

	private static readonly int startKeyIndex2 = 2;

	private static readonly ComboInputBuffer.ActionKey[] startKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	private static readonly int startKeyIndex3 = 3;

	private static readonly ComboInputBuffer.ActionKey[] startKey3 = new ComboInputBuffer.ActionKey[1];

	private static readonly string StopLookAT_Event = "StopLookAt";

	private static readonly string AreaEffectAlias01 = "Weapon_16510FengCao_Huan_Kuo";

	private static readonly string AreaEffectAlias02 = "Weapon_16510FengCao_Huan_Suo";

	private static readonly string Start_AreaEffect_Event = "Start_AreaEffect";

	private static readonly string StopNext_Event = "StopNext";

	private FP TargetDis;

	private TSVector2 SelfPos;

	private LogicEntity AttackTarget;

	private readonly int summonCount = 2;

	private int currentSummonCount;

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private readonly FP summonRadius = 8f;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		SelfPos = GetPosition();
		TargetDis = Distance(GetPosition(), new TSVector2(0, 0));
	}

	protected override IEnumerator DoMainLogic()
	{
		if (TargetDis > 2)
		{
			AddBuffToTarget(_actor, 505210310);
			AddBuffToTarget(_actor, 990010030);
			BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Fire"));
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Water"));
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Wind"));
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Light"));
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Dark"));
			RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Earth"));
			BeginLookAtByPos(new TSVector2(0, 0), 0.2, 2000, 0);
			yield return WaitTime(1);
			Teleport(new TSVector2(0, 0));
			BeginLookAt_NotWait(AttackTarget, 1, 540);
			yield return WaitDashFinish();
			CancelAttack();
			yield return WaitCustomEvent(StopNext_Event);
			RemoveBuffFromTarget(_actor, 505210310);
			RemoveBuffFromTarget(_actor, 990010030);
			BeginAttack(startKeyIndex2, startKey2);
			BeginLookAt_NotWait(AttackTarget, 7.5, 120);
			yield return WaitCustomEvent(Start_AreaEffect_Event);
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(3.5);
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitTime(4);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			currentSummonCount = summonCount;
			for (int i = 0; i < summonCount; i++)
			{
				TSVector2 tSVector = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
				TSVector2 normalized = (tSVector - GetEntityPositionObsoleted(GetCurrentPlayer())).normalized;
				SummonTeammate(1, tSVector, normalized, 2);
			}
		}
		else
		{
			BeginAttack(startKeyIndex2, startKey2);
			BeginLookAt_NotWait(AttackTarget, 7.5, 120);
			yield return WaitCustomEvent(Start_AreaEffect_Event);
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(3.5);
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitTime(4);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			currentSummonCount = summonCount;
			for (int j = 0; j < summonCount; j++)
			{
				TSVector2 tSVector2 = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
				TSVector2 normalized2 = (tSVector2 - GetEntityPositionObsoleted(GetCurrentPlayer())).normalized;
				SummonTeammate(1, tSVector2, normalized2, 2);
			}
		}
	}
}
