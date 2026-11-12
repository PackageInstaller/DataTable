using System.Collections;
using TrueSync;

namespace AIScript.Monster._Hot._70031Huochui;

public class Skill_ChaoJiuWuShenZhan_Hot : SkillSimpleBase
{
	private LogicEntity AttackTarget;

	private readonly TSVector2 centerPosition1 = new TSVector2(0, 0);

	private readonly TSVector2 targetPos = new TSVector2(0, -10);

	private readonly TSVector2 TeleportPos = new TSVector2(0, 14);

	private static readonly string CameraUp_Event = "CameraUp";

	private static readonly string CameraDown_Event = "CameraDown";

	private static readonly string AreaEffectAlias1 = "fx_common_base_Dark_YuJing_circular_5";

	private static readonly string AreaEffectAlias2 = "fx_warning_ring_10_5";

	private static readonly string AreaEffectAlias3 = "fx_warning_fan_180c_7r";

	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.U,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string TeleportStart_Event = "TeleportStart";

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Q,
		ComboInputBuffer.ActionKey._1
	};

	private readonly string Effect1 = "fx_70031HuoChui_base_Skill_04_Hot_End_root_01";

	private readonly string Effect2 = "fx_70031HuoChui_base_Skill_04_Hot_End_root_02";

	private readonly string Effect3 = "fx_70031HuoChui_base_Skill_04_Hot_End_root_03";

	private readonly string Effect4 = "fx_70031HuoChui_base_Skill_04_Hot_End_root_04";

	private readonly string Effect5 = "fx_70031HuoChui_base_Skill_04_Hot_End_root_05";

	private readonly string Effect6 = "fx_70031HuoChui_base_Skill_04_Hot_Start_root_pentagram";

	private static readonly string PlayEffect1_Event = "PlayEffect1";

	private static readonly string PlayEffect2_Event = "PlayEffect2";

	private static readonly string PlayEffect3_Event = "PlayEffect3";

	private static readonly string PlayEffect4_Event = "PlayEffect4";

	private static readonly string PlayEffect5_Event = "PlayEffect5";

	private static readonly string StopLoop_Event = "StopLoop";

	private static readonly string HotBulletXuLi = "fx_70031HuoChui_loop_Skill_04_Hot_End_shadow";

	private static readonly string HotBullet = "Hot_Skill_04_ChaoJiuWuShenZhan_Bullet";

	private readonly ComboInputBuffer.ActionKey[] _actionKey3 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Q,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string StartLookAt_Event = "StartLookAt";

	private static readonly string Bigweapon_Event = "Bigweapon";

	private readonly string Effect7 = "fx_70031HuoChui_base_Skill_04_Hot_Urtla01_Loop_weapon_hint";

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
		BeginAttack(1, _actionKey1);
		AddBuffToTarget(_actor, 990020140);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(TeleportStart_Event);
		SetHideModelEnable();
		SetUnparalleledEnable();
		BeginLookAtByPos(targetPos, 0.5, 360);
		yield return WaitCustomEvent(StopAttack_Event);
		Teleport(centerPosition1);
		CancelAttack();
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitFrame(10);
		BeginAttack(2, _actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
		StopLookAt();
		yield return WaitCustomEvent(CameraUp_Event);
		SwitchCameraSetting(active: true, "Camera_WuShenZhan");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(Effect6, 1f, 0, centerPosition1, GetTSVectToAngle(GetForward(), 0));
		yield return WaitCustomEvent(StopLoop_Event);
		CancelAttack();
		Teleport(TeleportPos);
		yield return WaitCustomEvent(PlayEffect1_Event);
		StartCor(Attack_1());
		yield return WaitCustomEvent(PlayEffect2_Event);
		StartCor(Attack_2());
		yield return WaitCustomEvent(PlayEffect3_Event);
		StartCor(Attack_3());
		yield return WaitCustomEvent(PlayEffect4_Event);
		StartCor(Attack_4());
		yield return WaitCustomEvent(PlayEffect5_Event);
		StartCor(Attack_5());
		yield return WaitFrame(1);
		BeginAttack(3, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(TeleportStart_Event);
		SetHideModelEnable();
		SetUnparalleledEnable();
		yield return WaitCustomEvent(StopAttack_Event);
		Teleport(centerPosition1);
		CancelAttack();
		SetUnparalleledDisable();
		SetHideModelDisable();
		if (!GetLogicTagToggleValue(_actor, "SkillTag_Ultra"))
		{
			SwitchCameraSetting(active: false, "Camera_WuShenZhan");
		}
		yield return WaitFrame(10);
		if (GetLogicTagToggleValue(_actor, "SkillTag_Ultra"))
		{
			BeginAttack(4, _actionKey3, flushInputedKeys: true, forceInterruptAttack: true);
			StopLookAt();
			yield return WaitCustomEvent(Bigweapon_Event);
			long FxLoopA = PlayEffect(Effect7, 1f, 0, GetPosition(), GetTSVectToAngle(GetForward(), 0));
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			PlayEarlyWarningEffect(AreaEffectAlias1, 1.15f, default, GetPosition(), default, 1f, actorScale: true);
			yield return WaitTime(0.75f);
			CancelAttack();
			yield return WaitTime(0.2f);
			PlayEarlyWarningEffect(AreaEffectAlias2, 0.6f, default, GetPosition(), default, 1f, actorScale: true);
			yield return WaitCustomEvent(StartLookAt_Event);
			BeginLookAt_NotWait(AttackTarget, 2, 1800);
			StopEffect(FxLoopA);
			yield return WaitFrame(5);
			StopLookAt();
			yield return WaitCustomEvent(CameraDown_Event);
			SwitchCameraSetting(active: false, "Camera_WuShenZhan");
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.2f);
	}

	protected override void OnSkillDisable()
	{
		SetUnparalleledDisable();
		SetHideModelDisable();
		SwitchCameraSetting(active: false, "Camera_WuShenZhan");
		RemoveBuffFromTarget(_actor, 990020140);
	}

	private IEnumerator Attack_1()
	{
		PlayEffect(Effect1, 1f, 0, centerPosition1, GetTSVectToAngle(GetForward(), 0));
		long FxLoopA = PlayEffect(HotBulletXuLi, 1f, 0, new TSVector2(0.38, 14.05), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(0.3);
		StopEffect(FxLoopA);
		Skill_ChaoJiuWuShenZhan_Hot skill_ChaoJiuWuShenZhan_Hot = this;
		string hotBullet = HotBullet;
		TSVector2 position = new TSVector2(0.38, 14.05);
		FP positionY = 0;
		FP range = 0;
		TSVector2 entityPosition = GetEntityPosition(AttackTarget);
		LogicEntity attackTarget = AttackTarget;
		skill_ChaoJiuWuShenZhan_Hot.Shoot(hotBullet, position, positionY, range, default, AimType.Target, BulletDirectionType.BulletToTarget, entityPosition, attackTarget);
		yield return WaitTime(5);
	}

	private IEnumerator Attack_2()
	{
		PlayEffect(Effect2, 1f, 0, centerPosition1, GetTSVectToAngle(GetForward(), 0));
		long FxLoopB = PlayEffect(HotBulletXuLi, 1f, 0, new TSVector2(-7.93, -11.74), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(0.9);
		StopEffect(FxLoopB);
		Skill_ChaoJiuWuShenZhan_Hot skill_ChaoJiuWuShenZhan_Hot = this;
		string hotBullet = HotBullet;
		TSVector2 position = new TSVector2(-7.93, -11.74);
		FP positionY = 0;
		FP range = 0;
		TSVector2 entityPosition = GetEntityPosition(AttackTarget);
		LogicEntity attackTarget = AttackTarget;
		skill_ChaoJiuWuShenZhan_Hot.Shoot(hotBullet, position, positionY, range, default, AimType.Target, BulletDirectionType.BulletToTarget, entityPosition, attackTarget);
	}

	private IEnumerator Attack_3()
	{
		PlayEffect(Effect3, 1f, 0, centerPosition1, GetTSVectToAngle(GetForward(), 0));
		long FxLoopC = PlayEffect(HotBulletXuLi, 1f, 0, new TSVector2(13.65, 4.08), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(1.4);
		StopEffect(FxLoopC);
		Skill_ChaoJiuWuShenZhan_Hot skill_ChaoJiuWuShenZhan_Hot = this;
		string hotBullet = HotBullet;
		TSVector2 position = new TSVector2(13.65, 4.08);
		FP positionY = 0;
		FP range = 0;
		TSVector2 entityPosition = GetEntityPosition(AttackTarget);
		LogicEntity attackTarget = AttackTarget;
		skill_ChaoJiuWuShenZhan_Hot.Shoot(hotBullet, position, positionY, range, default, AimType.Target, BulletDirectionType.BulletToTarget, entityPosition, attackTarget);
	}

	private IEnumerator Attack_4()
	{
		PlayEffect(Effect4, 1f, 0, centerPosition1, GetTSVectToAngle(GetForward(), 0));
		long FxLoopD = PlayEffect(HotBulletXuLi, 1f, 0, new TSVector2(-13.25, 4.08), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(1.5);
		StopEffect(FxLoopD);
		Skill_ChaoJiuWuShenZhan_Hot skill_ChaoJiuWuShenZhan_Hot = this;
		string hotBullet = HotBullet;
		TSVector2 position = new TSVector2(-13.25, 4.08);
		FP positionY = 0;
		FP range = 0;
		TSVector2 entityPosition = GetEntityPosition(AttackTarget);
		LogicEntity attackTarget = AttackTarget;
		skill_ChaoJiuWuShenZhan_Hot.Shoot(hotBullet, position, positionY, range, default, AimType.Target, BulletDirectionType.BulletToTarget, entityPosition, attackTarget);
	}

	private IEnumerator Attack_5()
	{
		PlayEffect(Effect5, 1f, 0, centerPosition1, GetTSVectToAngle(GetForward(), 0));
		long FxLoopE = PlayEffect(HotBulletXuLi, 1f, 0, new TSVector2(8.37, -11.53), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(2);
		StopEffect(FxLoopE);
		Skill_ChaoJiuWuShenZhan_Hot skill_ChaoJiuWuShenZhan_Hot = this;
		string hotBullet = HotBullet;
		TSVector2 position = new TSVector2(8.37, -11.53);
		FP positionY = 0;
		FP range = 0;
		TSVector2 entityPosition = GetEntityPosition(AttackTarget);
		LogicEntity attackTarget = AttackTarget;
		skill_ChaoJiuWuShenZhan_Hot.Shoot(hotBullet, position, positionY, range, default, AimType.Target, BulletDirectionType.BulletToTarget, entityPosition, attackTarget);
	}
}
