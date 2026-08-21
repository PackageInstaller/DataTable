using System;
using System.Runtime.InteropServices;

public class CriAtomExPlayer : CriDisposable
{
	public enum Status
	{
		Stop,
		Prep,
		Playing,
		PlayEnd,
		Error
	}

	internal struct Config
	{
		public CriAtomEx.VoiceAllocationMethod voiceAllocationMethod;

		public int maxPathStrings;

		public int maxPath;

		public int maxAisacs;

		public bool updatesTime;

		public bool enableAudioSyncedTimer;

		public static Config Default => new Config
		{
			voiceAllocationMethod = CriAtomEx.VoiceAllocationMethod.Once,
			maxPathStrings = 0,
			maxPath = 0,
			maxAisacs = 8,
			updatesTime = true,
			enableAudioSyncedTimer = false
		};
	}

	public enum TimeStretchParameterId
	{
		Ratio,
		FrameTime,
		Quality
	}

	public enum PitchShifterParameterId
	{
		Pitch,
		Formant,
		Mode
	}

	private bool hasExistingNativeHandle;

	private IntPtr entryPoolHandle = IntPtr.Zero;

	private int _entryPoolCapacity;

	private int max_path;

	public static readonly uint MaxOutputPorts = 8u;

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public bool isAvailable => handle != IntPtr.Zero;

	public int entryPoolCapacity => _entryPoolCapacity;

	private event CriAtomExBeatSync.CbFunc _onBeatSyncCallback;

	public event CriAtomExBeatSync.CbFunc OnBeatSyncCallback
	{
		add
		{
			if (_onBeatSyncCallback == null)
			{
				CriAtom.OnBeatSyncCallback += OnBeatSyncCallbackChainInternal;
			}
			_onBeatSyncCallback += value;
		}
		remove
		{
			_onBeatSyncCallback -= value;
			if (_onBeatSyncCallback == null)
			{
				CriAtom.OnBeatSyncCallback -= OnBeatSyncCallbackChainInternal;
			}
		}
	}

	private event CriAtomExSequencer.EventCallback _onSequenceCallback;

	public event CriAtomExSequencer.EventCallback OnSequenceCallback
	{
		add
		{
			if (_onSequenceCallback == null)
			{
				CriAtomExSequencer.OnCallback += OnSequenceCallbackChainInternal;
			}
			_onSequenceCallback += value;
		}
		remove
		{
			_onSequenceCallback -= value;
			if (_onSequenceCallback == null)
			{
				CriAtomExSequencer.OnCallback -= OnSequenceCallbackChainInternal;
			}
		}
	}

	public CriAtomExPlayer()
		: this(0, 0, enableAudioSyncedTimer: false, IntPtr.Zero)
	{
	}

	public CriAtomExPlayer(int maxPath, int maxPathStrings)
		: this(maxPath, maxPathStrings, enableAudioSyncedTimer: false, IntPtr.Zero)
	{
	}

	public CriAtomExPlayer(bool enableAudioSyncedTimer)
		: this(0, 0, enableAudioSyncedTimer, IntPtr.Zero)
	{
	}

	public CriAtomExPlayer(int maxPath, int maxPathStrings, bool enableAudioSyncedTimer)
		: this(maxPath, maxPathStrings, enableAudioSyncedTimer, IntPtr.Zero)
	{
	}

	public CriAtomExPlayer(IntPtr existingNativeHandle)
		: this(0, 0, enableAudioSyncedTimer: false, existingNativeHandle)
	{
	}

