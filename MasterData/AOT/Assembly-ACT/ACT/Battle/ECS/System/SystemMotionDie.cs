using System;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class SystemMotionDie : EntitySystem
{
	public const float FORCE_DIE_TIME = 7f;

	private bool _pauseInput;

	private Filter _filter;

	private EntityAction<CompAbility, CompMotion> _fixedUpdateEntityAction;

	public override Filter MajorFilter => _filter;

	internal float DeathLogicTime { get; private set; }

	private void TickDeathLogicTime()
	{
		SystemTime timeSystem = GameManager.timeSystem;
		DeathLogicTime += Time.fixedDeltaTime * timeSystem.globalSpeed * timeSystem.LogicSpeed;
	}

	protected override void OnCreate()
	{
		DeathLogicTime = 0f;
		_filter = World.NewFilter().All<CompTransform, CompTime, CompInput, CompMotion, CompPhysics, CompEffect>().Build();
		_fixedUpdateEntityAction = FixedUpdateEntity;
	}

	public override void FixedUpdate()
	{
		TickDeathLogicTime();
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (MPPlayer.local != null && MonoECS.instance != null && mainEntity.IsValid && mainEntity.IsLogicAvailable())
		{
			bool localPlayerAlive = MPPlayer.local.GetLocalPlayerAlive();
			if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal && !localPlayerAlive && Singleton<GameState>.instance.CanEnterPlayerLiveState(PlayerLiveState.Die))
			{
				MonoECS.instance.playState = PlayState.Death;
				Singleton<GameState>.instance.SetPlayerAliveState(PlayerLiveState.Die);
				if (Model<WildBossModel>.Interface.InWildBossBattle)
				{
					Entity currentWildBoss = Model<WildBossModel>.Interface.GetCurrentWildBoss();
					WorldBossFightEvent evt = EventTrackSolver.Instance.GetEvt<WorldBossFightEvent>();
					evt.entity = currentWildBoss;
					evt.duration = TimeSpan.FromMilliseconds(TimeManager.LocalTime.NowTimestamp - Model<WildBossModel>.Interface.InWildTimeStamp).TotalSeconds;
					evt.result = 0;
					EventTrackSolver.Instance.Dispatch(evt);
				}
			}
			IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
			if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Die)
			{
				if (topActivePanel != null && topActivePanel is BattleMainUIController { State: UIState.Opened })
				{
					if (!_pauseInput)
					{
						MonoECS.instance.PushPauseAllInput();
						_pauseInput = true;
					}
				}
				else if (_pauseInput)
				{
					MonoECS.instance.PopPauseAllInput();
					_pauseInput = false;
				}
			}
			else if (_pauseInput)
			{
				MonoECS.instance.PopPauseAllInput();
				_pauseInput = false;
			}
		}
		_filter.ForEach(_fixedUpdateEntityAction);
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.DieAnimationEnd && GameManager.timeSystem.LogicSpeed > 0f && Singleton<GameState>.instance.CanEnterPlayerLiveState(PlayerLiveState.Respawning))
		{
			IBaseUIController topActivePanel2 = Singleton<NewUIManager>.instance.GetTopActivePanel();
			if (topActivePanel2 != null && topActivePanel2.UIType == UI_TYPE.UI_BATTLEMAIN)
			{
				Singleton<GameState>.instance.SetPlayerAliveState(PlayerLiveState.Respawning);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.AllCharacterDieEnd, null);
				MonoECS.instance.playState = PlayState.UnBattle;
			}
		}
	}

	private void FixedUpdateEntity(Entity entity, CompAbility compAbility, CompMotion compMotion)
	{
		if (entity.IsTickAvailable())
		{
			RestoreInterruptedDeathMotion(compAbility, compMotion);
			if (compAbility != null && GameManager.timeSystem.LogicSpeed > 0f && DeathLogicTime - compAbility.dieStartTime > 7f && !compAbility.alive && !compMotion.DieAnimationEnd)
			{
				compMotion.DieAnimationEnd = true;
				compAbility.dieStartTime = float.MaxValue;
			}
			if (compMotion != null && compMotion.DieAnimationEnd && compAbility != null && !compAbility.alive)
			{
				EntityDieAnimEnd(entity);
			}
		}
	}

	private void RestoreInterruptedDeathMotion(CompAbility compAbility, CompMotion compMotion)
	{
		if (compAbility != null && compMotion != null && !compAbility.alive && !compMotion.DieAnimationEnd && compMotion.parameters.TryGetValue("IsDead", out var value) && !value.defaultBool)
		{
			compMotion.SetBool("IsDead", b: true);
			compMotion.SetTrigger("Die");
		}
	}

	private async void EntityDieAnimEnd(Entity entity)
	{
		if (entity.TryGetCompCharacter(out CompCharacter component))
		{
			BattleCharacterDieEvt evt = Singleton<EventManager>.instance.GetEvt<BattleCharacterDieEvt>();
			evt.targetEb = entity;
			evt.characterId = (component?.characterSource?.Id()).GetValueOrDefault();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterDie, evt);
		}
		if (entity == MonoECS.instance.mainEntity)
		{
			Singleton<GameManager>.instance.worldManager.OnCharacterDie(entity);
		}
		else if (entity.IsBehaveEntity() && !entity.IsCharacter())
		{
			MonoECS.instance.SetMonsterBehaveActive(entity, value: false);
			if (!(await UniTask.Delay(TimeSpan.FromSeconds(10.0), ignoreTimeScale: false, PlayerLoopTiming.Update, entity.GetCancellationTokenOnRelease()).SuppressCancellationThrow()))
			{
				MonoECS.instance.TryRemoveBehave(entity);
			}
		}
	}
}
