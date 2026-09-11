using System;
using UnityEngine;

public abstract class CriAtomSourceBase : CriMonoBehaviour
{
	public enum Status
	{
		Stop,
		Prep,
		Playing,
		PlayEnd,
		Error
	}

	protected bool initialized;

	protected Vector3 lastPosition;

	protected bool hasValidPosition;

	private CriAtomRegion currentRegion;

	private CriAtomListener currentListener;

	[SerializeField]
	private bool _playOnStart;

	[SerializeField]
	private CriAtomRegion _regionOnStart;

	[SerializeField]
	private CriAtomListener _listenerOnStart;

	[SerializeField]
	private bool _use3dPositioning = true;

	[SerializeField]
	private bool _freezeOrientation;

	[SerializeField]
	private bool _loop;

	[SerializeField]
	private float _volume = 1f;

	[SerializeField]
	private float _pitch;

	[SerializeField]
	private bool _androidUseLowLatencyVoicePool;

	[SerializeField]
	private bool need_to_player_update_all = true;

	[SerializeField]
	private bool _use3dRandomization;

	[SerializeField]
	private uint _randomPositionListMaxLength;

	[SerializeField]
	private CriAtomEx.Randomize3dConfig randomize3dConfig = new CriAtomEx.Randomize3dConfig(0);

	public CriAtomExPlayer player { get; protected set; }

	public CriAtomEx3dSource source { get; protected set; }

	public bool playOnStart
	{
		get
		{
			return _playOnStart;
		}
		set
		{
			_playOnStart = value;
		}
	}

	public bool use3dPositioning
	{
		get
		{
			return _use3dPositioning;
		}
		set
		{
			_use3dPositioning = value;
			if (player != null)
			{
				player.Set3dSource(use3dPositioning ? source : null);
				SetNeedToPlayerUpdateAll();
			}
		}
	}

	public bool freezeOrientation
	{
		get
		{
			return _freezeOrientation;
		}
		set
		{
			_freezeOrientation = value;
		}
	}

	public bool use3dRandomization
	{
		get
		{
			return _use3dRandomization;
		}
		set
		{
			_use3dRandomization = value;
			if (source != null)
			{
				if (_use3dRandomization)
				{
					source.SetRandomPositionConfig(randomize3dConfig);
				}
				else
				{
					source.SetRandomPositionConfig(null);
				}
			}
		}
	}

	public uint randomPositionListMaxLength
	{
		get
		{
			return _randomPositionListMaxLength;
		}
		set
		{
			if (initialized)
			{
				Debug.LogError("[CRIWARE] Max length of random position list cannot be changed after initialization of the CriAtomSource.", this);
			}
			else
			{
				_randomPositionListMaxLength = value;
			}
		}
	}

	public CriAtomRegion region3d
	{
		get
		{
			return currentRegion;
		}
		set
		{
			if (currentRegion == value)
			{
				return;
			}
			if (!_use3dPositioning)
			{
				Debug.LogWarning("[CRIWARE] Cannot set 3D Region on audio source with 3d positioning disabled.");
				return;
			}
			if (currentRegion != null)
			{
				currentRegion.referringSources.Remove(this);
			}
			CriAtomEx3dRegion criAtomEx3dRegion = ((value == null) ? null : value.region3dHn);
			if (source != null)
			{
				source.Set3dRegion(criAtomEx3dRegion);
				source.Update();
				currentRegion = value;
				if (currentRegion != null)
				{
					currentRegion.referringSources.Add(this);
				}
			}
			else
			{
				Debug.LogError("[CRIWARE] Internal: 3D Positioning is not initialized correctly.");
				currentRegion = null;
			}
		}
	}

	public CriAtomListener listener
	{
		get
		{
			return currentListener;
		}
		set
		{
			if (!_use3dPositioning)
			{
				Debug.LogWarning("[CRIWARE] Cannot set 3D Listener on audio source with 3d positioning disabled.");
				return;
			}
			currentListener = value;
			player.Set3dListener((value == null) ? null : value.nativeListener);
		}
	}

	public CriAtomRegion regionOnStart
	{
		get
		{
			return _regionOnStart;
		}
		set
		{
			_regionOnStart = value;
		}
	}

