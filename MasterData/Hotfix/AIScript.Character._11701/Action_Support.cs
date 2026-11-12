#define LOG_DEBUG
namespace AIScript.Character._11701;

public class Action_Support : ActorActionBase
{
	protected PlayerSkillCd _skillManage;

	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_11701 Action_2 OnDisable");
		_skillManage = null;
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_11701 Action_2 OnEnable");
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	public void OnUpdate()
	{
	}
}
