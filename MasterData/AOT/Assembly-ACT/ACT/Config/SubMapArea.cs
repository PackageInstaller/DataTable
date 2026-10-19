using System;

namespace ACT.Config;

[Serializable]
public class SubMapArea
{
	public readonly int id;

	public readonly int name;

	public readonly int affiliatedName;

	public readonly string RectSubRoot = "";

	public readonly int subTip;

	public readonly int AudioData;

	public readonly int areaFont;

	public SubMapArea(int id, int name, int affiliatedName, string RectSubRoot, int subTip, int AudioData, int areaFont)
	{
		this.id = id;
		this.name = name;
		this.affiliatedName = affiliatedName;
		this.RectSubRoot = RectSubRoot;
		this.subTip = subTip;
		this.AudioData = AudioData;
		this.areaFont = areaFont;
	}
}
