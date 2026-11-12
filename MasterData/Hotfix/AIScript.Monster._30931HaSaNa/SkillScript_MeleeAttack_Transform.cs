using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_MeleeAttack_Transform : SkillScript_TransformBase
{
	private readonly string comboTag = "ShaJuRenAttack_1";

	private readonly string eventName_BeginShockWave = "3rdWaves";

	private readonly int initShockWaveCount = 3;

	private readonly int addShockWaveCount = 1;

	private readonly FP totalDistanceShockWave = 9;

	private readonly FP totalDurationShockWave = 0.5;

	private readonly int intervalAngleShockWave = 50;

	private readonly int initExplosionCount = 5;

	private readonly int addExplosionCount;

	private readonly TSVector2 offset_Stage1 = new TSVector2(-1.68, 3.96);

	private readonly TSVector2 offset_Stage2 = new TSVector2(1.43, 7.23);

	private readonly TSVector2 offset_Stage3 = new TSVector2(-0.09, 4.22);

	private readonly string eventName_Hit = "ShockWave";

	private readonly string fxKey_TriggerShockWave = "fx_m30931_base_Skill01_snap_lightring";

	private readonly string areaEffectKey = "Area_30931HaSaNa_SandBlast_Small";

	private int _chargeCount;

	private int _shockWaveCorCount;

	private List<PlayFX> linkFxList;

	private int PunchCount;

	protected override IEnumerator DoMainLogic()
	{
		linkFxList = new List<PlayFX>();
		PunchCount = 0;
		yield return BeginLookAtMonsterTarget(0.5, 360);
		BeginAttack(1, comboTag, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		foreach (PlayFX linkFx in linkFxList)
		{
			linkFx.Stop();
		}
		foreach (MonsterAdventureActor activeDevice in _activeDevices)
		{
			SetLogicTagToggleValue(activeDevice, "Locked", value: false);
		}
		while (_shockWaveCorCount > 0)
		{
			yield return null;
		}
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
		_shockWaveCorCount = 0;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (string.Equals(eventName, eventName_BeginShockWave))
		{
			int num = initShockWaveCount + _chargeCount * addShockWaveCount;
			int num2 = initExplosionCount + _chargeCount * addExplosionCount;
			if (num <= 0 || num2 <= 0)
			{
				return;
			}
			int num3 = (num - 1) * intervalAngleShockWave;
			FP intervalDistance = ((num2 > 1) ? (totalDistanceShockWave / (num2 - 1)) : ((FP)0));
			FP intervalTimes = ((num2 > 1) ? (totalDurationShockWave / (num2 - 1)) : ((FP)0));
			TSVector2 forward = _actor.tsTransform.Forward;
			if (num > 1)
			{
				float num4 = (float)num3 * 0.5f;
				for (int i = 0; i < num; i++)
				{
					TSVector2 normalized = TSVector2.Rotate(forward, 0f - num4 + (float)(intervalAngleShockWave * i)).normalized;
					TSVector2 startPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), TSVector2.up * 4 * 1.4);
					StartCor(ShockWave(startPosition, normalized, num2, intervalDistance, intervalTimes));
				}
			}
			else
			{
				TSVector2 startPosition2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), TSVector2.up * 4 * 1.4);
				StartCor(ShockWave(startPosition2, _actor.tsTransform.Forward, num2, intervalDistance, intervalTimes));
			}
			return;
		}
		if (string.Equals(eventName, "StartLink"))
		{
			_chargeCount = GetActiveDeviceCount();
			foreach (MonsterAdventureActor activeDevice in _activeDevices)
			{
				SetLogicTagToggleValue(activeDevice, "Locked", value: true);
			}
			{
				foreach (MonsterAdventureActor activeDevice2 in _activeDevices)
				{
					linkFxList.Add(PlayLinkFX(linkFx, useCustomSource: true, activeDevice2.slotConfig.bodySlot.gameObject, TSVector.zero, 0, _actor.slotConfig.bodySlot.gameObject, TSVector.zero, 0));
				}
				return;
			}
		}
		if (string.Equals(eventName, "Turn"))
		{
			BeginLookAtMonsterTarget(0.5, 120);
		}
		else if (string.Equals(eventName, eventName_Hit))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventName = "HaSaNaTriggerDevice";
			PunchCount++;
			if (adventureActorCustomEvent.tsVector2ParamList == null)
			{
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2>();
			}
			else
			{
				adventureActorCustomEvent.tsVector2ParamList.Clear();
			}
			switch (PunchCount)
			{
			case 1:
			{
				TSVector2 tSVector3 = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage1 * 1.4);
				PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector3, 0, null, 0.25f);
				adventureActorCustomEvent.tsVector2ParamList.Add(tSVector3);
				break;
			}
			case 2:
			{
				TSVector2 tSVector2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage2 * 1.4);
				PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector2, 0, null, 0.25f);
				adventureActorCustomEvent.tsVector2ParamList.Add(tSVector2);
				break;
			}
			case 3:
			{
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage3 * 1.4);
				adventureActorCustomEvent.tsVector2ParamList.Add(tSVector);
				PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector, 0, null, 0.25f);
				break;
			}
			}
			if (GetLogicTagToggleValue(_actor, "IsMainline"))
			{
				PlayEffect("fx_level_StoryActivity_12_Boss_A");
			}
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private IEnumerator ShockWave(TSVector2 startPosition, TSVector2 direction, int explosionCount, FP intervalDistance, FP intervalTimes)
	{
		_shockWaveCorCount++;
		int lastExplosionCount = explosionCount;
		TSVector2 explosionPosition = startPosition;
		FP interval = 0;
		while (lastExplosionCount > 0)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				PlayAreaEffect(areaEffectKey, explosionPosition);
				lastExplosionCount--;
				explosionPosition += intervalDistance * direction;
				interval = intervalTimes;
			}
			yield return null;
		}
		_shockWaveCorCount--;
	}
}
