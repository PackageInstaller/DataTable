namespace ACT.ViewControl;

public interface IViewControlLayerInternal
{
	SelectableEx LastSelect { get; }

	void OnChildSelect(SelectableEx selectable);

	void OnChildDeselect(SelectableEx selectable);

	void OnChildUnavailable(SelectableEx selectable);

	void Register(SelectableEx selectable);

	void Unregister(SelectableEx selectable);

	void OnFocus();

	void OnUnFocus();
}
