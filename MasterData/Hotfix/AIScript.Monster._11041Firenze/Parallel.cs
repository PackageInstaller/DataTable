using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Parallel : AIBase
{
	protected LogicVariable _logicVariable;

	private CoroutineNode corSkill;

	public void OnStart()
	{
		_logicVariable = ActorHelper.GetFlowLogicVariable(_actor.gameObject);
	}

	public void OnUpdate()
	{
	}
}
