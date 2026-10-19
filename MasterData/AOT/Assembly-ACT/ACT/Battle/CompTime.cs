using System;
using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle;

public class CompTime : EcsComponent
{
	private float m_CameraScale = 1f;

	public float logicScale = 1f;

	public float abilityScale = 1f;

	public float abilityFixedSpeed;

	public float abilityFixedDeltaTime;

	public float fixedSpeed;

	public float fixedDeltaTime;

	public float motionScale = 1f;

	public float motionFixedSpeed;

	public float motionFixedDeltaTime;

	public float motionFixedSpeedOS;

	public float motionFixedDeltaTimeOS;

	public float physicsScale = 1f;

	public float physicsFixedSpeed;

	public float physicsFixedDeltalTime;

	public bool effectSpeedChange;

	public float inactiveTime;

	public float lifeTime;

	public float tickFixedDeltaTime;

	public float tickFixedDeltaAccumulator;

	public float frameHaltDuration;

	private float m_FrameHaltScale = 1f;

	public bool useDebugFrameHalt;

	public float debugFrameHaltScale;

	public float debugFrameHaltDuration;

	private float m_WitchTimeScale = 1f;

	private bool m_WitchTimeImmune;

	private readonly Dictionary<TimeType, List<TimeSpeedTimer>> _timerDict = new Dictionary<TimeType, List<TimeSpeedTimer>>();

	public float cameraScale
	{
		get
		{
			return m_CameraScale;
		}
		set
		{
			if (m_CameraScale != value)
			{
				m_CameraScale = value;
			}
		}
	}

	public bool isMotionTimeScale => (double)motionScale < 0.99;

	public float frameHaltScale
	{
		get
		{
			return m_FrameHaltScale;
		}
		set
		{
			if (m_FrameHaltScale != value)
			{
				m_FrameHaltScale = value;
			}
		}
	}

	public bool witchTimeImmune
	{
		get
		{
			return m_WitchTimeImmune;
		}
		set
		{
			if (m_WitchTimeImmune != value)
			{
				m_WitchTimeImmune = value;
			}
		}
	}

	public event Action<float> OnFixedSpeedChange;

	public void CalculateSpeed()
	{
		float num = fixedSpeed;
		fixedSpeed = (m_WitchTimeImmune ? 1f : m_WitchTimeScale) * logicScale * cameraScale;
		if (num != fixedSpeed)
		{
			OnFixedSpeedChange?.Invoke(fixedSpeed);
		}
		physicsFixedSpeed = physicsScale * (useDebugFrameHalt ? debugFrameHaltScale : m_FrameHaltScale) * fixedSpeed;
		motionFixedSpeed = motionScale * (useDebugFrameHalt ? debugFrameHaltScale : m_FrameHaltScale) * fixedSpeed;
		motionFixedSpeedOS = (useDebugFrameHalt ? debugFrameHaltScale : m_FrameHaltScale) * fixedSpeed;
		abilityFixedSpeed = abilityScale * (useDebugFrameHalt ? debugFrameHaltScale : m_FrameHaltScale) * fixedSpeed;
	}

	protected override void OnGet()
	{
		tickFixedDeltaTime = 0f;
		tickFixedDeltaAccumulator = 0f;
	}

	protected override void OnRelease()
	{
		m_CameraScale = 1f;
		_timerDict.Clear();
		m_WitchTimeScale = 1f;
		fixedDeltaTime = 0f;
		tickFixedDeltaTime = 0f;
		tickFixedDeltaAccumulator = 0f;
		motionFixedDeltaTime = 0f;
		frameHaltDuration = 0f;
		m_FrameHaltScale = 1f;
		motionScale = 1f;
		m_WitchTimeImmune = false;
		effectSpeedChange = false;
		inactiveTime = 0f;
		lifeTime = 0f;
		useDebugFrameHalt = false;
		debugFrameHaltScale = 0f;
		debugFrameHaltDuration = 0f;
		OnFixedSpeedChange = null;
		physicsFixedSpeed = 0f;
		physicsScale = 1f;
		physicsFixedDeltalTime = 0f;
		abilityFixedSpeed = 0f;
		abilityScale = 1f;
	}

	public bool isFrameHalt()
	{
		if (frameHaltDuration != 0f && m_FrameHaltScale != 1f)
		{
			return true;
		}
		return false;
	}

	private List<TimeSpeedTimer> GetTimerList(TimeType type)
	{
		if (!_timerDict.TryGetValue(type, out var value))
		{
			value = new List<TimeSpeedTimer>();
			_timerDict[type] = value;
		}
		return value;
	}

	public void TickSpeedTime(float delta)
	{
		foreach (KeyValuePair<TimeType, List<TimeSpeedTimer>> item in _timerDict)
		{
			List<TimeSpeedTimer> value = item.Value;
			if (value.Count == 0)
			{
				UpdateTimeScale(item.Key);
				continue;
			}
			ObjectPool<TimeSpeedTimer> timerPool = GameManager.timeSystem.timerPool;
			for (int num = value.Count - 1; num >= 0; num--)
			{
				TimeSpeedTimer timeSpeedTimer = value[num];
				timeSpeedTimer.FixedUpdate(delta);
				if (!timeSpeedTimer.IsChanging)
				{
					value.RemoveAt(num);
					timerPool.Release(timeSpeedTimer);
				}
				UpdateTimeScale(item.Key);
			}
		}
	}

	public void AddSpeedTimer(TimeType type, TimeSpeedTimer timer)
	{
		List<TimeSpeedTimer> timerList = GetTimerList(type);
		if (timer != null && !timerList.Contains(timer))
		{
			timerList.Add(timer);
		}
	}

	public void RemoveSpeedTimer(TimeType type, TimeSpeedTimer timer)
	{
		List<TimeSpeedTimer> timerList = GetTimerList(type);
		if (timer != null && timerList.Contains(timer))
		{
			timerList.Remove(timer);
			GameManager.timeSystem.timerPool.Release(timer);
		}
	}

	public void UpdateTimeScale(TimeType type)
	{
		float witchTimeScale = 1f;
		TimeSpeedTimer minTargetSpeedTimer = GetMinTargetSpeedTimer(type);
		if (minTargetSpeedTimer != null)
		{
			witchTimeScale = minTargetSpeedTimer.Speed;
		}
		if (type == TimeType.Witch)
		{
			m_WitchTimeScale = witchTimeScale;
		}
		if (type == TimeType.Motion)
		{
			motionScale = witchTimeScale;
		}
		if (type == TimeType.Physics)
		{
			physicsScale = witchTimeScale;
		}
		if (type == TimeType.Ability)
		{
			abilityScale = witchTimeScale;
		}
	}

	public TimeSpeedTimer GetMinTargetSpeedTimer(TimeType type)
	{
		List<TimeSpeedTimer> timerList = GetTimerList(type);
		TimeSpeedTimer result = null;
		float num = float.MaxValue;
		foreach (TimeSpeedTimer item in timerList)
		{
			if (item.TargetSpeed < num)
			{
				num = item.TargetSpeed;
				result = item;
			}
		}
		return result;
	}

	public void ClearSpeedTimer(TimeType type)
	{
		List<TimeSpeedTimer> timerList = GetTimerList(type);
		ObjectPool<TimeSpeedTimer> timerPool = GameManager.timeSystem.timerPool;
		for (int i = 0; i < timerList.Count; i++)
		{
			timerPool.Release(timerList[i]);
		}
		timerList.Clear();
		UpdateTimeScale(type);
	}
}
