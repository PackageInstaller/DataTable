namespace Proxima;

public interface IProximaPerformanceBenchmarkProvider
{
	ProximaPerformanceBenchmarkStartResponse Start(int sampleSeconds = 60, int warmupSeconds = 10, string sceneLabel = "");

	ProximaPerformanceBenchmarkStatus GetStatus();

	ProximaPerformanceBenchmarkStatus Cancel();

	ProximaPerformanceBenchmarkResult GetResult(string runId = "");
}
