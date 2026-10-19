using System.Collections.Generic;

namespace ACT.MissionSystem;

public interface IMissionDependencies
{
	IEnumerable<int> MissionDependencies { get; }
}
