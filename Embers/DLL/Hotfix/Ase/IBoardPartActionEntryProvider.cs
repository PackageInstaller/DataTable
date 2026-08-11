using System.Collections.Generic;

namespace Ase;

public interface IBoardPartActionEntryProvider
{
	string PartId { get; }

	IReadOnlyList<string> CacheAniNames { get; }

	IReadOnlyList<BoardPartActionEntry> ActionEntries { get; }
}
