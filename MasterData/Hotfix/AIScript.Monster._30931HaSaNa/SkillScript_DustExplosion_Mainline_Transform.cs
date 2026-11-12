using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustExplosion_Mainline_Transform : SkillScript_TransformBase
{
	private readonly string comboTag = "ShaJuRen_Attack_4";

	private readonly int AreaEffectCount_Follow = 12;

	private readonly FP BlastTimes_Follow = 8;

	private readonly FP BlastInterval_Follow = 1.5;

	private readonly string areaEffectKey_Follow = "Area_30931HaSaNa_SandBlast_Small_LongAlert";

	private readonly int AreaEffectCount_Outside = 10;

	private readonly FP BlastTimes_Outside = 5;

	private readonly FP BlastInterval_Outside = 3;

	private readonly FP BlastRadius_Outside = 14;

	private readonly string areaEffectKey_Outside = "Area_30931HaSaNa_SandBlast_Big";

	private readonly int AreaEffectCount_Spin = 4;

	private readonly FP BlastAngleInterval_Spin = 20;

	private readonly FP BlastTimeInterval_Spin = 1.5;

	private readonly FP BlastTimes_Spin = 8;

	private readonly FP BlastRadius_Spin = 6.25;

	private readonly string areaEffectKey_Spin = "Area_30931HaSaNa_SandBlast_Big";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, comboTag, flushInputedKeys: true);
		yield return WaitTime(1.5);
		SkillScript_DustExplosion_Mainline_Transform skillScript_DustExplosion_Mainline_Transform = this;
		TSVector2 position = GetPosition();
		skillScript_DustExplosion_Mainline_Transform.PlayEffect("fx_m30931_base_Skill01_snap_lightring", 1f, default, position);
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		for (int i = 0; i < list.Count; i++)
		{
			list.get_Item(i).Finish();
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(CircleExplosionFollow());
		StartCor(CircleExplosionSpin());
		yield return WaitTime(BlastTimeInterval_Spin);
		StartCor(CircleExplosionOutside());
		yield return WaitTime(10);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
	}

	private IEnumerator CircleExplosionFollow()
	{
		for (int i = 0; i < BlastTimes_Follow; i++)
		{
			FP attackRadius = Distance(GetPosition(), GetEntityPosition(GetAttackTarget(isUpToDate: true)));
			CircleExplosion(AreaEffectCount_Follow, attackRadius, areaEffectKey_Follow, TSVector2.up);
			yield return WaitTime(BlastInterval_Follow);
		}
	}

	private IEnumerator CircleExplosionOutside()
	{
		for (int i = 0; i < BlastTimes_Outside; i++)
		{
			CircleExplosion(AreaEffectCount_Outside, BlastRadius_Outside, areaEffectKey_Outside, TSVector2.up);
			if (i < 2)
			{
				yield return WaitTime(BlastInterval_Outside / 2);
			}
			yield return WaitTime(BlastInterval_Outside / 2);
		}
	}

	private IEnumerator CircleExplosionSpin()
	{
		TSVector2 CircleRotation = TSVector2.up;
		for (int i = 0; i < BlastTimes_Spin; i++)
		{
			CircleExplosion(AreaEffectCount_Spin, BlastRadius_Spin, areaEffectKey_Spin, CircleRotation);
			if (i == 0 || i == 2 || i == 4)
			{
				CircleExplosion(AreaEffectCount_Spin, BlastRadius_Spin * 2, areaEffectKey_Spin, CircleRotation);
			}
			yield return WaitTime(BlastTimeInterval_Spin);
			CircleRotation = RotateTo(CircleRotation, BlastAngleInterval_Spin);
		}
	}

	private void CircleExplosion(int areaEffectCount, FP AttackRadius, string AttackEffectkey, TSVector2 StartForward)
	{
		if (areaEffectCount > 0)
		{
			int num = 360 / areaEffectCount;
			TSVector2 tSVector = StartForward * AttackRadius;
			for (int i = 0; i < areaEffectCount; i++)
			{
				int num2 = -num * i;
				TSVector2 position = _actor.tsTransform.Position + RotateTo(tSVector, num2);
				PlayAreaEffect(AttackEffectkey, position);
			}
		}
	}
}
