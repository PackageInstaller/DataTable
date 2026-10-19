using System;

namespace ACT.Config;

[Serializable]
public class GuideData
{
	public readonly int id;

	public readonly string guideMark = "";

	public readonly int[] guideList = new int[0];

	public readonly string[] addressable = new string[0];

	public GuideData(int id, string guideMark, int[] guideList, string[] addressable)
	{
		this.id = id;
		this.guideMark = guideMark;
		this.guideList = guideList;
		this.addressable = addressable;
	}
}
