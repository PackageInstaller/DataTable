using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class Action_Support : ActorActionBase
{
	private FP contineTime = 10.5;

	private FP attackRange = 18;

	private const int perkId_24 = 511324;

	private PlayerAdventureActor mainCtrActor;

	private IState curState;

	private TraceState traceState = new TraceState();

	private NormalAttackState normalAttackState = new NormalAttackState();

	private PlayerSkillCd skillMgr;

	private AimTarget aimTarget = new AimTarget();

	private bool inAI;

	private FP timer;

	private bool firstIn;

	private bool canMove;

	private bool inUltra;

	private TraceTarget traceTarget = new TraceTarget();

	protected override void OnActionEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		traceState.Init(_actor, skillMgr, aimTarget);
		normalAttackState.Init(_actor, skillMgr, aimTarget);
		curState = null;
		firstIn = true;
		_actor.actorInfo.moveAcceleration = 120;
		_actor.logicVariable.ToggleLogicTag("AIEnd", value: false);
		timer = 0;
		inAI = false;
		canMove = GetPerkLv(511324, out var _);
		inUltra = false;
		HotfixEnum.worldLevelType levelType = ModuleController<AdventureModuleController>.Instance.levelType;
		if (canMove && levelType != HotfixEnum.worldLevelType.InfinityTower)
		{
			string localData = (_actor as PlayerAdventureActor).GetLocalData("AILeftTime");
			if (!string.IsNullOrEmpty(localData) && CommonUtils.TryParseStringParamToInt(localData, out var intValue) && intValue > 0)
			{
				timer = contineTime - intValue;
				inAI = true;
			}
		}
	}

	protected override void OnActionDisable()
	{
		aimTarget.Cancel();
		_actor.movementMode = AdventureActor.MovementMode.Run;
		HotfixEnum.worldLevelType levelType = ModuleController<AdventureModuleController>.Instance.levelType;
		if (canMove && levelType != HotfixEnum.worldLevelType.InfinityTower)
		{
			int num = TSMath.Max(0, contineTime - timer).AsInt();
			(_actor as PlayerAdventureActor).SetLocalData("AILeftTime", num.ToString());
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		if (firstIn)
		{
			firstIn = false;
			return;
		}
		_actor.logicVariable.ToggleLogicTag("AIEnd", value: false);
		inAI = false;
		timer = 0;
	}

	public override void OnStop()
	{
		base.OnStop();
		_actor.InterruptAttack(force: true);
		if (curState != null)
		{
			curState.Exit();
			curState = null;
		}
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void MainLoop()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		if (!inAI)
		{
			return;
		}
		if (timer < contineTime)
		{
			if (curState == null)
			{
				curState = GetNextState();
				if (curState != null)
				{
					curState.Enter();
				}
			}
			else if (curState.IsEnd)
			{
				curState = GetNextState();
				if (curState != null)
				{
					curState.Enter();
				}
			}
			else
			{
				curState.Update();
			}
			if (canMove && !inUltra)
			{
				DoMove();
			}
		}
		else
		{
			StopAI();
		}
		timer += _actor.LogicDeltaTime;
	}

	private IState GetNextState()
	{
		FP fP = TSVector2.Distance(_actor.tsTransform.Position, mainCtrActor.tsTransform.Position);
		if (!_actor.logicVariable.GetLogicTagToggle("InTrace") || !(fP > Config.trace_second))
		{
			FP fP2 = _actor.DistanceWithRadius(_actor.attackTarget);
			if (attackRange > fP2)
			{
				return normalAttackState;
			}
		}
		return null;
	}

	private void DoMove()
	{
		if (TSVector2.Distance(_actor.tsTransform.Position, mainCtrActor.tsTransform.Position) > Config.trace_first)
		{
			_actor.logicVariable.ToggleLogicTag("InTrace", value: true);
			traceTarget.BeginTrace(_actor, mainCtrActor, Config.trace_stop, -1, -1, () =>
			{
				_actor.logicVariable.ToggleLogicTag("InTrace", value: false);
			}, (bool isdie, bool isInterrupt, bool _, bool _) =>
			{
				_actor.logicVariable.ToggleLogicTag("InTrace", value: false);
			}, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, null, TraceUpdate);
		}
	}

	private void TraceUpdate()
	{
		if (_actor.actorSkillManage.HaveRunningSkill())
		{
			_actor.movementMode = AdventureActor.MovementMode.Walk;
		}
		else
		{
			_actor.movementMode = AdventureActor.MovementMode.Run;
		}
	}

	protected override void OnCastSkill()
	{
		BeginAI();
		CastBindSkill(() =>
		{
			inAI = true;
		});
	}

	protected override void OnCastUltimate()
	{
		if (inAI)
		{
			inUltra = true;
			if (curState != null && curState is TraceState traceState)
			{
				traceState.ForceExit();
			}
			traceTarget.CancelTrace();
			CastBindSkill(() =>
			{
				inUltra = false;
			});
		}
		else
		{
			base.OnCastUltimate();
		}
	}

	private void BeginAI()
	{
		timer = 0;
		_actor.logicVariable.ToggleLogicTag("AIEnd", value: false);
		inAI = false;
		if (curState != null && curState is TraceState traceState)
		{
			traceState.ForceExit();
		}
		traceTarget.CancelTrace();
	}

	private void StopAI()
	{
		_actor.logicVariable.ToggleLogicTag("AIEnd", value: true);
		_actor.logicVariable.SetLogicTagValue("shootIndex", 0);
		(_actor as PlayerAdventureActor).isAssistAIFinish = true;
		inAI = false;
		if (curState != null && curState is TraceState traceState)
		{
			traceState.ForceExit();
		}
		traceTarget.CancelTrace();
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
