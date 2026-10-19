using ACT.Battle;

namespace ACT.Config;

public class RuntimeInteractStateCondition : RuntimeStepCondition
{
	private InteractStateConditionConfig _config;

	private bool _isFinsh;

	public RuntimeInteractStateCondition(InteractStateConditionConfig config)
		: base(config)
	{
		_config = config;
	}

	public override void Init()
	{
	}

	public override void UnInit()
	{
	}

	public override bool CheckCondition()
	{
		if (!MonoECS.instance)
		{
			return false;
		}
		if (MonoECS.instance.ruleManager == null)
		{
			return false;
		}
		return MonoECS.instance.ruleManager.GetInteractAssetState(_config.interactStates.uid) == _config.interactStates.stateId;
	}
}
