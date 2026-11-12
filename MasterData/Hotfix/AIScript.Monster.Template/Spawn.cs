#define LOG_DEBUG
namespace AIScript.Monster.Template;

public class Spawn : AIBase
{
	protected int _skillId;

	protected bool _jumpOverPerformance;

	private bool _enterActionState;

	public void OnEnable()
	{
		_jumpOverPerformance = (_actor as MonsterAdventureActor).spawnerInfo.jumpOverSpawnPerformance;
		_enterActionState = (_actor as MonsterAdventureActor).spawnerInfo.enterActionStateWhenSpawn;
		_ = _jumpOverPerformance;
		NovaLogger.Debug("Spawned monster");
	}

	public void OnStart()
	{
		_actor.Idle();
		if (_skillId == 0)
		{
			ChangeState(success: true);
		}
	}

	private void ChangeState(bool success)
	{
		if (_enterActionState)
		{
			_actor.Action(makeThreatAlert: false);
			SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor);
		}
	}
}
