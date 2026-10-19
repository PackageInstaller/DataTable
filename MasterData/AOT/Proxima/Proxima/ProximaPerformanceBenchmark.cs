using System;

namespace Proxima;

public static class ProximaPerformanceBenchmark
{
	private const string ProviderUnavailableMessage = "当前项目未注册性能基准采集实现";

	private static IProximaPerformanceBenchmarkProvider _provider;

	public static void RegisterProvider(IProximaPerformanceBenchmarkProvider provider)
	{
		if (provider == null)
		{
			throw new ArgumentNullException("provider");
		}
		if (_provider != provider)
		{
			_provider?.Cancel();
			_provider = provider;
		}
	}

	public static void UnregisterProvider(IProximaPerformanceBenchmarkProvider provider)
	{
		if (_provider == provider)
		{
			_provider.Cancel();
			_provider = null;
		}
	}

	[ProximaTeardown]
	private static void CancelRunningBenchmark()
	{
		_provider?.Cancel();
	}

	[ProximaCommand("Internal", "", "", "", "")]
	private static ProximaPerformanceBenchmarkStartResponse StartPerformanceEvalBenchmarkFromProxima(int sampleSeconds = 60, int warmupSeconds = 10, string sceneLabel = "")
	{
		if (_provider == null)
		{
			return new ProximaPerformanceBenchmarkStartResponse
			{
				accepted = false,
				message = "当前项目未注册性能基准采集实现",
				status = CreateUnavailableStatus()
			};
		}
		return _provider.Start(sampleSeconds, warmupSeconds, sceneLabel);
	}

	[ProximaCommand("Internal", "", "", "", "")]
	private static ProximaPerformanceBenchmarkStatus GetPerformanceEvalBenchmarkStatus()
	{
		if (_provider == null)
		{
			return CreateUnavailableStatus();
		}
		return _provider.GetStatus();
	}

	[ProximaCommand("Internal", "", "", "", "")]
	private static ProximaPerformanceBenchmarkStatus CancelPerformanceEvalBenchmark()
	{
		if (_provider == null)
		{
			return CreateUnavailableStatus();
		}
		return _provider.Cancel();
	}

	[ProximaCommand("Internal", "", "", "", "")]
	private static ProximaPerformanceBenchmarkResult GetPerformanceEvalBenchmarkResult(string runId = "")
	{
		if (_provider == null)
		{
			return new ProximaPerformanceBenchmarkResult
			{
				error = "当前项目未注册性能基准采集实现"
			};
		}
		return _provider.GetResult(runId);
	}

	private static ProximaPerformanceBenchmarkStatus CreateUnavailableStatus()
	{
		return new ProximaPerformanceBenchmarkStatus
		{
			state = "unavailable",
			error = "当前项目未注册性能基准采集实现"
		};
	}
}
