namespace ACT.UI;

public struct UIOpenResult
{
	public static UIOpenResult InValid = new UIOpenResult
	{
		IsValid = false
	};

	public uint Uid;

	public bool IsValid;
}
