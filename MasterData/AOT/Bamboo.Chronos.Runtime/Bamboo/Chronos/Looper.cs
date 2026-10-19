namespace Bamboo.Chronos;

public struct Looper
{
	internal int Index;

	internal int Version;

	internal EventLoop EventLoop;

	internal Looper(int index, int version, EventLoop eventLoop)
	{
		Index = index;
		Version = version;
		EventLoop = eventLoop;
	}
}
