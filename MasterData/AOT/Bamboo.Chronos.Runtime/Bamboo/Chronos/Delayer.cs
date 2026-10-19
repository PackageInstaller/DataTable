namespace Bamboo.Chronos;

public struct Delayer
{
	internal int Index;

	internal int Version;

	internal EventDelay EventDelay;

	internal Delayer(int index, int version, EventDelay eventDelay)
	{
		Index = index;
		Version = version;
		EventDelay = eventDelay;
	}
}
