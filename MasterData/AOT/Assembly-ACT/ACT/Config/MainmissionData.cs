using System;

namespace ACT.Config;

[Serializable]
public class MainmissionData
{
	public readonly int id;

	public readonly int title;

	public readonly int subTitle;

	public readonly int type;

	public readonly bool isShowCount;

	public readonly int chapterDesc;

	public MainmissionData(int id, int title, int subTitle, int type, bool isShowCount, int chapterDesc)
	{
		this.id = id;
		this.title = title;
		this.subTitle = subTitle;
		this.type = type;
		this.isShowCount = isShowCount;
		this.chapterDesc = chapterDesc;
	}
}
