namespace UnityEngine.Rendering.Universal;

public struct PostProcessingData
{
	public int lutSize;

	public bool motionVector;

	internal bool motionFeature;

	public bool TAAHistoryValid;

	public RenderTargetIdentifier TAA_History;

	public RenderTargetIdentifier TAA_Target;

	internal ITemporalResolver temporalResolver;

	internal ITemporalResolver temporalFallbackResolver;

	internal Vector4 temporalJitter;

	internal float uberPostSharpening;

	internal ITemporalColorHistoryProvider temporalColorHistoryProvider;

	internal TemporalColorHistory previousTemporalColor;

	internal bool requiresMotionVectorOutput
	{
		get
		{
			if (!motionVector)
			{
				return motionFeature;
			}
			return true;
		}
	}

	internal bool RegisterTemporalResolver(ITemporalResolver resolver, bool fallback)
	{
		if (fallback)
		{
			if (temporalFallbackResolver == null)
			{
				temporalFallbackResolver = resolver;
			}
			return temporalFallbackResolver == resolver;
		}
		if (temporalResolver == null)
		{
			temporalResolver = resolver;
		}
		return temporalResolver == resolver;
	}

	public void SetTemporalColorHistoryProvider(ITemporalColorHistoryProvider provider)
	{
		temporalColorHistoryProvider = provider;
	}

	public bool TryGetPreviousTemporalColor(out TemporalColorHistory history)
	{
		history = previousTemporalColor;
		return history.isValid;
	}
}
