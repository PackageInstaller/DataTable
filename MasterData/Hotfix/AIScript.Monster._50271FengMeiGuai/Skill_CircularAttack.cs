#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_CircularAttack : SkillSimpleBase
{
	private CoroutineNode hitCor;

	private readonly int Circular_StartIndex;

	private readonly string Circular_StartKey = "Circular_Start";

	private readonly int Circular_InhaleIndex = 1;

	private readonly string Circular_InhaleKey = "Circular_Inhale";

	private readonly int Circular_SwitchIndex = 2;

	private readonly string Circular_SwitchKey = "Circular_Switch";

	private readonly int CircularAttackIndex = 3;

	private readonly string CircularAttackKey = "CircularAttack";

	private List<long> fxList;

	protected override void OnSkillEnable()
	{
		fxList = new List<long>();
		NovaLogger.Debug("风媒怪.圆形伤害.技能开始");
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
		fxList = null;
		StopCor(hitCor);
		StopLookAt();
		NovaLogger.Debug("风媒怪.圆形伤害.技能结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(Circular_StartIndex, Circular_StartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.17);
		fxList.Add(PlayEffect("fx_common_base_Dark_YuJing_circular_4", 0.7f, default, GetPosition(), default, 1.5f));
		BeginAttack(Circular_InhaleIndex, Circular_InhaleKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.22);
		BeginAttack(Circular_SwitchIndex, Circular_SwitchKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.35);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 2.5f);
		yield return WaitTime(0.1);
		BeginLookAt_NotWait(GetCurrentPlayer(), 2, 120);
		BeginAttack(CircularAttackIndex, CircularAttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		TSVector2 position = GetPosition();
		if (GetBuffNum(_actor, 502710000) >= 1)
		{
			SpawnBullet();
		}
		fxList.Add(PlayEffect("fx_50271_loop_atk_B_Skill03_aoe", 1f, default, position, default, 1.5f));
		hitCor = StartCor(HitDamage(8, position));
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (fxList != null && fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
		StopCor(hitCor);
	}

	protected IEnumerator HitDamage(int cycleIndex, TSVector2 pos)
	{
		for (int i = 0; i < cycleIndex; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, pos, default, default, 6);
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50271015, 0.5, HitBox.HurtAnimType.Small, "fx_50271_hit_skill01");
			yield return WaitTime(0.2);
		}
	}

	protected void SpawnBullet()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("FengMeiGuai_skill03_SplitBullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 6, 0, position, 0.5, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}
}
