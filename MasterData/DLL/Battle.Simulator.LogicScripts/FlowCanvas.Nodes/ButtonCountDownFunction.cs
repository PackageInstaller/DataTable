namespace FlowCanvas.Nodes;

public class ButtonCountDownFunction
{
	public const int ENABLE_BUTTON_COUNT_DOWN_BUFF_CLASS_ID = 100099994;

	public const int REMOVE_BUTTON_COUNT_DOWN_BUFF_CLASS_ID = 100099993;

	public static bool IsValidButtonType(ButtonType pButtonType)
	{
		if ((uint)pButtonType <= 2u)
		{
			return true;
		}
		return false;
	}
}
