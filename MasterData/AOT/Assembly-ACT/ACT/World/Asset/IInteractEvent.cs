using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

public interface IInteractEvent : IDataToBake
{
	ClientEvent clientEvent { get; }

	IEnumerable<int> checkedSwid { get; }
}
