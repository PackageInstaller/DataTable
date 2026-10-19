using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class BookHorizontalData
{
	public readonly int id;

	public readonly List<Maybe> content;

	public BookHorizontalData(int id, List<Maybe> content)
	{
		this.id = id;
		this.content = content;
	}
}
