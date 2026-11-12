using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17031ZhongNuJingYingQiShi;

public class Skill2_SupportArrow : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly string NormalBullet = "Bullet_SupportArrow_Normal";

	private static readonly string ExBullet = "Bullet_SupportArrow_Ex";

	private static readonly string Startfx_Ex = "fx_17031_base_xuli_4";

	private static readonly string Startfx = "fx_17031_base_xuli_4";

	private static readonly string shootevent = "Shoot";

	private string fx_choose;

	private string bullet_choose;

	private bool breakOff;

	private long fx_start;

	private readonly int checkbuff = 170210010;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		if (breakOff)
		{
			StopEffect(fx_start);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(_actor, checkbuff) != 0)
		{
			bullet_choose = ExBullet;
			fx_choose = Startfx_Ex;
		}
		else
		{
			bullet_choose = NormalBullet;
			fx_choose = Startfx;
		}
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction == null || targetsByFaction.Count == 0)
		{
			targetsByFaction.Add(_actor);
		}
		LogicEntity targetHp = GetTargetHp(hpMin: true, targetsByFaction, isAbs: false);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		TSVector2 Startpos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0));
		Skill2_SupportArrow skill2_SupportArrow = this;
		TSVector2 entityPosition = GetEntityPosition(targetHp);
		FP radius = 5;
		FP innerRadius = 2.5f;
		FP angle = 360;
		FP rotation = 0;
		DeterministicShape shapeData = skill2_SupportArrow.GetShapeData(DeterministicShape.ShapeType.Fan, entityPosition, default, default, radius, innerRadius, angle, rotation);
		TSVector2 shootpos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		BeginLookAtByPos_NotWait(shootpos, 0.3, 400);
		yield return WaitCustomEvent("fxevent");
		fx_start = PlayEffect(fx_choose, 1f, 1, default, default, 1f, actorScale: true);
		yield return WaitCustomEvent(shootevent);
		StopEffect(fx_start);
		FanMultipleShoot(bullet_choose, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, Startpos, 3, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, 2, 0, shootpos);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
