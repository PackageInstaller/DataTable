using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using ACT.Error;
using ACT.UI;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.LowLevel;
using UnityEngine.Networking;
using UnityEngine.PlayerLoop;
using UnityEngine.Profiling;
using bamboosdk;

namespace ACT;

public static class LuminApplication
{
	public static class APM
	{
		public class CrashsightTester
		{
			public void ForceNativeCrash()
			{
				CrashSightAgent.TestNativeCrash();
			}

			public void ForceOcCrash()
			{
				CrashSightAgent.TestOcCrash();
			}

			public void ForceOomCrash()
			{
				CrashSightAgent.TestOomCrash();
			}

			public void ForceJavaCrash()
			{
				CrashSightAgent.TestJavaCrash();
			}

			public void ForceAnr()
			{
				CrashSightAgent.TestANR();
			}
		}

		private class LuminLogHandler : ILogHandler
		{
			private readonly ILogHandler _defaultLogHandler;

			public LuminLogHandler(ILogHandler logHandler)
			{
				_defaultLogHandler = logHandler;
			}

			public void LogFormat(LogType logType, UnityEngine.Object context, string format, params object[] args)
			{
				if ((logType == LogType.Exception || logType == LogType.Error) && LogEnabled)
				{
					_defaultLogHandler?.LogFormat(logType, context, format, args);
				}
			}

			public void LogException(Exception exception, UnityEngine.Object context)
			{
				OnAPMReportException?.Invoke(exception, context);
				if (LogEnabled)
				{
					_defaultLogHandler?.LogException(exception, context);
				}
			}
		}

		public enum UWAAnalysisMode
		{
			Disable,
			Overview,
			Mono,
			Resources,
			Gpu
		}

		public static class UWAStartupConfigParams
		{
			public static class OVERVIEW
			{
				public const string MODE = "overview.mode";

				public const string ENGINE_CPU_STACK = "overview.engine_cpu_stack";

				public const string LUA_MEM = "overview.lua";

				public const string LUA_MEM_STACK = "overview.lua_mem_stack";

				public const string LUA_CPU_STACK = "overview.lua_cpu_stack";

				public const string LUA_DUMP_STEP = "overview.lua_dump_step";

				public const string TIMELINE = "overview.time_line";

				public const string STACK_DETAIL = "overview.stack_detail";

				public const string UNITY_API = "overview.unity_api";

				public const string RESOURCES = "overview.resouces";

				public const string UNITY_LOADING = "overview.unity_loading";
			}

			public static class MONO
			{
				public const string DUMP_STEP = "mono.mono_dump_step";
			}

			public static class RESOURCES
			{
				public const string UNITY_LOADING = "resources.unity_loading";
			}

			public static class LUA
			{
				public const string LUA_DUMP_STEP = "lua.lua_dump_step";

				public const string LUA_CPU_STACK = "lua.lua_cpu_stack";

				public const string LUA_MEM_STACK = "lua.lua_mem_stack";
			}

			public static class GPU
			{
				public const string TEXTURE_ANALYSIS = "gpu.texture_analysis";

				public const string MESH_ANALYSIS = "gpu.mesh_analysis";

				public const string RENDERTEXTURE_ANALYSIS = "gpu.rendertexture_analysis";
			}

			public const string SCREEN_ENABLE = "screen.enable";

			public const string SCREEN_INTERVAL = "screen.interval";
		}

		public class UWAStartupConfig
		{
			private readonly Dictionary<string, string> _configDict = new Dictionary<string, string>();

			public void SetConfig<T>(string key, T value)
			{
				_configDict[key] = value.ToString();
			}

			public string GetConfigDesc()
			{
				string text = "";
				foreach (KeyValuePair<string, string> item in _configDict)
				{
					if (text.Length > 0)
					{
						text += ",\n";
					}
					_ = item.Value;
					text = text + "\t\"" + item.Key + "\": " + item.Value;
				}
				return "{\n" + text + "\n}";
			}
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public readonly struct GPMSample
		{
			public readonly struct AutoScope : IDisposable
			{
				private readonly GPMSample _sample;

				public AutoScope(GPMSample sample)
				{
					_sample = sample;
					_sample.Push();
				}

				public void Dispose()
				{
					_sample.Pop();
				}
			}

			public GPMSample(string name)
			{
			}

			public void Push()
			{
			}

			public void Pop()
			{
			}

			public AutoScope Auto()
			{
				return new AutoScope(this);
			}
		}

		public interface IGPMProxy
		{
			bool Enabled { get; }

			uint NetworkLatency { set; }

			void StaticInit(string url, string appID, string appVersion, string channel = "", bool debug = false, Action<bool> onInit = null);

			int GetRegisterState();

			void SetCrashReport(bool enable);

			void ChangeScene(string sceneName);

			void BeginSceneLoad(string sceneName);

			void EndSceneLoad();

			void SetNetworkLatency(uint valueMs);

			void SetUser(string userId);

			void SetUserLevel(string userLevel);

			void SetQuality(int quality);

			void BeginIgnore();

			void EndIgnore();

			void BeginSegment(string name);

			void EndSegment(string name);

			float GetSDKData(GPMSDKMetricType type);

			void SetThreshold(GPMMetricThresholdID id, int threshold);

			void SetDataPackInterval(int normalS, int specialS);

			void SetUploadActive(bool normal, bool special);

			void SetUploadMinInterval(int normalS, int specialS);

			void SetStorageTimeLimit(int normalM, int specialM);

			void SetScreenShotRatio(float ratio, bool exTrigger = false);

			void SetScreenShotEnabled(bool enable, bool exTrigger = false);

			void SetScreenShotInterval(int interval, bool exTrigger = false);

			void SetStackEnabled(bool enable);

			void SetStackDepthLimit(int depth);

			void SetStackInterval(int interval);

			void AddCrashCustomLogPaths(params string[] filePaths);

			void AddCrashAttachmentPaths(GPMAttachmentType type, params string[] filePaths);

			void BeginDeepTracking();

			void EndDeepTracking();

			void AddCustomEvent<T1, T2, T3>(string eventName, string eventCategory, string k1, T1 v1, string k2, T2 v2, string k3, T3 v3);

			void AddCustomEvent<T1, T2>(string eventName, string eventCategory, string k1, T1 v1, string k2, T2 v2);

			void AddCustomEvent<T1>(string eventName, string eventCategory, string k1, T1 v1);

			void AddCustomEvent(string eventName, string eventCategory);

			void PushSample(string name);

			void PopSample(string name);

			void MarkMemorySnapshot(string trigger);
		}

		private class GPMProxy : IGPMProxy
		{
			public bool Enabled => false;

			public uint NetworkLatency
			{
				set
				{
				}
			}

			public event Action<string> OnStaticInit
			{
				add
				{
				}
				remove
				{
				}
			}

			public event Action<bool> OnRegisterFinish
			{
				add
				{
				}
				remove
				{
				}
			}

			public event Action<string> OnUserIdChanged
			{
				add
				{
				}
				remove
				{
				}
			}

			public void StaticInit(string url, string appID, string appVersion, string channel = "", bool debug = false, Action<bool> onInit = null)
			{
				onInit?.Invoke(obj: false);
			}

			public int GetRegisterState()
			{
				return 0;
			}

			public void SetCrashReport(bool enable)
			{
			}

			public void ChangeScene(string sceneName)
			{
			}

			public void BeginSceneLoad(string sceneName)
			{
			}

			public void EndSceneLoad()
			{
			}

			public void SetNetworkLatency(uint valueMs)
			{
			}

			public void SetUser(string userId)
			{
			}

			public void SetUserLevel(string userLevel)
			{
			}

			public void SetQuality(int quality)
			{
			}

			public void BeginIgnore()
			{
			}

			public void EndIgnore()
			{
			}

			public void BeginSegment(string name)
			{
			}

			public void EndSegment(string name)
			{
			}

			public float GetSDKData(GPMSDKMetricType type)
			{
				return -1f;
			}

			public void SetThreshold(GPMMetricThresholdID id, int threshold)
			{
			}

			public void SetDataPackInterval(int normalS, int specialS)
			{
			}

			public void SetUploadActive(bool normal, bool special)
			{
			}

			public void SetUploadMinInterval(int normalS, int specialS)
			{
			}

			public void SetStorageTimeLimit(int normalM, int specialM)
			{
			}

			public void SetScreenShotRatio(float ratio, bool exTrigger)
			{
			}

			public void SetScreenShotEnabled(bool enable, bool exTrigger)
			{
			}

			public void SetScreenShotInterval(int interval, bool exTrigger)
			{
			}

			public void SetStackEnabled(bool enable)
			{
			}

			public void SetStackDepthLimit(int depth)
			{
			}

			public void SetStackInterval(int interval)
			{
			}

			public void AddCrashCustomLogPaths(params string[] filePaths)
			{
			}

			public void AddCrashAttachmentPaths(GPMAttachmentType type, params string[] filePaths)
			{
			}

			public void BeginDeepTracking()
			{
			}

			public void EndDeepTracking()
			{
			}

			public void AddCustomEvent<T1, T2, T3>(string eventName, string eventCategory, string k1, T1 v1, string k2, T2 v2, string k3, T3 v3)
			{
			}

			public void AddCustomEvent<T1, T2>(string eventName, string eventCategory, string k1, T1 v1, string k2, T2 v2)
			{
			}

