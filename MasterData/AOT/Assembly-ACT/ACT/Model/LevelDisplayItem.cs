namespace ACT.Model;

public class LevelDisplayItem
{
	public DisplayItemType type;

	public int value;

	public string displayText;

	public bool isPlaceholder;

	public LevelDisplayItem(DisplayItemType itemType, int val, bool placeholder = false)
	{
		type = itemType;
		value = val;
		isPlaceholder = placeholder;
		if (isPlaceholder)
		{
			displayText = "";
		}
		else
		{
			displayText = $"世界等级{val}";
		}
	}
}
