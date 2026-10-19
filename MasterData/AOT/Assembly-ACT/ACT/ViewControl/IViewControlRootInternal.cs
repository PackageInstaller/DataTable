namespace ACT.ViewControl;

public interface IViewControlRootInternal
{
	void FocusLayer(ViewControlLayer layer, SelectableEx selectableEx, bool autoFindSelectable = true);

	void UnFocusLayer(ViewControlLayer layer);
}
