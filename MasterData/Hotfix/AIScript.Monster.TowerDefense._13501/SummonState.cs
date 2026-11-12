namespace AIScript.Monster.TowerDefense._13501;

public class SummonState
{
	private SummonFsmStatus fsmStatus;

	public AdventureActor _actor;

	public PlayerSkillCd _skillManage;

	public bool IsEnd => fsmStatus == SummonFsmStatus.Exit;

	public void Init(AdventureActor actor, PlayerSkillCd skillManager)
	{
		_actor = actor;
		_skillManage = skillManager;
	}

	public virtual void Enter()
	{
		fsmStatus = SummonFsmStatus.Enter;
	}

	public virtual void Update()
	{
	}

	public virtual void Exit()
	{
		fsmStatus = SummonFsmStatus.Exit;
	}

	public virtual void ForceExit()
	{
	}
}
