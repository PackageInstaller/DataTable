using System;
using System.Collections.Generic;
using Config;
using UnityEngine;

public class ThrownManager : IGameModule
{
	public class IntComparer : IEqualityComparer<int>
	{
		public bool Equals(int a, int b)
		{
			return a == b;
		}

		public int GetHashCode(int a)
		{
			return a;
		}
	}

	private GameObject _timelinePlayer;

	private Dictionary<int, TimelinePlayer> _perfomaceTable = new Dictionary<int, TimelinePlayer>(100, new IntComparer());

	private Dictionary<int, ThrownStateOfRender> m_throwns = new Dictionary<int, ThrownStateOfRender>(100, new IntComparer());

	private List<int> _waitDestoryTable = new List<int>(100);

	private List<TimelinePlayer> _timelinePools = new List<TimelinePlayer>(100);

	public bool TryGetThrownTimelinePlayer(int thrownID, out TimelinePlayer player)
	{
		return _perfomaceTable.TryGetValue(thrownID, out player);
	}

	public bool TryGetThrownPosition(int thrownID, out Vector3 position, out Vector3 forward)
	{
		if (m_throwns.TryGetValue(thrownID, out var value))
		{
			position = value.Position;
			forward = value.Forward;
			return true;
		}
		position = Vector3.zero;
		forward = Vector3.forward;
		return false;
	}

	public bool TryGetThrownTimelineID(int thrownID, out int timelineID)
	{
		if (m_throwns.TryGetValue(thrownID, out var value))
		{
			timelineID = value.TimelineID;
			return true;
		}
		timelineID = 0;
		return false;
	}

	public void Initialize()
	{
		_timelinePlayer = new GameObject("TimelineDirector");
		_timelinePlayer.AddComponent<Animator>();
		_timelinePlayer.AddComponent<AttachPointSetup>();
		_timelinePlayer.AddComponent<ComponentCameraAnimation>();
		_timelinePlayer.AddComponent<AudioSource>();
		_timelinePlayer.transform.SetParent(Camera.main.transform, worldPositionStays: false);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<SimGameOverEvent>(OnGameStopHandler);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<BuffItemCloseToEntityEvent>(OnBuffItemColseToEntityEventHandler);
	}

	public void DestoryAllThrown()
	{
		Dictionary<int, ThrownStateOfRender>.Enumerator enumerator = m_throwns.GetEnumerator();
		while (enumerator.MoveNext())
		{
			DestoryThrown(enumerator.Current.Key);
		}
	}

	private void OnGameStopHandler(SimGameOverEvent eventReceived)
	{
		if (eventReceived.state == GameOverState.end)
		{
			DestoryAllThrown();
		}
	}

	private void OnBuffItemColseToEntityEventHandler(BuffItemCloseToEntityEvent evt)
	{
		if (TryGetThrownTimelinePlayer(evt.mThrownID, out var player))
		{
			player.PlayClosingAnimation();
		}
	}

	public void Shutdown()
	{
		_timelinePools.Clear();
	}

	public void UpdateLogic(SimStateFrame stateFrame)
	{
		int count = stateFrame.AllEntityStates.Count;
		for (int i = 0; i < count; i++)
		{
			if (stateFrame.AllEntityStates[i] is WorldState)
			{
				WorldState worldState = stateFrame.AllEntityStates[i] as WorldState;
				UpdateThrown(worldState);
			}
		}
	}

	public bool TryGetThrown(int creationIndex, out ThrownStateOfRender thrownStateOfRender)
	{
		return m_throwns.TryGetValue(creationIndex, out thrownStateOfRender);
	}

