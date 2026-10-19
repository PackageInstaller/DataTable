using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

public interface IServiceAction : IDataToBake
{
	IEnumerable<StateWorldUid> checkedSwid { get; }

	void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent);
}
