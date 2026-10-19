namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMAnimation_Children
{
	public static ImmediateAnimation Animation(this HUMAnimation.Data.Create animation, bool unscaledTime = false)
	{
		return new ImmediateAnimation(animation.animator, unscaledTime);
	}
}
