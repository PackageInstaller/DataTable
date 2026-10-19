using System;

namespace ACT.Config;

[Serializable]
public class SpecialShow
{
	public readonly int id;

	public readonly string actionName = "";

	public readonly string path = "";

	public readonly int describe;

	public readonly int KeyTip;

	public readonly int PadKeyTip;

	public SpecialShow(int id, string actionName, string path, int describe, int KeyTip, int PadKeyTip)
	{
		this.id = id;
		this.actionName = actionName;
		this.path = path;
		this.describe = describe;
		this.KeyTip = KeyTip;
		this.PadKeyTip = PadKeyTip;
	}
}