	public CriAtomExPlayer(int maxPath, int maxPathStrings, bool enableAudioSyncedTimer, IntPtr existingNativeHandle)
	{
		if (!CriAtomPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriAtomPlugin is not initialized.");
		}
		Config config = Config.Default;
		config.maxPath = maxPath;
		config.maxPathStrings = maxPathStrings;
		config.enableAudioSyncedTimer = enableAudioSyncedTimer;
		hasExistingNativeHandle = existingNativeHandle != IntPtr.Zero;
		if (hasExistingNativeHandle)
		{
			handle = existingNativeHandle;
		}
		else
		{
			handle = criAtomExPlayer_Create(ref config, IntPtr.Zero, 0);
			max_path = config.maxPath;
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public override void Dispose()
	{
		CriDisposableObjectManager.Unregister(this);
		if (entryPoolHandle != IntPtr.Zero)
		{
			StopWithoutReleaseTime();
			CRIWAREE236F449(entryPoolHandle);
		}
		entryPoolHandle = IntPtr.Zero;
		_entryPoolCapacity = 0;
		if (!hasExistingNativeHandle && isAvailable)
		{
			criAtomExPlayer_Destroy(handle);
		}
		if (_onBeatSyncCallback != null)
		{
			_onBeatSyncCallback = null;
			CriAtom.OnBeatSyncCallback -= OnBeatSyncCallbackChainInternal;
		}
		handle = IntPtr.Zero;
		GC.SuppressFinalize(this);
	}

	public void SetCue(CriAtomExAcb acb, string name)
	{
		criAtomExPlayer_SetCueName(handle, acb?.nativeHandle ?? IntPtr.Zero, name);
	}

	public void SetCue(CriAtomExAcb acb, int id)
	{
		criAtomExPlayer_SetCueId(handle, acb?.nativeHandle ?? IntPtr.Zero, id);
	}

	public void SetCueIndex(CriAtomExAcb acb, int index)
	{
		criAtomExPlayer_SetCueIndex(handle, acb?.nativeHandle ?? IntPtr.Zero, index);
	}

	public void SetContentId(CriFsBinder binder, int contentId)
	{
		criAtomExPlayer_SetContentId(handle, binder?.nativeHandle ?? IntPtr.Zero, contentId);
	}

	public void SetFile(CriFsBinder binder, string path)
	{
		criAtomExPlayer_SetFile(handle, binder?.nativeHandle ?? IntPtr.Zero, path);
	}

	public void SetData(byte[] buffer, int size)
	{
		criAtomExPlayer_SetData(handle, buffer, size);
	}

	public void SetData(IntPtr buffer, int size)
	{
		criAtomExPlayer_SetData(handle, buffer, size);
	}

	public void SetFormat(CriAtomEx.Format format)
	{
		criAtomExPlayer_SetFormat(handle, format);
	}

	public void SetNumChannels(int numChannels)
	{
		criAtomExPlayer_SetNumChannels(handle, numChannels);
	}

	public void SetSamplingRate(int samplingRate)
	{
		criAtomExPlayer_SetSamplingRate(handle, samplingRate);
	}

	public void PrepareEntryPool(int capacity, bool stopOnEmpty)
	{
		if (entryPoolHandle != IntPtr.Zero)
		{
			CRIWAREE236F449(entryPoolHandle);
			_entryPoolCapacity = 0;
			entryPoolHandle = IntPtr.Zero;
		}
		if (capacity > 0)
		{
			entryPoolHandle = CRIWAREA322B0F8(handle, capacity, max_path, stopOnEmpty);
			if (entryPoolHandle != IntPtr.Zero)
			{
				_entryPoolCapacity = capacity;
			}
		}
	}

	public int GetNumEntries()
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return 0;
		}
		return CRIWAREB37289C3(entryPoolHandle);
	}

