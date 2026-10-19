namespace UnityEngine.Rendering.Universal;

public interface ITemporalColorHistoryProvider
{
	bool TryGetPreviousTemporalColor(out TemporalColorHistory history);
}
