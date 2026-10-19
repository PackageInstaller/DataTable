using System;

namespace Proxima;

[Serializable]
public sealed class ProximaPerformanceBenchmarkStatus
{
	public string state = "idle";

	public bool running;

	public string run_id = "";

	public string scene_label = "";

	public string suggested_scene_label = "";

	public string device_grade = "";

	public string world_partition_name = "";

	public string chunk_debug_name = "";

	public int sample_seconds;

	public int warmup_seconds;

	public double elapsed_seconds;

	public double remaining_seconds;

	public double progress;

	public double phase_elapsed_seconds;

	public double phase_remaining_seconds;

	public bool can_download;

	public string file_name = "";

	public string error = "";
}
