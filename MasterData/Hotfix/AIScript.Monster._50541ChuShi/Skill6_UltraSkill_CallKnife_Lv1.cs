using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill6_UltraSkill_CallKnife_Lv1 : SimpleAPI_ChuShi
{
	private readonly ComboInputBuffer.ActionKey[] UltraSkill_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private readonly ComboInputBuffer.ActionKey[] UltraSkill_BossRush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private readonly ComboInputBuffer.ActionKey[] Call = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private readonly FP ShootingPositionY = 1;

	private readonly FP BulletStartRadius = 3.5;

	private readonly int BulletAmount = 8;

	private readonly FP AlignShootDelayTime = 0.75;

	private readonly FP DurationTime = 0.75;

	private readonly FP DanmakuAngle = 180;

	private readonly TSVector2 CallBackTargetPosition = new TSVector2(0, 15.8);

	private readonly TSVector2 CallLineTargetPosition = new TSVector2(0, 13.8);

	private ComboInputBuffer.ActionKey[] UltraSkill;

	private FP TurnSpeed;

	private bool IsCallBackChargeEnd;

	private TSVector2 SkillPoint;

	private TSVector2 PalabolaBulletStartPosition;

	private FP PalabolaBulletStartPositionY;

	private FP PalabolaBulletRotation;

	private TSVector2 PalabolaBulletAimPosition;

	private string PalabolaBulletType;

	private TSVector2 PalabolaBulletDirection;

	private CoroutineNode CheckBackBulletCoroutine;

	private CoroutineNode StartShootingNodeOut;

	private CoroutineNode StartShootingNodeIn;

	private CoroutineNode CallBackChargeNode;

	private CoroutineNode CallBackNode;

	private List<long> LinkEffects = new List<long>();

	private List<TSVector2> AllSummonPosition = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		AddBuffToTarget(_actor, 990020140);
		TurnSpeed = GetRotSpdInSkill();
		SetLogicTagToggleValue(_actor, "IsUltra", value: true);
		IsCallBackChargeEnd = false;
		if (GetLogicTagToggleValue(_actor, "IsBossRush"))
		{
			UltraSkill = UltraSkill_BossRush;
		}
		else
		{
			UltraSkill = UltraSkill_Normal;
		}
	}

	protected override void OnSkillDisable()
	{
		AllSummonPosition.Clear();
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
		StopDash();
		SwitchCameraSetting(active: false, "UltraSkill");
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		SetLogicTagToggleValue(_actor, "IsUltra", value: false);
		TriggerOpLisener("FX3to2");
		List<LogicEntity> targetByTeammateIndexes = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 });
		KillActors(targetByTeammateIndexes);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBlockPriorityToStatic();
		SkillPoint = new TSVector2(0, 16);
		yield return StartCor(JumpToPoints(SkillPoint));
		SwitchCameraSetting(active: true, "UltraSkill");
		yield return BeginLookAtByPos(GetPosition() + new TSVector2(0, -1), 0, TurnSpeed);
		BeginAttack(1, UltraSkill, flushInputedKeys: true, forceInterruptAttack: true);
		TriggerOpLisener("FX2to3");
		yield return WaitTime(2);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		StartCor(ref StartShootingNodeIn, StartShooting("Knife_Straight", AdventureWeapon.MultipleShootStyle.FromLeftToRight, AlignShootDelayTime, BulletAmount, DurationTime, DanmakuAngle, BulletStartRadius, IsFlash: true));
		StartCor(ref StartShootingNodeOut, StartShooting("Knife_Straight_Fire", AdventureWeapon.MultipleShootStyle.FromLeftToRight, AlignShootDelayTime + 0.75, 3, DurationTime, 100, BulletStartRadius + 2, IsFlash: false));
		yield return WaitTime(2.5);
		StartCor(ref StartShootingNodeIn, StartShooting("Knife_Straight", AdventureWeapon.MultipleShootStyle.FromLeftToRight, AlignShootDelayTime, BulletAmount + 1, DurationTime, DanmakuAngle, BulletStartRadius, IsFlash: true));
		StartCor(ref StartShootingNodeOut, StartShooting("Knife_Straight_Fire", AdventureWeapon.MultipleShootStyle.FromLeftToRight, AlignShootDelayTime + 0.75, 2, DurationTime, 25, BulletStartRadius + 2, IsFlash: false));
		yield return WaitTime(2.5);
		StartCor(ref StartShootingNodeIn, StartShooting("Fork_Straight", AdventureWeapon.MultipleShootStyle.FromRightToLeft, AlignShootDelayTime, BulletAmount + 2, DurationTime, DanmakuAngle, BulletStartRadius, IsFlash: true));
		StartCor(ref StartShootingNodeOut, StartShooting("Fork_Straight_Fire", AdventureWeapon.MultipleShootStyle.FromRightToLeft, AlignShootDelayTime + 0.75, 2, DurationTime, 75, BulletStartRadius + 2, IsFlash: false));
		yield return WaitTime(2.5);
		StartCor(ref StartShootingNodeIn, StartShooting("Knife_Straight", AdventureWeapon.MultipleShootStyle.FromLeftToRight, AlignShootDelayTime, BulletAmount + 3, DurationTime, DanmakuAngle, BulletStartRadius, IsFlash: true));
		StartCor(ref StartShootingNodeOut, StartShooting("Knife_Straight_Fire", AdventureWeapon.MultipleShootStyle.FromLeftToRight, AlignShootDelayTime + 0.75, 2, DurationTime, 50, BulletStartRadius + 2, IsFlash: false));
		yield return WaitTime(AlignShootDelayTime);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(2);
		if (GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 }).Count == 0)
		{
			IsCallBackChargeEnd = true;
		}
		else
		{
			StartCor(ref CallBackChargeNode, CallBackCharge());
		}
		while (!IsCallBackChargeEnd)
		{
			if (GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 }).Count == 0)
			{
				IsCallBackChargeEnd = true;
				StopCor(CallBackChargeNode);
				StartCor(ref CallBackNode, CallBack());
			}
			yield return null;
		}
		SkillEnd();
		yield return WaitTime(2);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (!(e is AdventureBulletFinishEvent adventureBulletFinishEvent) || (!(adventureBulletFinishEvent.tag == "Knife_Straight_Fire") && !(adventureBulletFinishEvent.tag == "Fork_Straight_Fire")))
		{
			return;
		}
		PalabolaBulletStartPosition = adventureBulletFinishEvent.bulletPosition;
		PalabolaBulletStartPositionY = adventureBulletFinishEvent.bulletPositionY;
		PalabolaBulletDirection = SkillPoint - PalabolaBulletStartPosition;
		PalabolaBulletRotation = GetTSVectToAngle(PalabolaBulletDirection, 0);
		TSVector2 palabolaBulletStartPosition = PalabolaBulletStartPosition;
		FP radius = 3;
		FP innerRadius = 2;
		FP angle = 1;
		FP palabolaBulletRotation = PalabolaBulletRotation;
		PalabolaBulletAimPosition = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Fan, palabolaBulletStartPosition, default, default, radius, innerRadius, angle, palabolaBulletRotation), _actor, isReachable: true);
		string tag = adventureBulletFinishEvent.tag;
		if (!(tag == "Knife_Straight_Fire"))
		{
			if (tag == "Fork_Straight_Fire")
			{
				PalabolaBulletType = "Fork_Parabola_Fire";
			}
		}
		else
		{
			PalabolaBulletType = "Knife_Parabola_Fire";
		}
		FanMultipleShoot(PalabolaBulletType, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, PalabolaBulletStartPosition, PalabolaBulletStartPositionY, PalabolaBulletDirection, 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, 0, PalabolaBulletAimPosition);
	}

	private IEnumerator StartShooting(string BulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, FP alignShootDelayTime, int BulletCount, FP Duration, FP Angle, FP BulletStartRadius, bool IsFlash)
	{
		TSVector2 forward = GetForward();
		FanMultipleShoot(BulletAlias, multipleShootStyle, alignShoot: true, alignShootDelayTime, BulletCount, Duration, SkillPoint, ShootingPositionY, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, Angle, 0, BulletStartRadius);
		if (multipleShootStyle == AdventureWeapon.MultipleShootStyle.FromLeftToRight)
		{
			FP InitialAngleL = 0.5 * Angle;
			int CurrentBulletCount = 0;
			while (CurrentBulletCount < BulletCount)
			{
				TSVector2 tSVector = TransLocalPosToWorldPos(relativePoint: new TSVector2(0, BulletStartRadius), csOrigin: GetPosition(), csForward: RotateTo(GetForward(), InitialAngleL));
				Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv = this;
				TSVector2 position = tSVector;
				skill6_UltraSkill_CallKnife_Lv.PlayEffect("BulletBorn", 1f, default, position, default, 1.5f);
				CurrentBulletCount++;
				if (CurrentBulletCount < BulletCount)
				{
					yield return WaitTime(Duration / (BulletCount - 1));
				}
				InitialAngleL -= Angle / (BulletCount - 1);
			}
		}
		else
		{
			FP InitialAngleL = -0.5 * Angle;
			int CurrentBulletCount = 0;
			while (CurrentBulletCount < BulletCount)
			{
				TSVector2 tSVector2 = TransLocalPosToWorldPos(relativePoint: new TSVector2(0, BulletStartRadius), csOrigin: GetPosition(), csForward: RotateTo(GetForward(), InitialAngleL));
				Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv2 = this;
				TSVector2 position = tSVector2;
				skill6_UltraSkill_CallKnife_Lv2.PlayEffect("BulletBorn", 1f, default, position, default, 1.5f);
				CurrentBulletCount++;
				if (CurrentBulletCount < BulletCount)
				{
					yield return WaitTime(Duration / (BulletCount - 1));
				}
				InitialAngleL += Angle / (BulletCount - 1);
			}
		}
		if (BulletAlias == "Knife_Straight" || BulletAlias == "Fork_Straight")
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_50541_ult_knifeshoot");
			ShootWarningLineShow(multipleShootStyle, BulletCount, Angle);
		}
		else
		{
			yield return WaitTime(0.75);
			ShootWarningLineShow(multipleShootStyle, BulletCount, Angle);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_50541_ult_fireknife");
		}
		if (IsFlash)
		{
			PlayEffect("HitFlashFX", 1f, position: CallLineTargetPosition, fxPositionY: 1.5, angle: default, spawnSize: 1.5f);
		}
	}

	private void ShootWarningLineShow(AdventureWeapon.MultipleShootStyle multipleShootStyle, int BulletCount, FP Angle)
	{
		if (multipleShootStyle == AdventureWeapon.MultipleShootStyle.FromLeftToRight)
		{
			for (FP fP = 0.5 * Angle; fP >= -0.5 * Angle; fP -= Angle / (BulletCount - 1))
			{
				TSVector2 skillPoint = SkillPoint;
				FP angle = fP + 180;
				PlayEarlyWarningEffect("ShootWarningLine", 0.5f, default, skillPoint, angle, 2f);
			}
		}
		else
		{
			for (FP fP2 = -0.5 * Angle; fP2 <= 0.5 * Angle; fP2 += Angle / (BulletCount - 1))
			{
				TSVector2 skillPoint = SkillPoint;
				FP angle = fP2 + 180;
				PlayEarlyWarningEffect("ShootWarningLine", 0.5f, default, skillPoint, angle, 2f);
			}
		}
	}

	protected IEnumerator CheckBrokenLineBulletBack()
	{
		while (true)
		{
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(2, CallBackTargetPosition, list, 32768);
			for (int i = 0; i < list.Count; i++)
			{
				AdventureBullet adventureBullet = list.get_Item(i).Entity as AdventureBullet;
				if (adventureBullet != null && adventureBullet.owner == _actor)
				{
					Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv = this;
					TSVector2 position = adventureBullet.tsTransform.Position;
					skill6_UltraSkill_CallKnife_Lv.PlayEffect("BulletBorn", 1f, default, position);
					adventureBullet.Finish(cancel: true);
				}
			}
			yield return null;
		}
	}

	private void SkillEnd()
	{
		Singleton<InteractiveManager>.Instance.triggerOpListener("FX3to2");
		StopCor(CheckBackBulletCoroutine);
		ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger("UltraSkill");
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected IEnumerator CallBackCharge()
	{
		BeginAttack(2, Call, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		List<LogicEntity> AllSummon = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 });
		foreach (LogicEntity item4 in AllSummon)
		{
			Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv = this;
			LogicEntity target = item4;
			long item = skill6_UltraSkill_CallKnife_Lv.PlayLinkEffect("CallLine1", useCustomSource: false, null, default, default, target);
			LinkEffects.Add(item);
			SetLogicTagToggleValue(item4, "IsCallBack", value: true);
		}
		yield return WaitTime(0.1);
		foreach (LogicEntity item5 in AllSummon)
		{
			Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv2 = this;
			LogicEntity target = item5;
			long item2 = skill6_UltraSkill_CallKnife_Lv2.PlayLinkEffect("CallLine2", useCustomSource: false, null, default, default, target);
			LinkEffects.Add(item2);
		}
		yield return WaitTime(2.5);
		AllSummon.Clear();
		AllSummon = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 });
		for (int num = AllSummon.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = AllSummon.get_Item(num);
			AdventureActor adventureActor = logicEntity as AdventureActor;
			Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv3 = this;
			LogicEntity target = logicEntity;
			long item3 = skill6_UltraSkill_CallKnife_Lv3.PlayLinkEffect("CallLine2", useCustomSource: false, null, default, default, target, default, default, breakWhenLostSourceOrTarget: false);
			LinkEffects.Add(item3);
			Skill6_UltraSkill_CallKnife_Lv1 skill6_UltraSkill_CallKnife_Lv4 = this;
			TSVector2 position = adventureActor.tsTransform.Position;
			skill6_UltraSkill_CallKnife_Lv4.PlayEffect("HitFlashFX", 1f, default, position, default, 0.5f);
			AllSummonPosition.Add(GetEntityPositionObsoleted(logicEntity));
			adventureActor.DestroySelf();
		}
	}

	private IEnumerator CallBack()
	{
		FP CallBackTargetPositionY = 1.4;
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_50541_skill_silkcatchknife_explosion");
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitTime(0.3);
		foreach (long linkEffect in LinkEffects)
		{
			StopEffect(linkEffect);
		}
		StartCor(ref CheckBackBulletCoroutine, CheckBrokenLineBulletBack());
		foreach (TSVector2 item in AllSummonPosition)
		{
			FanMultipleShoot("Knife_CallBack_Fire", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, item, CallBackTargetPositionY, CallBackTargetPosition - item, 0, AimType.Default, BulletDirectionType.BulletToTarget, 0, 0, 0);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
