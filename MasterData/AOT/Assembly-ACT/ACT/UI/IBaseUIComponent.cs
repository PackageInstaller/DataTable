namespace ACT.UI;

public interface IBaseUIComponent
{
	bool IsDestroyed { get; }

	IBaseUIController GetUIController();
}
