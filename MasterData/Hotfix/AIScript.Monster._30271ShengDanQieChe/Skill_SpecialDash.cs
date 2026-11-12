using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill_SpecialDash : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Run = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Gift = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private long Emoji;

	private long BoxFx;

	private long WarningFx;

	private List<LogicEntity> Friends = new List<LogicEntity>();

	private List<LogicEntity> LiWuJi1 = new List<LogicEntity>();

	private int Max;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(Emoji);
		StopEffect(WarningFx);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Gift, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Throw");
		BoxFx = PlayEffect("fx_m30271_loop_ThrowBoxLv2");
		Shoot01();
		yield return WaitTime(2);
		PlayEffect("fx_m30271_base_ThrowBoxLv2_end");
		StopEffect(BoxFx);
		yield return WaitTime(0.5);
		for (int i = 0; i < 3; i++)
		{
			BeginAttack(2, Run, flushInputedKeys: true, forceInterruptAttack: true);
			WarningFx = PlayEarlyWarningEffect("fx_common_base_Dash_YuJing_20_start", 2f);
			Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Idle");
			BeginLookAt_NotWait(GetCurrentPlayer(), 1, 90);
			yield return WaitTime(1);
			StopEffect(Emoji);
			TSVector2 dashpos = GetEntityPosition(GetCurrentPlayer()) - GetPosition();
			yield return WaitTime(1);
			Dash01(dashpos);
			Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_RunFast");
			yield return WaitDashFinish();
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 360);
			StopEffect(Emoji);
			yield return WaitTime(0.5);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash01(TSVector2 dashpos)
	{
		BeginDash(1, dashpos, 15, 99, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}

	private void Shoot01()
	{
		LiWuJi1 = GetTargetByDataID(3040016);
		TSVector2 position = GetPosition();
		FP radius = 15;
		FP innerRadius = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		Friends = GetTargetsFromShape(shapeData, GetTargetsByFaction(isFriend: true));
		if (LiWuJi1.Count >= 1)
		{
			for (int i = 0; i < LiWuJi1.Count; i++)
			{
				if (Friends.Contains(LiWuJi1.get_Item(i)))
				{
					Friends.Remove(LiWuJi1.get_Item(i));
				}
			}
		}
		if (Friends.Count >= 1)
		{
			if (Friends.Count >= 3)
			{
				Max = 3;
			}
			else
			{
				Max = 1;
			}
			for (int j = 0; j < Max; j++)
			{
				CircleMultipleShoot("Bullet_30271_MonsterGift", AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: true, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 2, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, GetEntityPosition(Friends.get_Item(j)));
			}
		}
	}
}
