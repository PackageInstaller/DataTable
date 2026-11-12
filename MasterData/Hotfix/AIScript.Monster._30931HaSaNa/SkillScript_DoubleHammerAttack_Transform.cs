using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DoubleHammerAttack_Transform : SkillScript_TransformBase
{
	private readonly string comboTag_Stage1 = "ShaJuRen_Attack_5";

	private readonly string BombName = "Weapon_30931HaSaNa_Bomb";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, comboTag_Stage1, flushInputedKeys: true);
		BeginLookAtMonsterTarget(2, 50);
		yield return WaitTime(0.5);
		PlayEffect("fx_m30932_base_Attack_5_charge_2");
		yield return WaitTime(1.5);
		CancelAttack();
		BeginLookAtMonsterTarget(999, 200);
		yield return WaitCustomEvent("stopturn1");
		StopWaitLookAt();
		yield return WaitCustomEvent("BombShoot1");
		CircleMultiBomb();
		yield return WaitCustomEvent("startturn2");
		BeginLookAtMonsterTarget(999, 200);
		yield return WaitCustomEvent("stopturn2");
		StopWaitLookAt();
		yield return WaitCustomEvent("BombShoot2");
		CircleMultiBomb();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void CircleMultiBomb()
	{
		CircleMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 5, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 7)), 0, RotateTo(GetForward(), GetRandomValue(0, 360)), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 1);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (!string.Equals(eventName, "HammerHit1") && !string.Equals(eventName, "HammerHit2"))
		{
			return;
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventName = "HaSaNaTriggerDevice";
		TSVector2 value = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 8));
		PlayEffect("fx_level_StoryActivity_12_Boss_A");
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		for (int i = 0; i < list.Count; i++)
		{
			if (Distance(list.get_Item(i).tsTransform.Position, value) <= 6)
			{
				list.get_Item(i).Finish();
			}
		}
	}
}
