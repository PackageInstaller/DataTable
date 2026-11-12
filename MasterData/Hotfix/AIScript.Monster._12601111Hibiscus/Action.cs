using AdventureBehaviour;

namespace AIScript.Monster._12601111Hibiscus;

public class Action : AIBase
{
	private readonly int normalSkillId = 12610001;

	private readonly int normalPhaseCount = 3;

	private PlayerAdventureActor mainCtrActor;

	private int curNormalPhase;

	private bool isRunSkill;

	public void OnEnable()
	{
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		curNormalPhase = 0;
		isRunSkill = false;
		_actor.EnableCloseBlock();
	}

	public void OnDisable()
	{
		mainCtrActor = null;
	}

	public void OnStart()
	{
	}

	public void OnStop()
	{
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void MainLoop()
	{
		_actor.monsterTarget = GetAttackTarget();
		if (!isRunSkill && _actor.monsterTarget != null)
		{
			RunSkill();
		}
		if (_actor.monsterTarget == null)
		{
			ResetNormalPharse();
		}
	}

	private void DoRunSkill()
	{
		if (_actor.monsterTarget != null)
		{
			RunSkill();
		}
	}

	private void RunSkill()
	{
		isRunSkill = true;
		curNormalPhase = curNormalPhase % normalPhaseCount + 1;
		_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
		_actor.LookAt(_actor.monsterTarget.tsTransform.Position, 0);
		ILRuntimeAPI.CreateSkill(normalSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			if (_actor.actorHealthInfo.isAlive)
			{
				isRunSkill = false;
				DoRunSkill();
			}
		});
	}

	private void ResetNormalPharse()
	{
		curNormalPhase = 0;
	}

	private LogicEntity GetAttackTarget()
	{
		return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
	}
}
