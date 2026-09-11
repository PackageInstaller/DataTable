using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using AOT;
using CriWare;
using UnityEngine;

public static class CriAtomPlugin
{
	public struct FileOpenCondition
	{
		public int freeBindsCount;

		public int freeFilesCount;

		public int freeLoadersCount;

		public bool CanLoadAcf
		{
			get
			{
				int num;
				if (freeFilesCount > 0)
				{
					num = ((freeLoadersCount > 0) ? 1 : 0);
					if (num != 0)
					{
						goto IL_0022;
					}
				}
				else
				{
					num = 0;
				}
				Debug.LogWarning("[CRIWARE] Resources for Load ACF not enough. Increase 'Number of Loaders' in Library Initializer.");
				goto IL_0022;
				IL_0022:
				return (byte)num != 0;
			}
		}

		public bool CanLoadAcb
		{
			get
			{
				int num;
				if (freeFilesCount > 0)
				{
					num = ((freeLoadersCount > 0) ? 1 : 0);
					if (num != 0)
					{
						goto IL_0022;
					}
				}
				else
				{
					num = 0;
				}
				Debug.LogWarning("[CRIWARE] Resources for Load ACB not enough. Increase 'Number of Loaders' in Library Initializer.");
				goto IL_0022;
				IL_0022:
				return (byte)num != 0;
			}
		}

		public bool CanLoadAcbWithAwb
		{
			get
			{
				if (CanLoadAcb)
				{
					return CanAttachAwb;
				}
				return false;
			}
		}

		public bool CanAttachAwb
		{
			get
			{
				int num;
				if (freeFilesCount > 0)
				{
					num = ((freeBindsCount > 0) ? 1 : 0);
					if (num != 0)
					{
						goto IL_0022;
					}
				}
				else
				{
					num = 0;
				}
				Debug.LogWarning("[CRIWARE] Resources for Load AWB not enough. Increase 'Number of Binders' in Library Initializer.");
				goto IL_0022;
				IL_0022:
				return (byte)num != 0;
			}
		}
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public delegate ulong CallbackFromNativeDelegate(IntPtr ptr1);

	private static int initializationCount = 0;

	private static List<IntPtr> effectInterfaceList = null;

	private static bool isConfigured = false;

	private static float timeSinceStartup = 0f;

	private static Common.CpuUsage cpuUsage;

	private static int CRIATOMUNITY_PARAMETER_ID_LOOP_COUNT = 0;

	private static ushort CRIATOMPARAMETER2_ID_INVALID = ushort.MaxValue;

	private static ulong temporalStorage = 0uL;

	public static bool isInitialized => initializationCount > 0;

	public static event Action OnBeforeInitialize = null;

	public static event Action OnInitialized = null;

	public static event Action OnBeforeFinalize = null;

	public static event Action OnFinalized = null;

	public static void Log(string log)
	{
	}

	public static void ExecuteQueuedCueLinkCallbacks()
	{
		if (CriAtom.HasCueLinkCallback)
		{
			CRIWARE78D4DCD5();
		}
	}

	public static void ExecuteQueuedEventCallbacks()
	{
		if (CriAtom.HasUserCallback)
		{
			CRIWARE9D7B85D0();
		}
	}

	public static void ExecuteQueuedBeatSyncCallbacks()
	{
		if (CriAtom.HasBeatSyncCallback)
		{
			CRIWAREE53FFB06();
		}
	}

	public static bool GetAudioEffectInterfaceList(out List<IntPtr> effect_interface_list)
	{
		if (IsLibraryInitialized())
		{
			effect_interface_list = null;
			return false;
		}
		if (effectInterfaceList == null)
		{
			effectInterfaceList = new List<IntPtr>();
		}
		effect_interface_list = effectInterfaceList;
		return true;
	}

