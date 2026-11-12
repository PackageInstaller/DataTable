using AIScript.Monster.Template;

namespace AIScript.Monster._31801FeiLong;

public class ParallelScript : Parallel
{
	private ParallelLogicController _logicController;

	public override void OnStart()
	{
		base.OnStart();
		_logicController = new ParallelLogicController();
		_logicController.OnEnable(_actor, isBossRush: false);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_logicController.OnDisable();
		_logicController = null;
	}
}
