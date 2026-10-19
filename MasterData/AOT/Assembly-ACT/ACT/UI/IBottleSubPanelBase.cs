namespace ACT.UI;

public interface IBottleSubPanelBase : ISubUIView, IBaseUIComponent
{
	void Init();

	void Refresh();

	void UnInit();

	void OnParentViewClose();
}
