using AIScript.Monster.Template;

namespace AIScript.Monster._31801FeiLong;

public class ParallelScript_BossRush : Parallel_BossRush
{
	private ParallelLogicController _logicController;

	public override void OnStart()
	{
		base.OnStart();
		_logicController = new ParallelLogicController();
		_logicController.OnEnable(_actor, isBossRush: true);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_logicController.OnDisable();
		_logicController = null;
	}
}
