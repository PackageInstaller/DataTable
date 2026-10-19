using System;
using ACT.Battle;
using ACT.Config;
using ACT.Utility;

namespace ACT.Model;

public class HighlightStepData : GuideStepData
{
	private FindHighlightObjAction _findAction;

	private InputKey _inputKey;

	private bool _clickAnywhere;

	private LocalizeStringData _textLocalizeData;

	private int _guideTutorialDesId;

	private HighlightGuideStepTextPosType _textPosType;

	private int _targetLevel;

	private HighlightGuideSkipPosType _skipbtnPosType;

	public FindHighlightObjAction FindAction => _findAction;

	public InputKey InputKey => _inputKey;

	public bool ClickAnywhere => _clickAnywhere;

	public LocalizeStringData TextLocalizeData => _textLocalizeData;

	public int GuideTutorialDesId => _guideTutorialDesId;

	public HighlightGuideStepTextPosType TextPosType => _textPosType;

	public int TargetLevel => _targetLevel;

	public HighlightGuideSkipPosType SkipBtnPosTypeType => _skipbtnPosType;

	public HighlightStepData(HighlightStepConfig config, int index)
		: base(config, index)
	{
		if (config.findAction != null)
		{
			_findAction = (FindHighlightObjAction)Activator.CreateInstance(config.findAction?.GetType(), config.findAction);
		}
		_successCondition = new HighlightSC();
		_clickAnywhere = config.clickAnywhere;
		_skipbtnPosType = config.SkipPosType;
		_guideTutorialDesId = config.guideTutorialDesId;
		_textPosType = config.textPosType;
	}

	public override void OnStart()
	{
	}

	public override void OnFinish()
	{
	}
}
