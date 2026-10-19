using System;
using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class SystemTime : EntitySystem
{
	[Serializable]
	public struct ConfigChangeGlobalSpeed
	{
		public float duration;

		public float easeTime;

		public float speed;
	}

	public float m_OverheadTimeOfThisFrame;

	private float logicSpeed = 1f;

	public AllianceSpeedTimer globalTimer;

	public AllianceSpeedTimer[] allianceTimer;

	public ObjectPool<TimeSpeedTimer> timerPool;

	private Filter _filter;

	private EntityAction<CompTime> _fixedUpdateBehaveAction;

	private EntityAction<CompTime> _updateTimeCameraScaleAction;

	private EntityAction _pauseEffectAction;

	private EntityAction<CompTime> _resumeEffectAction;

	private readonly List<TimeSpeedTimer> _worldRuntimeSpeedTimers = new List<TimeSpeedTimer>();

	private float _worldRuntimeSpeed = 1f;

	public float LogicSpeed => logicSpeed;

	public float globalSpeed => globalTimer.speed * debugSpeed;

	public float debugSpeed { get; private set; } = 1f;

	public float time { get; protected set; }

	public float timeScaled { get; protected set; }

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompTime>().Build();
		_fixedUpdateBehaveAction = FixedUpdateBehave;
		_updateTimeCameraScaleAction = UpdateTimeCameraScale;
		_pauseEffectAction = PauseEffect;
		_resumeEffectAction = ResumeEffect;
		m_OverheadTimeOfThisFrame = 0f;
		globalTimer = new AllianceSpeedTimer();
		timerPool = new ObjectPool<TimeSpeedTimer>(null, (TimeSpeedTimer p) =>
		{
			p.Reset();
		}, 100);
	}

	public override void FixedUpdate()
	{
		float fixedDeltaTime = Time.fixedDeltaTime;
		time += fixedDeltaTime * debugSpeed;
		timeScaled += (MonoECS.instance.running ? (fixedDeltaTime * globalSpeed) : 0f);
		globalTimer.FixedUpdate(fixedDeltaTime);
		if (globalTimer.lastFrameChanged)
		{
			ApplyGlobalSpeed();
		}
		TickWorldRuntimeSpeed(fixedDeltaTime);
		_filter.ForEachStable(_fixedUpdateBehaveAction);
	}

	private void ApplyGlobalSpeed()
	{
		_filter.ForEachStable(_updateTimeCameraScaleAction);
	}

	private void UpdateTimeCameraScale(Entity entity, CompTime compTime)
	{
		compTime.cameraScale = globalSpeed;
	}

	public void DebugChangeSpeed(float v)
	{
		debugSpeed = v;
		ApplyGlobalSpeed();
	}

	private void FixedUpdateBehave(Entity entity, CompTime compTime)
	{
		CompBehave compBehave = entity.GetCompBehave();
		if (!entity.IsTickAvailable())
		{
			if (compBehave != null && compBehave.IsLogicAvailable() && compBehave.TickLod == EntityTickLod.Quarter)
			{
				compTime.tickFixedDeltaAccumulator += Time.fixedDeltaTime;
			}
			else if (compBehave != null && compBehave.TickLod == EntityTickLod.Sleep)
			{
				compTime.tickFixedDeltaAccumulator = 0f;
			}
			compTime.tickFixedDeltaTime = 0f;
			compTime.fixedDeltaTime = 0f;
			compTime.motionFixedDeltaTime = 0f;
			compTime.motionFixedDeltaTimeOS = 0f;
			compTime.physicsFixedDeltalTime = 0f;
			compTime.abilityFixedDeltaTime = 0f;
			return;
		}
		float tickDeltaScale = compBehave.TickDeltaScale;
		float num = Time.fixedDeltaTime * tickDeltaScale;
		if (compTime.tickFixedDeltaAccumulator > 0f)
		{
			compTime.tickFixedDeltaAccumulator += Time.fixedDeltaTime;
			num = compTime.tickFixedDeltaAccumulator;
			compTime.tickFixedDeltaAccumulator = 0f;
		}
		compTime.tickFixedDeltaTime = num;
		compTime.TickSpeedTime(num);
		compTime.logicScale = logicSpeed;
		compTime.CalculateSpeed();
		if (entity.TryGetCompSound(out CompSound component))
		{
			component.SetCurSoundPausedByFixedSpeed(compTime.fixedSpeed <= 0f);
		}
		compTime.fixedDeltaTime = compTime.fixedSpeed * num;
		compTime.motionFixedDeltaTime = compTime.motionFixedSpeed * num;
		compTime.motionFixedDeltaTimeOS = compTime.motionFixedSpeedOS * num;
		compTime.physicsFixedDeltalTime = compTime.physicsFixedSpeed * num;
		compTime.abilityFixedDeltaTime = compTime.abilityFixedSpeed * num;
		compTime.lifeTime += compTime.fixedDeltaTime;
		if (compTime.debugFrameHaltDuration > 0f)
		{
			compTime.debugFrameHaltDuration -= num;
			if (compTime.debugFrameHaltDuration <= 0f)
			{
				entity.ApplyDebugFrameHalt(0f, 1f);
			}
		}
		if (compTime.frameHaltDuration > 0f)
		{
			compTime.frameHaltDuration -= num;
			if (compTime.frameHaltDuration <= 0f)
			{
				entity.ApplyFrameHalt(0f, 1f);
			}
		}
		compTime.inactiveTime += num;
	}

	public void InitializeEntity(Entity entity)
	{
		if (entity.TryGetCompTime(out CompTime component))
		{
			component.cameraScale = globalSpeed;
		}
	}

	protected override void OnPause()
	{
		_filter?.ForEach(_pauseEffectAction);
	}

	protected override void OnResume()
	{
		_filter?.ForEachStable(_resumeEffectAction);
	}

	private static void PauseEffect(Entity entity)
	{
	}

	private static void ResumeEffect(Entity entity, CompTime compTime)
	{
	}

	private static void ChangeEffectSpeed(CompEffect compEffect, float speed)
	{
		foreach (EffectRuntimeItem myEffect in compEffect.myEffects)
		{
			myEffect.SetSpeed(speed);
		}
	}

	private void TickWorldRuntimeSpeed(float delta)
	{
		for (int num = _worldRuntimeSpeedTimers.Count - 1; num >= 0; num--)
		{
			TimeSpeedTimer timeSpeedTimer = _worldRuntimeSpeedTimers[num];
			timeSpeedTimer.FixedUpdate(delta);
			if (!timeSpeedTimer.IsChanging)
			{
				_worldRuntimeSpeedTimers.RemoveAt(num);
				timerPool.Release(timeSpeedTimer);
			}
		}
		UpdateWorldRuntimeSpeed();
	}

	private void UpdateWorldRuntimeSpeed()
	{
		float num = float.MaxValue;
		bool flag = false;
		foreach (TimeSpeedTimer worldRuntimeSpeedTimer in _worldRuntimeSpeedTimers)
		{
			if (worldRuntimeSpeedTimer.IsChanging)
			{
				flag = true;
				if (worldRuntimeSpeedTimer.Speed < num)
				{
					num = worldRuntimeSpeedTimer.Speed;
				}
			}
		}
		_worldRuntimeSpeed = (flag ? num : 1f);
	}

	internal void ChangeGlobalSpeed(ConfigChangeGlobalSpeed config)
	{
		globalTimer.ChangeSpeed(config);
	}

	internal void ChangeWorldRuntimeSpeed(ConfigChangeGlobalSpeed config)
	{
		TimeSpeedTimer timeSpeedTimer = timerPool.Get();
		timeSpeedTimer.InitTimer(config);
		_worldRuntimeSpeedTimers.Add(timeSpeedTimer);
	}

	internal TimeSpeedTimer AddWorldRuntimeSpeedTimer(ConfigChangeGlobalSpeed config)
	{
		TimeSpeedTimer timeSpeedTimer = timerPool.Get();
		timeSpeedTimer.InitTimer(config.speed, -1f, Mathf.Max(0f, config.easeTime));
		_worldRuntimeSpeedTimers.Add(timeSpeedTimer);
		return timeSpeedTimer;
	}

	internal void RemoveWorldRuntimeSpeedTimer(TimeSpeedTimer timer)
	{
		if (timer != null && _worldRuntimeSpeedTimers.Remove(timer))
		{
			timerPool.Release(timer);
			UpdateWorldRuntimeSpeed();
		}
	}

	internal void ForceChangeGlobalSpeed(float speed)
	{
		globalTimer.ForceChangeSpeed(speed);
	}

	internal void ChangeLogicSpeed(bool pause)
	{
		logicSpeed = ((!pause) ? 1 : 0);
	}

	internal float GetCurrentDeltaTime()
	{
		if (!MonoECS.instance.running)
		{
			return 0f;
		}
		return Time.deltaTime * globalSpeed * logicSpeed;
	}

	internal float GetWorldRuntimeDeltaTime()
	{
		if (!MonoECS.instance.running)
		{
			return 0f;
		}
		MonoECS instance = MonoECS.instance;
		if ((object)instance != null && instance.mainEntity.IsValid)
		{
			CompEffect compEffect = instance.mainEntity.GetCompEffect();
			if (compEffect != null && compEffect.bInUltraTimeline)
			{
				return 0f;
			}
		}
		return Time.fixedDeltaTime * globalSpeed * logicSpeed * _worldRuntimeSpeed;
	}
}
