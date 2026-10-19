namespace ACT.UI;

public static class GamePadTipHelper
{
	public static readonly GamePadTipsAction ConfirmAction = new GamePadTipsAction
	{
		inputAction = "UI/Confirm",
		localizeTable = "Common",
		localizeKey = 13
	};

	public static readonly GamePadTipsAction BackAction = new GamePadTipsAction
	{
		inputAction = "UI/Back",
		localizeTable = "Common",
		localizeKey = 606
	};

	public static readonly GamePadTipsAction ScrollAction = new GamePadTipsAction
	{
		inputAction = "UI/RSUpDownSelect",
		localizeTable = "Common",
		localizeKey = 2165
	};
}