	public CriAtomListener listenerOnStart
	{
		get
		{
			return _listenerOnStart;
		}
		set
		{
			_listenerOnStart = value;
		}
	}

	public bool loop
	{
		get
		{
			return _loop;
		}
		set
		{
			_loop = value;
		}
	}

	public float volume
	{
		get
		{
			return _volume;
		}
		set
		{
			_volume = value;
			if (player != null)
			{
				player.SetVolume(_volume);
				SetNeedToPlayerUpdateAll();
			}
		}
	}

	public float pitch
	{
		get
		{
			return _pitch;
		}
		set
		{
			_pitch = value;
			if (player != null)
			{
				player.SetPitch(_pitch);
				SetNeedToPlayerUpdateAll();
			}
		}
	}

	public float pan3dAngle
	{
		get
		{
			if (player == null)
			{
				return 0f;
			}
			return player.GetParameterFloat32(CriAtomEx.Parameter.Pan3dAngle);
		}
		set
		{
			if (player != null)
			{
				player.SetPan3dAngle(value);
				SetNeedToPlayerUpdateAll();
			}
		}
	}

	public float pan3dDistance
	{
		get
		{
			if (player == null)
			{
				return 0f;
			}
			return player.GetParameterFloat32(CriAtomEx.Parameter.Pan3dDistance);
		}
		set
		{
			if (player != null)
			{
				player.SetPan3dInteriorDistance(value);
				SetNeedToPlayerUpdateAll();
			}
		}
	}

	public int startTime
	{
		get
		{
			if (player == null)
			{
				return 0;
			}
			return player.GetParameterSint32(CriAtomEx.Parameter.StartTime);
		}
		set
		{
			if (player != null)
			{
				player.SetStartTime(value);
				SetNeedToPlayerUpdateAll();
			}
		}
	}

	public long time
	{
		get
		{
			if (player == null)
			{
				return 0L;
			}
			return player.GetTime();
		}
	}

	public Status status
	{
		get
		{
			if (player == null)
			{
				return Status.Error;
			}
			return (Status)player.GetStatus();
		}
	}

	public bool attenuationDistanceSetting
	{
		get
		{
			if (source == null)
			{
				return false;
			}
			return source.GetAttenuationDistanceSetting();
		}
		set
		{
			if (source != null)
			{
				source.SetAttenuationDistanceSetting(value);
				source.Update();
			}
		}
	}

	public bool androidUseLowLatencyVoicePool
	{
		get
		{
			return _androidUseLowLatencyVoicePool;
		}
		set
		{
			_androidUseLowLatencyVoicePool = value;
		}
	}

	protected void SetNeedToPlayerUpdateAll()
	{
		need_to_player_update_all = true;
	}

	protected virtual void InternalInitialize()
	{
		CriAtomPlugin.InitializeLibrary();
		player = new CriAtomExPlayer();
		source = new CriAtomEx3dSource(enableVoicePriorityDecay: false, randomPositionListMaxLength);
		initialized = true;
	}

	protected virtual void InternalFinalize()
	{
		initialized = false;
		region3d = null;
		player.Dispose();
		player = null;
		source.Dispose();
		source = null;
		CriAtomPlugin.FinalizeLibrary();
	}

	private void Awake()
	{
		InternalInitialize();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		hasValidPosition = false;
		SetInitialParameters();
		SetNeedToPlayerUpdateAll();
	}

	private void OnDestroy()
	{
		InternalFinalize();
	}

	protected bool SetInitialSourcePosition()
	{
		Vector3 vector = (lastPosition = base.transform.position);
		if (source != null)
		{
			source.SetPosition(vector.x, vector.y, vector.z);
			source.Update();
			return true;
		}
		return false;
	}

	protected virtual void SetInitialParameters()
	{
		use3dPositioning = use3dPositioning;
		use3dRandomization = use3dRandomization;
		if (!SetInitialSourcePosition())
		{
			Debug.LogError("[ADX][SetInitialParameters] source is null.", this);
		}
		player.SetVolume(_volume);
		player.SetPitch(_pitch);
	}

