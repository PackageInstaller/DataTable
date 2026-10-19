using ACT.World.Behave;

namespace ACT.World.Asset;

public interface IEventAction
{
	void Enter(BehaveControlBaseBehaveEvent behave);

	bool Do(BehaveControlBaseBehaveEvent behave);

	void Exit(BehaveControlBaseBehaveEvent behave);
}
