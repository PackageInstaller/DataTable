using ACT.Battle;

namespace ACT.UI;

public class PopUpImageViewInputController : BaseUIViewInputController<PopUpImageViewBaseView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.Close();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void OnCommonBack(bool value)
	{
		if (value)
		{
			View?.Close();
		}
	}

	[GameInputBindingBool("LargeMapView/Left")]
	public void OnSelectImageLeft(bool value)
	{
		if (value)
		{
			View?.LastImage();
		}
	}

	[GameInputBindingBool("LargeMapView/Right")]
	public void OnSelectImageRight(bool value)
	{
		if (value)
		{
			View?.NextImage();
		}
	}

	[GameInputBindingBool("LargeMapView/MapSideInfoLast")]
	public void OnSelectionLeft(bool value)
	{
		if (value)
		{
			View?.LastImage();
		}
	}

	[GameInputBindingBool("LargeMapView/MapSideInfoNext")]
	public void OnSelectionRight(bool value)
	{
		if (value)
		{
			View?.NextImage();
		}
	}
}