	public void UpdateThrown(WorldState worldState)
	{
		if (worldState.mIsGameOver)
		{
			return;
		}
		if (worldState.mThrownStateArray != null)
		{
			for (int i = 0; i < worldState.mThrownStateArray.Count; i++)
			{
				ThrownFrameState thrownState = worldState.mThrownStateArray[i];
				ThrownStateOfRender value = null;
				if (m_throwns.TryGetValue(thrownState.mCreationIndex, out value))
				{
					m_throwns[thrownState.mCreationIndex].ThrownState = thrownState;
					m_throwns[thrownState.mCreationIndex].UpdateState = EnThrownUpdateState.Update;
				}
				else if (!_waitDestoryTable.Contains(thrownState.mCreationIndex))
				{
					value = FrameObjectPool<ThrownStateOfRender>.Claim();
					value.ThrownState = thrownState;
					value.UpdateState = EnThrownUpdateState.Add;
					m_throwns.Add(thrownState.mCreationIndex, value);
				}
			}
		}
		Dictionary<int, ThrownStateOfRender>.Enumerator enumerator = m_throwns.GetEnumerator();
		while (enumerator.MoveNext())
		{
			ThrownStateOfRender value2 = enumerator.Current.Value;
			if (value2.UpdateState == EnThrownUpdateState.Add)
			{
				SpawnThrown(value2);
				value2.UpdateState = EnThrownUpdateState.Update;
				continue;
			}
			ThrownFrameState thrownState2 = value2.ThrownState;
			if (!_perfomaceTable.TryGetValue(thrownState2.mCreationIndex, out var value3))
			{
				continue;
			}
			Vector3 vector = (Vector3)thrownState2.mPosition;
			Vector3 vector2 = value2.Forward;
			float num = ((thrownState2.mRuntime == 0 && thrownState2.mFrameFreezeTime == int.MaxValue) ? 1f : ((float)(thrownState2.mStep * BattleSimulatorSystem.sTargetLogicFrameRate) / 1000f));
			float currentTimelineTimeScale = (value3.CurrentTimelineTimeScale = num);
			value3.UpdateWorldAndEntityTimeScale(currentTimelineTimeScale);
			if (thrownState2.mFrameFreezeTime > 0 && value3.CurrentTimelineTimeScale > 0f)
			{
				value3.FrameFreezeRecordedTimeScale = value3.CurrentTimelineTimeScale;
				value3.CurrentTimelineTimeScale = 0f;
				value3.UpdateWorldAndEntityTimeScale(value3.CurrentTimelineTimeScale);
			}
			if (value3.CurrentTimelineTimeScale == 0f)
			{
				if (thrownState2.mFrameFreezeTime <= 0 && value3.FrameFreezeRecordedTimeScale != -1f)
				{
					value3.CurrentTimelineTimeScale = value3.FrameFreezeRecordedTimeScale;
					value3.UpdateWorldAndEntityTimeScale(value3.CurrentTimelineTimeScale);
					value3.FrameFreezeRecordedTimeScale = -1f;
				}
				continue;
			}
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState2.mAbilityID);
			if (config != null && config.IsUseConfigY)
			{
				if (thrownState2.mCurFrame > value2.currentFrame)
				{
					while (thrownState2.mCurFrame > value2.currentFrame)
					{
						uint currentFrame = (uint)value2.currentFrame;
						if (currentFrame < config.MoveActionTimelineNode.Duration)
						{
							VectorInt3 vectorInt = config.MoveActionTimelineNode.AverageSpeed;
							if (!config.MoveActionTimelineNode.UseUniformMotion)
							{
								vectorInt = config.MoveActionTimelineNode.AnimationMove.get_Item((int)currentFrame);
							}
							int y = vectorInt.Y;
							vector = vector.NewY(value2.Position.y + (float)y / 1000f);
							vector2 = (vector - value2.Position).normalized;
							value2.Position = vector;
						}
						value2.currentFrame++;
					}
				}
				else
				{
					vector = vector.NewY(value2.Position.y);
				}
			}
			else
			{
				if (thrownState2.mTargetPosition != Int3.up && value2.EffectCtrl == null)
				{
					TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(thrownState2.mAbilityID);
					if (timelineInfo != null && thrownState2.mCurLockIndex > 0 && thrownState2.mCurLockIndex <= timelineInfo.thrownLockActionClips.Count)
					{
						ThrownLockActionClip thrownLockActionClip = timelineInfo.thrownLockActionClips[thrownState2.mCurLockIndex - 1];
						if (thrownLockActionClip != null && !string.IsNullOrEmpty(thrownLockActionClip.EffectPath))
						{
							GameObject gameObject = Asset.Instantiate(thrownLockActionClip.EffectPath);
							if (gameObject != null)
							{
								gameObject.transform.position = (Vector3)thrownState2.mTargetPosition;
								gameObject.transform.rotation = Quaternion.identity;
								gameObject.transform.localScale = thrownLockActionClip.EffectScale;
								value2.EffectCtrl = gameObject.GetComponent<EffectController>();
								value2.EffectCtrl.Initialize(isLoop: false, thrownLockActionClip.EffectLiveTime, 1f, BattleScene.MainPlayerQuality, null);
								value2.EffectCtrl.Simulator(0f);
							}
						}
					}
				}
				if (thrownState2.mIsInLock && thrownState2.mTargetID != 0)
				{
					Vector3 vector3 = Vector3.zero;
					NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(thrownState2.mTargetID);
					if (agent != null)
					{
						vector3 = (agent.transform.position + Vector3.up * 1.5f - value2.Position).normalized;
					}
					if (vector3 != Vector3.zero)
					{
						float num3 = 360f;
						foreach (ThrownLockActionInfo thrownLockActionInfo in config.ThrownLockActionInfoList)
						{
							if (thrownState2.mRuntime > thrownLockActionInfo.Start && thrownState2.mRuntime <= thrownLockActionInfo.Start + thrownLockActionInfo.Duration)
							{
								num3 = (float)thrownLockActionInfo.TurnRate / 1000f;
							}
						}
						vector2 = Vector3.RotateTowards(value2.Forward, vector3, num3 * (MathF.PI / 180f) * Time.deltaTime, 0f);
					}
				}
				vector = (Vector3)thrownState2.mPosition;
				vector2 = (Vector3)thrownState2.mForward;
			}
			if (vector2 == Vector3.zero)
			{
				vector2 = (Vector3)thrownState2.mForward;
				if (vector2 == Vector3.zero)
				{
					vector2 = Vector3.forward;
				}
			}
			value2.LastPosition = value2.Position;
			value2.Position = vector;
			value2.Forward = vector2;
			value3.UpdateTransform(vector, vector2);
		}
	}

	public void SpawnThrown(ThrownStateOfRender thrownStateOfRender)
	{
		int mProduceTimelineID = thrownStateOfRender.ThrownState.mProduceTimelineID;
		int mProduceIndexOfTimeline = thrownStateOfRender.ThrownState.mProduceIndexOfTimeline;
		Vector3 vector = (Vector3)thrownStateOfRender.ThrownState.mPosition;
		Vector3 vector2 = (Vector3)thrownStateOfRender.ThrownState.mForward;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownStateOfRender.TimelineID);
		TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(thrownStateOfRender.TimelineID);
		if (mProduceTimelineID != 0)
		{
			Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(mProduceTimelineID);
			if (config2 != null && config2.PostSpwanThrownEvents.get_Item(mProduceIndexOfTimeline) != null)
			{
				thrownStateOfRender.Position = vector;
				thrownStateOfRender.Forward = vector2;
			}
		}
		else if (timelineInfo != null)
		{
			thrownStateOfRender.Position = (Vector3)thrownStateOfRender.ThrownState.mPosition;
			thrownStateOfRender.LastPosition = (Vector3)thrownStateOfRender.ThrownState.mPosition;
			thrownStateOfRender.Forward = (Vector3)thrownStateOfRender.ThrownState.mForward;
		}
		if (config != null && config.IsUseConfigY)
		{
			thrownStateOfRender.Position = vector.NewY(vector.y + timelineInfo.ActionStartOffsetY);
			if (config.MoveActionTimelineNode != null && config.MoveActionTimelineNode.Duration > 0)
			{
				VectorInt3 vectorInt = config.MoveActionTimelineNode.AverageSpeed;
				if (!config.MoveActionTimelineNode.UseUniformMotion)
				{
					vectorInt = config.MoveActionTimelineNode.AnimationMove.get_Item(0);
				}
				thrownStateOfRender.Forward = vector2.NewY((float)vectorInt.Y / 1000f);
			}
		}
		if (timelineInfo != null && timelineInfo.thrownLockActionClips.Count > 0)
		{
			thrownStateOfRender.StartChangeHeightTime = uint.MaxValue;
			for (int i = 0; i < timelineInfo.thrownLockActionClips.Count; i++)
			{
				ThrownLockActionClip thrownLockActionClip = timelineInfo.thrownLockActionClips[i];
				if (thrownLockActionClip != null && thrownLockActionClip.StartChangeHeightTime < thrownStateOfRender.StartChangeHeightTime)
				{
					thrownStateOfRender.StartChangeHeightTime = (uint)thrownLockActionClip.StartChangeHeightTime;
				}
			}
		}
		TimelinePlayer timelinePlayer = null;
		if (_timelinePools.Count > 0)
		{
			timelinePlayer = _timelinePools[0];
			_timelinePools.RemoveAt(0);
		}
		else
		{
			timelinePlayer = new TimelinePlayer();
		}
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(thrownStateOfRender.CasterID);
		timelinePlayer.Initialize(thrownStateOfRender.AudioRoot.transform, agent, thrownStateOfRender.CreationIndex);
		timelinePlayer.Stop();
		config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownStateOfRender.TimelineID);
		timelinePlayer.Play(thrownStateOfRender.TimelineID, vector, vector2, usePosition: true, 1f, -1, config == null || !config.IsDependCasterForThrown);
		timelinePlayer.UpdateTransform(thrownStateOfRender.Position, thrownStateOfRender.Forward);
		if (_perfomaceTable.ContainsKey(thrownStateOfRender.CreationIndex))
		{
			_perfomaceTable[thrownStateOfRender.CreationIndex] = timelinePlayer;
		}
		else
		{
			_perfomaceTable.Add(thrownStateOfRender.CreationIndex, timelinePlayer);
		}
	}

	public void DestoryThrown(int id)
	{
		_waitDestoryTable.Add(id);
		TimelinePlayer value = null;
		if (_perfomaceTable.TryGetValue(id, out value))
		{
			value.Stop();
			value.OnEnterPool();
			_timelinePools.Add(value);
			_perfomaceTable.Remove(id);
		}
	}

	public void FixedUpdate()
	{
	}

	public void Update()
	{
		Dictionary<int, TimelinePlayer>.Enumerator enumerator = _perfomaceTable.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.Update();
		}
	}

	public void LateUpdate()
	{
		for (int i = 0; i < _waitDestoryTable.Count; i++)
		{
			if (m_throwns.TryGetValue(_waitDestoryTable[i], out var value))
			{
				FrameObjectPool<ThrownStateOfRender>.Release(value);
				m_throwns.Remove(_waitDestoryTable[i]);
			}
		}
		_waitDestoryTable.Clear();
	}

	public void Reset()
	{
	}

	public void Hide(int id, bool hide)
	{
		if (_perfomaceTable.TryGetValue(id, out var value))
		{
			if (hide)
			{
				value.DisableRenders();
			}
			else
			{
				value.EnableRenders();
			}
		}
	}

	public void HideAll(bool hide)
	{
		if (hide)
		{
			Dictionary<int, TimelinePlayer>.Enumerator enumerator = _perfomaceTable.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.Value.DisableRenders();
			}
		}
		else
		{
			Dictionary<int, TimelinePlayer>.Enumerator enumerator2 = _perfomaceTable.GetEnumerator();
			while (enumerator2.MoveNext())
			{
				enumerator2.Current.Value.EnableRenders();
			}
		}
	}
}
