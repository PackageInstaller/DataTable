using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_Hammering_Transform : SkillScript_TransformBase
{
	private readonly string comboTag_Stage1 = "ShaJuRen_Attack_2";

	private readonly TSVector2 offset_Stage1 = new TSVector2(1.1, 4.4);

	private readonly TSVector2 offset_Stage2 = new TSVector2(-1.5, 4.3);

	private readonly TSVector2 offset_Stage3_1 = new TSVector2(-1.5, 3.77);

	private readonly TSVector2 offset_Stage3_2 = new TSVector2(1.56, 3.77);

	private readonly string eventName_Hit = "ShockWave";

	private readonly string fxKey_TriggerShockWave = "fx_m30931_base_Skill01_snap_lightring";

	private int PunchCount;

	protected override IEnumerator DoMainLogic()
	{
		PunchCount = 0;
		BeginAttack(1, comboTag_Stage1, flushInputedKeys: true);
		BeginLookAtMonsterTarget(0.65, 200);
		yield return WaitCustomEvent("StartTurn2");
		BeginLookAtMonsterTarget(0.25, 200);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (!string.Equals(eventName, eventName_Hit))
		{
			return;
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventName = "HaSaNaTriggerDevice";
		List<TSVector2> list = new List<TSVector2>();
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
			TSVector2 tSVector4 = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage1 * 1.4);
			PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector4, 0, null, 0.25f);
			adventureActorCustomEvent.tsVector2ParamList.Add(tSVector4);
			list.Add(tSVector4);
			break;
		}
		case 2:
		{
			TSVector2 tSVector3 = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage2 * 1.4);
			PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector3, 0, null, 0.25f);
			adventureActorCustomEvent.tsVector2ParamList.Add(tSVector3);
			list.Add(tSVector3);
			break;
		}
		case 3:
		{
			TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage3_1 * 1.4);
			TSVector2 tSVector2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), offset_Stage3_2 * 1.4);
			list.Add(tSVector);
			list.Add(tSVector2);
			adventureActorCustomEvent.tsVector2ParamList.Add(tSVector);
			adventureActorCustomEvent.tsVector2ParamList.Add(tSVector2);
			PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector, 0, null, 0.25f);
			PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector2, 0, null, 0.25f);
			break;
		}
		}
		if (GetLogicTagToggleValue(_actor, "IsMainline"))
		{
			PlayEffect("fx_level_StoryActivity_12_Boss_A");
			List<AdventureBulletBase> list2 = new List<AdventureBulletBase>();
			_actor.QueryOwnedAliveBullets(list2);
			for (int i = 0; i < list2.Count; i++)
			{
				foreach (TSVector2 item in list)
				{
					if (Distance(list2.get_Item(i).tsTransform.Position, item) <= 6)
					{
						list2.get_Item(i).Finish();
					}
				}
			}
		}
		list.Clear();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}
}
