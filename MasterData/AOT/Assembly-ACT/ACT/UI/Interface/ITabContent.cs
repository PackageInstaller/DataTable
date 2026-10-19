namespace ACT.UI.Interface;

public interface ITabContent
{
	ITabItem Tab { get; set; }

	bool IsActive { get; }

	void FocusIn();

	void FocusOut();
}