	public int GetNumConsumedEntries()
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return 0;
		}
		return CRIWARE37386F0F(entryPoolHandle);
	}

	public bool EntryFile(CriFsBinder binder, string path, bool repeat)
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return false;
		}
		return CRIWAREE4291791(entryPoolHandle, binder?.nativeHandle ?? IntPtr.Zero, path, repeat, max_path);
	}

	public bool EntryContentId(CriFsBinder binder, int contentId, bool repeat)
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return false;
		}
		return CRIWARE523ADE9C(entryPoolHandle, binder?.nativeHandle ?? IntPtr.Zero, contentId, repeat);
	}

	public bool EntryData(byte[] buffer, int size, bool repeat)
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return false;
		}
		return CRIWARE07FBFC2E(entryPoolHandle, buffer, size, repeat);
	}

	public bool EntryData(IntPtr buffer, int size, bool repeat)
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return false;
		}
		return CRIWARE07FBFC2E(entryPoolHandle, buffer, size, repeat);
	}

	public bool EntryCue(CriAtomExAcb acb, string name, bool repeat)
	{
		if (entryPoolHandle == IntPtr.Zero)
		{
			return false;
		}
		return CRIWARE1F4B8024(entryPoolHandle, acb?.nativeHandle ?? IntPtr.Zero, name, repeat);
	}

	public CriAtomExPlayback Start()
	{
		if (entryPoolHandle != IntPtr.Zero)
		{
			CRIWAREEFFAFF4A(entryPoolHandle);
		}
		return new CriAtomExPlayback(criAtomExPlayer_Start(handle));
	}

	public CriAtomExPlayback Prepare()
	{
		return new CriAtomExPlayback(criAtomExPlayer_Prepare(handle));
	}

	public bool StartAsync(IntPtr playbackId = default(IntPtr))
	{
		return criAtomExPlayer_StartAsync(handle, playbackId) != 0;
	}

	public bool IsReadyToStartAsync()
	{
		return criAtomExPlayer_IsReadyToStartAsync(handle) != 0;
	}

	public void StopAsync()
	{
		criAtomExPlayer_StopAsync(handle);
	}

	public CriAtomExPlayback GetLastPlaybackId()
	{
		return new CriAtomExPlayback(criAtomExPlayer_GetLastPlaybackId(handle));
	}

	public void Stop(bool ignoresReleaseTime)
	{
		if (isAvailable)
		{
			if (!ignoresReleaseTime)
			{
				criAtomExPlayer_Stop(handle);
			}
			else
			{
				criAtomExPlayer_StopWithoutReleaseTime(handle);
			}
			if (entryPoolHandle != IntPtr.Zero)
			{
				CRIWARE5649DC21(entryPoolHandle);
			}
		}
	}

	public void Pause()
	{
		criAtomExPlayer_Pause(handle, sw: true);
	}

	public void Resume(CriAtomEx.ResumeMode mode)
	{
		criAtomExPlayer_Resume(handle, mode);
	}

	public bool IsPaused()
	{
		return criAtomExPlayer_IsPaused(handle);
	}

	public void SetVolume(float volume)
	{
		criAtomExPlayer_SetVolume(handle, volume);
	}

	public void SetPitch(float pitch)
	{
		criAtomExPlayer_SetPitch(handle, pitch);
	}

	public void SetPlaybackRatio(float ratio)
	{
		criAtomExPlayer_SetPlaybackRatio(handle, ratio);
	}

	public void SetPan3dAngle(float angle)
	{
		criAtomExPlayer_SetPan3dAngle(handle, angle);
	}

	public void SetPan3dInteriorDistance(float distance)
	{
		criAtomExPlayer_SetPan3dInteriorDistance(handle, distance);
	}

	public void SetPan3dVolume(float volume)
	{
		criAtomExPlayer_SetPan3dVolume(handle, volume);
	}

	public void SetPanType(CriAtomEx.PanType panType)
	{
		criAtomExPlayer_SetPanType(handle, panType);
	}

	public void SetSendLevel(int channel, CriAtomEx.Speaker id, float level)
	{
		criAtomExPlayer_SetSendLevel(handle, channel, id, level);
	}

	public void SetBiquadFilterParameters(CriAtomEx.BiquadFilterType type, float frequency, float gain, float q)
	{
		criAtomExPlayer_SetBiquadFilterParameters(handle, type, frequency, gain, q);
	}

	public void SetBandpassFilterParameters(float cofLow, float cofHigh)
	{
		criAtomExPlayer_SetBandpassFilterParameters(handle, cofLow, cofHigh);
	}

	public void SetBusSendLevel(string busName, float level)
	{
		criAtomExPlayer_SetBusSendLevelByName(handle, busName, level);
	}

	public bool GetBusSendLevel(string busName, out float level)
	{
		return criAtomExPlayer_GetBusSendLevelByName(handle, busName, out level);
	}

	[Obsolete("Use CriAtomExPlayer.SetBusSendLevel(string busName, float level)")]
	public void SetBusSendLevel(int busId, float level)
	{
		criAtomExPlayer_SetBusSendLevel(handle, busId, level);
	}

	public void SetBusSendLevelOffset(string busName, float levelOffset)
	{
		criAtomExPlayer_SetBusSendLevelOffsetByName(handle, busName, levelOffset);
	}

	public bool GetBusSendLevelOffset(string busName, out float level)
	{
		return criAtomExPlayer_GetBusSendLevelOffsetByName(handle, busName, out level);
	}

	[Obsolete("Use CriAtomExPlayer.SetBusSendLevelOffset(int busId, float levelOffset)")]
	public void SetBusSendLevelOffset(int busId, float levelOffset)
	{
		criAtomExPlayer_SetBusSendLevelOffset(handle, busId, levelOffset);
	}

	public void AttachAisac(string globalAisacName)
	{
		criAtomExPlayer_AttachAisac(handle, globalAisacName);
	}

	public void DetachAisac(string globalAisacName)
	{
		criAtomExPlayer_DetachAisac(handle, globalAisacName);
	}

	public void SetAisacControl(string controlName, float value)
	{
		criAtomExPlayer_SetAisacControlByName(handle, controlName, value);
	}

	[Obsolete("Use CriAtomExPlayer.SetAisacControl")]
	public void SetAisac(string controlName, float value)
	{
		SetAisacControl(controlName, value);
	}

	public void SetAisacControl(uint controlId, float value)
	{
		criAtomExPlayer_SetAisacControlById(handle, (ushort)controlId, value);
	}

	[Obsolete("Use SetAisacControl")]
	public void SetAisac(uint controlId, float value)
	{
		criAtomExPlayer_SetAisacControlById(handle, (ushort)controlId, value);
	}

	public bool GetAttachedAisacInfo(int aisacAttachedIndex, out CriAtomEx.AisacInfo aisacInfo)
	{
		using CriStructMemory<CriAtomEx.AisacInfo> criStructMemory = new CriStructMemory<CriAtomEx.AisacInfo>();
		bool num = criAtomExPlayer_GetAttachedAisacInfo(handle, aisacAttachedIndex, criStructMemory.ptr);
		if (num)
		{
			aisacInfo = new CriAtomEx.AisacInfo(criStructMemory.bytes, 0);
		}
		else
		{
			aisacInfo = default(CriAtomEx.AisacInfo);
		}
		return num;
	}

	public void Set3dSource(CriAtomEx3dSource source)
	{
		criAtomExPlayer_Set3dSourceHn(handle, source?.nativeHandle ?? IntPtr.Zero);
	}

	public void Set3dListener(CriAtomEx3dListener listener)
	{
		criAtomExPlayer_Set3dListenerHn(handle, listener?.nativeHandle ?? IntPtr.Zero);
	}

	public void SetStartTime(long startTimeMs)
	{
		criAtomExPlayer_SetStartTime(handle, startTimeMs);
	}

	public void SetStartTimeMicro(long startTimeUs)
	{
		criAtomExPlayer_SetStartTimeMicro(handle, startTimeUs);
	}

	public void SetFirstBlockIndex(int index)
	{
		criAtomExPlayer_SetFirstBlockIndex(handle, index);
	}

	public void SetSelectorLabel(string selector, string label)
	{
		criAtomExPlayer_SetSelectorLabel(handle, selector, label);
	}

	public void UnsetSelectorLabel(string selector)
	{
		criAtomExPlayer_UnsetSelectorLabel(handle, selector);
	}

	public void ClearSelectorLabels()
	{
		criAtomExPlayer_ClearSelectorLabels(handle);
	}

	public void SetCategory(int categoryId)
	{
		criAtomExPlayer_SetCategoryById(handle, (uint)categoryId);
	}

	public void SetCategory(string categoryName)
	{
		criAtomExPlayer_SetCategoryByName(handle, categoryName);
	}

	public void UnsetCategory()
	{
		criAtomExPlayer_UnsetCategory(handle);
	}

	public void SetCuePriority(int priority)
	{
		criAtomExPlayer_SetCuePriority(handle, priority);
	}

	public void SetVoicePriority(int priority)
	{
		criAtomExPlayer_SetVoicePriority(handle, priority);
	}

	public void SetVoiceControlMethod(CriAtomEx.VoiceControlMethod method)
	{
		criAtomExPlayer_SetVoiceControlMethod(handle, method);
	}

	public void SetPreDelayTime(float time)
	{
		criAtomExPlayer_SetPreDelayTime(handle, time);
	}

	public void SetEnvelopeAttackTime(float time)
	{
		criAtomExPlayer_SetEnvelopeAttackTime(handle, time);
	}

	public void SetEnvelopeHoldTime(float time)
	{
		criAtomExPlayer_SetEnvelopeHoldTime(handle, time);
	}

	public void SetEnvelopeDecayTime(float time)
	{
		criAtomExPlayer_SetEnvelopeDecayTime(handle, time);
	}

	public void SetEnvelopeReleaseTime(float time)
	{
		criAtomExPlayer_SetEnvelopeReleaseTime(handle, time);
	}

	public void SetEnvelopeSustainLevel(float level)
	{
		criAtomExPlayer_SetEnvelopeSustainLevel(handle, level);
	}

	public void AttachFader()
	{
		criAtomExPlayer_AttachFader(handle, IntPtr.Zero, IntPtr.Zero, 0);
	}

	public void DetachFader()
	{
		criAtomExPlayer_DetachFader(handle);
	}

	public void SetFadeOutTime(int ms)
	{
		criAtomExPlayer_SetFadeOutTime(handle, ms);
	}

	public void SetFadeInTime(int ms)
	{
		criAtomExPlayer_SetFadeInTime(handle, ms);
	}

	public void SetFadeInStartOffset(int ms)
	{
		criAtomExPlayer_SetFadeInStartOffset(handle, ms);
	}

	public void SetFadeOutEndDelay(int ms)
	{
		criAtomExPlayer_SetFadeOutEndDelay(handle, ms);
	}

	public bool IsFading()
	{
		return criAtomExPlayer_IsFading(handle);
	}

	public void ResetFaderParameters()
	{
		criAtomExPlayer_ResetFaderParameters(handle);
	}

	public void SetGroupNumber(int group_no)
	{
		criAtomExPlayer_SetGroupNumber(handle, group_no);
	}

	public void Update(CriAtomExPlayback playback)
	{
		criAtomExPlayer_Update(handle, playback.id);
	}

	public void UpdateAll()
	{
		criAtomExPlayer_UpdateAll(handle);
	}

	public void ResetParameters()
	{
		criAtomExPlayer_ResetParameters(handle);
	}

	public long GetTime()
	{
		return criAtomExPlayer_GetTime(handle);
	}

	public Status GetStatus()
	{
		return criAtomExPlayer_GetStatus(handle);
	}

	public float GetParameterFloat32(CriAtomEx.Parameter id)
	{
		return criAtomExPlayer_GetParameterFloat32(handle, id);
	}

	public uint GetParameterUint32(CriAtomEx.Parameter id)
	{
		return criAtomExPlayer_GetParameterUint32(handle, id);
	}

	public int GetParameterSint32(CriAtomEx.Parameter id)
	{
		return criAtomExPlayer_GetParameterSint32(handle, id);
	}

	public void SetSoundRendererType(CriAtomEx.SoundRendererType type)
	{
		criAtomExPlayer_SetSoundRendererType(handle, type);
	}

	public void SetRandomSeed(uint seed)
	{
		criAtomExPlayer_SetRandomSeed(handle, seed);
	}

	public void Loop(bool sw)
	{
		if (sw)
		{
			criAtomExPlayer_LimitLoopCount(handle, -3);
			return;
		}
		uint loopCountParameterId = CriAtomPlugin.GetLoopCountParameterId();
		criAtomExPlayerParameter_RemoveParameter(criAtomExPlayer_GetPlayerParameter(handle), loopCountParameterId);
	}

	public void SetAsrRackId(int asr_rack_id)
	{
		criAtomExPlayer_SetAsrRackId(handle, asr_rack_id);
	}

	public void SetVoicePoolIdentifier(uint identifier)
	{
		criAtomExPlayer_SetVoicePoolIdentifier(handle, identifier);
	}

	public void SetDspTimeStretchRatio(float ratio)
	{
		SetDspParameter(0, ratio);
	}

	public void SetDspPitchShifterPitch(float pitch)
	{
		float value = pitch / 4800f + 0.5f;
		SetDspParameter(0, value);
	}

	public void SetDspParameter(int id, float value)
	{
		criAtomExPlayer_SetDspParameter(handle, id, value);
	}

	public void SetSequencePrepareTime(uint ms)
	{
		criAtomExPlayer_SetSequencePrepareTime(handle, ms);
	}

	public void AttachTween(CriAtomExTween tween)
	{
		criAtomExPlayer_AttachTween(handle, tween.nativeHandle);
	}

	public void DetachTween(CriAtomExTween tween)
	{
		criAtomExPlayer_DetachTween(handle, tween.nativeHandle);
	}

	public void DetachTweenAll()
	{
		criAtomExPlayer_DetachTweenAll(handle);
	}

	public void SetEnvelopeAttackCurve(CriAtomEx.CurveType curveType, float strength)
	{
		criAtomExPlayer_SetEnvelopeAttackCurve(handle, curveType, strength);
	}

	public void SetEnvelopeDecayCurve(CriAtomEx.CurveType curveType, float strength)
	{
		criAtomExPlayer_SetEnvelopeDecayCurve(handle, curveType, strength);
	}

	public void SetEnvelopeReleaseCurve(CriAtomEx.CurveType curveType, float strength)
	{
		criAtomExPlayer_SetEnvelopeReleaseCurve(handle, curveType, strength);
	}

	public void AddOutputPort(CriAtomExOutputPort outputPort)
	{
		criAtomExPlayer_AddOutputPort(handle, outputPort.NativeHandle);
	}

	public void RemoveOutputPort(CriAtomExOutputPort outputPort)
	{
		criAtomExPlayer_RemoveOutputPort(handle, outputPort.NativeHandle);
	}

	public void ClearOutputPorts()
	{
		criAtomExPlayer_ClearOutputPorts(handle);
	}

	public void AddPreferredOutputPort(CriAtomExOutputPort outputPort)
	{
		criAtomExPlayer_AddPreferredOutputPort(handle, outputPort.NativeHandle);
	}

	public void RemovePreferredOutputPort(CriAtomExOutputPort outputPort)
	{
		criAtomExPlayer_RemovePreferredOutputPort(handle, outputPort.NativeHandle);
	}

	public void RemovePreferredOutputPort(string name)
	{
		criAtomExPlayer_RemovePreferredOutputPortByName(handle, name);
	}

	public void ClearPreferredOutputPorts()
	{
		criAtomExPlayer_ClearPreferredOutputPorts(handle);
	}

	public void SetScheduleTime(long scheduleTime)
	{
		criAtomExPlayer_SetScheduleTime(handle, scheduleTime);
	}

	public void Stop()
	{
		if (isAvailable)
		{
			criAtomExPlayer_Stop(handle);
			CRIWARE5649DC21(entryPoolHandle);
		}
	}

	public void StopWithoutReleaseTime()
	{
		if (isAvailable)
		{
			criAtomExPlayer_StopWithoutReleaseTime(handle);
			CRIWARE5649DC21(entryPoolHandle);
		}
	}

	public void Pause(bool sw)
	{
		criAtomExPlayer_Pause(handle, sw);
	}

	~CriAtomExPlayer()
	{
		Dispose();
	}

	private void OnBeatSyncCallbackChainInternal(ref CriAtomExBeatSync.Info info)
	{
		if (!(info.playerHn != nativeHandle))
		{
			_onBeatSyncCallback(ref info);
		}
	}

	private void OnSequenceCallbackChainInternal(ref CriAtomExSequencer.CriAtomExSequenceEventInfo info)
	{
		if (!(info.playerHn != nativeHandle))
		{
			_onSequenceCallback(ref info);
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExPlayer_Create(ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Destroy(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetCueId(IntPtr player, IntPtr acb_hn, int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetCueName(IntPtr player, IntPtr acb_hn, string cue_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetCueIndex(IntPtr player, IntPtr acb_hn, int index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFile(IntPtr player, IntPtr binder, string path);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetData(IntPtr player, byte[] buffer, int size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetData(IntPtr player, IntPtr buffer, int size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetContentId(IntPtr player, IntPtr binder, int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetVoicePoolIdentifier(IntPtr player, uint identifier);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomExPlayer_Start(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomExPlayer_Prepare(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayer_StartAsync(IntPtr player, IntPtr playback_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_StopAsync(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayer_IsReadyToStartAsync(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomExPlayer_GetLastPlaybackId(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Stop(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_StopWithoutReleaseTime(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Pause(IntPtr player, bool sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Resume(IntPtr player, CriAtomEx.ResumeMode mode);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayer_IsPaused(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern Status criAtomExPlayer_GetStatus(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern long criAtomExPlayer_GetTime(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFormat(IntPtr player, CriAtomEx.Format format);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetNumChannels(IntPtr player, int num_channels);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetSamplingRate(IntPtr player, int sampling_rate);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr CRIWAREA322B0F8(IntPtr player, int capacity, int max_path, bool stopOnEmpty);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREE236F449(IntPtr pool);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int CRIWAREB37289C3(IntPtr pool);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int CRIWARE37386F0F(IntPtr pool);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREEFFAFF4A(IntPtr pool);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWAREE4291791(IntPtr pool, IntPtr binder, string path, bool repeat, int max_path);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE523ADE9C(IntPtr pool, IntPtr binder, int id, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE07FBFC2E(IntPtr pool, byte[] buffer, int size, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE07FBFC2E(IntPtr pool, IntPtr buffer, int size, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE1F4B8024(IntPtr pool, IntPtr acbhn, string name, bool repeat);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE5649DC21(IntPtr pool);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetStartTime(IntPtr player, long start_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetStartTimeMicro(IntPtr player, long startTimeUs);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetSequencePrepareTime(IntPtr player, uint seq_prep_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_LimitLoopCount(IntPtr player, int count);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Update(IntPtr player, uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_UpdateAll(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_ResetParameters(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExPlayer_GetParameterFloat32(IntPtr player, CriAtomEx.Parameter id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomExPlayer_GetParameterUint32(IntPtr player, CriAtomEx.Parameter id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayer_GetParameterSint32(IntPtr player, CriAtomEx.Parameter id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExPlayer_GetPlayerParameter(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayerParameter_RemoveParameter(IntPtr player_parameter, uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetVolume(IntPtr player, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPitch(IntPtr player, float pitch);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPlaybackRatio(IntPtr player, float playback_ratio);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPan3dAngle(IntPtr player, float pan3d_angle);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPan3dInteriorDistance(IntPtr player, float pan3d_interior_distance);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPan3dVolume(IntPtr player, float pan3d_volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPanType(IntPtr player, CriAtomEx.PanType panType);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetSendLevel(IntPtr player, int channel, CriAtomEx.Speaker id, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetBusSendLevel(IntPtr player, int bus_id, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetBusSendLevelByName(IntPtr player, string bus_name, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayer_GetBusSendLevelByName(IntPtr player, string bus_name, out float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetBusSendLevelOffset(IntPtr player, int bus_id, float level_offset);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetBusSendLevelOffsetByName(IntPtr player, string bus_name, float level_offset);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayer_GetBusSendLevelOffsetByName(IntPtr player, string bus_name, out float level_offset);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetBandpassFilterParameters(IntPtr player, float cof_low, float cof_high);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetBiquadFilterParameters(IntPtr player, CriAtomEx.BiquadFilterType type, float frequency, float gain, float q);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetVoicePriority(IntPtr player, int priority);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetVoiceControlMethod(IntPtr player, CriAtomEx.VoiceControlMethod method);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetAisacControlById(IntPtr player, ushort control_id, float control_value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetAisacControlByName(IntPtr player, string control_name, float control_value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Set3dSourceHn(IntPtr player, IntPtr source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_Set3dListenerHn(IntPtr player, IntPtr listener);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetCategoryById(IntPtr player, uint category_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetCategoryByName(IntPtr player, string category_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_UnsetCategory(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetCuePriority(IntPtr player, int cue_priority);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetPreDelayTime(IntPtr player, float predelay_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeAttackTime(IntPtr player, float attack_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeHoldTime(IntPtr player, float hold_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeDecayTime(IntPtr player, float decay_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeReleaseTime(IntPtr player, float release_time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeSustainLevel(IntPtr player, float susutain_level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_AttachFader(IntPtr player, IntPtr config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_AttachAisac(IntPtr player, string globalAisacName);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_DetachAisac(IntPtr player, string globalAisacName);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_DetachFader(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFadeOutTime(IntPtr player, int ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFadeInTime(IntPtr player, int ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFadeInStartOffset(IntPtr player, int ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFadeOutEndDelay(IntPtr player, int ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayer_IsFading(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_ResetFaderParameters(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetGroupNumber(IntPtr player, int group_no);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayer_GetAttachedAisacInfo(IntPtr player, int aisac_attached_index, IntPtr aisac_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetFirstBlockIndex(IntPtr player, int index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetSelectorLabel(IntPtr player, string selector, string label);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_UnsetSelectorLabel(IntPtr player, string selector);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_ClearSelectorLabels(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetSoundRendererType(IntPtr player, CriAtomEx.SoundRendererType type);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetRandomSeed(IntPtr player, uint seed);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREF8C9436A(IntPtr player, bool sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetAsrRackId(IntPtr player, int asr_rack_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetDspParameter(IntPtr player, int id, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_AttachTween(IntPtr player, IntPtr tween);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_DetachTween(IntPtr player, IntPtr tween);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_DetachTweenAll(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeAttackCurve(IntPtr player, CriAtomEx.CurveType curve_type, float strength);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeDecayCurve(IntPtr player, CriAtomEx.CurveType curve_type, float strength);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetEnvelopeReleaseCurve(IntPtr player, CriAtomEx.CurveType curve_type, float strength);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_AddOutputPort(IntPtr player, IntPtr outputPort);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_RemoveOutputPort(IntPtr player, IntPtr outputPort);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_ClearOutputPorts(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_AddPreferredOutputPort(IntPtr player, IntPtr outputPort);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_RemovePreferredOutputPort(IntPtr player, IntPtr outputPort);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_RemovePreferredOutputPortByName(IntPtr player, string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_ClearPreferredOutputPorts(IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayer_SetScheduleTime(IntPtr player, long schedule_time);
}
