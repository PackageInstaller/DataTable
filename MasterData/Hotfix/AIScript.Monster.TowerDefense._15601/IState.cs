namespace AIScript.Monster.TowerDefense._15601;

public class IState
{
	private fsmStatus fsmStatus;

	public AdventureActor _actor;

	public PlayerSkillCd _skillManage;

	public bool IsEnd => fsmStatus == fsmStatus.Exit;

	public void Init(AdventureActor actor, PlayerSkillCd skillManager)
	{
		_actor = actor;
		_skillManage = skillManager;
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