	protected virtual void UpdatePosition()
	{
		Vector3 position = base.transform.position;
		source.SetPosition(position.x, position.y, position.z);
		if (hasValidPosition)
		{
			Vector3 vector = (position - lastPosition) / Time.deltaTime;
			source.SetVelocity(vector.x, vector.y, vector.z);
		}
		if (!freezeOrientation)
		{
			source.SetOrientation(base.transform.forward, base.transform.up);
		}
		source.Update();
		lastPosition = position;
		hasValidPosition = true;
	}

	private void Start()
	{
		if (use3dPositioning && regionOnStart != null)
		{
			region3d = regionOnStart;
		}
		if (use3dPositioning && listenerOnStart != null)
		{
			listener = listenerOnStart;
		}
		PlayOnStart();
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
		if (use3dPositioning)
		{
			UpdatePosition();
		}
		if (need_to_player_update_all)
		{
			player.UpdateAll();
			need_to_player_update_all = false;
		}
	}

	public abstract CriAtomExPlayback Play();

	protected abstract CriAtomExAcb GetAcb();

	protected abstract void PlayOnStart();

	public CriAtomExPlayback Play(string cueName)
	{
		if (player == null)
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		CriAtomExAcb acb = GetAcb();
		player.SetCue(acb, cueName);
		return InternalPlayCue();
	}

	public CriAtomExPlayback Play(int cueId)
	{
		if (player == null)
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		CriAtomExAcb acb = GetAcb();
		player.SetCue(acb, cueId);
		return InternalPlayCue();
	}

	protected CriAtomExPlayback InternalPlayCue()
	{
		if (!hasValidPosition)
		{
			SetInitialSourcePosition();
			hasValidPosition = true;
		}
		if (status == Status.Stop)
		{
			player.Loop(_loop);
		}
		return player.Start();
	}

	public void Stop()
	{
		if (player != null)
		{
			player.Stop();
		}
	}

	public void Pause(bool sw)
	{
		if (player != null)
		{
			if (!sw)
			{
				player.Resume(CriAtomEx.ResumeMode.PausedPlayback);
			}
			else
			{
				player.Pause();
			}
		}
	}

	public bool IsPaused()
	{
		if (player == null)
		{
			return false;
		}
		return player.IsPaused();
	}

	public void SetBusSendLevel(string busName, float level)
	{
		if (player != null)
		{
			player.SetBusSendLevel(busName, level);
			SetNeedToPlayerUpdateAll();
		}
	}

	[Obsolete("Use CriAtomSource.SetBusSendLevel(string, float)")]
	public void SetBusSendLevel(int busId, float level)
	{
		if (player != null)
		{
			player.SetBusSendLevel(busId, level);
			SetNeedToPlayerUpdateAll();
		}
	}

	public void SetBusSendLevelOffset(string busName, float levelOffset)
	{
		if (player != null)
		{
			player.SetBusSendLevelOffset(busName, levelOffset);
			SetNeedToPlayerUpdateAll();
		}
	}

	[Obsolete("Use CriAtomSource.SetBusSendLevelOffset(string, float)")]
	public void SetBusSendLevelOffset(int busId, float levelOffset)
	{
		if (player != null)
		{
			player.SetBusSendLevelOffset(busId, levelOffset);
			SetNeedToPlayerUpdateAll();
		}
	}

	public void SetAisacControl(string controlName, float value)
	{
		if (player != null)
		{
			player.SetAisacControl(controlName, value);
			SetNeedToPlayerUpdateAll();
		}
	}

	[Obsolete("Use CriAtomSource.SetAisacControl")]
	public void SetAisac(string controlName, float value)
	{
		SetAisacControl(controlName, value);
	}

	public void SetAisacControl(uint controlId, float value)
	{
		if (player != null)
		{
			player.SetAisacControl(controlId, value);
			SetNeedToPlayerUpdateAll();
		}
	}

	[Obsolete("Use CriAtomSource.SetAisacControl")]
	public void SetAisac(uint controlId, float value)
	{
		SetAisacControl(controlId, value);
	}

	public void AttachToAnalyzer(CriAtomExOutputAnalyzer analyzer)
	{
		if (player != null)
		{
			analyzer.AttachExPlayer(player);
		}
	}

	public void DetachFromAnalyzer(CriAtomExOutputAnalyzer analyzer)
	{
		analyzer.DetachExPlayer();
	}
}
