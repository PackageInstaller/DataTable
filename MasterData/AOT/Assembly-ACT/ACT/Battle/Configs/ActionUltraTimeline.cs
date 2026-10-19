using System.Collections.Generic;
using ACT.Event;
using ACT.Model;
using ACT.Rendering;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行大招Timeline", "Action", new string[] { "ultra", "timeline", "motion" })]
public class ActionUltraTimeline : ActionPlayTimeline
{
	private struct AppliedTimer
	{
		public Entity target;

		public TimeType type;

		public TimeSpeedTimer timer;
	}

	public bool useRootDir = true;

	public bool hideScene = true;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Precache(List<YooAssetReference> addlist)
	{
		base.Precache(addlist);
	}

	public override async void Do(ActionMemory memory)
	{
		if (!Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.CharacterUltraTimeline))
		{
			return;
		}
		MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.CharacterUltraTimeline);
		Entity entity = memory.caster;
		entity.GetCompEffect().bInUltraTimeline = true;
		entity.GetCompPhysics()?.ClearVelocity();
		Singleton<GameState>.instance.GameControlStateMachine.EnterState(GameControlState.Skill);
		MonoECS.instance.PushPauseAllInput();
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Player_Vibrate);
		timeline.dontSyncPosition = false;
		GameObject light = GameUtility.mainLight.gameObject;
		if (light != null)
		{
			light.SetActive(value: false);
		}
		GameManager.timeSystem.ForceChangeGlobalSpeed(1f);
		if (entity.TryGetCompTime(out CompTime component))
		{
			component.ClearSpeedTimer(TimeType.Witch);
		}
		List<AppliedTimer> _appliedTimers = new List<AppliedTimer>();
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			if (allEntity != entity && allEntity.TryGetCompTime(out CompTime component2))
			{
				TimeSpeedTimer timeSpeedTimer = GameManager.timeSystem.timerPool.Get();
				timeSpeedTimer.InitTimer(0f, -1f);
				component2.AddSpeedTimer(TimeType.Witch, timeSpeedTimer);
				_appliedTimers.Add(new AppliedTimer
				{
					target = allEntity,
					type = TimeType.Witch,
					timer = timeSpeedTimer
				});
			}
		}
		TimeSpeedTimer timeSpeedTimer2 = GameManager.timeSystem.timerPool.Get();
		timeSpeedTimer2.InitTimer(0f, -1f);
		entity.GetCompTime()?.AddSpeedTimer(TimeType.Ability, timeSpeedTimer2);
		CompBehave compBehave = entity.GetCompBehave();
		compBehave?.EntityTags.AddTag(EntityTag.IgnoreAttack);
		timeline.Init(memory);
		GameRenderScene.Set(GameRenderScene.Scene.UltraCutscene);
		if (!hideScene)
		{
			await timeline.DoTimeline();
		}
		else
		{
			Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var battleMainController);
			((BattleMainUIController)battleMainController).HideCanvas();
			MonoECS.instance.HideScene(entity, state: true);
			await timeline.DoTimeline();
			MonoECS.instance.HideScene(entity, state: false);
			((BattleMainUIController)battleMainController).ShowCanvas();
		}
		MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.CharacterUltraTimeline);
		GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtUltraTimelineOver evt = abilitySystem.GetEvt<EvtUltraTimelineOver>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		abilitySystem.FireDamageableEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		UltraEvent evt2 = Singleton<EventManager>.instance.GetEvt<UltraEvent>();
		evt2.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnUltra, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
		if (light != null)
		{
			light.SetActive(value: true);
		}
		for (int num = _appliedTimers.Count - 1; num >= 0; num--)
		{
			AppliedTimer appliedTimer = _appliedTimers[num];
			if (appliedTimer.target.TryGetCompTime(out CompTime component3))
			{
				component3.RemoveSpeedTimer(appliedTimer.type, appliedTimer.timer);
				component3.UpdateTimeScale(appliedTimer.type);
			}
		}
		_appliedTimers.Clear();
		entity.GetCompTime()?.ClearSpeedTimer(TimeType.Ability);
		entity.GetCompEffect().bInUltraTimeline = false;
		compBehave?.EntityTags.RemoveTag(EntityTag.IgnoreAttack);
		MonoECS.instance.PopPauseAllInput();
		Singleton<GameState>.instance.GameControlStateMachine.ExitState(GameControlState.Skill);
	}
}
