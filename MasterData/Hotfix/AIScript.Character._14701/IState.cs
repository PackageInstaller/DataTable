using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._14701;

public class IState
{
	private fsmStatus fsmStatus;

	public AdventureActor _actor;

	public PlayerSkillCd _skillManage;

	public AimTarget _aimTarget;

	public bool IsEnd => fsmStatus == fsmStatus.Exit;

	public void Init(AdventureActor actor, PlayerSkillCd skillManager, AimTarget aimTarget)
	{
		_actor = actor;
		_skillManage = skillManager;
		_aimTarget = aimTarget;
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

	public LogicEntity GetAttackTarget()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			return CommonUtils.GetAssistantAttackTarget(_actor);
		}
		return _actor.attackTarget;
	}
}