			public void AddCustomEvent<T1>(string eventName, string eventCategory, string k1, T1 v1)
			{
			}

			public void AddCustomEvent(string eventName, string eventCategory)
			{
			}

			public void PushSample(string name)
			{
			}

			public void PopSample(string name)
			{
			}

			public void MarkMemorySnapshot(string trigger)
			{
			}
		}

		private static string CRASH_SIGHT_APP_ID = "72c2cae71f";

		private static string CRASH_SIGHT_APP_KEY = "aed08566-4346-427c-a5db-d59fb7c12356";

		private static string CRASH_SIGHT_URL = "https://android.crashsight.qq.com/pb/async";

		public static readonly CrashsightTester CrashSightTester = new CrashsightTester();

		private static Action<string> OnAPMReportUserId;

		private static Action<Exception, UnityEngine.Object> OnAPMReportException;

		public const int UWA_MAIN_PROJECT_ID = 9105;

		public const int UWA_ANALYSE_PROJECT_ID = 9065;

		private static bool _analyserIsInit;

		private static int _projectId;

		private static readonly HashSet<string> _sampleTags = new HashSet<string>();

		private static bool _logEnabledBeforeAnalysis;

		private static bool _gpmIsInit = false;

		private static readonly GPMProxy _gpmProxy = new GPMProxy();

		public static bool EnableAnalysisDump => _analyserIsInit;

		public static bool gpmEnabled => _gpmIsInit;

		public static IGPMProxy GPM => _gpmProxy;

		private static void InitCrashSight()
		{
			CrashSightAgent.ReRegistAllMonitors();
			OnAPMReportUserId = (Action<string>)Delegate.Combine(OnAPMReportUserId, new Action<string>(UpdateCrashSightReportUserId));
		}

		private static void UpdateCrashSightReportUserId(string userId)
		{
			CrashSightAgent.SetUserId(userId);
		}

		public static bool Init(bool debug, Action<bool> onInit)
		{
			ResetLogHandler();
			InitCrashSight();
			onInit?.Invoke(obj: true);
			return true;
		}

		private static void ResetLogHandler()
		{
			Debug.unityLogger.logHandler = new LuminLogHandler(Debug.unityLogger.logHandler);
		}

		public static void UpdateUserId(string uid)
		{
			Debug.Log("APM_UPDATE_USER_ID: " + uid);
			OnAPMReportUserId?.Invoke(uid);
		}

		public static void AnalyserPushSample(string sampleTag)
		{
			AnalyserSampleOperate(sampleTag, isPush: true);
		}

		public static void AnalyserPopSample(string sampleTag)
		{
			AnalyserSampleOperate(sampleTag, isPush: false);
		}

		private static void AnalyserSampleOperate(string tag, bool isPush)
		{
		}

		public static void AnalysisStart(int mode, int projectId)
		{
			AnalysisStart((UWAAnalysisMode)mode, projectId);
		}

		public static void AnalysisStart(UWAAnalysisMode mode, int projectId, string config = null)
		{
		}

		private static void StartUWARecord(UWAAnalysisMode mode, int projectId, string config = null)
		{
		}

		public static void AnalysisStop()
		{
		}

		private static void UploadUWAReport(Action<bool, string> callback)
		{
			callback?.Invoke(arg1: false, string.Empty);
		}

		public static void AnalyserTag(string markTag)
		{
		}

		public static void AnalyserDump()
		{
		}
	}

	public class Resource
	{
		public static bool IsLocalSimulation()
		{
			return false;
		}
	}

	public static class RuntimeInfo
	{
		public readonly struct FrameRateSample(double timestamp, double frameTimeMs, bool isBackground)
		{
			public readonly double Timestamp = timestamp;

			public readonly float FrameTimeMs = (float)frameTimeMs;

			public readonly bool IsBackground = isBackground;

			public float FrameRate
			{
				get
				{
					if (!(FrameTimeMs > 0f))
					{
						return 0f;
					}
					return 1000f / FrameTimeMs;
				}
			}

			public double EndTimestamp => Timestamp + (double)FrameTimeMs * 0.001;
		}

		public readonly struct MemoryMetrics(long managedUsedBytes, long processResidentBytes, long processPrivateBytes, long unityAllocatedBytes, long unityReservedBytes, long unityMonoUsedBytes, long unityMonoHeapBytes)
		{
			public readonly long ManagedUsedBytes = managedUsedBytes;

			public readonly long ProcessResidentBytes = processResidentBytes;

			public readonly long ProcessPrivateBytes = processPrivateBytes;

			public readonly long UnityAllocatedBytes = unityAllocatedBytes;

			public readonly long UnityReservedBytes = unityReservedBytes;

			public readonly long UnityMonoUsedBytes = unityMonoUsedBytes;

			public readonly long UnityMonoHeapBytes = unityMonoHeapBytes;
		}

		public readonly struct FrameTimeMetrics(float cpuFrameTimeMs, float gpuFrameTimeMs, int cpuFrameTimeSampleCount, int gpuFrameTimeSampleCount)
		{
			public readonly float CpuFrameTimeMs = cpuFrameTimeMs;

			public readonly float GpuFrameTimeMs = gpuFrameTimeMs;

			public readonly int CpuFrameTimeSampleCount = cpuFrameTimeSampleCount;

			public readonly int GpuFrameTimeSampleCount = gpuFrameTimeSampleCount;

			public bool HasCpuFrameTime => CpuFrameTimeSampleCount > 0;

			public bool HasGpuFrameTime => GpuFrameTimeSampleCount > 0;
		}

		public readonly struct SecondSample(double timestamp, int frameCount, double coveredSeconds, MemoryMetrics averageMemory, FrameTimeMetrics averageFrameTime, int backgroundFrameCount, int chunkId, int uiType)
		{
			public readonly double Timestamp = timestamp;

			public readonly int FrameCount = frameCount;

			public readonly double CoveredSeconds = coveredSeconds;

			public readonly float AverageFrameRate = ((coveredSeconds > 0.0) ? ((float)((double)frameCount / coveredSeconds)) : 0f);

			public readonly MemoryMetrics AverageMemory = averageMemory;

			public readonly FrameTimeMetrics AverageFrameTime = averageFrameTime;

			public readonly int BackgroundFrameCount = backgroundFrameCount;

			public readonly int ChunkId = chunkId;

			public readonly int UiType = uiType;

			public bool IsBackground => BackgroundFrameCount > 0;

			public double EndTimestamp => Timestamp + CoveredSeconds;
		}

		private readonly struct FrameTick(double timestamp, double frameIntervalSeconds, in MemoryMetrics memory, in FrameTimeMetrics frameTime, bool inBackground)
		{
			public readonly double Timestamp = timestamp;

			public readonly double FrameIntervalSeconds = frameIntervalSeconds;

			public readonly MemoryMetrics Memory = memory;

			public readonly FrameTimeMetrics FrameTime = frameTime;

			public readonly bool InBackground = inBackground;
		}

		public const double RetentionSeconds = 60.0;

		public const int MaxSupportedFrameRate = 240;

		public const int Capacity = 14400;

		private const double SecondWindowSeconds = 1.0;

		private const int SecondCapacity = 120;

		private const int TickCapacity = 2048;

		private const int ContextUnknown = -1;

		private const int AggregationThreadIdleWaitMilliseconds = 250;

		private const int AggregationThreadStopJoinMilliseconds = 500;

		private const double MaxValidFrameIntervalSeconds = 5.0;

		private static readonly object _gate = new object();

		private static readonly FrameRateSample[] _samples = new FrameRateSample[14400];

		private static readonly DateTime _startLocalTime = DateTime.Now;

		private static readonly DateTime _startUtcTime = DateTime.UtcNow;

		private static readonly double _startTimestamp = Time.realtimeSinceStartupAsDouble;

		private static DateTime _sessionStartLocalTime;

		private static DateTime _sessionStartUtcTime;

		private static long _sessionStartUnixSeconds;

		private static double _sessionStartTimestamp;

		private static bool _sessionStartTimestampPending;

		private static int _headIndex;

		private static int _count;

		private static double _lastFrameTimestamp;

		private static readonly SecondSample[] _secondSamples = new SecondSample[120];

		private static int _secondHeadIndex;

		private static int _secondCount;

		private static bool _secondBucketActive;

		private static double _secondBucketStart;

		private static double _secondBucketEnd;

		private static int _secondBucketFrameCount;

		private static long _secondManagedUsedSum;

		private static long _secondProcessResidentSum;

		private static long _secondProcessPrivateSum;

		private static long _secondUnityAllocatedSum;

		private static long _secondUnityReservedSum;

		private static long _secondUnityMonoUsedSum;

		private static long _secondUnityMonoHeapSum;

		private static double _secondCpuFrameTimeSumMs;

		private static double _secondGpuFrameTimeSumMs;

		private static int _secondCpuFrameTimeCount;

		private static int _secondGpuFrameTimeCount;

		private static int _secondBucketBackgroundFrameCount;

		private static bool _lastSampledBackground;

		private static volatile bool _recordingEnabled;

		private static volatile bool _recordingRestartPending;

		private static volatile int _currentChunkId = -1;

		private static volatile int _currentUiType = -1;

		private static readonly FrameTick[] _tickBuffer = new FrameTick[2048];

		private static readonly AutoResetEvent _tickSignal = new AutoResetEvent(initialState: false);

