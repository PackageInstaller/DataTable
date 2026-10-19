namespace Bamboo.Chronos;

public struct Tweener
{
	internal int Index;

	internal int Version;

	internal EventTween EventTween;

	internal Tweener(int index, int version, EventTween eventTween)
	{
		Index = index;
		Version = version;
		EventTween = eventTween;
	}
}
