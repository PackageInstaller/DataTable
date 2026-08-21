using System;
using System.Collections;
using System.IO;
using System.Runtime.InteropServices;
using AOT;
using CriMana.Detail;
using CriWare;
using UnityEngine;

namespace CriMana;

public class Player : CriDisposable
{
	public enum Status
	{
		Stop,
		Dechead,
		WaitPrep,
		Prep,
		Ready,
		Playing,
		PlayEnd,
		Error,
		StopProcessing,
		ReadyForRendering
	}

	public enum SetMode
	{
		New,
		Append,
		AppendRepeatedly
	}

	public enum MovieEventSyncMode
	{
		FrameTime,
		PlayBackTime
	}

	public enum AudioTrack
	{
		Off,
		Auto
	}

	public enum TimerType
	{
		None,
		System,
		Audio,
		User,
		Manual
	}

	public delegate void CuePointCallback(ref EventPoint eventPoint);

	public delegate void StatusChangeCallback(Status status);

	public delegate void SubtitleChangeCallback(IntPtr subtitleBuffer);

	public delegate Shader ShaderDispatchCallback(MovieInfo movieInfo, bool additiveMode);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	internal delegate void CuePointCallbackFromNativeDelegate(IntPtr ptr1, IntPtr ptr2, [In] ref EventPoint eventPoint);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	internal delegate void SubtitleCallbackFromNativeDelegate(IntPtr ptr1, IntPtr ptr2);

	public enum CriManaUnityPlayer_RenderEventAction
	{
		UPDATE = 0,
		INITIALIZE = 256,
		RENDER = 512,
		DESTROY = 768
	}

	private const int InvalidPlayerId = -1;

	private static Player updatingPlayer;

	private int playerId = -1;

	private bool isDisposed;

	private Status internalrequiredStatus;

	private Status _nativeStatus;

	private Status? lastNativeStatus;

	private Status? lastPlayerStatus;

	private bool wasStopping;

	private bool isPreparingForRendering;

	private bool isNativeStartInvoked;

	private bool isNativeInitialized;

	private RendererResource rendererResource;

	private MovieInfo _movieInfo = new MovieInfo();

	private FrameInfo _frameInfo = new FrameInfo();

	private bool isMovieInfoAvailable;

	private bool isFrameInfoAvailable;

	private ShaderDispatchCallback _shaderDispatchCallback;

	private bool enableSubtitle;

	private int subtitleBufferSize;

	private uint droppedFrameCount;

	private CriAtomExPlayer _atomExPlayer;

	private CriAtomExPlayer _subAtomExPlayer;

	private CriAtomExPlayer _extraAtomExPlayer;

	private CriAtomEx3dSource _atomEx3Dsource;

	private TimerType _timerType = TimerType.Audio;

	private bool isStoppingForSeek;

	public CuePointCallback cuePointCallback;

	public StatusChangeCallback statusChangeCallback;

	private Status requiredStatus
	{
		get
		{
			return internalrequiredStatus;
		}
		set
		{
			internalrequiredStatus = value;
			switch (value)
			{
			case Status.Stop:
				wasStopping = true;
				break;
			case Status.ReadyForRendering:
				isPreparingForRendering = true;
				break;
			}
			InvokePlayerStatusCheck();
		}
	}

	public bool additiveMode { get; set; }

	public int maxFrameDrop { get; set; }

	public bool applyTargetAlpha { get; set; }

	public bool uiRenderMode { get; set; }

	public bool isFrameAvailable => isFrameInfoAvailable;

	public MovieInfo movieInfo
	{
		get
		{
			if (!isMovieInfoAvailable)
			{
				return null;
			}
			return _movieInfo;
		}
	}

	public FrameInfo frameInfo
	{
		get
		{
			if (!isFrameAvailable)
			{
				return null;
			}
			return _frameInfo;
		}
	}

	public Status status
	{
		get
		{
			if (_nativeStatus == Status.Error)
			{
				return Status.Error;
			}
			if (wasStopping && _nativeStatus != Status.Stop)
			{
				return Status.StopProcessing;
			}
			if (requiredStatus == Status.ReadyForRendering)
			{
				if (_nativeStatus == Status.Playing)
				{
					if (rendererResource == null || !rendererResource.IsPrepared())
					{
						return Status.Prep;
					}
					return Status.ReadyForRendering;
				}
				return Status.Prep;
			}
			if (_nativeStatus == Status.Ready)
			{
				if (rendererResource == null)
				{
					return Status.Prep;
				}
				return Status.Ready;
			}
			return _nativeStatus;
		}
	}

	public Status nativeStatus => _nativeStatus;

	public int numberOfEntries => NativeMethods_GetNumberOfEntry(playerId);

	public IntPtr subtitleBuffer { get; private set; }

	public int subtitleSize { get; private set; }

	public CriAtomExPlayer atomExPlayer => _atomExPlayer;

	public CriAtomExPlayer subAtomExPlayer => _subAtomExPlayer;

	public CriAtomExPlayer extraAtomExPlayer => _extraAtomExPlayer;

	public CriAtomEx3dSource atomEx3DsourceForAmbisonics => _atomEx3Dsource;

	public TimerType timerType => _timerType;

	public CriManaMoviePlayerHolder playerHolder { get; set; }

	public bool isAlive => playerId != -1;

	public event SubtitleChangeCallback OnSubtitleChanged;

