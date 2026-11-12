using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_MeeleBase : SkillSimpleBase
{
	private readonly string eventName_TriggerShockWave = "ShockWave";

	private readonly string fxKey_TriggerShockWave = "fx_m30931_base_Skill01_snap_lightring";

	private readonly string eventName_TriggerFanBlast1 = "FanBlast1";

	private readonly string eventName_TriggerFanBlast2 = "FanBlast2";

	private readonly string effectKey_TriggerFanBlast = "Area_30931HaSaNa_SandBlast_Mini";

	protected bool _isStrength;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isStrength = GetLogicTagToggleValue(_actor, "IsSkillStrength");
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (string.Equals(eventName, eventName_TriggerShockWave))
		{
			TSVector2 logicTagTSVector2Value = GetLogicTagTSVector2Value(_actor, "Offset_SmashPoint");
			TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), logicTagTSVector2Value);
			PlayFx(fxKey_TriggerShockWave, 1f, 0, tSVector, 0, null, 0.15f);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventName = "HaSaNaTriggerDevice";
			if (adventureActorCustomEvent.tsVector2ParamList == null)
			{
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2>();
			}
			else
			{
				adventureActorCustomEvent.tsVector2ParamList.Clear();
			}
			adventureActorCustomEvent.tsVector2ParamList.Add(tSVector);
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_isStrength)
		{
			RemoveBuffFromTarget(_actor, 309310010);
			RemoveBuffFromTarget(_actor, 309310020);
		}
		SetLogicTagToggleValue(_actor, "IsSkillStrength", value: false);
		_isStrength = false;
	}

	private IEnumerator FanBlastAttack(FP Radius, FP TotalAngle, FP PerAngle, FP IntervalTime)
	{
		FP amount = TotalAngle / PerAngle + 1;
		FP rotation = TotalAngle / 2;
		TSVector2 curPos = GetPosition();
		TSVector2 curFor = GetForward();
		for (int i = 0; i < amount; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(curPos, RotateTo(curFor, rotation), TSVector2.up * Radius);
			if (QueryPositionReachable(_actor, position))
			{
				PlayAreaEffect(effectKey_TriggerFanBlast, position);
			}
			rotation -= PerAngle;
			yield return WaitTime(IntervalTime);
		}
	}
}
