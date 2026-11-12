using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Prologue;

public class EnterState : IState
{
	private bool isPlaying;

	private CoroutineNode corMain;

	private const string VIDEO_FINISHED = "VIDEO_FINISHED";

	public EnterState(LogicEntity _entity, PrologueMgr prologueMgr)
		: base(_entity, prologueMgr)
	{
	}

	public override void Enter()
	{
		base.Enter();
		MonoSingleton<LuaManager>.Instance.FireEvent("Prologue_EventUpload", "1");
		MonoSingleton<LuaManager>.Instance.FireEvent("MainBattleMenuBtnPauseActive", a1: false);
		playerActor.SwithAnimationGroup();
		playerActor.SwithToUnBattle(0.1f);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologuel_setState");
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_inCS");
		Singleton<EventDispatchManager>.Instance.AddEventListener("VIDEO_FINISHED", OnVideoFinished);
		MonoSingleton<LuaManager>.Instance.FireEvent("OpenPanel", PrologueConfig.ProVideoGUI, PrologueConfig.videoUrl_start, a3: false, PrologueConfig.transDuration, a5: false, 0, PrologueConfig.videoUrl_start_skip, a8: true);
		StartCor(ref corMain, DoMainLogic());
	}

	private IEnumerator DoMainLogic()
	{
		CommonHelper.EnableSkillInput(enable: false);
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		while (!isPlaying)
		{
			yield return null;
		}
		playerActor.buffComponent.AddBuff(PrologueConfig.buff, playerActor);
		playerActor.movAgent.canBlock = false;
		playerActor.EnableForbiddenRush();
		monsterActor.movAgent.canBlock = false;
		playerActor.PlayComboByKey(PrologueConfig.combo_phone, () =>
		{
			Debug.Log("==>播放完成");
		});
		yield return 0.5f;
		ProloguelevelMgr.Instance.SetVCamPriority(0);
		yield return PrologueConfig.camraTime;
		MonoSingleton<LuaManager>.Instance.FireEvent("FadeIn");
		yield return 1f;
		SceneSingleton<DeterministicCollisionManager>.Instance.UnRegisterCollider(playerActor.dtCollider, ignoreLock: true);
		SceneSingleton<DeterministicCollisionManager>.Instance.RegisterCollider(playerActor.dtCollider, ignoreLock: true);
		yield return 0.5f;
		SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_Index", 6);
		MonoSingleton<LuaManager>.Instance.FireEvent("Prologue_EventUpload", "2");
		Exit();
	}

	public override void Exit()
	{
		base.Exit();
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("VIDEO_FINISHED", OnVideoFinished);
		StopCor(ref corMain);
		prologueMgr.ChangeState(PrologueMgr.Status.FirstPart);
	}

	protected void OnVideoFinished(IEvent evt)
	{
		isPlaying = true;
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_prologuel_explore_setState");
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("desert_outCS");
	}
}
