namespace Bamboo.Chronos;

public static class TweenerExtension
{
	public static bool IsValid(this in Tweener tweener)
	{
		return tweener.EventTween?.IsValid(tweener.Index, tweener.Version) ?? false;
	}

	public static void Cancel(this in Tweener tweener)
	{
		tweener.EventTween?.Cancel(tweener.Index, tweener.Version);
	}

	public static void Pause(this in Tweener tweener)
	{
		tweener.EventTween?.Pause(tweener.Index, tweener.Version);
	}

	public static void Resume(this in Tweener tweener)
	{
		tweener.EventTween?.Resume(tweener.Index, tweener.Version);
	}
}
