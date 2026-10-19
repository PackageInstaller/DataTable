using System;
using ACT.Config;

namespace ACT.Model;

public class EffectShowStepData : GuideStepData
{
	private FindHighlightObjAction _findAction;

	public FindHighlightObjAction FindAction => _findAction;

	public EffectShowStepData(EffectShowStepConfig config, int index)
		: base(config, index)
	{
		if (config.findAction != null)
		{
			_findAction = (FindHighlightObjAction)Activator.CreateInstance(config.findAction?.GetType(), config.findAction);
		}
		_successCondition = new SoftHighlightSC();
	}

	public override void OnStart()
	{
	}

	public override void OnFinish()
	{
	}
}
