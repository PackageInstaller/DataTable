using System;
using System.Diagnostics;
using ACT;
using Bamboo.Chronos;
using Fundamental;
using UnityEngine;
using UnityEngine.Profiling;

public abstract class RuntimeLoadFlow
{
	private static readonly ObjectPool<LoadInstructionWithTime> _loadInstrutionObjectPool = new ObjectPool<LoadInstructionWithTime>((LoadInstructionWithTime x) =>
	{
		x.Clear();
	}, null);

	private static readonly ObjectPool<Stopwatch> _stopWatchObjectPool = new ObjectPool<Stopwatch>((Stopwatch x) =>
	{
		x.Reset();
	}, null);

	private Stopwatch _totalStopWatch;

	private Stopwatch _stepStopWatch;

	protected Looper _ticker;

	private const int DELTA_TIME = 20;

	private long _lastProcess;

	private bool _enableAPMReport;

	private bool _isStart;

	private string _fromMemSize;

	private float _startTime;

	private const double BytesToMb = 1.0 / 1048576.0;

	private const double MbToBytes = 1048576.0;

	private const float scale = 1f;

	private const float unusedReservedWeight = 0.5f;

	private const float fixedOverheadMb = 80f;

	public LoadInstructionWithTime WaitInitializer { get; private set; }

	public virtual int Weight => 1;

	public string Name { get; private set; }

	public bool IsComplete
	{
		get
		{
			if (_isStart)
			{
				return WaitInitializer.IsComplete;
			}
			return false;
		}
	}

	private event Action _onFlowComplete;

	public event Action OnFlowComplete
	{
		add
		{
			if (WaitInitializer.status)
			{
				value?.Invoke();
			}
			else
			{
				_onFlowComplete += value;
			}
		}
		remove
		{
			_onFlowComplete -= value;
		}
	}

	protected RuntimeLoadFlow(string name)
	{
		Name = name;
		WaitInitializer = _loadInstrutionObjectPool.Get();
		_ticker = UpdateTimer.Default.LoopMs(20, () =>
		{
			WaitInitializer.AddTime((float)TimeSpan.FromMilliseconds(20.0).TotalSeconds);
		});
	}

	~RuntimeLoadFlow()
	{
		_loadInstrutionObjectPool.Release(WaitInitializer);
		if (_ticker.IsValid())
		{
			_ticker.Cancel();
		}
	}

	public void Start(bool enableReport)
	{
		_startTime = Time.realtimeSinceStartup;
		Debug.Log("Start RuntimeLoadFlow: " + Name);
		if (enableReport)
		{
			_fromMemSize = GetCurrentMemUsage();
		}
		_enableAPMReport = enableReport;
		_totalStopWatch = _stopWatchObjectPool.Get();
		_stepStopWatch = _stopWatchObjectPool.Get();
		WaitInitializer.onUpdate -= OnInstructionUpdate;
		WaitInitializer.onUpdate += OnInstructionUpdate;
		_lastProcess = -1L;
		OnStart();
		_isStart = true;
	}

	protected virtual void OnStart()
	{
	}

	protected virtual void OnComplete()
	{
	}

	private void OnInstructionUpdate()
	{
		if (WaitInitializer.Current == 0L)
		{
			if (_lastProcess == WaitInitializer.Current)
			{
				return;
			}
			_totalStopWatch.Start();
			_stepStopWatch.Start();
			Debug.Log("[LuminRuntimeInitializer][" + Name + "] : Start");
		}
		else if (WaitInitializer.Current < WaitInitializer.Total)
		{
			if (_lastProcess == WaitInitializer.Current)
			{
				return;
			}
			_stepStopWatch.Restart();
		}
		else if (WaitInitializer.IsComplete)
		{
			_stopWatchObjectPool.Release(_totalStopWatch);
			_stopWatchObjectPool.Release(_stepStopWatch);
			if (_enableAPMReport)
			{
				SampleMark("[Init Flow Complete] " + Name, _fromMemSize, GetCurrentMemUsage());
			}
			OnComplete();
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			Debug.Log($"Complete RuntimeLoadFlow: {Name}, elapsed {realtimeSinceStartup - _startTime:F2}s");
			_onFlowComplete?.Invoke();
			_onFlowComplete = null;
			WaitInitializer.onUpdate -= OnInstructionUpdate;
			if (_ticker.IsValid())
			{
				_ticker.Cancel();
			}
		}
		_lastProcess = WaitInitializer.Current;
	}

	private void SampleMark(string trigger, string form, string to)
	{
		LuminApplication.APM.GPM.AddCustomEvent("init_flow_memory_snapshot", "performance", "trigger", trigger, "from", form, "to", to);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[init flow memory] " + trigger + "\n\tfrom:" + form + "\n\tto:" + to);
		}
	}

	private static string GetCurrentMemUsage()
	{
		long totalAllocatedMemoryLong = Profiler.GetTotalAllocatedMemoryLong();
		long totalReservedMemoryLong = Profiler.GetTotalReservedMemoryLong();
		long totalUnusedReservedMemoryLong = Profiler.GetTotalUnusedReservedMemoryLong();
		long monoHeapSizeLong = Profiler.GetMonoHeapSizeLong();
		long monoUsedSizeLong = Profiler.GetMonoUsedSizeLong();
		long bytes = EstimatePssBytes();
		return "Memory | " + $"Estimated PSS: {ToMb(bytes):F1} MB, " + $"Unity Allocated: {ToMb(totalAllocatedMemoryLong):F1} MB, " + $"Unity Reserved: {ToMb(totalReservedMemoryLong):F1} MB, " + $"Unused Reserved: {ToMb(totalUnusedReservedMemoryLong):F1} MB, " + $"Mono Heap: {ToMb(monoHeapSizeLong):F1} MB, " + $"Mono Used: {ToMb(monoUsedSizeLong):F1} MB";
	}

	private static long EstimatePssBytes()
	{
		long totalAllocatedMemoryLong = Profiler.GetTotalAllocatedMemoryLong();
		long totalUnusedReservedMemoryLong = Profiler.GetTotalUnusedReservedMemoryLong();
		double num = (double)(((float)totalAllocatedMemoryLong + (float)totalUnusedReservedMemoryLong * 0.5f) * 1f) + 83886080.0;
		if (num <= 0.0)
		{
			return 0L;
		}
		return (long)num;
	}

	private static double ToMb(long bytes)
	{
		return (double)bytes * (1.0 / 1048576.0);
	}
}
