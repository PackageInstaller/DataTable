using System;
using ACT.UI.CommonComponent.FancyScrollView.Scroller;

namespace ACT.UI.ViewComponent.ScrollView;

public class CommonScrollView : Scroller
{
	public bool freeScroll;

	public override void ScrollTo(float position, float duration, EasingFunction easingFunction, Action onComplete = null)
	{
		if (!freeScroll && position < (float)minIndex)
		{
			position = minIndex;
		}
		base.ScrollTo(position, duration, easingFunction, onComplete);
	}
}
