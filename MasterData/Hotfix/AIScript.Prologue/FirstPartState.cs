using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Prologue;

public class FirstPartState : IState
{
	private CoroutineNode corMain;

	private CoroutineNode corNpcGuild;

	private CoroutineNode corTurnDown;

	private CoroutineNode corTurnBack;

	private CoroutineNode corEnd;

	private CoroutineNode corCheckPlayerPosition;

	private bool isInTurn;

	private bool stage2;

	private bool isSlideReady;

	private Vector3 orginalGravity;

	private const string AVG_BB_END = "AVG_BB_END";

	private bool isAvgEnd;

	private ActorState lastState;

	private bool isTrigger;

	public FirstPartState(LogicEntity _entity, PrologueMgr prologueMgr)
		: base(_entity, prologueMgr)
	{
	}

	public override void Enter()
	{
		base.Enter();
		lastState = ActorState.StandBy;
		isTrigger = false;
		orginalGravity = ProloguelevelMgr.Instance.GetGravity();
		Singleton<EventDispatchManager>.Instance.AddEventListener("AVG_BB_END", OnAvgEnd);
		Register(prologueMgr.edgeOBBs, OnForceTurn);
		Register(prologueMgr.endOBB_1, OnEnd);
		StartCor(ref corMain, DoMainLogic());
		StartCor(ref corCheckPlayerPosition, CheckPlayerMove());
	}

	private IEnumerator DoMainLogic()
	{
		stage2 = false;
		isSlideReady = false;
		playerActor.SetAnimMaxSpd(PrologueConfig.maxSpd_1);
		playerActor.SetSpeed(PrologueConfig.playSpeed_1);
		monsterActor.SetSpeed(PrologueConfig.npcSpeed_1);
		StartCor(enumerator: DoNpcGuild(new TSVector2(prologueMgr.npcTargetPos.position.x, prologueMgr.npcTargetPos.position.z)), cor: ref corNpcGuild);
		yield return 1f;
		MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", "BBm00_01", 1);
		while (!isAvgEnd)
		{
			yield return null;
		}
		if (!stage2)
		{
			stage2 = true;
			yield return 6f;
			playerActor.TriggerStage(2);
			playerActor.SetAnimMaxSpd(PrologueConfig.maxSpd_2);
			playerActor.HidePhone();
		}
	}