	public static void SetConfigParameters(int max_virtual_voices, int max_voice_limit_groups, int max_categories, byte max_aisacs, byte max_bus_sends, int max_sequence_events_per_frame, int max_beatsync_callbacks_per_frame, int max_cuelink_callbacks_per_frame, int num_standard_memory_voices, int num_standard_streaming_voices, int num_hca_mx_memory_voices, int num_hca_mx_streaming_voices, int output_sampling_rate, int num_asr_output_channels, CriAtom.SpeakerMapping speakerMapping, bool uses_in_game_preview, float server_frequency, int max_parameter_blocks, int categories_per_playback, int max_faders, int num_buses, float max_pitch, CriAtomEx.SoundRendererType sound_renderer_type, bool enable_sonicsync_for_common, bool enable_atom_sound_disabled_mode)
	{
		CRIWARE93D0F200(max_virtual_voices, max_voice_limit_groups, max_categories, max_aisacs, max_bus_sends, max_sequence_events_per_frame, max_beatsync_callbacks_per_frame, max_cuelink_callbacks_per_frame, num_standard_memory_voices, num_standard_streaming_voices, num_hca_mx_memory_voices, num_hca_mx_streaming_voices, output_sampling_rate, num_asr_output_channels, speakerMapping, uses_in_game_preview, server_frequency, max_parameter_blocks, categories_per_playback, max_faders, num_buses, max_pitch, sound_renderer_type, enable_sonicsync_for_common, enable_atom_sound_disabled_mode);
		isConfigured = true;
	}

	public static void SetConfigMonitorParametes(int max_preview_objects, int communication_buffer_size, int playback_position_update_interval)
	{
		CRIWAREF8609254((uint)max_preview_objects, (uint)(communication_buffer_size * 1024), playback_position_update_interval);
	}

	public static void SetConfigAdditionalParameters_EDITOR(bool enable_user_pcm_output, int user_pcm_buffer_length)
	{
		CRIWAREB038D089(enable_user_pcm_output);
		CriAtomExAsr.SetPcmBufferSize(user_pcm_buffer_length);
	}

	public static void SetConfigAdditionalParameters_PC(long buffering_time_pc, bool use_microsoft_spatial_sound)
	{
		CRIWAREF387ABE9(buffering_time_pc, use_microsoft_spatial_sound);
	}

	public static void SetConfigAdditionalParameters_LINUX(CriAtomConfig.LinuxOutput output, int pulse_latency_usec)
	{
		CRIWARE8556AA6E((int)output, pulse_latency_usec);
	}

	public static void SetConfigAdditionalParameters_IOS(bool enable_sonicsync, uint buffering_time_ios, bool override_ipod_music_ios, bool enable_os_notification_handling)
	{
		CRIWAREF39C9ED5(enable_sonicsync, buffering_time_ios, override_ipod_music_ios, enable_os_notification_handling);
	}

	public static void SetConfigAdditionalParameters_ANDROID(bool enable_sonicsync, int num_low_delay_memory_voices, int num_low_delay_streaming_voices, int sound_buffering_time, int sound_start_buffering_time, bool use_fast_mixer, bool use_aaudio, int stream_type)
	{
		if (!enable_sonicsync)
		{
			stream_type = 0;
		}
		CRIWARE4047B2C6(enable_sonicsync, num_low_delay_memory_voices, num_low_delay_streaming_voices, sound_buffering_time, sound_start_buffering_time, use_fast_mixer, stream_type);
	}

	public static void SetConfigAdditionalParameters_VITA(int num_atrac9_memory_voices, int num_atrac9_streaming_voices, int num_mana_decoders)
	{
	}

	public static void SetConfigAdditionalParameters_PS4(int num_atrac9_memory_voices, int num_atrac9_streaming_voices, bool use_audio3d, int num_audio3d_memory_voices, int num_audio3d_streaming_voices, int num_mp4_streaming_voices)
	{
	}

	public static void SetConfigAdditionalParameters_PS5(int max_channel_ports, int max_object_ports, int num_mp4_streaming_voices)
	{
	}

	public static void SetConfigAdditionalParameters_SWITCH(bool enable_sonicsync, int num_opus_memory_voices, int num_opus_streaming_voices, bool init_socket)
	{
	}