		private static int _tickHead;

		private static int _tickCount;

		private static Thread _aggregationThread;

		private static volatile bool _aggregationStopRequested;

		private static readonly FrameTiming[] _frameTimingBuffer = new FrameTiming[1];

		private static Process _currentProcess;

		private static bool _processMemoryUnavailable;

		private static volatile bool _frameTimingObserved;

		private static volatile bool _unityMemoryMetricObserved;

		private const string RuntimeSampleEventName = "client_runtime_sample";

		private const double ReportWindowSeconds = 30.0;

		private const int ReportSamplesPerPacket = 30;

		private const int ReportCapacity = 600;

		private const int MaxReportPacketsPerTick = 4;

		private const double BytesToMegabytes = 1.0 / 1048576.0;

		private static readonly SecondSample[] _reportSamples = new SecondSample[600];

		private static readonly SecondSample[] _reportPacketBuffer = new SecondSample[30];

		private static int _reportPacketCount;

		private static int _reportHead;

		private static volatile int _reportCount;

		private static double _reportWindowAnchor;

		private static double _nextReportWindowEnd;

		public static double CurrentTimestamp => Time.realtimeSinceStartupAsDouble;

		public static bool IsInBackground => !Application.isFocused;

		public static bool IsSecondAggregationRunning
		{
			get
			{
				if (_aggregationThread != null)
				{
					return _aggregationThread.IsAlive;
				}
				return false;
			}
		}

		public static bool IsFrameTimingObserved => _frameTimingObserved;

		public static bool IsUnityMemoryMetricObserved => _unityMemoryMetricObserved;

		public static bool IsRecordingEnabled => _recordingEnabled;

		public static int CurrentChunkId => _currentChunkId;

		public static int CurrentUiType => _currentUiType;

		public static int SampleCount
		{
			get
			{
				lock (_gate)
				{
					return _count;
				}
			}
		}

		public static int SecondSampleCount
		{
			get
			{
				lock (_gate)
				{
					return _secondCount;
				}
			}
		}

		public static DateTime StartLocalTime => _startLocalTime;

		public static DateTime StartUtcTime => _startUtcTime;

		public static double StartTimestamp => _startTimestamp;

		public static DateTime SessionStartLocalTime => _sessionStartLocalTime;

		public static DateTime SessionStartUtcTime => _sessionStartUtcTime;

		public static long SessionStartUnixSeconds => _sessionStartUnixSeconds;

		public static double SessionStartTimestamp => _sessionStartTimestamp;

		public static void SetChunkId(int chunkId)
		{
			_currentChunkId = chunkId;
		}

		public static void SetUiType(int uiType)
		{
			_currentUiType = uiType;
		}

		public static void ResetRecording()
		{
			SetRecordingEnabled(enabled: false);
			SetRecordingEnabled(enabled: true);
		}

		public static void SetRecordingEnabled(bool enabled)
		{
			if (_recordingEnabled == enabled)
			{
				return;
			}
			_recordingEnabled = enabled;
			if (!enabled)
			{
				lock (_gate)
				{
					DiscardPendingSamplesLocked();
				}
				FlushPendingReports();
				return;
			}
			_sessionStartLocalTime = DateTime.Now;
			_sessionStartUtcTime = DateTime.UtcNow;
			_sessionStartUnixSeconds = new DateTimeOffset(_sessionStartUtcTime).ToUnixTimeSeconds();
			_sessionStartTimestampPending = true;
			_recordingRestartPending = true;
			Clear();
		}

		public static void ResetStatistics()
		{
			if (_recordingEnabled)
			{
				SetRecordingEnabled(enabled: false);
			}
			Clear();
		}

		public static void StopRecorder()
		{
			UninstallPlayerLoopSystem();
			StopSecondAggregationThread();
		}

		public static bool TryGetLatestSample(out FrameRateSample sample)
		{
			lock (_gate)
			{
				if (_count == 0)
				{
					sample = default;
					return false;
				}
				sample = _samples[IndexAt(_count - 1)];
				return true;
			}
		}

		public static bool TryGetLatestRecordedTimestamp(out double timestamp)
		{
			lock (_gate)
			{
				bool flag = _count > 0;
				bool flag2 = _secondCount > 0;
				if (!flag && !flag2)
				{
					timestamp = 0.0;
					return false;
				}
				double num = (flag ? _samples[IndexAt(_count - 1)].EndTimestamp : double.MinValue);
				double num2 = (flag2 ? _secondSamples[SecondIndexAt(_secondCount - 1)].EndTimestamp : double.MinValue);
				timestamp = ((num >= num2) ? num : num2);
				return true;
			}
		}

		public static bool TryGetLatestRecordedLocalTime(out DateTime localTime)
		{
			if (TryGetLatestRecordedTimestamp(out var timestamp))
			{
				localTime = ToLocalTime(timestamp);
				return true;
			}
			localTime = default;
			return false;
		}

		public static int CopySamples(double fromTimestamp, double toTimestamp, List<FrameRateSample> destination)
		{
			if (destination == null)
			{
				throw new ArgumentNullException("destination");
			}
			destination.Clear();
			if (toTimestamp < fromTimestamp)
			{
				return 0;
			}
			lock (_gate)
			{
				for (int i = 0; i < _count; i++)
				{
					FrameRateSample item = _samples[IndexAt(i)];
					if (!(item.Timestamp < fromTimestamp))
					{
						if (item.Timestamp > toTimestamp)
						{
							break;
						}
						destination.Add(item);
					}
				}
			}
			return destination.Count;
		}

		public static FrameRateSample[] GetSamples(double fromTimestamp, double toTimestamp)
		{
			List<FrameRateSample> list = new List<FrameRateSample>();
			int num = CopySamples(fromTimestamp, toTimestamp, list);
			if (num == 0)
			{
				return Array.Empty<FrameRateSample>();
			}
			FrameRateSample[] array = new FrameRateSample[num];
			list.CopyTo(array);
			return array;
		}

		public static bool TryGetAverageFrameRate(double fromTimestamp, double toTimestamp, out double averageFrameRate, out int frameCount, out double coveredSeconds)
		{
			averageFrameRate = 0.0;
			frameCount = 0;
			coveredSeconds = 0.0;
			if (toTimestamp < fromTimestamp)
			{
				return false;
			}
			lock (_gate)
			{
				double num = 0.0;
				double num2 = 0.0;
				for (int i = 0; i < _count; i++)
				{
					FrameRateSample frameRateSample = _samples[IndexAt(i)];
					if (!(frameRateSample.Timestamp < fromTimestamp))
					{
						if (frameRateSample.Timestamp > toTimestamp)
						{
							break;
						}
						if (frameCount == 0)
						{
							num = frameRateSample.Timestamp;
						}
						num2 = frameRateSample.EndTimestamp;
						frameCount++;
					}
				}
				if (frameCount == 0)
				{
					return false;
				}
				coveredSeconds = num2 - num;
				if (coveredSeconds <= 0.0)
				{
					return false;
				}
				averageFrameRate = (double)frameCount / coveredSeconds;
				return true;
			}
		}

		public static void Clear()
		{
			lock (_gate)
			{
				_headIndex = 0;
				_count = 0;
				_secondHeadIndex = 0;
				_secondCount = 0;
				ResetReportQueueLocked();
				DiscardPendingSamplesLocked();
			}
		}

		public static int CopySecondSamples(double fromTimestamp, double toTimestamp, List<SecondSample> destination)
		{
			if (destination == null)
			{
				throw new ArgumentNullException("destination");
			}
			destination.Clear();
			if (toTimestamp < fromTimestamp)
			{
				return 0;
			}
			lock (_gate)
			{
				for (int i = 0; i < _secondCount; i++)
				{
					SecondSample item = _secondSamples[SecondIndexAt(i)];
					if (!(item.Timestamp < fromTimestamp))
					{
						if (item.Timestamp > toTimestamp)
						{
							break;
						}
						destination.Add(item);
					}
				}
			}
			return destination.Count;
		}

		public static SecondSample[] GetSecondSamples(double fromTimestamp, double toTimestamp)
		{
			List<SecondSample> list = new List<SecondSample>();
			int num = CopySecondSamples(fromTimestamp, toTimestamp, list);
			if (num == 0)
			{
				return Array.Empty<SecondSample>();
			}
			SecondSample[] array = new SecondSample[num];
			list.CopyTo(array);
			return array;
		}

		public static DateTime ToLocalTime(double timestamp)
		{
			DateTime startLocalTime = _startLocalTime;
			return startLocalTime.AddSeconds(timestamp - _startTimestamp);
		}

		public static DateTime ToUtcTime(double timestamp)
		{
			DateTime startUtcTime = _startUtcTime;
			return startUtcTime.AddSeconds(timestamp - _startTimestamp);
		}

		public static double ToTimestamp(DateTime time)
		{
			return _startTimestamp + (time.ToUniversalTime() - _startUtcTime).TotalSeconds;
		}

