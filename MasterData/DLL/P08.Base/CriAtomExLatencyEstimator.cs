using System;

[Obsolete("This feature is obsoleted. Estimation will not occur if SonicSYNC is enabled.")]
public static class CriAtomExLatencyEstimator
{
	public enum Status
	{
		Stop,
		Processing,
		Done,
		Error
	}

	public struct EstimatorInfo
	{
		public Status status;

		public uint estimated_latency;
	}

	public static void InitializeModule()
	{
	}

	public static void FinalizeModule()
	{
	}

	public static EstimatorInfo GetCurrentInfo()
	{
		return new EstimatorInfo
		{
			status = Status.Stop,
			estimated_latency = 0u
		};
	}
}
