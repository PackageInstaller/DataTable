namespace Ase;

public class HeroCultivateView : UGuiViewBase
{
	protected bool showHeroFimage = true;

	protected bool showArrowPart = true;

	public bool ShowHeroFimage => showHeroFimage;

	public bool ShowArrowPart => showArrowPart;

	public virtual void Show()
	{
		base.gameObject.SetActive(value: true);
	}

	public virtual void Hide()
	{
		base.gameObject.SetActive(value: false);
	}
}
