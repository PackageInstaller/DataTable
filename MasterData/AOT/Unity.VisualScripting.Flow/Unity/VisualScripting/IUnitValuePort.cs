using System;

namespace Unity.VisualScripting;

public interface IUnitValuePort : IUnitPort, IGraphItem
{
	Type type { get; }
}
