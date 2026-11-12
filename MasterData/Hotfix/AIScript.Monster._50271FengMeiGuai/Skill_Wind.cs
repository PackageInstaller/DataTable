#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_Wind : SkillSimpleBase
{
	private LogicEntity Targetenemy;

	private string evt_play = "PlayHintFx";

	private string evt_stop = "StopHintFx";

	private List<long> fxList = new List<long>();

	private readonly int windStartIndex;

	private readonly string windStartKey = "Wind_Start";

	private readonly int windHoldIndex = 1;

	private readonly string windHoldKey = "Wind_Hold";

	private readonly int windAttackIndex = 2;

	private readonly string windAttackKey = "Wind_Attack";

	private readonly int windInhaleIndex = 3;

	private readonly string windInhaleKey = "Wind_Inhale";

	private TSVector2 atkDir;

	private long windFxIndex;

	private string windFx = "fx_50271_loop_ground_wind";

	private long warningFxIndex;

	private string warningFx = "fx_50271_warning_windvane";

	private long pointer_motionFxIndex;

	private string pointer_motionFx = "fx_m50271_loop_pointer_rotate";

	private long pointer_motionlessFxIndex;

	private string pointer_motionlessFx = "fx_m50271_loop_pointer_rotate_end";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		if (fxList != null && fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
		fxList.Clear();
		DispatchCustomEvent(evt_play);
	}

	protected override IEnumerator DoMainLogic()
	{
		atkDir = ChooseDirectionOfATK();
		DispatchCustomEvent(evt_stop);
		pointer_motionFxIndex = PlayEffect(pointer_motionFx);
		fxList.Add(pointer_motionFxIndex);
		windFxIndex = PlayEffect(windFx, 1f, default, GetPosition(), GetTSVectToAngle(atkDir, 0));
		fxList.Add(windFxIndex);
		MoveToPosition(TSVector2.zero, 0.1, AdventureActor.MovementMode.Run, 5);
		yield return WaitMoveStatus();
		yield return BeginLookAtByPos(new TSVector2(0, -20), 0.6, 300);
		BeginAttack(windStartIndex, windStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.2);
		BeginAttack(windInhaleIndex, windInhaleKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.07);
		BeginAttack(windHoldIndex, windHoldKey, flushInputedKeys: true, forceInterruptAttack: true);
		StopEffect(pointer_motionFxIndex);
		pointer_motionlessFxIndex = PlayEffect(pointer_motionlessFx, 1f, default, default, GetTSVectToAngle(atkDir, 0));
		fxList.Add(pointer_motionlessFxIndex);
		yield return WaitTime(0.8);
		if (GetBuffNum(_actor, 502710000) >= 1)
		{
			PlayAreaEffect("Area_50271_FengMeiGuai_Skill05_WindRepel", TransLocalPosToWorldPos(GetPosition(), atkDir, new TSVector2(0, 15)));
			StartCor(SpawnBulletGenerator());
		}
		warningFxIndex = PlayEffect(warningFx, 1f, default, GetPosition(), GetTSVectToAngle(atkDir, 0));
		fxList.Add(warningFxIndex);
		yield return WaitTime(0.8);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 2.5f);
		yield return BeginLookAtByPos(atkDir, 0.4, 450);
		StopEffect(warningFxIndex);
		BeginAttack(windAttackIndex, windAttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (GetBuffNum(_actor, 502710000) >= 1)
		{
			yield return WaitTime(10);
		}
		else
		{
			yield return WaitTime(2);
		}
		StopEffect(windFxIndex);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private TSVector2 ChooseDirectionOfATK()
	{
		TSVector2 result;
		switch ((int)(long)GetRandomValue(0, 3.5, isInt: true))
		{
		case 0:
			result = new TSVector2(0, 40);
			break;
		case 1:
			result = new TSVector2(-40, 0);
			break;
		case 2:
			result = new TSVector2(40, 0);
			break;
		case 3:
			result = new TSVector2(0, -40);
			break;
		default:
			NovaLogger.Debug("风媒怪.机制风技能.选择方向异常");
			return TSVector2.down;
		}
		return result;
	}

	protected IEnumerator SpawnBulletGenerator()
	{
		StartCor(SpawnBullet01());
		StartCor(SpawnBullet01());
		StartCor(SpawnBullet02());
		yield return WaitTime(3);
		StartCor(SpawnBullet01());
		StartCor(SpawnBullet01());
		StartCor(SpawnBullet02());
		yield return WaitTime(3);
		StartCor(SpawnBullet01());
		StartCor(SpawnBullet01());
		StartCor(SpawnBullet02());
	}

	protected IEnumerator SpawnBullet01()
	{
		Skill_Wind skill_Wind = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), atkDir, new TSVector2(0, -15));
		FP width = 25;
		FP length = 23;
		FP rotation = 0;
		DeterministicShape shapeData = skill_Wind.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		TSVector2 SpawnPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		PlayAreaEffect("Area_50271_FengMeiGuai_Skill05_WindbBulletWarning", SpawnPos);
		yield return WaitTime(0.8);
		FanMultipleShoot("FengMeiGuai_skill05_SplitBullet", AdventureWeapon.MultipleShootStyle.FromSideToCenter, alignShoot: true, 0.5, 1, 0, SpawnPos, 0.5, atkDir, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 0);
	}

	protected IEnumerator SpawnBullet02()
	{
		GetEnemy();
		TSVector2 SpawnPos = GetEntityPosition(Targetenemy);
		PlayAreaEffect("Area_50271_FengMeiGuai_Skill05_WindbBulletWarning", SpawnPos);
		yield return WaitTime(0.8);
		FanMultipleShoot("FengMeiGuai_skill05_SplitBullet", AdventureWeapon.MultipleShootStyle.FromSideToCenter, alignShoot: true, 0.5, 1, 0, SpawnPos, 0.5, atkDir, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 0);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