	public static void SetConfigAdditionalParameters_SWITCH2(int num_opus_memory_voices, int num_opus_streaming_voices, bool init_socket)
	{
	}

	public static void SetConfigAdditionalParameters_WEBGL(int num_webaudio_voices)
	{
	}

	public static void SetMaxSamplingRateForStandardVoicePool(int sampling_rate_for_memory, int sampling_rate_for_streaming)
	{
		CRIWARED100DE47(sampling_rate_for_memory, sampling_rate_for_streaming);
	}

	public static int GetRequiredMaxVirtualVoices(CriAtomConfig atomConfig)
	{
		return 0 + atomConfig.standardVoicePoolConfig.memoryVoices + atomConfig.standardVoicePoolConfig.streamingVoices + atomConfig.hcaMxVoicePoolConfig.memoryVoices + atomConfig.hcaMxVoicePoolConfig.streamingVoices;
	}

	public static void InitializeLibrary()
	{
		Common.CheckBinaryVersionCompatibility();
		initializationCount++;
		if (initializationCount != 1)
		{
			return;
		}
		if (IsLibraryInitialized())
		{
			FinalizeLibrary();
			initializationCount = 1;
		}
		if (!isConfigured)
		{
			Debug.Log("[CRIWARE] Atom initialization parameters are not configured. Initializes Atom by default parameters.");
		}
		CriFsPlugin.InitializeLibrary();
		OnBeforeInitialize?.Invoke();
		CRIWARE2DD8CA72();
		OnInitialized?.Invoke();
		OnInitialized = null;
		if (effectInterfaceList != null)
		{
			for (int i = 0; i < effectInterfaceList.Count; i++)
			{
				CriAtomExAsr.RegisterEffectInterface(effectInterfaceList[i]);
			}
		}
		CriAtomServer.CreateInstance();
		CriAtomListener.CreateDummyNativeListener();
	}

	public static bool IsLibraryInitialized()
	{
		return CRIWARE398C7D3B();
	}

	public static void FinalizeLibrary()
	{
		initializationCount--;
		if (initializationCount < 0)
		{
			initializationCount = 0;
			if (!IsLibraryInitialized())
			{
				return;
			}
		}
		if (initializationCount == 0)
		{
			CriAtomListener.DestroyDummyNativeListener();
			CriAtomServer.DestroyInstance();
			CriDisposableObjectManager.CallOnModuleFinalization(CriDisposableObjectManager.ModuleType.Atom);
			if (effectInterfaceList != null)
			{
				effectInterfaceList.Clear();
				effectInterfaceList = null;
			}
			OnBeforeFinalize?.Invoke();
			CRIWAREC582BA6C();
			OnFinalized?.Invoke();
			OnFinalized = null;
			CriFsPlugin.FinalizeLibrary();
		}
	}

	public static void Pause(bool pause)
	{
		if (isInitialized)
		{
			CRIWARE12A7B67D(pause);
		}
	}

	public static Common.CpuUsage GetCpuUsage()
	{
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		if (realtimeSinceStartup - timeSinceStartup > 1f)
		{
			CriAtomEx.GetPerformanceInfo(out var info);
			cpuUsage.last = (float)info.lastServerTime * 100f / (float)info.averageServerInterval;
			cpuUsage.average = (float)info.averageServerTime * 100f / (float)info.averageServerInterval;
			cpuUsage.peak = (float)info.maxServerTime * 100f / (float)info.averageServerInterval;
			CriAtomEx.ResetPerformanceMonitor();
			timeSinceStartup = realtimeSinceStartup;
		}
		return cpuUsage;
	}

	public static int GetOutputSamplingRate()
	{
		return CRIWARE8BDF4875();
	}

	public static int GetOutputChannels()
	{
		return CRIWARE912275C3();
	}

	public static bool IsInitializedForPcmOutput()
	{
		return false;
	}

	public static ushort GetLoopCountParameterId()
	{
		ushort num = CRIWARE42CC4C11(CRIATOMUNITY_PARAMETER_ID_LOOP_COUNT);
		if (num == CRIATOMPARAMETER2_ID_INVALID)
		{
			throw new Exception("GetNativeParameterId failed.");
		}
		return num;
	}

