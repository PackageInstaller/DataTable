using System;

namespace Proxima;

[Serializable]
public sealed class ProximaPerformanceBenchmarkStartResponse
{
	public bool accepted;

	public string message = "";

	public ProximaPerformanceBenchmarkStatus status;
}
