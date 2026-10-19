using System;

namespace ACT.Config;

[Serializable]
public class BookVerticalData
{
	public readonly int id;

	public readonly int title;

	public readonly int content;

	public BookVerticalData(int id, int title, int content)
	{
		this.id = id;
		this.title = title;
		this.content = content;
	}
}
