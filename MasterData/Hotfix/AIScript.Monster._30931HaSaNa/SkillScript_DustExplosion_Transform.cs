using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustExplosion_Transform : SkillScript_TransformBase
{
	private readonly string comboTag = "ShaJuRen_Attack_4";

	private readonly int AreaEffectCount_Follow = 15;

	private readonly FP BlastTimes_Follow = 4;

	private readonly FP BlastInterval_Follow = 4.5;

	private readonly string areaEffectKey_Follow = "Area_30931HaSaNa_SandBlast_Small_LongAlert";

	private readonly int AreaEffectCount_Outside = 10;

	private readonly FP BlastTimes_Outside = 3;

	private readonly FP BlastInterval_Outside = 6;

	private readonly FP BlastRadius_Outside = 14;

	private readonly string areaEffectKey_Outside = "Area_30931HaSaNa_SandBlast_Big";

	private readonly int AreaEffectCount_Spin = 4;

	private readonly FP BlastAngleInterval_Spin = 20;

	private readonly FP BlastTimeInterval_Spin = 1.5;

	private readonly FP BlastTimes_Spin = 12;

	private readonly FP BlastRadius_Spin = 7.5;

	private readonly string areaEffectKey_Spin = "Area_30931HaSaNa_SandBlast_Big";

	private readonly FP addAreaEffectCount_Spin = 0.5;

	private List<PlayFX> linkFxList;

	private int BlastCount_Spin;

	protected override IEnumerator DoMainLogic()
	{
		linkFxList = new List<PlayFX>();
		int chargeCount = GetActiveDeviceCount();
		BlastCount_Spin = (int)(long)(AreaEffectCount_Spin + chargeCount * addAreaEffectCount_Spin);
		foreach (MonsterAdventureActor activeDevice in _activeDevices)
		{
			SetLogicTagToggleValue(activeDevice, "Locked", value: true);
		}
		foreach (MonsterAdventureActor activeDevice2 in _activeDevices)
		{
			linkFxList.Add(PlayLinkFX(linkFx, useCustomSource: true, activeDevice2.slotConfig.bodySlot.gameObject, TSVector.zero, 0, _actor.slotConfig.bodySlot.gameObject, TSVector.zero, 0));
		}
		BeginAttack(1, comboTag, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(CircleExplosionFollow());
		yield return WaitTime(1.5);
		StartCor(CircleExplosionSpin());
		yield return WaitTime(1.5);
		if (chargeCount >= 3)
		{
			StartCor(CircleExplosionOutside());
		}
		yield return WaitTime(15);
		CancelAttack();
		foreach (PlayFX linkFx in linkFxList)
		{
			linkFx.Stop();
		}
		foreach (MonsterAdventureActor activeDevice3 in _activeDevices)
		{
			SetLogicTagToggleValue(activeDevice3, "Locked", value: false);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		foreach (PlayFX linkFx in linkFxList)
		{
			linkFx.Stop();
		}
		foreach (MonsterAdventureActor activeDevice in _activeDevices)
		{
			SetLogicTagToggleValue(activeDevice, "Locked", value: false);
		}
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
			yield return WaitTime(BlastInterval_Outside);
		}
	}

	private IEnumerator CircleExplosionSpin()
	{
		TSVector2 CircleRotation = TSVector2.up;
		for (int i = 0; i < BlastTimes_Spin; i++)
		{
			CircleExplosion(BlastCount_Spin, BlastRadius_Spin, areaEffectKey_Spin, CircleRotation);
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
