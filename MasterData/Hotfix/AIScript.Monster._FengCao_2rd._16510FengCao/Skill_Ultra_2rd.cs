using System.Collections;
using AIScript.Monster._16510FengCao;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_Ultra_2rd : SkillSimpleBase
{
	private readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

	private readonly int startKeyIndex2 = 2;

	private readonly ComboInputBuffer.ActionKey[] startKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	private readonly int startKeyIndex3 = 3;

	private readonly ComboInputBuffer.ActionKey[] startKey3 = new ComboInputBuffer.ActionKey[1];

	private readonly string StopLookAT_Event = "StopLookAt";

	private readonly string AreaEffectAlias01 = "Weapon_16510FengCao_Huan_Kuo";

	private readonly string AreaEffectAlias02 = "Weapon_16510FengCao_Huan_Suo";

	private readonly string Start_AreaEffect_Event = "Start_AreaEffect";

	private readonly string StopNext_Event = "StopNext";

	private readonly string BulletName = "Weapon_16510FengCao_Cyclones_DaZhao";

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
		Parallel.inUltra = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Parallel.inUltra = false;
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
			CancelAttack();
			yield return WaitCustomEvent(StopNext_Event);
			RemoveBuffFromTarget(_actor, 505210310);
			RemoveBuffFromTarget(_actor, 990010030);
			BeginAttack(startKeyIndex2, startKey2);
			yield return WaitCustomEvent(Start_AreaEffect_Event);
			PlayAreaEffect(AreaEffectAlias01, new TSVector2(0, 0));
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(3.5);
			PlayAreaEffect(AreaEffectAlias01, new TSVector2(0, 0));
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitTime(4);
			CancelAttack();
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, new TSVector2(0, 0), 0, default, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			currentSummonCount = summonCount;
			for (int i = 0; i < summonCount; i++)
			{
				TSVector2 tSVector = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
				TSVector2 normalized = (tSVector - GetEntityPosition(GetCurrentPlayer())).normalized;
				SummonTeammate(1, tSVector, normalized, 2);
			}
		}
		else
		{
			BeginAttack(startKeyIndex2, startKey2);
			yield return WaitCustomEvent(Start_AreaEffect_Event);
			PlayAreaEffect(AreaEffectAlias01, new TSVector2(0, 0));
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(3.5);
			PlayAreaEffect(AreaEffectAlias01, new TSVector2(0, 0));
			PlayAreaEffect(AreaEffectAlias02, new TSVector2(0, 0));
			yield return WaitTime(4);
			CancelAttack();
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, new TSVector2(0, 0), 0, default, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			currentSummonCount = summonCount;
			for (int j = 0; j < summonCount; j++)
			{
				TSVector2 tSVector2 = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
				TSVector2 normalized2 = (tSVector2 - GetEntityPosition(GetCurrentPlayer())).normalized;
				SummonTeammate(1, tSVector2, normalized2);
			}
		}
	}
}
