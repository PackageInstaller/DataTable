using System;

namespace Proxima;

[Serializable]
public sealed class ProximaPerformanceBenchmarkResult
{
	public bool available;

	public string run_id = "";

	public string file_name = "";

	public string content = "";

	public string error = "";
}
