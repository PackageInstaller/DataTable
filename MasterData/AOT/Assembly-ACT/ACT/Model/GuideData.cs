using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Utility;

namespace ACT.Model;

public class GuideData
{
	private int _id;

	private List<GuideStepData> _stepData = new List<GuideStepData>();

	public int _curStepIndex;

	public int _finishStepIndex;

	public GuideStepType _guideType;

	public GuideStepCondition[] Conditions;

	private GuideFinshCondition[] _finshConditions;

	public bool _isNeedSkip;

	public GuideStepAction[] Actions;

	public GuideStepAction[] FinshActions;

	public int Id => _id;

	public bool CheckAnyFinshCondition()
	{
		return CheckAnyFinshCondition(_finshConditions);
	}

	public static bool CheckAnyFinshCondition(GuideFinshCondition[] conditions)
	{
		if (conditions == null)
		{
			return false;
		}
		for (int i = 0; i < conditions.Length; i++)
		{
			if (conditions[i] != null && conditions[i].CheckCondition())
			{
				return true;
			}
		}
		return false;
	}

	public GuideData(GuideConfig config, bool isPc)
	{
		_id = config.id;
		List<GuideStepConfig> stepConfigsByCurrentInput = GetStepConfigsByCurrentInput(config, isPc, out _finishStepIndex);
		_guideType = config.guideType;
		Conditions = config.Conditions;
		_finshConditions = config.FinshConditions;
		_isNeedSkip = config.IsNeedSkip;
		Actions = config.Actions;
		FinshActions = config.FinshActions;
		for (int i = 0; i < stepConfigsByCurrentInput.Count; i++)
		{
			GuideStepConfig guideStepConfig = stepConfigsByCurrentInput[i];
			if (!(guideStepConfig is HighlightStepConfig))
			{
				if (!(guideStepConfig is ImageStepConfig))
				{
					if (!(guideStepConfig is VideoStepConfig))
					{
						if (!(guideStepConfig is SoftHighlightStepConfig))
						{
							if (guideStepConfig is EffectShowStepConfig)
							{
								_stepData.Add(new EffectShowStepData(stepConfigsByCurrentInput[i] as EffectShowStepConfig, i));
							}
						}
						else
						{
							_stepData.Add(new SoftHighlightStepData(stepConfigsByCurrentInput[i] as SoftHighlightStepConfig, i));
						}
					}
					else
					{
						_stepData.Add(new VideoStepData(stepConfigsByCurrentInput[i] as VideoStepConfig, i));
					}
				}
				else
				{
					_stepData.Add(new ImageStepData(stepConfigsByCurrentInput[i] as ImageStepConfig, i));
				}
			}
			else
			{
				_stepData.Add(new HighlightStepData(stepConfigsByCurrentInput[i] as HighlightStepConfig, i));
			}
		}
		_curStepIndex = -1;
	}

	private List<GuideStepConfig> GetStepConfigsByCurrentInput(GuideConfig config, bool isPc, out int finishStepIndex)
	{
		if (config.guideType == GuideStepType.Highlight)
		{
			switch (MonoECS.instance.InputMode)
			{
			case DeviceInputMode.KeyboardAndMouse:
				finishStepIndex = config.pcFinishStepIndex;
				return config.pcStepConfigs;
			case DeviceInputMode.Gamepad:
				finishStepIndex = config.handshankFinishStepIndex;
				return config.handshankStepConfigs;
			case DeviceInputMode.TouchScreen:
				finishStepIndex = config.mobileFinishStepIndex;
				return config.mobileStepConfigs;
			}
		}
		if (isPc)
		{
			finishStepIndex = config.pcFinishStepIndex;
			return config.pcStepConfigs;
		}
		finishStepIndex = config.mobileFinishStepIndex;
		return config.mobileStepConfigs;
	}

	public bool ToNextStep(out GuideStepData stepData)
	{
		List<GuideStepData> stepData2 = _stepData;
		if (stepData2 == null || stepData2.Count <= 0 || _curStepIndex >= _stepData.GetLastIndex())
		{
			stepData = null;
			return false;
		}
		stepData = _stepData[++_curStepIndex];
		return true;
	}

	public GuideStepData GetStepByIndex(int stepIndex)
	{
		List<GuideStepData> stepData = _stepData;
		if (stepData == null || stepData.Count <= 0 || stepIndex > _stepData.GetLastIndex())
		{
			return null;
		}
		return _stepData[stepIndex];
	}

	public bool ToFirstStep(out GuideStepData stepData)
	{
		List<GuideStepData> stepData2 = _stepData;
		if (stepData2 == null || stepData2.Count <= 0)
		{
			stepData = null;
			return false;
		}
		stepData = _stepData[0];
		return true;
	}
}
