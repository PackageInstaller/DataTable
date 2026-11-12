using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class SkillScript_Rush : SkillAdvancedBase
{
	private Skill_Rush _skillRush;

	private bool _triggerPerk_P11;

	private PlayFX _chargeFX_P11;

	private FP _chargeTime_P11;

	private PlayFX _chargeFinishFX_P11;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, Config.comboKeys_Rush, Config.comboKeys_Rush_Independent, Config.interruptTime_Rush, useSpecialRushEnd: false, Config.comboKeys_SpecialRushEnd);
		_triggerPerk_P11 = false;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515011, out var _))
		{
			return;
		}
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastTriggerTime_P11");
		if (logicTagValue <= 0 || _actor.LogicTime - logicTagValue > CommonUtils.GetScriptValue(_actor, 15011011))
		{
			_triggerPerk_P11 = true;
			if (_chargeFX_P11 == null)
			{
				_chargeFX_P11 = new PlayFX();
			}
			_chargeFX_P11.Play(_actor, _skill, "fx_15001_loop_Rush_P11_Charge", default, _actor.tsTransform.Position, default);
		}
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
		if (!_triggerPerk_P11)
		{
			return;
		}
		_chargeTime_P11 += _actor.LogicDeltaTime;
		if (_chargeTime_P11 >= Config_MainControl.chargeTime_P11)
		{
			if (_chargeFinishFX_P11 == null)
			{
				_chargeFinishFX_P11 = new PlayFX();
			}
			else if (_chargeFinishFX_P11.fxInstance == null)
			{
				_chargeFinishFX_P11.Play(_actor, _skill, "fx_15001_loop_Rush_P11_Charge_end", default, _actor.tsTransform.Position, default);
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_skillRush?.OnDisable();
		if (_triggerPerk_P11 && _chargeTime_P11 >= Config_MainControl.chargeTime_P11)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Main_Skill_P11_Boom", _actor.tsTransform.Position);
			_actor.logicVariable.SetLogicTagValue("LastTriggerTime_P11", _actor.LogicTime);
		}
		_triggerPerk_P11 = false;
		_chargeTime_P11 = 0;
		_chargeFX_P11?.Stop();
		_chargeFX_P11?.Clear();
		_chargeFinishFX_P11?.Stop();
		_chargeFinishFX_P11?.Clear();
	}
}
