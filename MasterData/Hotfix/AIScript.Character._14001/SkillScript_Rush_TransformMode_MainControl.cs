using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._14001;

public class SkillScript_Rush_TransformMode_MainControl : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] _comboKeys_Rush;

	private ComboInputBuffer.ActionKey[] _comboKeys_Rush_Independent;

	private ComboInputBuffer.ActionKey[] _comboKeys_SpecialRushEnd;

	private bool _useSpecialRushEnd;

	private FP _interruptTime_Rush;

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (InitParam())
		{
			if (_skillRush == null)
			{
				_skillRush = new Skill_Rush();
			}
			_skillRush.OnEnable(_actor, _skill, _comboKeys_Rush, _comboKeys_Rush_Independent, _interruptTime_Rush, _useSpecialRushEnd, _comboKeys_SpecialRushEnd);
		}
		else
		{
			_skill.Clear();
		}
	}

	private bool InitParam()
	{
		if (Enum.TryParse<Config_MainControl.TransformMode>(_actor.logicVariable.GetLogicTagStringValue("TransformMode"), out var result))
		{
			switch (result)
			{
			case Config_MainControl.TransformMode.Tank:
				_comboKeys_Rush = Config_MainControl.comboKeys_Rush_Tank;
				_comboKeys_Rush_Independent = Config_MainControl.comboKeys_Rush_Independent_Tank;
				_comboKeys_SpecialRushEnd = Config_MainControl.comboKeys_SpecialRushEnd_Tank;
				_useSpecialRushEnd = false;
				_interruptTime_Rush = Config_MainControl.interruptTime_Rush_Tank;
				return true;
			case Config_MainControl.TransformMode.MiniGun:
				_comboKeys_Rush = Config_MainControl.comboKeys_Rush_MiniGun;
				_comboKeys_Rush_Independent = Config_MainControl.comboKeys_Rush_Independent_MiniGun;
				_comboKeys_SpecialRushEnd = Config_MainControl.comboKeys_SpecialRushEnd_MiniGun;
				_useSpecialRushEnd = false;
				_interruptTime_Rush = Config_MainControl.interruptTime_Rush_MiniGun;
				return true;
			}
		}
		return false;
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_skillRush?.OnDisable();
	}
}
