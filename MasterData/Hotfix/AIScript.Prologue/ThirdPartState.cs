using System.Collections;
using TrueSync;

namespace AIScript.Prologue;

public class ThirdPartState : IState
{
	private CoroutineNode corNpcGuild;

	private CoroutineNode corTrun;

	private CoroutineNode corClimb;

	private bool isClimbing;

	private const string VIDEO_FINISHED = "VIDEO_FINISHED";

	public ThirdPartState(LogicEntity _entity, PrologueMgr prologueMgr)
		: base(_entity, prologueMgr)
	{
	}

	public override void Enter()
	{
		base.Enter();
		Singleton<EventDispatchManager>.Instance.AddEventListener("VIDEO_FINISHED", OnVideoFinished);
		Register(prologueMgr.climbOBB, OnClimb);
		Register(prologueMgr.endOBB_3, OnEnd);
		Register(prologueMgr.sandstormOBB, OnSandStormStart);
		playerActor.SetSpeed(4.2);
		monsterActor.SetSpeed(4.2);
		StartCor(ref corNpcGuild, DoNpcGuild());
		MonoSingleton<LuaManager>.Instance.FireEvent("ProloguelEnableBtnControl", 2, a2: false);
	}

	private IEnumerator DoNpcGuild()
	{
		TSVector2 targetPos = new TSVector2(prologueMgr.climbStartPos.position.x, prologueMgr.climbStartPos.position.z);
		bool firstMoveEnd = false;
		while (true)
		{
			FP fP = TSMath.Abs(TSVector2.Dot(playerActor.tsTransform.Position - monsterActor.tsTransform.Position, new TSVector2(0.21, 0.98)));
			if (fP < PrologueConfig.wait_move_3)
			{
				monsterActor.MoveTo(targetPos, 0.1);
			}
			else if (fP > PrologueConfig.wait_idle_3)
			{
				monsterActor.StandBy();
			}
			if (TSVector2.Distance(targetPos, monsterActor.tsTransform.Position) <= 0.3 && !firstMoveEnd)
			{
				monsterActor.StandBy();
				targetPos = new TSVector2(prologueMgr.climbEndPos.position.x, prologueMgr.climbEndPos.position.z);
				firstMoveEnd = true;
			}
			yield return null;
		}
	}

	private void OnSandStormStart(WorldOBB worldOBB)
	{
		playerActor.TriggerStage(3);
		playerActor.SetAnimMaxSpd(PrologueConfig.maxSpd_3);
		playerActor.SetSpeed(PrologueConfig.playSpeed_3_move);
		monsterActor.SetSpeed(PrologueConfig.npcSpeed_3);
	}

	private void OnClimb(WorldOBB worldOBB)
	{
		StartCor(ref corClimb, DoClimb(worldOBB));
	}

	private IEnumerator DoClimb(WorldOBB worldOBB)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", "BBm00_01", 8);
		isClimbing = true;
		playerActor.TriggerStage(4);
		playerActor.SetSpeed(PrologueConfig.playSpeed_3_climb);
		TSVector2 normalized = (new TSVector2(prologueMgr.EndPos.position.x, prologueMgr.EndPos.position.z) - playerActor.tsTransform.Position).normalized;
		playerActor.FixedMoveDir = normalized;
		playerActor.IsFixedMoveDir = true;
		yield return 20f;
		MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", "BBm00_01", 9);
	}

	public override void Update()
	{
		base.Update();
		if (!SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() || !isClimbing)
		{
			return;
		}
		if (TSMath.Abs(TSVector2.SignedAngle(SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection(), playerActor.tsTransform.Forward)) < PrologueConfig.offsetAngleY)
		{
			playerActor.forceStandBy = false;
			return;
		}
		playerActor.forceStandBy = true;
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		playerActor.PlayComboByKey(PrologueConfig.combo_notBack, () =>
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		}, () =>
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		});
		MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", PrologueConfig.bubbleID3, PrologueConfig.bubbleGroupID3);
	}

	private void OnEnd(WorldOBB worldOBB)
	{
		StartCor(ref corClimb, DoEnd(worldOBB));
	}

	private IEnumerator DoEnd(WorldOBB worldOBB)
	{
		isClimbing = false;
		playerActor.IsFixedMoveDir = false;
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		bool flage = false;
		TSVector2 targetPosition = new TSVector2(prologueMgr.EndPos.position.x, prologueMgr.EndPos.position.z);
		playerActor.MoveTo(targetPosition, 0.1, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
		{
			flage = true;
		}, randomMove: false, forceMove: true);
		while (!flage)
		{
			yield return null;
		}
		playerActor.PlayComboByKey(PrologueConfig.combo_stop, () =>
		{
		});
		yield return 1f;
		MonoSingleton<LuaManager>.Instance.FireEvent("OpenPanel", PrologueConfig.ProVideoGUI, PrologueConfig.videoUrl_end, a3: true, PrologueConfig.transDuration, a5: false, 0, PrologueConfig.videoUrl_end_skip);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_inCS");
		SceneSingleton<AdventureIndicatorController>.Instance.StopHintAttackRangeGraphic();
	}

	protected void OnVideoFinished(IEvent evt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Prologue_EventUpload", "5");
		CommonHelper.EnableSkillInput(enable: true);
		MonoSingleton<LuaManager>.Instance.FireEvent("ProloguelEnableBtnControl", 2, a2: true);
		SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon = prologueMgr.cacheCameraBeacon;
		MonoSingleton<LuaManager>.Instance.FireEvent("MainBattleMenuBtnPauseActive", a1: true);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologuel_all_stop");
		MonoSingleton<LuaManager>.Instance.FireEvent("LevelStateChanged", 3, 0);
		Singleton<InteractiveManager>.Instance.triggerOpListener("PrologueNextFloor");
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_outCS");
	}

	public override void Exit()
	{
		base.Exit();
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("VIDEO_FINISHED", OnVideoFinished);
		StopCor(ref corClimb);
		StopCor(ref corTrun);
	}
}
