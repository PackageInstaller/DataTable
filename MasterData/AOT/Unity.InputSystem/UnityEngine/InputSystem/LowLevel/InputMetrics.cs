using System;

namespace UnityEngine.InputSystem.LowLevel;

[Serializable]
public struct InputMetrics
{
	public int maxNumDevices { get; set; }

	public int currentNumDevices { get; set; }

	public int maxStateSizeInBytes { get; set; }

	public int currentStateSizeInBytes { get; set; }

	public int currentControlCount { get; set; }

	public int currentLayoutCount { get; set; }

	public int totalEventBytes { get; set; }

	public int totalEventCount { get; set; }

	public int totalUpdateCount { get; set; }

	public double totalEventProcessingTime { get; set; }

	public double totalEventLagTime { get; set; }

	public float averageEventBytesPerFrame => (float)totalEventBytes / (float)totalUpdateCount;

	public double averageProcessingTimePerEvent => totalEventProcessingTime / (double)totalEventCount;

	public double averageLagTimePerEvent => totalEventLagTime / (double)totalEventCount;
}
