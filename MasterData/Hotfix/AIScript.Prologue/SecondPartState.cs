using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Prologue;

public class SecondPartState : IState
{
	private CoroutineNode corMain;

	private CoroutineNode corEnterBattle;

	private CoroutineNode corPlaySound;

	private bool isPlaying;

	private bool isBattle2End;

	private const string VIDEO_START = "VIDEO_START";

	private const string VIDEO_FINISHED = "VIDEO_FINISHED";

	public SecondPartState(LogicEntity _entity, PrologueMgr prologueMgr)
		: base(_entity, prologueMgr)
	{
	}

	public override void Enter()
	{
		base.Enter();
		Singleton<EventDispatchManager>.Instance.AddEventListener("VIDEO_START", OnVideoStart);
		Singleton<EventDispatchManager>.Instance.AddEventListener("VIDEO_FINISHED", OnVideoFinished);
		Register(prologueMgr.runOBB, OnRun);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnNextState);
		StartCor(ref corMain, DoMainLogic());
	}

	private IEnumerator DoMainLogic()
	{
		while (!isPlaying)
		{
			yield return null;
		}
		new TSVector2(prologueMgr.battle2StartPoint.position.x, prologueMgr.battle2StartPoint.position.z);
		if (playerActor.visualControl != null && playerActor.visualControl.interactiveEnvPawn != null)
		{
			playerActor.visualControl.interactiveEnvPawn.Active();
		}
		SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon = playerActor.transform;
		SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		yield return 1.5f;
		SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = true;
		SceneSingleton<AdventureIndicatorController>.Instance.StartHintAttackRangeGraphic();
		MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_AttackRange");
		while (!isBattle2End)
		{
			yield return null;
		}
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		TSVector2 targetPos = new TSVector2(prologueMgr.climbStartPos.position.x, prologueMgr.climbStartPos.position.z);
		TSVector2 dir = targetPos - playerActor.tsTransform.Position;
		playerActor.LookAtDir(dir, 0);
		yield return null;
		playerActor.InterruptAttack(force: true);
		playerActor.PlayComboByKey(PrologueConfig.combo_unfire_look);
		playerActor.SwithToUnBattle(PrologueConfig.fadeTime);
		yield return PrologueConfig.time_DelayBorn;
		dir = (targetPos - playerActor.tsTransform.Position).normalized;
		TSVector2 tSVector = dir * PrologueConfig.dis_Born + playerActor.tsTransform.Position;
		monsterActor.tsTransform.Position = tSVector;
		monsterActor.tsTransform.PositionY = CommonHelper.GetTerrainHeight(tSVector, 0);
		monsterActor.tsTransform.Forward = dir;
		monsterActor.Teleport(tSVector);
		monsterActor.ShowSelf(flage: true);
		monsterActor.PlayComboByKey(PrologueConfig.combo_born, () =>
		{
		});
		yield return PrologueConfig.bornTime;
		SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		Exit();
	}

	private void OnRun(WorldOBB worldOBB)
	{
		playerActor.SetSpeed(PrologueConfig.playSpeed_2);
	}

	private void OnNextState(IEvent evt)
	{
		if (!(evt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger))
		{
			return;
		}
		if (adventureInteractiveIDTrigger.interactiveID.Equals("SeeSignPost"))
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		}
		else if (adventureInteractiveIDTrigger.interactiveID.Equals("Skill_Open"))
		{
			List<string> btnList = new List<string> { "Fire2" };
			CommonHelper.EnableSkillInput(enable: true, btnList);
			MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_Index", 22);
		}
		else if (adventureInteractiveIDTrigger.interactiveID.Equals("SeePostAnime"))
		{
			SceneSingleton<AdventureIndicatorController>.Instance.StartHintAttackRangeGraphic();
			playerActor.SwithToBattle(0.1f);
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
			if (playerActor.visualControl != null && playerActor.visualControl.interactiveEnvPawn != null)
			{
				playerActor.visualControl.interactiveEnvPawn.Deactive();
			}
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_inCS");
			MonoSingleton<LuaManager>.Instance.FireEvent("Prologue_EventUpload", "3");
			MonoSingleton<LuaManager>.Instance.FireEvent("OpenPanel", PrologueConfig.ProVideoGUI, PrologueConfig.videoUrl_middle, a3: false, PrologueConfig.transDuration, a5: true, PrologueConfig.fadeDuration, PrologueConfig.videoUrl_middle_skip, a8: true);
		}
		else if (adventureInteractiveIDTrigger.interactiveID.Equals(PrologueConfig.interactID_battle2End))
		{
			isBattle2End = true;
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologuel_combatEnd_setState");
			SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = false;
		}
	}

	private IEnumerator DoPlaySound()
	{
		yield return PrologueConfig.video_triggerTime;
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologue_secondCombat_setState");
	}

	protected void OnVideoStart(IEvent evt)
	{
		StartCor(ref corPlaySound, DoPlaySound());
	}

	protected void OnVideoFinished(IEvent evt)
	{
		bool flag = false;
		GeneralEvent generalEvent = (GeneralEvent)evt;
		if (generalEvent != null)
		{
			flag = (bool)generalEvent.data;
		}
		if (flag)
		{
			StopCor(ref corEnterBattle);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologuel_skip_setState");
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("Prologue_EventUpload", "4");
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_outCS");
		Singleton<InteractiveManager>.Instance.triggerOpListener("MonsterWave_2");
		isPlaying = true;
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologuel_explore_setState");
	}

	public override void Exit()
	{
		base.Exit();
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("VIDEO_START", OnVideoStart);
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("VIDEO_FINISHED", OnVideoFinished);
		AdventureTargetBlob.onAttackRangeGraphicStateChange = null;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("INTERACTIVEID", OnNextState);
		StopCor(ref corMain);
		StopCor(ref corPlaySound);
		StopCor(ref corEnterBattle);
		prologueMgr.ChangeState(PrologueMgr.Status.ThirdPart);
	}
}
