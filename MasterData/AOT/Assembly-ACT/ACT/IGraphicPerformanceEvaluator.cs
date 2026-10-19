using System;

namespace ACT;

public interface IGraphicPerformanceEvaluator
{
	event Action<GraphicPerformanceLoad> PerformanceLoadChanged;

	bool TryGetPerformanceLoad(out GraphicPerformanceLoad performanceLoad);
}