		[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
		private static void InstallRuntimeInfoRecorder()
		{
			if (Time.realtimeSinceStartupAsDouble < _lastFrameTimestamp)
			{
				Clear();
			}
			PlayerLoopSystem currentPlayerLoop = PlayerLoop.GetCurrentPlayerLoop();
			if (currentPlayerLoop.subSystemList == null)
			{
				return;
			}
			List<PlayerLoopSystem> list = new List<PlayerLoopSystem>(currentPlayerLoop.subSystemList);
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (list[num].type == typeof(RuntimeInfo))
				{
					list.RemoveAt(num);
				}
			}
			int index = 0;
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].type == typeof(TimeUpdate))
				{
					index = i;
					break;
				}
			}
			list.Insert(index, new PlayerLoopSystem
			{
				type = typeof(RuntimeInfo),
				updateDelegate = RecordFrame
			});
			currentPlayerLoop.subSystemList = list.ToArray();
			PlayerLoop.SetPlayerLoop(currentPlayerLoop);
			_lastFrameTimestamp = Time.realtimeSinceStartupAsDouble;
			_lastSampledBackground = !Application.isFocused;
			StartSecondAggregationThread();
		}

		private static void UninstallPlayerLoopSystem()
		{
			PlayerLoopSystem currentPlayerLoop = PlayerLoop.GetCurrentPlayerLoop();
			if (currentPlayerLoop.subSystemList == null)
			{
				return;
			}
			List<PlayerLoopSystem> list = new List<PlayerLoopSystem>(currentPlayerLoop.subSystemList);
			bool flag = false;
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (!(list[num].type != typeof(RuntimeInfo)))
				{
					list.RemoveAt(num);
					flag = true;
				}
			}
			if (flag)
			{
				currentPlayerLoop.subSystemList = list.ToArray();
				PlayerLoop.SetPlayerLoop(currentPlayerLoop);
			}
		}

		private static void RecordFrame()
		{
			double realtimeSinceStartupAsDouble = Time.realtimeSinceStartupAsDouble;
			if (!_recordingEnabled)
			{
				_lastFrameTimestamp = realtimeSinceStartupAsDouble;
				return;
			}
			if (_recordingRestartPending)
			{
				_recordingRestartPending = false;
				_lastFrameTimestamp = realtimeSinceStartupAsDouble;
				_lastSampledBackground = !Application.isFocused;
				if (_sessionStartTimestampPending)
				{
					_sessionStartTimestamp = realtimeSinceStartupAsDouble;
					_sessionStartTimestampPending = false;
				}
				return;
			}
			double num = realtimeSinceStartupAsDouble - _lastFrameTimestamp;
			_lastFrameTimestamp = realtimeSinceStartupAsDouble;
			if (!double.IsNaN(num) && !double.IsInfinity(num) && !(num <= 0.0) && !(num > 5.0))
			{
				bool flag = !Application.isFocused;
				bool flag2 = flag != _lastSampledBackground;
				_lastSampledBackground = flag;
				if (!flag2)
				{
					AppendFrame(realtimeSinceStartupAsDouble, num, ReadMemoryMetrics(), ReadFrameTimeMetrics(), flag);
					ProcessRuntimeReportTick();
				}
			}
		}

		private static void AppendFrame(double timestamp, double frameIntervalSeconds, in MemoryMetrics memory, in FrameTimeMetrics frameTime, bool inBackground)
		{
			lock (_gate)
			{
				AppendFrameSampleLocked(new FrameRateSample(timestamp, frameIntervalSeconds * 1000.0, inBackground));
				EnqueueFrameTickLocked(timestamp, frameIntervalSeconds, in memory, in frameTime, inBackground);
			}
		}

		private static MemoryMetrics ReadMemoryMetrics()
		{
			long totalMemory = GC.GetTotalMemory(forceFullCollection: false);
			TryGetProcessMemory(out var workingSetBytes, out var privateBytes);
			long totalAllocatedMemoryLong = Profiler.GetTotalAllocatedMemoryLong();
			long totalReservedMemoryLong = Profiler.GetTotalReservedMemoryLong();
			long monoUsedSizeLong = Profiler.GetMonoUsedSizeLong();
			long monoHeapSizeLong = Profiler.GetMonoHeapSizeLong();
			if (totalAllocatedMemoryLong > 0 || totalReservedMemoryLong > 0 || monoUsedSizeLong > 0 || monoHeapSizeLong > 0)
			{
				_unityMemoryMetricObserved = true;
			}
			return new MemoryMetrics(totalMemory, workingSetBytes, privateBytes, totalAllocatedMemoryLong, totalReservedMemoryLong, monoUsedSizeLong, monoHeapSizeLong);
		}

		private static bool TryGetProcessMemory(out long workingSetBytes, out long privateBytes)
		{
			workingSetBytes = 0L;
			privateBytes = 0L;
			if (_processMemoryUnavailable)
			{
				return false;
			}
			try
			{
				if (_currentProcess == null)
				{
					_currentProcess = Process.GetCurrentProcess();
				}
				workingSetBytes = _currentProcess.WorkingSet64;
				privateBytes = _currentProcess.PrivateMemorySize64;
				return true;
			}
			catch (Exception)
			{
				_processMemoryUnavailable = true;
				_currentProcess = null;
				return false;
			}
		}

		private static FrameTimeMetrics ReadFrameTimeMetrics()
		{
			FrameTimingManager.CaptureFrameTimings();
			if (FrameTimingManager.GetLatestTimings(1u, _frameTimingBuffer) == 0)
			{
				return default;
			}
			FrameTiming frameTiming = _frameTimingBuffer[0];
			double cpuFrameTime = frameTiming.cpuFrameTime;
			double gpuFrameTime = frameTiming.gpuFrameTime;
			bool flag = IsValidFrameTime(cpuFrameTime);
			bool flag2 = IsValidFrameTime(gpuFrameTime);
			if (flag | flag2)
			{
				_frameTimingObserved = true;
			}
			return new FrameTimeMetrics(flag ? ((float)cpuFrameTime) : 0f, flag2 ? ((float)gpuFrameTime) : 0f, flag ? 1 : 0, flag2 ? 1 : 0);
		}

		private static bool IsValidFrameTime(double frameTimeMs)
		{
			if (frameTimeMs > 0.0 && !double.IsNaN(frameTimeMs))
			{
				return !double.IsInfinity(frameTimeMs);
			}
			return false;
		}

		private static void AppendFrameSampleLocked(FrameRateSample sample)
		{
			while (_count > 0 && sample.Timestamp - _samples[IndexAt(0)].Timestamp > 60.0)
			{
				DropOldest();
			}
			if (_count == 14400)
			{
				DropOldest();
			}
			_samples[IndexAt(_count)] = sample;
			_count++;
		}

		private static void DropOldest()
		{
			_headIndex = (_headIndex + 1) % 14400;
			_count--;
		}

		private static int IndexAt(int offsetFromHead)
		{
			return (_headIndex + offsetFromHead) % 14400;
		}

		private static void StartSecondAggregationThread()
		{
			if (_aggregationThread == null || !_aggregationThread.IsAlive)
			{
				_aggregationStopRequested = false;
				_aggregationThread = new Thread(SecondAggregationLoop)
				{
					IsBackground = true,
					Name = "RuntimeInfo.SecondAggregation"
				};
				_aggregationThread.Start();
			}
		}

		private static void StopSecondAggregationThread()
		{
			Thread aggregationThread = _aggregationThread;
			if (aggregationThread == null)
			{
				return;
			}
			_aggregationStopRequested = true;
			_tickSignal.Set();
			if (aggregationThread.IsAlive)
			{
				aggregationThread.Join(500);
			}
			if (aggregationThread.IsAlive)
			{
				return;
			}
			_aggregationThread = null;
			lock (_gate)
			{
				DiscardPendingSamplesLocked();
			}
		}

		private static void SecondAggregationLoop()
		{
			while (true)
			{
				try
				{
					DrainFrameTicks();
				}
				catch (Exception)
				{
					break;
				}
				if (_aggregationStopRequested)
				{
					break;
				}
				_tickSignal.WaitOne(250);
			}
		}

		private static void DrainFrameTicks()
		{
			lock (_gate)
			{
				while (_tickCount > 0)
				{
					FrameTick frameTick = _tickBuffer[_tickHead];
					_tickHead = (_tickHead + 1) % 2048;
					_tickCount--;
					AccumulateSecondBucketLocked(frameTick.Timestamp, frameTick.FrameIntervalSeconds, in frameTick.Memory, in frameTick.FrameTime, frameTick.InBackground);
				}
			}
		}

		private static void EnqueueFrameTickLocked(double timestamp, double frameIntervalSeconds, in MemoryMetrics memory, in FrameTimeMetrics frameTime, bool inBackground)
		{
			if (_tickCount == 2048)
			{
				_tickHead = (_tickHead + 1) % 2048;
				_tickCount--;
			}
			bool flag = _tickCount == 0;
			_tickBuffer[(_tickHead + _tickCount) % 2048] = new FrameTick(timestamp, frameIntervalSeconds, in memory, in frameTime, inBackground);
			_tickCount++;
			if (flag)
			{
				_tickSignal.Set();
			}
		}

		private static void DiscardPendingSamplesLocked()
		{
			_tickHead = 0;
			_tickCount = 0;
			_secondBucketActive = false;
			_secondBucketFrameCount = 0;
			_secondBucketBackgroundFrameCount = 0;
			_secondCpuFrameTimeSumMs = 0.0;
			_secondGpuFrameTimeSumMs = 0.0;
			_secondCpuFrameTimeCount = 0;
			_secondGpuFrameTimeCount = 0;
		}

		private static void AccumulateSecondBucketLocked(double timestamp, double frameIntervalSeconds, in MemoryMetrics memory, in FrameTimeMetrics frameTime, bool inBackground)
		{
			if (!_secondBucketActive)
			{
				_secondBucketActive = true;
				_secondBucketStart = timestamp;
				_secondBucketFrameCount = 0;
				_secondBucketBackgroundFrameCount = 0;
				_secondManagedUsedSum = 0L;
				_secondProcessResidentSum = 0L;
				_secondProcessPrivateSum = 0L;
				_secondUnityAllocatedSum = 0L;
				_secondUnityReservedSum = 0L;
				_secondUnityMonoUsedSum = 0L;
				_secondUnityMonoHeapSum = 0L;
				_secondCpuFrameTimeSumMs = 0.0;
				_secondGpuFrameTimeSumMs = 0.0;
				_secondCpuFrameTimeCount = 0;
				_secondGpuFrameTimeCount = 0;
			}
			_secondBucketFrameCount++;
			if (inBackground)
			{
				_secondBucketBackgroundFrameCount++;
			}
			_secondManagedUsedSum += memory.ManagedUsedBytes;
			_secondProcessResidentSum += memory.ProcessResidentBytes;
			_secondProcessPrivateSum += memory.ProcessPrivateBytes;
			_secondUnityAllocatedSum += memory.UnityAllocatedBytes;
			_secondUnityReservedSum += memory.UnityReservedBytes;
			_secondUnityMonoUsedSum += memory.UnityMonoUsedBytes;
			_secondUnityMonoHeapSum += memory.UnityMonoHeapBytes;
			if (frameTime.CpuFrameTimeSampleCount > 0)
			{
				_secondCpuFrameTimeSumMs += frameTime.CpuFrameTimeMs;
				_secondCpuFrameTimeCount += frameTime.CpuFrameTimeSampleCount;
			}
			if (frameTime.GpuFrameTimeSampleCount > 0)
			{
				_secondGpuFrameTimeSumMs += frameTime.GpuFrameTimeMs;
				_secondGpuFrameTimeCount += frameTime.GpuFrameTimeSampleCount;
			}
			_secondBucketEnd = timestamp + frameIntervalSeconds;
			double num = _secondBucketEnd - _secondBucketStart;
			if (!(num < 1.0))
			{
				int secondBucketFrameCount = _secondBucketFrameCount;
				MemoryMetrics averageMemory = new MemoryMetrics(_secondManagedUsedSum / secondBucketFrameCount, _secondProcessResidentSum / secondBucketFrameCount, _secondProcessPrivateSum / secondBucketFrameCount, _secondUnityAllocatedSum / secondBucketFrameCount, _secondUnityReservedSum / secondBucketFrameCount, _secondUnityMonoUsedSum / secondBucketFrameCount, _secondUnityMonoHeapSum / secondBucketFrameCount);
				FrameTimeMetrics averageFrameTime = new FrameTimeMetrics((_secondCpuFrameTimeCount > 0) ? ((float)(_secondCpuFrameTimeSumMs / (double)_secondCpuFrameTimeCount)) : 0f, (_secondGpuFrameTimeCount > 0) ? ((float)(_secondGpuFrameTimeSumMs / (double)_secondGpuFrameTimeCount)) : 0f, _secondCpuFrameTimeCount, _secondGpuFrameTimeCount);
				SecondSample sample = new SecondSample(_secondBucketStart, secondBucketFrameCount, num, averageMemory, averageFrameTime, _secondBucketBackgroundFrameCount, _currentChunkId, _currentUiType);
				AppendSecondSampleLocked(sample);
				EnqueueReportSampleLocked(in sample);
				_secondBucketActive = false;
			}
		}

		private static void AppendSecondSampleLocked(SecondSample sample)
		{
			while (_secondCount > 0 && sample.Timestamp - _secondSamples[SecondIndexAt(0)].Timestamp > 60.0)
			{
				SecondDropOldest();
			}
			if (_secondCount == 120)
			{
				SecondDropOldest();
			}
			_secondSamples[SecondIndexAt(_secondCount)] = sample;
			_secondCount++;
		}

		private static void SecondDropOldest()
		{
			_secondHeadIndex = (_secondHeadIndex + 1) % 120;
			_secondCount--;
		}

		private static int SecondIndexAt(int offsetFromHead)
		{
			return (_secondHeadIndex + offsetFromHead) % 120;
		}

		private static void EnqueueReportSampleLocked(in SecondSample sample)
		{
			if (_reportCount >= 600)
			{
				_reportHead = (_reportHead + 1) % 600;
				_reportCount--;
			}
			_reportSamples[(_reportHead + _reportCount) % 600] = sample;
			_reportCount++;
		}

		private static void ResetReportQueueLocked()
		{
			_reportHead = 0;
			_reportCount = 0;
		}

		private static void FetchReportWindowLocked(double windowEnd)
		{
			_reportPacketCount = 0;
			while (_reportPacketCount < 30 && _reportCount > 0)
			{
				SecondSample secondSample = _reportSamples[_reportHead];
				if (!(secondSample.Timestamp >= windowEnd))
				{
					_reportPacketBuffer[_reportPacketCount] = secondSample;
					_reportPacketCount++;
					_reportHead = (_reportHead + 1) % 600;
					_reportCount--;
					continue;
				}
				break;
			}
		}

		private static void ProcessRuntimeReportTick()
		{
			double sessionStartTimestamp = _sessionStartTimestamp;
			if (sessionStartTimestamp <= 0.0)
			{
				return;
			}
			if (_reportWindowAnchor != sessionStartTimestamp)
			{
				_reportWindowAnchor = sessionStartTimestamp;
				_nextReportWindowEnd = sessionStartTimestamp + 30.0;
			}
			double currentTimestamp = CurrentTimestamp;
			for (int i = 0; i < 4; i++)
			{
				if (!(currentTimestamp >= _nextReportWindowEnd))
				{
					break;
				}
				lock (_gate)
				{
					FetchReportWindowLocked(_nextReportWindowEnd);
				}
				SendRuntimeReportPacket();
				_nextReportWindowEnd += 30.0;
			}
		}

		private static void FlushPendingReports()
		{
			while (true)
			{
				lock (_gate)
				{
					FetchReportWindowLocked(double.PositiveInfinity);
					if (_reportPacketCount == 0)
					{
						break;
					}
				}
				SendRuntimeReportPacket();
			}
		}

		private static void SendRuntimeReportPacket()
		{
			JArray jArray = new JArray();
			JArray jArray2 = new JArray();
			JArray jArray3 = new JArray();
			JArray jArray4 = new JArray();
			JArray jArray5 = new JArray();
			JArray jArray6 = new JArray();
			JArray jArray7 = new JArray();
			JArray jArray8 = new JArray();
			JArray jArray9 = new JArray();
			JArray jArray10 = new JArray();
			JArray jArray11 = new JArray();
			int num = 0;
			for (int i = 0; i < _reportPacketCount; i++)
			{
				SecondSample secondSample = _reportPacketBuffer[i];
				if (!secondSample.IsBackground)
				{
					long num2 = (long)Math.Round(secondSample.Timestamp - _sessionStartTimestamp, MidpointRounding.ToEven);
					if (!jArray9.Contains(num2))
					{
						jArray9.Add(num2);
						jArray10.Add(secondSample.ChunkId);
						jArray11.Add(secondSample.UiType);
						jArray.Add(Math.Round(secondSample.AverageFrameRate, 2));
						jArray2.Add(ToMegabytes(secondSample.AverageMemory.ManagedUsedBytes));
						jArray3.Add(ToMegabytes(secondSample.AverageMemory.UnityAllocatedBytes));
						jArray4.Add(ToMegabytes(secondSample.AverageMemory.UnityReservedBytes));
						jArray5.Add(ToMegabytes(secondSample.AverageMemory.UnityMonoUsedBytes));
						jArray6.Add(ToMegabytes(secondSample.AverageMemory.UnityMonoHeapBytes));
						jArray7.Add(Math.Round(secondSample.AverageFrameTime.CpuFrameTimeMs, 2));
						jArray8.Add(Math.Round(secondSample.AverageFrameTime.GpuFrameTimeMs, 2));
						num++;
					}
				}
			}
			if (num != 0)
			{
				JObject jObject = new JObject
				{
					["start_timestamp"] = _sessionStartUnixSeconds,
					["fps_list"] = jArray,
					["managed_used_mb"] = jArray2,
					["unity_allocated_mb"] = jArray3,
					["unity_reserved_mb"] = jArray4,
					["unity_mono_used_mb"] = jArray5,
					["unity_mono_heap_mb"] = jArray6,
					["cpu_frame_time_ms"] = jArray7,
					["gpu_frame_time_ms"] = jArray8,
					["second_list"] = jArray9,
					["world_id_list"] = jArray10,
					["ui_id_list"] = jArray11
				};
				BamBooSdk.getInstance().taEvent("client_runtime_sample", jObject.ToString());
			}
		}

		private static long ToMegabytes(long bytes)
		{
			return (long)Math.Round((double)bytes * (1.0 / 1048576.0), MidpointRounding.AwayFromZero);
		}
	}

	private static readonly byte[] Key = Convert.FromBase64String("yv82l+V4Q7XuxDX0UOaWye4AVLPUZ5XM");

	private static byte[] GCMKey;

	private static bool IsEncry;

	private const int GcmNonceSize = 12;

	private const int GcmTagSize = 16;

	private const int GcmOverhead = 28;

	public const string LocalVersionDefine = "dev.local";

	public const string InternalVersion = "dev.local";

	private const string AppInfoKey_Region = "region";

	private const string AppInfoKey_Env = "env";

	private const string AppInfoKey_AutoStartUWA = "uwa";

	private const string AppInfoKey_Channel = "channel";

	private const string AppInfoKey_Version = "client_version";

	private const string AppInfoKey_ConfigUrl = "config_url";

	private const string AppInfoKey_FeedbackUrlName = "feedback_url";

	private const string GMUrl = "gm_url";

	private static RemoteConfig _remoteConfig;

	private static GMApi _gmApi;

	private static bool _AppInfoIsInit;

	private static string _displayVersionShort;

	private static string _displayVersion;

	private static string _appRegion = string.Empty;

	private static string _appEnv = string.Empty;

	private static string _appChannel = string.Empty;

	private static string _appClientVersion = string.Empty;

	private static string _deviceId = string.Empty;

	private static string _feedbackUrl = string.Empty;

	private static string _resourceVersion = "";

	private static string _tableVersion = "";

	private static string _dllVersion = "";

	private static string _rawFileVersion = "";

	private static string _serverVersion = "";

	private const string SERVER_VERSION_PREFIX = "S";

	private static bool _reviewMode = false;

	private static int _isPad = -1;

	private const string WeGameChannel = "wegame";

	public static readonly UnityEvent OnDisplayVersionUpdate = new UnityEvent();

	public static string AppID = "1038";

	public const string RES_COMMIT_ID_PREFIX = "P";

	public const string TABLE_COMMIT_ID_PREFIX = "C";

	public const string DLL_COMMIT_ID_PREFIX = "D";

	public const string RAW_FILE_COMMIT_ID_PREFIX = "R";

	private const string COMMIT_INFO_FILE_NAME = "commit_info";

	private const string COMMIT_ID_KEY_CLIENT = "client_commit_id";

	private const string COMMIT_ID_KEY_TABLE = "table_commit_id";

	private const string COMMIT_ID_KEY_DLL = "dll_commit_id";

	private const string COMMIT_ID_KEY_RAW_FILE = "raw_file_commit_id";

	public static string GetPlatformName = Application.platform switch
	{
		RuntimePlatform.Android => "Android", 
		RuntimePlatform.IPhonePlayer => "iOS", 
		RuntimePlatform.WindowsPlayer => "Win64", 
		RuntimePlatform.OSXPlayer => "MacOS", 
		RuntimePlatform.WindowsEditor => "Win64", 
		_ => "", 
	};

	public static bool IsGcmEncryptionEnabled => IsEncry;

	public static int AutoStartUWAMode { get; private set; } = 0;

	public static bool IsAssigned { get; private set; }

	public static bool IsPad
	{
		get
		{
			if (_isPad >= 0)
			{
				return _isPad == 1;
			}
			Debug.Log("[Screen Info] width: " + Screen.width + ", height: " + Screen.height + ", dpi: " + Screen.dpi);
			float dpi = Screen.dpi;
			if (dpi <= 0f)
			{
				_isPad = 0;
			}
			else
			{
				float num = (float)Screen.width / dpi;
				float num2 = (float)Screen.height / dpi;
				_isPad = ((Mathf.Sqrt(num * num + num2 * num2) > 7f) ? 1 : 0);
			}
			return _isPad == 1;
		}
	}

	public static string AppRegion => _appRegion;

	public static string AppEnv => _appEnv;

	public static string AppChannel => _appChannel;

	public static bool IsWeGameChannel => string.Equals(_appChannel, "wegame", StringComparison.OrdinalIgnoreCase);

	public static string AppClientVersion => _appClientVersion;

	public static string DeviceId
	{
		get
		{
			return _deviceId;
		}
		set
		{
			_deviceId = value;
		}
	}

	public static bool ReviewMode
	{
		get
		{
			return _reviewMode;
		}
		set
		{
			_reviewMode = value;
		}
	}

	public static string AppCpsId { get; set; } = string.Empty;

	public static string AppCpsGroup { get; set; } = string.Empty;

	public static string FeedbackUrl => _feedbackUrl;

	public static bool IsLocalVersion => "dev.local".Equals("dev.local");

	public static RemoteConfig RemoteConfig => _remoteConfig;

	public static GMApi GmApi { get; } = new GMApi();

	public static string SDKAccountId { get; private set; }

	public static bool LogEnabled { get; private set; } = true;

	public static string ShortDisplayVersion
	{
		get
		{
			if (_AppInfoIsInit)
			{
				return _displayVersionShort;
			}
			return "dev.local";
		}
	}

	public static string DisplayVersion
	{
		get
		{
			if (_AppInfoIsInit)
			{
				return _displayVersion;
			}
			return "dev.local";
		}
	}

	public static string CurrentPlatformId
	{
		get
		{
			switch (Application.platform)
			{
			case RuntimePlatform.OSXEditor:
			case RuntimePlatform.WindowsPlayer:
			case RuntimePlatform.WindowsEditor:
			case RuntimePlatform.LinuxEditor:
				return "Win64";
			case RuntimePlatform.Android:
				return "Android";
			case RuntimePlatform.OSXPlayer:
			case RuntimePlatform.IPhonePlayer:
				return "iOS";
			default:
				return "Win64";
			}
		}
	}

	private static string CommitInfoFilePath => Path.Combine(GetResPath(), "commit_info");

	public static event Action OnResourceVersionUpdated;

	public static string Encrypt(string plainText)
	{
		using Aes aes = Aes.Create();
		aes.Key = Key;
		aes.GenerateIV();
		aes.Mode = CipherMode.CBC;
		aes.Padding = PaddingMode.PKCS7;
		byte[] iV = aes.IV;
		ICryptoTransform transform = aes.CreateEncryptor(aes.Key, aes.IV);
		using MemoryStream memoryStream = new MemoryStream();
		memoryStream.Write(iV, 0, iV.Length);
		using (CryptoStream stream = new CryptoStream(memoryStream, transform, CryptoStreamMode.Write))
		{
			using StreamWriter streamWriter = new StreamWriter(stream);
			streamWriter.Write(plainText);
		}
		return Convert.ToBase64String(memoryStream.ToArray());
	}

	public static string Decrypt(string cipherText)
	{
		byte[] array = Convert.FromBase64String(cipherText);
		byte[] array2 = new byte[16];
		Array.Copy(array, 0, array2, 0, 16);
		byte[] buffer = array.AsSpan(16).ToArray();
		using Aes aes = Aes.Create();
		aes.Key = Key;
		aes.IV = array2;
		aes.Mode = CipherMode.CBC;
		aes.Padding = PaddingMode.PKCS7;
		ICryptoTransform transform = aes.CreateDecryptor(aes.Key, aes.IV);
		using MemoryStream stream = new MemoryStream(buffer);
		using CryptoStream stream2 = new CryptoStream(stream, transform, CryptoStreamMode.Read);
		using StreamReader streamReader = new StreamReader(stream2);
		return streamReader.ReadToEnd();
	}

	public static void InitializeGCMKey(bool isEncry, byte[] key)
	{
		IsEncry = isEncry;
		if (!isEncry)
		{
			GCMKey = null;
			return;
		}
		if (key == null || (key.Length != 16 && key.Length != 24 && key.Length != 32))
		{
			throw new ArgumentException("Key must be 128, 192, or 256 bits.");
		}
		GCMKey = key;
	}

	public static string GcmEncrypt(string plainText)
	{
		if (!IsEncry)
		{
			return plainText;
		}
		return GcmEncryptWithKey(plainText, GCMKey);
	}

	public static byte[] GcmEncrypt(byte[] plainBytes)
	{
		if (!IsEncry)
		{
			return plainBytes;
		}
		return GcmEncryptWithKey(plainBytes, GCMKey);
	}

	public static byte[] GcmEncrypt(ReadOnlySpan<byte> plainBytes)
	{
		if (!IsEncry)
		{
			return plainBytes.ToArray();
		}
		return GcmEncryptWithKey(plainBytes, GCMKey);
	}

	public static string GcmEncryptWithKey(string plainText, byte[] key)
	{
		return Convert.ToBase64String(GcmEncryptWithKey(Encoding.UTF8.GetBytes(plainText), key));
	}

	public static byte[] GcmEncryptWithKey(byte[] plainBytes, byte[] key)
	{
		return GcmEncryptWithKey(plainBytes.AsSpan(), key);
	}

	public static byte[] GcmEncryptWithKey(ReadOnlySpan<byte> plainBytes, byte[] key)
	{
		byte[] array = new byte[12];
		byte[] array2 = new byte[plainBytes.Length];
		byte[] array3 = new byte[16];
		RandomNumberGenerator.Fill(array);
		if (!TryAesGcmEncrypt(key, array, plainBytes, array2, array3))
		{
			LuminAesGcmCompat.Encrypt(key, array, plainBytes, array2, array3);
		}
		return PackGcmPayload(array, array2, array3);
	}

	public static string GcmDecrypt(string cipherText)
	{
		if (!IsEncry)
		{
			return cipherText;
		}
		return GcmDecryptWithKey(cipherText, GCMKey);
	}

	public static byte[] GcmDecrypt(ReadOnlySpan<byte> cipherBytes)
	{
		if (!IsEncry)
		{
			return cipherBytes.ToArray();
		}
		return GcmDecryptWithKey(cipherBytes, GCMKey);
	}

	public static bool TryGcmDecrypt(ReadOnlySpan<byte> cipherBytes, Span<byte> destination, out int written)
	{
		if (!IsEncry)
		{
			return TryCopyPlaintext(cipherBytes, destination, out written);
		}
		if (cipherBytes.Length < 28)
		{
			written = 0;
			return false;
		}
		return TryGcmDecryptWithKey(cipherBytes, GCMKey, destination, out written);
	}

	public static bool TryCopyPlaintext(ReadOnlySpan<byte> source, Span<byte> destination, out int written)
	{
		if (source.Length > destination.Length)
		{
			written = 0;
			return false;
		}
		source.CopyTo(destination);
		written = source.Length;
		return true;
	}

	public static byte[] GcmDecrypt(byte[] cipherBytes)
	{
		if (!IsEncry)
		{
			return cipherBytes;
		}
		return GcmDecryptWithKey(cipherBytes, GCMKey);
	}

	public static string GcmDecryptWithKey(string cipherText, byte[] key)
	{
		return Encoding.UTF8.GetString(GcmDecryptWithKey(Convert.FromBase64String(cipherText), key));
	}

	public static byte[] GcmDecryptWithKey(byte[] cipherBytes, byte[] key)
	{
		return GcmDecryptWithKey(cipherBytes.AsSpan(), key);
	}

	public static byte[] GcmDecryptWithKey(ReadOnlySpan<byte> cipherBytes, byte[] key)
	{
		byte[] array = new byte[cipherBytes.Length - 28];
		if (!TryGcmDecryptWithKey(cipherBytes, key, array, out var written))
		{
			throw new ArgumentException("Destination buffer is too small.");
		}
		return array[..written].ToArray();
	}

	public static bool TryGcmDecryptWithKey(ReadOnlySpan<byte> cipherBytes, byte[] key, Span<byte> destination, out int written)
	{
		int num = cipherBytes.Length - 28;
		if (num < 0 || destination.Length < num)
		{
			written = 0;
			return false;
		}
		ReadOnlySpan<byte> readOnlySpan = cipherBytes;
		ReadOnlySpan<byte> nonce = readOnlySpan.Slice(0, 12);
		ReadOnlySpan<byte> tag = cipherBytes.Slice(cipherBytes.Length - 16, 16);
		ReadOnlySpan<byte> ciphertext = cipherBytes.Slice(12, num);
		Span<byte> span = destination;
		Span<byte> plaintext = span.Slice(0, num);
		if (TryAesGcmDecrypt(key, nonce, ciphertext, tag, plaintext))
		{
			written = num;
			return true;
		}
		try
		{
			LuminAesGcmCompat.Decrypt(key, nonce, ciphertext, tag, plaintext);
			written = num;
			return true;
		}
		catch (CryptographicException)
		{
			written = 0;
			return false;
		}
	}

	private static byte[] PackGcmPayload(ReadOnlySpan<byte> nonce, ReadOnlySpan<byte> ciphertext, ReadOnlySpan<byte> tag)
	{
		byte[] array = new byte[28 + ciphertext.Length];
		nonce.CopyTo(array.AsSpan(0, 12));
		ciphertext.CopyTo(array.AsSpan(12, ciphertext.Length));
		tag.CopyTo(array.AsSpan(12 + ciphertext.Length, 16));
		return array;
	}

	private static bool TryAesGcmEncrypt(byte[] key, byte[] nonce, ReadOnlySpan<byte> plainBytes, byte[] ciphertext, byte[] tag)
	{
		try
		{
			using AesGcm aesGcm = new AesGcm(key);
			aesGcm.Encrypt(nonce, plainBytes.ToArray(), ciphertext, tag);
			return true;
		}
		catch (PlatformNotSupportedException)
		{
			return false;
		}
	}

	private static bool TryAesGcmDecrypt(byte[] key, ReadOnlySpan<byte> nonce, ReadOnlySpan<byte> ciphertext, ReadOnlySpan<byte> tag, Span<byte> plaintext)
	{
		try
		{
			using AesGcm aesGcm = new AesGcm(key);
			aesGcm.Decrypt(nonce.ToArray(), ciphertext.ToArray(), tag.ToArray(), plaintext);
			return true;
		}
		catch (CryptographicException)
		{
			return false;
		}
		catch (PlatformNotSupportedException)
		{
			return false;
		}
	}

	public static byte[] NormalizeAesKeyBytes(byte[] plainBytes)
	{
		int num = plainBytes.Length;
		if (num == 16 || num == 24 || num == 32)
		{
			return plainBytes;
		}
		string s = Encoding.UTF8.GetString(plainBytes).Trim();
		try
		{
			byte[] array = Convert.FromBase64String(s);
			num = array.Length;
			if (num == 16 || num == 24 || num == 32)
			{
				return array;
			}
		}
		catch (FormatException)
		{
		}
		byte[] bytes = Encoding.UTF8.GetBytes(s);
		num = bytes.Length;
		if (num == 16 || num == 24 || num == 32)
		{
			return bytes;
		}
		throw new ArgumentException($"Invalid AES key length after decrypt: {plainBytes.Length}");
	}

	public static void SetHandleOnScreenDeviceCallback<T>(OnScreenControlNode<T>.HandleOnScreenDeviceInput callback) where T : struct
	{
		OnScreenControlNode<T>.InputCallback = callback;
	}

	public static void SetLogEnabled(bool enabled)
	{
		LogEnabled = enabled;
	}

	internal static IEnumerator LoadDebugLogEnableState()
	{
		yield return EnableIfCouldLog();
	}

	private static IEnumerator EnableIfCouldLog()
	{
		string text = Path.Combine(Application.streamingAssetsPath, "app_log_enabled");
		string content = string.Empty;
		if (text.StartsWith("jar") || text.StartsWith("http"))
		{
			UnityWebRequest request = UnityWebRequest.Get(text);
			yield return request.SendWebRequest();
			if (request.result == UnityWebRequest.Result.Success)
			{
				byte[] data = request.downloadHandler.data;
				if (data != null && data.Length > 0)
				{
					content = FixStringContent(Encoding.UTF8.GetString(data));
				}
			}
		}
		else if (File.Exists(text))
		{
			content = FixStringContent(File.ReadAllText(text, Encoding.UTF8));
		}
		LogEnabled = !string.IsNullOrEmpty(content);
	}

	internal static async Task LoadAppInfo()
	{
		try
		{
			string text = Path.Combine(Application.streamingAssetsPath, "app_info");
			string content = string.Empty;
			if (text.StartsWith("jar") || text.StartsWith("http"))
			{
				UnityWebRequest request = UnityWebRequest.Get(text);
				await request.SendWebRequest();
				if (request.result == UnityWebRequest.Result.Success)
				{
					byte[] data = request.downloadHandler.data;
					if (data != null && data.Length > 0)
					{
						content = FixStringContent(Encoding.UTF8.GetString(data));
					}
				}
			}
			else if (File.Exists(text))
			{
				content = FixStringContent(File.ReadAllText(text, Encoding.UTF8));
			}
			ReadAppInfo(content);
			IsAssigned = true;
		}
		catch
		{
			LuminErrorAOT.ReportGameLoadingError("C01-1101", "01", 0, "读取应用信息失败");
		}
	}

	private static string FixStringContent(string content)
	{
		return content.Trim(' ', '\n', '\r');
	}

	public static IEnumerator Init(MonoBehaviour root, int defaultPackageVersion, int rawfileVersion, int clientStaticVersion, int dllVersion, Action<bool, RemoteConfig> callback)
	{
		SDKAccountId = LuminBambooBridgeListener.UserInfo?.uid ?? "0";
		yield return RemoteConfigInfoUtils.LoadRemoteConfig(_appRegion, _appEnv, _appChannel, _appClientVersion, _deviceId, defaultPackageVersion, rawfileVersion, clientStaticVersion, dllVersion, SDKAccountId, (bool success, RemoteConfig config) =>
		{
			OnRemoteConfigLoaded(success, config);
			callback?.Invoke(success, config);
		});
	}

	public static bool FeatureIsBlocked(int systemType)
	{
		if (_remoteConfig != null)
		{
			return _remoteConfig.FeatureIsBlocked(systemType);
		}
		return false;
	}

	private static void ReadAppInfo(string allText)
	{
		if (string.IsNullOrEmpty(allText))
		{
			return;
		}
		string text = Decrypt(allText);
		if (LogEnabled)
		{
			Debug.Log("[App Info] GetText: " + text);
		}
		string[] array = text.Split(',');
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split("=");
			string a = FixStringContent(array2[0]);
			string text2 = FixStringContent(array2[1]);
			if (string.Equals(a, "region", StringComparison.OrdinalIgnoreCase))
			{
				_appRegion = text2;
			}
			else if (string.Equals(a, "channel", StringComparison.OrdinalIgnoreCase))
			{
				_appChannel = text2;
			}
			else if (string.Equals(a, "env", StringComparison.OrdinalIgnoreCase))
			{
				_appEnv = text2;
			}
			else if (string.Equals(a, "client_version", StringComparison.OrdinalIgnoreCase))
			{
				_appClientVersion = text2;
			}
			else if (string.Equals(a, "config_url", StringComparison.OrdinalIgnoreCase))
			{
				RemoteConfigInfoUtils.SetOverrideRequestRemoteConfigUrl(text2);
				GMApi.SetBaseUrl(text2);
			}
			else if (string.Equals(a, "feedback_url", StringComparison.OrdinalIgnoreCase))
			{
				_feedbackUrl = text2;
			}
			else if (string.Equals(a, "uwa", StringComparison.OrdinalIgnoreCase))
			{
				AutoStartUWAMode = (int.TryParse(text2, out var result) ? result : 0);
			}
		}
		_AppInfoIsInit = true;
		LoadSavedCommitIds();
		RefreshAppInfos();
		OnDisplayVersionUpdate?.Invoke();
	}

	public static string FormatCommitId(string commitId, string tag)
	{
		if (string.IsNullOrEmpty(commitId))
		{
			return "";
		}
		return "_" + tag + ((commitId.Length > 6) ? commitId.Substring(0, 6) : commitId);
	}

	internal static void UpdateResourceVersion(string clientCommitId, string tableCommitId, string dllCommitId, string rawFileCommitId)
	{
		_resourceVersion = FormatCommitId(clientCommitId, "P");
		_tableVersion = FormatCommitId(tableCommitId, "C");
		_dllVersion = FormatCommitId(dllCommitId, "D");
		_rawFileVersion = FormatCommitId(rawFileCommitId, "R");
		_serverVersion = "";
		RefreshAppInfos();
		OnResourceVersionUpdated?.Invoke();
	}

	public static void UpdateServerVersion(string serverVersion)
	{
		_serverVersion = FormatCommitId(serverVersion, "S");
		RefreshAppInfos();
	}

	internal static void SaveCommitIds(string clientCommitId, string tableCommitId, string dllCommitId, string rawFileCommitId)
	{
		try
		{
			string content = "client_commit_id=" + clientCommitId + ",table_commit_id=" + tableCommitId + ",dll_commit_id=" + dllCommitId + ",raw_file_commit_id=" + rawFileCommitId;
			string commitInfoFilePath = CommitInfoFilePath;
			string directoryName = Path.GetDirectoryName(commitInfoFilePath);
			if (!string.IsNullOrEmpty(directoryName) && !Directory.Exists(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			try
			{
				AotCrypto.WriteEncrypted(commitInfoFilePath, content);
				if (LogEnabled)
				{
					Debug.Log("[LuminApplication] CommitId已保存到(加密): " + commitInfoFilePath);
				}
			}
			catch (Exception ex)
			{
				try
				{
					string text = Path.Combine(Application.persistentDataPath, "commit_info");
					string directoryName2 = Path.GetDirectoryName(text);
					if (!string.IsNullOrEmpty(directoryName2) && !Directory.Exists(directoryName2))
					{
						Directory.CreateDirectory(directoryName2);
					}
					AotCrypto.WriteEncrypted(text, content);
					if (LogEnabled)
					{
						Debug.Log("[LuminApplication] CommitId已保存到持久化路径(加密): " + text);
					}
				}
				catch (Exception ex2)
				{
					throw new AggregateException("Write to primary and fallback paths both failed", ex, ex2);
				}
			}
		}
		catch (Exception ex3)
		{
			Debug.LogError("[LuminApplication] 保存CommitId失败: " + ex3.Message);
		}
	}

	internal static void LoadSavedCommitIds()
	{
		try
		{
			if (!File.Exists(CommitInfoFilePath))
			{
				return;
			}
			string text = AotCrypto.ReadDecrypted(CommitInfoFilePath);
			if (string.IsNullOrEmpty(text))
			{
				return;
			}
			string text2 = null;
			string text3 = null;
			string text4 = null;
			string text5 = null;
			string[] array = text.Split(',');
			for (int i = 0; i < array.Length; i++)
			{
				string[] array2 = array[i].Split('=');
				if (array2.Length == 2)
				{
					string text6 = array2[0].Trim();
					string text7 = array2[1].Trim();
					switch (text6)
					{
					case "client_commit_id":
						text2 = text7;
						break;
					case "table_commit_id":
						text3 = text7;
						break;
					case "dll_commit_id":
						text4 = text7;
						break;
					case "raw_file_commit_id":
						text5 = text7;
						break;
					}
				}
			}
			if (!string.IsNullOrEmpty(text2) && !string.IsNullOrEmpty(text3) && !string.IsNullOrEmpty(text4))
			{
				UpdateResourceVersion(text2, text3, text4, text5 ?? "");
				if (LogEnabled)
				{
					Debug.Log("[LuminApplication] 加载已保存的CommitId: Client=" + text2 + ", Table=" + text3 + ", Dll=" + text4 + ", RawFile=" + text5);
				}
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[LuminApplication] 加载CommitId失败: " + ex.Message);
		}
	}

	private static void RefreshAppInfos()
	{
		if (_AppInfoIsInit)
		{
			string text = _appRegion + _appEnv;
			string runtimePlatformShortName = GetRuntimePlatformShortName();
			if (!string.IsNullOrEmpty(text))
			{
				text = text + runtimePlatformShortName + "_";
			}
			_displayVersionShort = text + _appClientVersion;
			_displayVersion = text + _appClientVersion + _resourceVersion + _tableVersion + _dllVersion + _rawFileVersion + _serverVersion;
			OnDisplayVersionUpdate.Invoke();
		}
	}

	internal static string GetRuntimePlatformShortName()
	{
		string text = "";
		return Application.platform switch
		{
			RuntimePlatform.Android => "Android", 
			RuntimePlatform.IPhonePlayer => "iOS", 
			RuntimePlatform.OSXPlayer => "Mac", 
			RuntimePlatform.WindowsPlayer => "Win", 
			_ => "Unknown", 
		};
	}

	public static void RefreshRemoteConfig(MonoBehaviour root)
	{
		root.StartCoroutine(RemoteConfigInfoUtils.LoadRemoteConfig(_appRegion, _appEnv, _appChannel, _appClientVersion, _deviceId, _remoteConfig.AssetsVersion, _remoteConfig.RawFileVersion, _remoteConfig.ClientStaticVersion, _remoteConfig.DllVersion, LuminBambooBridgeListener.UserInfo?.uid ?? "0", OnRemoteConfigLoaded));
	}

	public static void RefreshRemoteConfig(MonoBehaviour root, Action<bool, RemoteConfig> callback)
	{
		root.StartCoroutine(RemoteConfigInfoUtils.LoadRemoteConfig(_appRegion, _appEnv, _appChannel, _appClientVersion, _deviceId, _remoteConfig.AssetsVersion, _remoteConfig.RawFileVersion, _remoteConfig.ClientStaticVersion, _remoteConfig.DllVersion, LuminBambooBridgeListener.UserInfo?.uid ?? "0", (bool success, RemoteConfig config) =>
		{
			OnRemoteConfigLoaded(success, config);
			_reviewMode = _remoteConfig.ServerName.ToLower() == "review";
			callback?.Invoke(success, config);
		}));
	}

	private static void OnRemoteConfigLoaded(bool success, RemoteConfig config)
	{
		_remoteConfig = (success ? config : _remoteConfig);
	}

	public static string GetResPath()
	{
		return Path.Combine(Application.persistentDataPath, "res");
	}

	public static byte[] GetAesGcmKey(string password)
	{
		byte[] bytes = Encoding.UTF8.GetBytes(password);
		using SHA256 sHA = SHA256.Create();
		return sHA.ComputeHash(bytes);
	}

	public static string GetManifestPath(AssetType type)
	{
		return type switch
		{
			AssetType.RawFile => RemoteConfig.RawFileManifestPrefix, 
			AssetType.Dll => RemoteConfig.DllManifestPrefix, 
			AssetType.ClientStatic => RemoteConfig.ClientStaticManifestPrefix, 
			_ => RemoteConfig.ManifestPrefix, 
		};
	}

	public static string GetBundlePath(AssetType type)
	{
		return type switch
		{
			AssetType.RawFile => RemoteConfig.RawFileBundlePrefix ?? RemoteConfig.RawFileManifestPrefix, 
			AssetType.Dll => RemoteConfig.DllBundlePrefix ?? RemoteConfig.DllManifestPrefix, 
			AssetType.ClientStatic => RemoteConfig.ClientStaticBundlePrefix ?? RemoteConfig.ClientStaticManifestPrefix, 
			_ => RemoteConfig.BundlePrefix ?? RemoteConfig.ManifestPrefix, 
		};
	}

	public static string GetCDNPath(AssetType type)
	{
		return type switch
		{
			AssetType.RawFile => RemoteConfig.RawFileCdnUrl, 
			AssetType.Dll => RemoteConfig.DllCdnUrl, 
			AssetType.ClientStatic => RemoteConfig.ClientStaticCdnUrl, 
			_ => RemoteConfig.CdnUrl, 
		};
	}

	public static string GetBackUpCDNPath(AssetType type)
	{
		return type switch
		{
			AssetType.RawFile => RemoteConfig.RawFileBackUpCdnUrl, 
			AssetType.Dll => RemoteConfig.DllBackUpCdnUrl, 
			AssetType.ClientStatic => RemoteConfig.ClientStaticBackUpCdnUrl, 
			_ => RemoteConfig.BackUpCdnUrl, 
		};
	}
}
