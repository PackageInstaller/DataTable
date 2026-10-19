using ACT.Battle;
using ACT.Event;
using Fundamental;

namespace ACT.Config;

public class RuntimeSeverPreCondition : RuntimeStepCondition
{
	private SeverPreConditionConfig _config;

	private bool _isFinsh;

	public RuntimeSeverPreCondition(SeverPreConditionConfig config)
		: base(config)
	{
		_config = config;
	}

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TaskGroupFinsh, OnTaskGroupFinsh);
		if (Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(_config.MissionGroupId))
		{
			_isFinsh = true;
		}
	}

	private void OnTaskGroupFinsh(BaseEventContent obj)
	{
		if (obj is TaskGroupFinshEvt taskGroupFinshEvt && taskGroupFinshEvt.taskGroupId == _config.MissionGroupId)
		{
			_isFinsh = true;
		}
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TaskGroupFinsh, OnTaskGroupFinsh);
	}

	public override bool CheckCondition()
	{
		return _isFinsh;
	}
}