	private IEnumerator CheckPlayerMove()
	{
		bool isMoving = false;
		bool isFirstMove = false;
		FP countTime = 0;
		TSVector2 position = playerActor.tsTransform.Position;
		while (true)
		{
			if (!isFirstMove)
			{
				if (position != playerActor.tsTransform.Position)
				{
					isFirstMove = true;
					isMoving = true;
				}
				yield return null;
				continue;
			}
			if (isMoving)
			{
				countTime = 0;
				position = playerActor.tsTransform.Position;
				yield return null;
				if (position == playerActor.tsTransform.Position)
				{
					isMoving = false;
				}
				continue;
			}
			if (position != playerActor.tsTransform.Position)
			{
				isMoving = true;
			}
			countTime += (FP)0.03;
			if (countTime >= 10)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_Index", 6);
				isTrigger = false;
				isFirstMove = false;
				countTime = 0;
			}
			yield return null;
		}
	}

	protected void OnAvgEnd(IEvent evt)
	{
		GeneralEvent generalEvent = (GeneralEvent)evt;
		if (generalEvent == null)
		{
			return;
		}
		string[] array = ((string)generalEvent.data).Split('|');
		if (array.Length != 0)
		{
			_ = array[0];
			string obj = array[1];
			if (obj == "1" && !isSlideReady)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", "BBm00_01", 2);
			}
			if (obj == "2" && !isSlideReady)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", "BBm00_01", 4);
				isAvgEnd = true;
			}
		}
	}

	private IEnumerator DoNpcGuild(TSVector2 targetPos)
	{
		isInTurn = false;
		while (true)
		{
			FP fP = TSMath.Abs(TSVector2.Dot(playerActor.tsTransform.Position - monsterActor.tsTransform.Position, new TSVector2(-0.8, 0.6)));
			if (fP < PrologueConfig.wait_move)
			{
				monsterActor.MoveTo(targetPos, 0.1);
			}
			else if (fP > PrologueConfig.wait_idle && !isSlideReady)
			{
				monsterActor.StandBy();
			}
			if (fP > PrologueConfig.wait_turnback && !isInTurn && !isSlideReady)
			{
				isInTurn = true;
				StartCor(ref corTurnBack, DoTurnBack());
			}
			yield return null;
		}
	}

	private IEnumerator DoTurnBack()
	{
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		playerActor.StandBy();
		TSVector2 dir = (playerActor.tsTransform.Position - monsterActor.tsTransform.Position).normalized;
		bool flage = false;
		playerActor.LookAtDir(dir, 0, () =>
		{
			flage = true;
		});
		while (!flage)
		{
			yield return null;
		}
		playerActor.PlayComboByKey(stage2 ? PrologueConfig.combo_turnBack : PrologueConfig.combo_turnBack0, () =>
		{
		});
		yield return PrologueConfig.time_1;
		playerActor.InterruptAttack(force: true, fadeOutAnim: false);
		TSVector2 targetPosition = playerActor.tsTransform.Position + -dir * PrologueConfig.moveDis_1;
		playerActor.MoveTo(targetPosition, 0.1, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
			isInTurn = false;
		}, randomMove: false, forceMove: true);
	}

	private void OnForceTurn(WorldOBB worldOBB)
	{
		StartCor(ref corTurnDown, DoTurnDown(worldOBB));
	}

	private IEnumerator DoTurnDown(WorldOBB worldOBB)
	{
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		playerActor.StandBy();
		TSVector2 dir = playerActor.tsTransform.Forward.normalized;
		playerActor.PlayComboByKey(stage2 ? PrologueConfig.combo_turnDown : PrologueConfig.combo_turnDown0, () =>
		{
		});
		yield return PrologueConfig.time_2;
		playerActor.InterruptAttack(force: true, fadeOutAnim: false);
		TSVector2 targetPosition = playerActor.tsTransform.Position + -dir * PrologueConfig.moveDis_2;
		playerActor.MoveTo(targetPosition, 0.1, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		}, randomMove: false, forceMove: true);
	}

	private void OnEnd(WorldOBB worldOBB)
	{
		StartCor(ref corEnd, DoSlide(worldOBB));
	}

	private IEnumerator DoSlide(WorldOBB worldOBB)
	{
		isSlideReady = true;
		if (!stage2)
		{
			stage2 = true;
		}
		monsterActor.SetSpeed(PrologueConfig.npcSpeed_1_2);
		ProloguelevelMgr.Instance.SetGravity(new Vector3(0f, (float)PrologueConfig.gravity, 0f));
		playerActor.SetSpeed(PrologueConfig.playSpeed_1_2);
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		playerActor.StandBy();
		if (!isAvgEnd)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleShow", "BBm00_01", 3);
		}
		bool flage = false;
		TSVector2 targetPosition = new TSVector2(prologueMgr.preSlidePos.position.x, prologueMgr.preSlidePos.position.z);
		playerActor.MoveTo(targetPosition, 0.1, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
		{
			flage = true;
		});
		yield return 1f;
		StopCor(ref corNpcGuild);
		monsterActor.LookAtDir(PrologueConfig.slideDir, 0);
		yield return 1f;
		TSVector2 StartPos2 = new TSVector2(-33.65, -26.5);
		monsterActor.PlayComboByKey(PrologueConfig.combo_slope2, () =>
		{
			monsterActor.SyncMovementLocation(StartPos2, CommonHelper.GetTerrainHeight(StartPos2, 0), monsterActor.tsTransform.Rotation);
			Debug.Log("==>蝴蝶滑沙动作播放完成");
		});
		playerActor.TriggerStage(2);
		playerActor.SetAnimMaxSpd(PrologueConfig.maxSpd_2);
		while (!flage)
		{
			yield return null;
		}
		TSVector2 slideDir = PrologueConfig.slideDir;
		FP duration = TSVector2.Angle(slideDir, playerActor.tsTransform.Forward) / PrologueConfig.rotSpd_2;
		flage = false;
		playerActor.LookAtDir(slideDir, duration, () =>
		{
			flage = true;
		});
		while (!flage)
		{
			yield return null;
		}
		playerActor.PlayComboByKey(PrologueConfig.combo_slope, () =>
		{
			Debug.Log("==>播放完成");
		});
		playerActor.HidePhone();
		yield return PrologueConfig.slideTime - 4;
		ProloguelevelMgr.Instance.SetGravity(orginalGravity);
		monsterActor.MoveTo(new TSVector2(-28.6, -1.25), 0.1, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
		{
			monsterActor.ShowSelf(flage: false);
			Singleton<InteractiveManager>.Instance.triggerOpListener("ActivePost");
		});
		yield return 4f;
		SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		Exit();
	}

	public override void Update()
	{
		base.Update();
		if (!isTrigger)
		{
			if (playerActor.movementState == ActorState.Move && lastState == ActorState.StandBy)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Prologue_Move");
				isTrigger = true;
			}
			lastState = playerActor.movementState;
		}
	}

	public override void Exit()
	{
		base.Exit();
		ProloguelevelMgr.Instance.SetGravity(orginalGravity);
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("AVG_BB_END", OnAvgEnd);
		StopCor(ref corMain);
		StopCor(ref corTurnDown);
		StopCor(ref corTurnBack);
		StopCor(ref corNpcGuild);
		StopCor(ref corEnd);
		StopCor(ref corCheckPlayerPosition);
		prologueMgr.ChangeState(PrologueMgr.Status.SencondPart);
	}
}
