namespace Unity.VisualScripting;

public interface IUnitControlPort : IUnitPort, IGraphItem
{
	bool isPredictable { get; }

	bool couldBeEntered { get; }
}
