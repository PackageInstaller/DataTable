using AIScript.DynamicLevel;

namespace AIScript.Monster.TowerDefense;

public class IState
{
	private fsmStatus fsmStatus;

	public TowerDefenseCharacterActor _actor;

	public bool IsEnd => fsmStatus == fsmStatus.Exit;

	public void Init(TowerDefenseCharacterActor actor)
	{
		_actor = actor;
	}

	public virtual void Enter()
	{
		fsmStatus = fsmStatus.Enter;
	}

	public virtual void Update()
	{
	}

	public virtual void Exit()
	{
		fsmStatus = fsmStatus.Exit;
	}

	public virtual void ForceExit()
	{
	}
}