	public static bool GetWaveSamples(CriAtomExAcb acb, string cueName, short[] decodeLpcmBuffer)
	{
		GCHandle gCHandle = GCHandle.Alloc(decodeLpcmBuffer, GCHandleType.Pinned);
		bool result = CRIWARE0DC87E1B(acb.nativeHandle, cueName, gCHandle.AddrOfPinnedObject(), decodeLpcmBuffer.Length);
		gCHandle.Free();
		return result;
	}

	public static void DecryptAcb(IntPtr acb_hn, ulong key, ulong nonce)
	{
		temporalStorage = key ^ 0x17D207B5350050L;
		CRIWAREF824542E(acb_hn, CallbackFromNative, IntPtr.Zero);
		temporalStorage = 0uL;
	}

	public static FileOpenCondition GetFileOpenCondition()
	{
		CriFs.GetNumBinds(out var curNum, out var _, out var limit);
		CriFs.GetNumOpenedFiles(out var curNum2, out var _, out var limit2);
		CriFs.GetNumUsedLoaders(out var curNum3, out var _, out var limit3);
		return new FileOpenCondition
		{
			freeBindsCount = limit - curNum,
			freeFilesCount = limit2 - curNum2,
			freeLoadersCount = limit3 - curNum3
		};
	}

	[MonoPInvokeCallback(typeof(CallbackFromNativeDelegate))]
	private static ulong CallbackFromNative(IntPtr ptr1)
	{
		return temporalStorage;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE0DC87E1B(IntPtr acbHn, string cue_name, IntPtr decode_lpcm_buffer, long decodeLpcmBufferLength);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE93D0F200(int max_virtual_voices, int max_voice_limit_groups, int max_categories, byte max_aisacs, byte max_bus_sends, int max_sequence_events_per_frame, int max_beatsync_callbacks_per_frame, int max_cuelink_callbacks_per_frame, int num_standard_memory_voices, int num_standard_streaming_voices, int num_hca_mx_memory_voices, int num_hca_mx_streaming_voices, int output_sampling_rate, int num_asr_output_channels, CriAtom.SpeakerMapping speakerMapping, bool uses_in_game_preview, float server_frequency, int max_parameter_blocks, int categories_per_playback, int max_faders, int num_buses, float max_pitch, CriAtomEx.SoundRendererType sound_renderer_type, bool enable_sonicsync_for_common, bool enable_atom_sound_disabled_mode);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREF8609254(uint max_preivew_objects, uint communication_buffer_size, int playback_position_update_interval);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREB038D089(bool enable_user_pcm_out_mode);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREF387ABE9(long buffering_time_pc, bool use_microsoft_spatial_sound);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE8556AA6E(int output, int pulse_latency_usec);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREF39C9ED5(bool enable_sonicsync, uint buffering_time_ios, bool override_ipod_music_ios, bool enable_os_notification_handling);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE4047B2C6(bool enable_sonicsync, int num_low_delay_memory_voices, int num_low_delay_streaming_voices, int sound_buffering_time, int sound_start_buffering_time, bool apply_hw_property, int stream_type);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE2DD8CA72();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool CRIWARE398C7D3B();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREC582BA6C();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE12A7B67D(bool pause);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern uint CRIWAREF9C76501();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE7379256E(int code);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE327AA439(IntPtr cbfunc, string separator_string);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWAREEC96E4D7(IntPtr cbfunc);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE9D7B85D0();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWAREC6A6ABD9(IntPtr cbfunc);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREE53FFB06();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE43BC08E6(IntPtr cbfunc);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE78D4DCD5();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARED100DE47(int sampling_rate_for_memory, int sampling_rate_for_streaming);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE5C426122();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE9E6FE8C6();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWAREF824542E(IntPtr acb_hn, CallbackFromNativeDelegate func, IntPtr obj);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern ushort CRIWARE42CC4C11(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE7F398A3A();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int CRIWARE8BDF4875();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int CRIWARE912275C3();
}
