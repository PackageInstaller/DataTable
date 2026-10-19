namespace ACT.UI;

public class MonoPopUpRewardMultiRowView : BaseUIView
{
	public MonoScrollBagComponent scrollBag;

	private MonoScrollBagComponent.Param scrollBagParam;

	protected override void Init()
	{
		scrollBagParam = (MonoScrollBagComponent.Param)uiViewData;
		scrollBag.Init(scrollBagParam);
	}
}