	public Player()
	{
		if (!CriManaPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriManaPlugin is not initialized.");
		}
		playerId = NativeMethods_Create();
		additiveMode = false;
		maxFrameDrop = 0;
		SetupPlayerHolder();
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Mana);
	}

	public Player(bool advanced_audio_mode, bool ambisonics_mode, uint max_path_length)
	{
		if (!CriManaPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriManaPlugin is not initialized.");
		}
		if (advanced_audio_mode || max_path_length != 0)
		{
			playerId = NativeMethods_CreateWithParameters(advanced_audio_mode, max_path_length);
			if (advanced_audio_mode)
			{
				_atomExPlayer = new CriAtomExPlayer(NativeMethods_GetAtomExPlayerByTrackId(playerId, 0u));
				_subAtomExPlayer = new CriAtomExPlayer(NativeMethods_GetAtomExPlayerByTrackId(playerId, 1u));
				_extraAtomExPlayer = new CriAtomExPlayer(NativeMethods_GetAtomExPlayerByTrackId(playerId, 2u));
				if (ambisonics_mode)
				{
					_atomEx3Dsource = new CriAtomEx3dSource();
					_atomExPlayer.Set3dSource(_atomEx3Dsource);
					_atomExPlayer.SetPanType(CriAtomEx.PanType.Pos3d);
					_atomExPlayer.UpdateAll();
				}
			}
		}
		else
		{
			playerId = NativeMethods_Create();
		}
		additiveMode = false;
		maxFrameDrop = 0;
		SetupPlayerHolder();
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Mana);
	}

	~Player()
	{
		Dispose(disposing: false);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	public void CreateRendererResource(int width, int height, bool alpha)
	{
		MovieInfo movieInfo = new MovieInfo();
		movieInfo.hasAlpha = alpha;
		movieInfo.width = (uint)width;
		movieInfo.height = (uint)height;
		movieInfo.dispWidth = (uint)width;
		movieInfo.dispHeight = (uint)height;
		movieInfo.codecType = CodecType.SofdecPrime;
		movieInfo.alphaCodecType = CodecType.SofdecPrime;
		Shader userShader = ((_shaderDispatchCallback == null) ? null : _shaderDispatchCallback(this.movieInfo, additiveMode));
		if (rendererResource != null && !rendererResource.IsSuitable(playerId, movieInfo, additiveMode, userShader))
		{
			rendererResource.Dispose();
			rendererResource = null;
		}
		if (rendererResource == null)
		{
			rendererResource = RendererResourceFactory.DispatchAndCreate(playerId, movieInfo, additiveMode, userShader);
		}
	}

	public void DisposeRendererResource()
	{
		if (rendererResource != null)
		{
			rendererResource.Dispose();
			rendererResource = null;
		}
	}

	public void Prepare()
	{
		wasStopping = false;
		if (_nativeStatus == Status.Stop || _nativeStatus == Status.PlayEnd)
		{
			requiredStatus = Status.Ready;
			PrepareNativePlayer();
			UpdateNativePlayer();
		}
	}

	public void PrepareForRendering()
	{
		if (requiredStatus == Status.Ready)
		{
			Pause(sw: true);
			requiredStatus = Status.ReadyForRendering;
		}
		else if (_nativeStatus == Status.Stop || _nativeStatus == Status.PlayEnd)
		{
			Start();
			Pause(sw: true);
			requiredStatus = Status.ReadyForRendering;
		}
	}

	public void Start()
	{
		wasStopping = false;
		if (requiredStatus == Status.ReadyForRendering)
		{
			requiredStatus = Status.Playing;
			Pause(sw: false);
			UpdateNativePlayer();
		}
		else
		{
			requiredStatus = Status.Playing;
			if (_nativeStatus == Status.Stop || _nativeStatus == Status.PlayEnd)
			{
				PrepareNativePlayer();
				UpdateNativePlayer();
			}
		}
		if (rendererResource != null)
		{
			rendererResource.OnPlayerStart();
		}
		isStoppingForSeek = false;
	}

	public void Stop()
	{
		isStoppingForSeek = false;
		requiredStatus = Status.Stop;
		if (rendererResource != null)
		{
			rendererResource.OnPlayerStop();
		}
		if (playerId != -1)
		{
			NativeMethods_Stop(playerId);
			UpdateNativePlayer();
		}
		DisableInfos();
	}

	public void StopForSeek()
	{
		if (rendererResource != null && !rendererResource.OnPlayerStopForSeek())
		{
			Debug.LogWarning("[CRIWARE] StopForSeek is not supported on this platform/codec.");
			Stop();
			return;
		}
		requiredStatus = Status.Stop;
		if (playerId != -1)
		{
			isStoppingForSeek = true;
			NativeMethods_Stop(playerId);
			UpdateNativePlayer();
		}
		DisableInfos(keepFrameInfo: true);
	}

	public void Pause(bool sw)
	{
		NativeMethods_Pause(playerId, sw ? 1 : 0);
		if (rendererResource != null)
		{
			rendererResource.OnPlayerPause(sw, triggredFromApplciationPause: false);
		}
	}

	public bool IsPaused()
	{
		return NativeMethods_IsPaused(playerId);
	}

	public bool SetFile(CriFsBinder binder, string moviePath, SetMode setMode = SetMode.New)
	{
		IntPtr binder2 = binder?.nativeHandle ?? IntPtr.Zero;
		if (!CriWareExtension.TryGetFilePath(moviePath, out moviePath) && binder == null && Common.IsStreamingAssetsPath(moviePath))
		{
			moviePath = Path.Combine(Common.streamingAssetsPath, moviePath);
		}
		if (setMode == SetMode.New)
		{
			NativeMethods_SetFile(playerId, binder2, moviePath);
			return true;
		}
		return NativeMethods_EntryFile(playerId, binder2, moviePath, setMode == SetMode.AppendRepeatedly);
	}

	public bool SetData(IntPtr data, long dataSize, SetMode setMode = SetMode.New)
	{
		if (setMode == SetMode.New)
		{
			NativeMethods_SetData(playerId, data, dataSize);
			return true;
		}
		return NativeMethods_EntryData(playerId, data, dataSize, setMode == SetMode.AppendRepeatedly);
	}

	[Obsolete("Use SetData(IntPtr, Int64, SetMode) instead")]
	public bool SetData(byte[] data, long datasize, SetMode setMode = SetMode.New)
	{
		if (setMode == SetMode.New)
		{
			NativeMethods_SetData(playerId, data, datasize);
			return true;
		}
		return NativeMethods_EntryData(playerId, data, datasize, setMode == SetMode.AppendRepeatedly);
	}

	public bool SetContentId(CriFsBinder binder, int contentId, SetMode setMode = SetMode.New)
	{
		if (binder == null)
		{
			Debug.LogError("[CRIWARE] CriFsBinder is null");
			return false;
		}
		if (setMode == SetMode.New)
		{
			NativeMethods_SetContentId(playerId, binder.nativeHandle, contentId);
			return true;
		}
		return NativeMethods_EntryContentId(playerId, binder.nativeHandle, contentId, setMode == SetMode.AppendRepeatedly);
	}

	public bool SetFileRange(string filePath, ulong offset, long range, SetMode setMode = SetMode.New)
	{
		if (setMode == SetMode.New)
		{
			NativeMethods_SetFileRange(playerId, filePath, offset, range);
			return true;
		}
		return NativeMethods_EntryFileRange(playerId, filePath, offset, range, setMode == SetMode.AppendRepeatedly);
	}

	public void Loop(bool sw)
	{
		NativeMethods_Loop(playerId, sw ? 1 : 0);
	}

	public void SetAudioBaseConcatenation(bool enabled)
	{
		NativeMethods_SetAudioBaseConcatenation(playerId, enabled);
	}

	public void SetMasterTimerType(TimerType timerType)
	{
		_timerType = timerType;
		NativeMethods_SetMasterTimerType(playerId, timerType);
	}

	public void SetSeekPosition(int frameNumber)
	{
		NativeMethods_SetSeekPosition(playerId, frameNumber);
	}

	public void SetMovieEventSyncMode(MovieEventSyncMode mode)
	{
		NativeMethods_SetMovieEventSyncMode(playerId, mode);
	}

	public void SetSpeed(float speed)
	{
		NativeMethods_SetSpeed(playerId, speed);
	}

	public void SetMaxPictureDataSize(uint maxDataSize)
	{
		NativeMethods_SetMaxPictureDataSize(playerId, maxDataSize);
	}

	public void SetBufferingTime(float sec)
	{
		NativeMethods_SetBufferingTime(playerId, sec);
	}

	public void SetMinBufferSize(int min_buffer_size)
	{
		NativeMethods_SetMinBufferSize(playerId, min_buffer_size);
	}

	public void SetAudioTrack(int track)
	{
		NativeMethods_SetAudioTrack(playerId, track);
	}

	public void SetAudioTrack(AudioTrack track)
	{
		switch (track)
		{
		case AudioTrack.Off:
			NativeMethods_SetAudioTrack(playerId, -1);
			break;
		case AudioTrack.Auto:
			NativeMethods_SetAudioTrack(playerId, 100);
			break;
		}
	}

	public void SetSubAudioTrack(int track)
	{
		NativeMethods_SetSubAudioTrack(playerId, track);
	}

	public void SetSubAudioTrack(AudioTrack track)
	{
		switch (track)
		{
		case AudioTrack.Off:
			NativeMethods_SetSubAudioTrack(playerId, -1);
			break;
		case AudioTrack.Auto:
			NativeMethods_SetSubAudioTrack(playerId, 100);
			break;
		}
	}

	public void SetExtraAudioTrack(int track)
	{
		NativeMethods_SetExtraAudioTrack(playerId, track);
	}

	public void SetExtraAudioTrack(AudioTrack track)
	{
		switch (track)
		{
		case AudioTrack.Off:
			NativeMethods_SetExtraAudioTrack(playerId, -1);
			break;
		case AudioTrack.Auto:
			NativeMethods_SetExtraAudioTrack(playerId, 100);
			break;
		}
	}

	public void SetVolume(float volume)
	{
		NativeMethods_SetVolume(playerId, volume);
	}

	public float GetVolume()
	{
		return NativeMethods_GetVolume(playerId);
	}

	public void SetSubAudioVolume(float volume)
	{
		NativeMethods_SetSubAudioVolume(playerId, volume);
	}

	public float GetSubAudioVolume()
	{
		return NativeMethods_GetSubAudioVolume(playerId);
	}

	public void SetExtraAudioVolume(float volume)
	{
		NativeMethods_SetExtraAudioVolume(playerId, volume);
	}

	public float GetExtraAudioVolume()
	{
		return NativeMethods_GetExtraAudioVolume(playerId);
	}

	public void SetBusSendLevel(string bus_name, float level)
	{
		NativeMethods_SetBusSendLevelByName(playerId, bus_name, level);
	}

	public void SetSubAudioBusSendLevel(string bus_name, float volume)
	{
		NativeMethods_SetSubAudioBusSendLevelByName(playerId, bus_name, volume);
	}

	public void SetExtraAudioBusSendLevel(string bus_name, float volume)
	{
		NativeMethods_SetExtraAudioBusSendLevelByName(playerId, bus_name, volume);
	}

	public void SetSubtitleChannel(int channel)
	{
		enableSubtitle = channel != -1;
		if (enableSubtitle)
		{
			NativeMethods_SetSubtitleCallback(playerId, SubtitleCallbackFromNative);
			if (isMovieInfoAvailable)
			{
				AllocateSubtitleBuffer((int)movieInfo.maxSubtitleSize);
			}
		}
		else
		{
			DeallocateSubtitleBuffer();
			NativeMethods_SetSubtitleCallback(playerId, null);
		}
		NativeMethods_SetSubtitleChannel(playerId, channel);
	}

	public void SetShaderDispatchCallback(ShaderDispatchCallback shaderDispatchCallback)
	{
		_shaderDispatchCallback = shaderDispatchCallback;
	}

	public long GetTime()
	{
		return NativeMethods_GetTime(playerId);
	}

	public int GetDisplayedFrameNo()
	{
		if (rendererResource != null)
		{
			int displayedFrameNo = rendererResource.GetDisplayedFrameNo();
			if (displayedFrameNo >= 0)
			{
				return displayedFrameNo;
			}
		}
		return NativeMethods_GetDisplayedFrameNo(playerId);
	}

	public bool HasRenderedNewFrame()
	{
		if (rendererResource == null)
		{
			return false;
		}
		return rendererResource.HasRenderedNewFrame();
	}

	public void SetAsrRackId(int asrRackId)
	{
		NativeMethods_SetAsrRackId(playerId, asrRackId);
	}

	public void SetTimeStretchQuality(float quality)
	{
		NativeMethods_SetTimeStretchQuality(playerId, quality);
	}

	public void SetDecryptionKey(ulong key)
	{
		NativeMethods_SetDecryptionKey(playerId, key);
	}

	public void UpdateWithUserTime(ulong timeCount, ulong timeUnit)
	{
		if (_timerType != TimerType.User)
		{
			Debug.LogError("[CRIWARE] Timer type is invalid.");
		}
		NativeMethods_SetUserTime(playerId, timeCount, timeUnit);
		InternalUpdate();
	}

	public void SetManualTimerUnit(ulong timeUnitN, ulong timeUnitD)
	{
		if (_timerType != TimerType.Manual)
		{
			Debug.LogError("[CRIWARE] Timer type is invalid.");
		}
		NativeMethods_SetManualTimerUnit(playerId, timeUnitN, timeUnitD);
	}

	public void UpdateWithManualTimeAdvanced()
	{
		if (_timerType != TimerType.Manual)
		{
			Debug.LogError("[CRIWARE] Timer type is invalid.");
		}
		NativeMethods_AdvanceManualTimer(playerId);
		InternalUpdate();
	}

	public void Update()
	{
		if (_timerType != TimerType.User && _timerType != TimerType.Manual)
		{
			InternalUpdate();
		}
	}

	public void SyncMasterTimer()
	{
		NativeMethods_SyncMasterTimer(playerId);
	}

	public void OnWillRenderObject(CriManaMovieMaterialBase sender)
	{
		if (rendererResource != null && _nativeStatus == Status.Playing)
		{
			rendererResource.UpdateTextures();
			IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.RENDER);
		}
	}

	public bool UpdateMaterial(Material material)
	{
		if (rendererResource != null && isFrameInfoAvailable)
		{
			if (rendererResource.UpdateMaterial(material))
			{
				return requiredStatus != Status.ReadyForRendering;
			}
			return false;
		}
		return false;
	}

	public void PauseOnApplicationPause(bool sw)
	{
		NativeMethods_Pause(playerId, sw ? 1 : 0);
		if (rendererResource != null)
		{
			rendererResource.OnPlayerPause(sw, triggredFromApplciationPause: true);
		}
	}

	public void IssuePluginEvent(CriManaUnityPlayer_RenderEventAction renderEventAction)
	{
		int eventID = (int)((uint)CriManaPlugin.renderingEventOffset | (uint)renderEventAction) | playerId;
		GL.IssuePluginEvent(NativeMethods_GetRenderEventFunc(), eventID);
	}

	private void Dispose(bool disposing)
	{
		if (isDisposed)
		{
			return;
		}
		isDisposed = true;
		CriDisposableObjectManager.Unregister(this);
		int num = 0;
		if (rendererResource != null && playerId != -1)
		{
			IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.DESTROY);
			num = rendererResource.GetNumberOfFrameBeforeDestroy(playerId);
		}
		DisposeRendererResource();
		DeallocateSubtitleBuffer();
		if (playerId != -1)
		{
			if (atomExPlayer != null)
			{
				_atomExPlayer.Dispose();
				_atomExPlayer = null;
			}
			if (subAtomExPlayer != null)
			{
				_subAtomExPlayer.Dispose();
				_subAtomExPlayer = null;
			}
			if (extraAtomExPlayer != null)
			{
				_extraAtomExPlayer.Dispose();
				_extraAtomExPlayer = null;
			}
			NativeMethods_Destroy(playerId);
			if (atomEx3DsourceForAmbisonics != null)
			{
				_atomEx3Dsource.Dispose();
				_atomEx3Dsource = null;
			}
		}
		if (playerHolder != null)
		{
			if (num > 0)
			{
				playerHolder.StartCoroutine(IssuePluginUpdatesForFrames(num, playerHolder, destroy: true, playerId));
			}
			else
			{
				UnityEngine.Object.Destroy(playerHolder.gameObject);
			}
		}
		else if (num > 0)
		{
			Debug.LogError("[CRIWARE] Player couldn't destroy internal resources.");
		}
		playerId = -1;
		cuePointCallback = null;
		OnSubtitleChanged = null;
	}

	private void InternalUpdate()
	{
		NativeMethods_SyncUpdate(playerId);
		if (requiredStatus == Status.Stop)
		{
			if (_nativeStatus != Status.Stop)
			{
				UpdateNativePlayer();
			}
			return;
		}
		switch (_nativeStatus)
		{
		case Status.Dechead:
			UpdateNativePlayer();
			if (_nativeStatus != Status.WaitPrep)
			{
				break;
			}
			goto case Status.WaitPrep;
		case Status.WaitPrep:
		{
			NativeMethods_GetMovieInfo(playerId, _movieInfo);
			isMovieInfoAvailable = true;
			if (enableSubtitle)
			{
				AllocateSubtitleBuffer((int)movieInfo.maxSubtitleSize);
			}
			Shader userShader = ((_shaderDispatchCallback == null) ? null : _shaderDispatchCallback(movieInfo, additiveMode));
			if (rendererResource != null && !rendererResource.IsSuitable(playerId, _movieInfo, additiveMode, userShader))
			{
				rendererResource.Dispose();
				isFrameInfoAvailable = false;
				rendererResource = null;
			}
			if (rendererResource == null)
			{
				rendererResource = RendererResourceFactory.DispatchAndCreate(playerId, _movieInfo, additiveMode, userShader);
				if (rendererResource == null)
				{
					Stop();
					return;
				}
			}
			rendererResource.SetApplyTargetAlpha(applyTargetAlpha);
			rendererResource.SetUiRenderMode(uiRenderMode);
			rendererResource.AttachToPlayer(playerId);
			if (requiredStatus != Status.Ready)
			{
				if (requiredStatus != Status.Playing && requiredStatus != Status.ReadyForRendering)
				{
					break;
				}
				NativeMethods_Start(playerId);
				isNativeStartInvoked = true;
				if (isNativeInitialized)
				{
					IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.DESTROY);
				}
				IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.INITIALIZE);
				isNativeInitialized = true;
			}
			goto case Status.Prep;
		}
		case Status.Prep:
			UpdateNativePlayer();
			if (_nativeStatus == Status.Ready)
			{
				goto case Status.Ready;
			}
			if (_nativeStatus != Status.Playing)
			{
				break;
			}
			goto case Status.Playing;
		case Status.Ready:
			if (requiredStatus != Status.Playing && requiredStatus != Status.ReadyForRendering)
			{
				break;
			}
			if (!isNativeStartInvoked)
			{
				NativeMethods_Start(playerId);
				isNativeStartInvoked = true;
				if (isNativeInitialized)
				{
					IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.DESTROY);
				}
				IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.INITIALIZE);
				isNativeInitialized = true;
			}
			goto case Status.Playing;
		case Status.Playing:
			UpdateNativePlayer();
			if (_nativeStatus == Status.Playing)
			{
				bool frameDrop = maxFrameDrop < 0 || droppedFrameCount < maxFrameDrop;
				bool flag = true;
				bool flag2 = false;
				while (flag)
				{
					flag2 = rendererResource.UpdateFrame(playerId, _frameInfo, ref frameDrop);
					if ((flag2 & frameDrop) && (maxFrameDrop < 0 || droppedFrameCount < maxFrameDrop))
					{
						droppedFrameCount++;
						if (maxFrameDrop > 0 && droppedFrameCount == maxFrameDrop)
						{
							frameDrop = false;
						}
					}
					else if (!(flag2 & frameDrop))
					{
						flag = false;
						if (flag2)
						{
							droppedFrameCount = 0u;
						}
					}
				}
				isFrameInfoAvailable |= flag2;
				IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.UPDATE);
			}
			else if (_nativeStatus != Status.PlayEnd)
			{
			}
			break;
		case Status.Error:
			UpdateNativePlayer();
			break;
		}
		if (_nativeStatus == Status.Error)
		{
			DisableInfos();
		}
	}

	private IEnumerator IssuePluginUpdatesForFrames(int frameCount, MonoBehaviour playerHolder, bool destroy, int playerId)
	{
		while (frameCount > 0)
		{
			IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.UPDATE);
			NativeMethods_SyncUpdate(playerId);
			frameCount--;
			yield return null;
		}
		if (destroy)
		{
			UnityEngine.Object.Destroy(playerHolder.gameObject);
		}
	}

	private void DisableInfos(bool keepFrameInfo = false)
	{
		if (!keepFrameInfo)
		{
			isFrameInfoAvailable = false;
			isMovieInfoAvailable = false;
		}
		isNativeStartInvoked = false;
		subtitleSize = 0;
	}

	private void PrepareNativePlayer()
	{
		if (cuePointCallback != null)
		{
			NativeMethods_SetCuePointCallback(playerId, CuePointCallbackFromNative);
		}
		NativeMethods_Prepare(playerId);
	}

	private void UpdateNativePlayer()
	{
		updatingPlayer = this;
		uint num = (uint)subtitleBufferSize;
		_nativeStatus = (Status)NativeMethods_Update(playerId);
		if (!lastNativeStatus.HasValue || lastNativeStatus != _nativeStatus || isPreparingForRendering)
		{
			lastNativeStatus = _nativeStatus;
			InvokePlayerStatusCheck();
		}
		subtitleSize = (int)num;
		updatingPlayer = null;
		if (isNativeInitialized && (_nativeStatus == Status.StopProcessing || _nativeStatus == Status.Stop))
		{
			isNativeInitialized = false;
			if (!isStoppingForSeek || rendererResource == null || !rendererResource.ShouldSkipDestroyOnStopForSeek())
			{
				IssuePluginEvent(CriManaUnityPlayer_RenderEventAction.DESTROY);
			}
		}
	}

	private void InvokePlayerStatusCheck()
	{
		Status status = this.status;
		if (!lastPlayerStatus.HasValue || lastPlayerStatus != status)
		{
			lastPlayerStatus = status;
			if (statusChangeCallback != null)
			{
				statusChangeCallback(status);
			}
			if (isPreparingForRendering && this.status != Status.Prep)
			{
				isPreparingForRendering = false;
			}
		}
	}

	private void AllocateSubtitleBuffer(int size)
	{
		if (subtitleBufferSize < size)
		{
			DeallocateSubtitleBuffer();
			subtitleBuffer = Marshal.AllocHGlobal(size);
			subtitleBufferSize = size;
			subtitleSize = 0;
		}
		for (int i = 0; i < subtitleBufferSize; i++)
		{
			Marshal.WriteByte(subtitleBuffer, i, 0);
		}
	}

	private void DeallocateSubtitleBuffer()
	{
		if (subtitleBuffer != IntPtr.Zero)
		{
			Marshal.FreeHGlobal(subtitleBuffer);
			subtitleBuffer = IntPtr.Zero;
			subtitleBufferSize = 0;
			subtitleSize = 0;
		}
	}

	internal void SetupPlayerHolder()
	{
		if (Application.isPlaying)
		{
			GameObject gameObject = new GameObject("CriManaMovieResources");
			playerHolder = gameObject.AddComponent<CriManaMoviePlayerHolder>();
			playerHolder.player = this;
			playerHolder = playerHolder;
		}
	}

	[MonoPInvokeCallback(typeof(CuePointCallbackFromNativeDelegate))]
	private static void CuePointCallbackFromNative(IntPtr ptr1, IntPtr ptr2, [In] ref EventPoint eventPoint)
	{
		if (updatingPlayer.cuePointCallback != null)
		{
			updatingPlayer.cuePointCallback(ref eventPoint);
		}
	}

	[MonoPInvokeCallback(typeof(SubtitleCallbackFromNativeDelegate))]
	private static void SubtitleCallbackFromNative(IntPtr ptr1, IntPtr ptr2)
	{
		if (updatingPlayer.OnSubtitleChanged != null)
		{
			updatingPlayer.subtitleSize = NativeMethods_GetSubtitleOnTime(updatingPlayer.playerId, updatingPlayer.subtitleBuffer, updatingPlayer.subtitleBufferSize);
			updatingPlayer.OnSubtitleChanged(updatingPlayer.subtitleBuffer);
		}
	}

	internal static int NativeMethods_GetNumberOfEntry(int playerId)
	{
		using (new CriDurationMeasurementScope("CRIWAREDC7A9039"))
		{
			return CRIWAREDC7A9039(playerId);
		}
	}

	internal static int NativeMethods_Create()
	{
		using (new CriDurationMeasurementScope("CRIWAREE876C886"))
		{
			return CRIWAREE876C886();
		}
	}

	internal static int NativeMethods_CreateWithParameters(bool useAtomExPlayer, uint maxPathLength)
	{
		using (new CriDurationMeasurementScope("CRIWARE4A87DB5C"))
		{
			return CRIWARE4A87DB5C(useAtomExPlayer, maxPathLength);
		}
	}

	internal static IntPtr NativeMethods_GetAtomExPlayerByTrackId(int player_id, uint track_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE8B2D675B"))
		{
			return CRIWARE8B2D675B(player_id, track_id);
		}
	}

	internal void NativeMethods_Stop(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE8303B4D4"))
		{
			CRIWARE8303B4D4(player_id);
		}
	}

	internal void NativeMethods_Pause(int player_id, int sw)
	{
		using (new CriDurationMeasurementScope("CRIWAREB8E6C310"))
		{
			CRIWAREB8E6C310(player_id, sw);
		}
	}

	internal static bool NativeMethods_IsPaused(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE26DD65CC"))
		{
			return CRIWARE26DD65CC(player_id);
		}
	}

	internal static void NativeMethods_SetFile(int player_id, IntPtr binder, string path)
	{
		using (new CriDurationMeasurementScope("CRIWAREE22B49D8"))
		{
			CRIWAREE22B49D8(player_id, binder, path);
		}
	}

	internal static bool NativeMethods_EntryFile(int player_id, IntPtr binder, string path, bool repeat)
	{
		using (new CriDurationMeasurementScope("CRIWAREB48F72B8"))
		{
			return CRIWAREB48F72B8(player_id, binder, path, repeat);
		}
	}

	internal static void NativeMethods_SetData(int player_id, IntPtr data, long datasize)
	{
		using (new CriDurationMeasurementScope("CRIWARE0C529F63"))
		{
			CRIWARE0C529F63(player_id, data, datasize);
		}
	}

	internal static void NativeMethods_SetData(int player_id, byte[] data, long datasize)
	{
		using (new CriDurationMeasurementScope("CRIWARE0C529F63"))
		{
			CRIWARE0C529F63(player_id, data, datasize);
		}
	}

	internal static bool NativeMethods_EntryData(int player_id, IntPtr data, long datasize, bool repeat)
	{
		using (new CriDurationMeasurementScope("CRIWARE13AF3A46"))
		{
			return CRIWARE13AF3A46(player_id, data, datasize, repeat);
		}
	}

	internal static bool NativeMethods_EntryData(int player_id, byte[] data, long datasize, bool repeat)
	{
		using (new CriDurationMeasurementScope("CRIWARE13AF3A46"))
		{
			return CRIWARE13AF3A46(player_id, data, datasize, repeat);
		}
	}

	internal static void NativeMethods_SetContentId(int player_id, IntPtr binder, int content_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE341F577B"))
		{
			CRIWARE341F577B(player_id, binder, content_id);
		}
	}

	internal static bool NativeMethods_EntryContentId(int player_id, IntPtr binder, int content_id, bool repeat)
	{
		using (new CriDurationMeasurementScope("CRIWARE7AE54FDD"))
		{
			return CRIWARE7AE54FDD(player_id, binder, content_id, repeat);
		}
	}

	internal static void NativeMethods_SetFileRange(int player_id, string path, ulong offset, long range)
	{
		using (new CriDurationMeasurementScope("CRIWARE4036379F"))
		{
			CRIWARE4036379F(player_id, path, offset, range);
		}
	}

	internal static bool NativeMethods_EntryFileRange(int player_id, string path, ulong offset, long range, bool repeat)
	{
		using (new CriDurationMeasurementScope("CRIWARE8B9E05D1"))
		{
			return CRIWARE8B9E05D1(player_id, path, offset, range, repeat);
		}
	}

	internal void NativeMethods_Loop(int player_id, int sw)
	{
		using (new CriDurationMeasurementScope("CRIWAREC8B899BE"))
		{
			CRIWAREC8B899BE(player_id, sw);
		}
	}

	internal static void NativeMethods_SetAudioBaseConcatenation(int player_id, bool flag)
	{
		using (new CriDurationMeasurementScope("CRIWARE2F11EF05"))
		{
			CRIWARE2F11EF05(player_id, flag);
		}
	}

	internal static void NativeMethods_SetMasterTimerType(int player_id, TimerType timer_type)
	{
		using (new CriDurationMeasurementScope("CRIWAREB71193FE"))
		{
			CRIWAREB71193FE(player_id, timer_type);
		}
	}

	internal static void NativeMethods_SetSeekPosition(int player_id, int seek_frame_no)
	{
		using (new CriDurationMeasurementScope("CRIWARE4395A3DA"))
		{
			CRIWARE4395A3DA(player_id, seek_frame_no);
		}
	}

	internal static void NativeMethods_SetMovieEventSyncMode(int player_id, MovieEventSyncMode mode)
	{
		using (new CriDurationMeasurementScope("CRIWAREF502498D"))
		{
			CRIWAREF502498D(player_id, mode);
		}
	}

	internal static void NativeMethods_SetSpeed(int player_id, float speed)
	{
		using (new CriDurationMeasurementScope("CRIWARE06A8929C"))
		{
			CRIWARE06A8929C(player_id, speed);
		}
	}

	internal static void NativeMethods_SetMaxPictureDataSize(int player_id, uint max_data_size)
	{
		using (new CriDurationMeasurementScope("CRIWAREA16157B4"))
		{
			CRIWAREA16157B4(player_id, max_data_size);
		}
	}

	internal static void NativeMethods_SetBufferingTime(int player_id, float sec)
	{
		using (new CriDurationMeasurementScope("CRIWARE96E92747"))
		{
			CRIWARE96E92747(player_id, sec);
		}
	}

	internal static void NativeMethods_SetMinBufferSize(int player_id, int min_buffer_size)
	{
		using (new CriDurationMeasurementScope("CRIWAREF8D6A82D"))
		{
			CRIWAREF8D6A82D(player_id, min_buffer_size);
		}
	}

	internal static void NativeMethods_SetAudioTrack(int player_id, int track)
	{
		using (new CriDurationMeasurementScope("CRIWARE6C5FB551"))
		{
			CRIWARE6C5FB551(player_id, track);
		}
	}

	internal static void NativeMethods_SetSubAudioTrack(int player_id, int track)
	{
		using (new CriDurationMeasurementScope("CRIWARE6B983595"))
		{
			CRIWARE6B983595(player_id, track);
		}
	}

	internal static void NativeMethods_SetExtraAudioTrack(int player_id, int track)
	{
		using (new CriDurationMeasurementScope("CRIWARE17CEB774"))
		{
			CRIWARE17CEB774(player_id, track);
		}
	}

	internal static void NativeMethods_SetVolume(int player_id, float vol)
	{
		using (new CriDurationMeasurementScope("CRIWARE6026A40D"))
		{
			CRIWARE6026A40D(player_id, vol);
		}
	}

	internal static float NativeMethods_GetVolume(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWAREC0EF06CB"))
		{
			return CRIWAREC0EF06CB(player_id);
		}
	}

	internal static void NativeMethods_SetSubAudioVolume(int player_id, float vol)
	{
		using (new CriDurationMeasurementScope("CRIWAREFAFCF08A"))
		{
			CRIWAREFAFCF08A(player_id, vol);
		}
	}

	internal static float NativeMethods_GetSubAudioVolume(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWAREAFAF2514"))
		{
			return CRIWAREAFAF2514(player_id);
		}
	}

	internal static void NativeMethods_SetExtraAudioVolume(int player_id, float vol)
	{
		using (new CriDurationMeasurementScope("CRIWAREBD501C85"))
		{
			CRIWAREBD501C85(player_id, vol);
		}
	}

	internal static float NativeMethods_GetExtraAudioVolume(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWAREA035D305"))
		{
			return CRIWAREA035D305(player_id);
		}
	}

	internal static void NativeMethods_SetBusSendLevelByName(int player_id, string bus_name, float level)
	{
		using (new CriDurationMeasurementScope("CRIWARE7664C592"))
		{
			CRIWARE7664C592(player_id, bus_name, level);
		}
	}

	internal static void NativeMethods_SetSubAudioBusSendLevelByName(int player_id, string bus_name, float level)
	{
		using (new CriDurationMeasurementScope("CRIWARE1473A93D"))
		{
			CRIWARE1473A93D(player_id, bus_name, level);
		}
	}

	internal static void NativeMethods_SetExtraAudioBusSendLevelByName(int player_id, string bus_name, float level)
	{
		using (new CriDurationMeasurementScope("CRIWARE29FA2B02"))
		{
			CRIWARE29FA2B02(player_id, bus_name, level);
		}
	}

	internal static void NativeMethods_SetSubtitleCallback(int player_id, SubtitleCallbackFromNativeDelegate cbfunc)
	{
		using (new CriDurationMeasurementScope("CRIWAREFEF2147B"))
		{
			CRIWAREFEF2147B(player_id, cbfunc);
		}
	}

	internal static void NativeMethods_SetSubtitleChannel(int player_id, int channel)
	{
		using (new CriDurationMeasurementScope("CRIWARE275978C3"))
		{
			CRIWARE275978C3(player_id, channel);
		}
	}

	internal static long NativeMethods_GetTime(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWAREBAA8F9D9"))
		{
			return CRIWAREBAA8F9D9(player_id);
		}
	}

	internal static int NativeMethods_GetDisplayedFrameNo(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWAREE460B3D8"))
		{
			return CRIWAREE460B3D8(player_id);
		}
	}

	internal static void NativeMethods_SetAsrRackId(int player_id, int asr_rack_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE5421BA66"))
		{
			CRIWARE5421BA66(player_id, asr_rack_id);
		}
	}

	internal static void NativeMethods_SetTimeStretchQuality(int player_id, float quality)
	{
		using (new CriDurationMeasurementScope("CRIWARE19FBE70F"))
		{
			CRIWARE19FBE70F(player_id, quality);
		}
	}

	internal static void NativeMethods_SetUserTime(int player_id, ulong user_count, ulong user_unit)
	{
		using (new CriDurationMeasurementScope("CRIWARE451BA763"))
		{
			CRIWARE451BA763(player_id, user_count, user_unit);
		}
	}

	internal static void NativeMethods_SetManualTimerUnit(int player_id, ulong timer_unit_n, ulong timer_unit_d)
	{
		using (new CriDurationMeasurementScope("CRIWARE22F128A3"))
		{
			CRIWARE22F128A3(player_id, timer_unit_n, timer_unit_d);
		}
	}

	internal static void NativeMethods_AdvanceManualTimer(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE32377ABC"))
		{
			CRIWARE32377ABC(player_id);
		}
	}

	internal static void NativeMethods_SyncMasterTimer(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE049707B0"))
		{
			CRIWARE049707B0(player_id);
		}
	}

	internal static IntPtr NativeMethods_GetRenderEventFunc()
	{
		using (new CriDurationMeasurementScope("criWareUnity_GetRenderEventFunc"))
		{
			return criWareUnity_GetRenderEventFunc();
		}
	}

	internal static void NativeMethods_Destroy(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE14EB1872"))
		{
			CRIWARE14EB1872(player_id);
		}
	}

	internal static void NativeMethods_SyncUpdate(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWAREEF5D54ED"))
		{
			CRIWAREEF5D54ED(player_id);
		}
	}

	internal static void NativeMethods_GetMovieInfo(int player_id, [Out] MovieInfo movie_info)
	{
		using (new CriDurationMeasurementScope("CRIWAREF77A9B06"))
		{
			CRIWAREF77A9B06(player_id, movie_info);
		}
	}

	internal void NativeMethods_Start(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE949088C1"))
		{
			CRIWARE949088C1(player_id);
		}
	}

	internal void NativeMethods_Prepare(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE959E4269"))
		{
			CRIWARE959E4269(player_id);
		}
	}

	internal static int NativeMethods_Update(int player_id)
	{
		using (new CriDurationMeasurementScope("CRIWARE9D6DF2A5"))
		{
			return CRIWARE9D6DF2A5(player_id);
		}
	}

	internal static void NativeMethods_SetCuePointCallback(int player_id, CuePointCallbackFromNativeDelegate cbfunc)
	{
		using (new CriDurationMeasurementScope("CRIWAREEADB6DEA"))
		{
			CRIWAREEADB6DEA(player_id, cbfunc);
		}
	}

	internal static int NativeMethods_GetSubtitleOnTime(int player_id, IntPtr subtitle_buffer, int subtitle_buffer_size)
	{
		using (new CriDurationMeasurementScope("CRIWARE774161EF"))
		{
			return CRIWARE774161EF(player_id, subtitle_buffer, subtitle_buffer_size);
		}
	}

	internal static void NativeMethods_SetDecryptionKey(int player_id, ulong key)
	{
		using (new CriDurationMeasurementScope("CRIWARE5D3C7FCE"))
		{
			CRIWARE5D3C7FCE(player_id, key);
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWAREE876C886();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWAREC062D006();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWARE4A87DB5C(bool useAtomExPlayer, uint maxPathLength);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE14EB1872(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREE22B49D8(int player_id, IntPtr binder, string path);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE341F577B(int player_id, IntPtr binder, int content_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE4036379F(int player_id, string path, ulong offset, long range);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE0C529F63(int player_id, IntPtr data, long datasize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE0C529F63(int player_id, byte[] data, long datasize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool CRIWAREB48F72B8(int player_id, IntPtr binder, string path, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool CRIWARE7AE54FDD(int player_id, IntPtr binder, int content_id, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool CRIWARE8B9E05D1(int player_id, string path, ulong offset, long range, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool CRIWARE13AF3A46(int player_id, IntPtr data, long datasize, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool CRIWARE13AF3A46(int player_id, byte[] data, long datasize, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE8CB1B7CC(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWAREDC7A9039(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREEADB6DEA(int player_id, CuePointCallbackFromNativeDelegate cbfunc);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREFEF2147B(int player_id, SubtitleCallbackFromNativeDelegate cbfunc);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREF77A9B06(int player_id, [Out] MovieInfo movie_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWARE9D6DF2A5(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE959E4269(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE949088C1(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE8303B4D4(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE4395A3DA(int player_id, int seek_frame_no);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREF502498D(int player_id, MovieEventSyncMode mode);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREB8E6C310(int player_id, int sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool CRIWARE26DD65CC(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREC8B899BE(int player_id, int sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE2F11EF05(int player_id, bool flag);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern long CRIWAREBAA8F9D9(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWARE44413D00(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern IntPtr CRIWARE8B2D675B(int player_id, uint track_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWAREE460B3D8(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE6C5FB551(int player_id, int track);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE6026A40D(int player_id, float vol);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern float CRIWAREC0EF06CB(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE6B983595(int player_id, int track);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREFAFCF08A(int player_id, float vol);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern float CRIWAREAFAF2514(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE17CEB774(int player_id, int track);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREBD501C85(int player_id, float vol);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern float CRIWAREA035D305(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE7664C592(int player_id, string bus_name, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE1473A93D(int player_id, string bus_name, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE29FA2B02(int player_id, string bus_name, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE275978C3(int player_id, int channel);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern int CRIWARE774161EF(int player_id, IntPtr subtitle_buffer, int subtitle_buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE06A8929C(int player_id, float speed);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREA16157B4(int player_id, uint max_data_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE96E92747(int player_id, float sec);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREF8D6A82D(int player_id, int min_buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE5421BA66(int player_id, int asr_rack_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE19FBE70F(int player_id, float quality);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREEF5D54ED(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWAREB71193FE(int player_id, TimerType timer_type);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE451BA763(int player_id, ulong user_count, ulong user_unit);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE22F128A3(int player_id, ulong timer_unit_n, ulong timer_unit_d);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE32377ABC(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE049707B0(int player_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void CRIWARE5D3C7FCE(int player_id, ulong key);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern IntPtr criWareUnity_GetRenderEventFunc();
}
