using ACT.Event;

namespace ACT.World.Asset;

public interface IInteractVerification : IDataToBake
{
	bool Verify(IRuleManager ruleManager, LocalStateWorldEvent eventContent);
}
