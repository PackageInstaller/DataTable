using System;

namespace ACT.Config;

[Serializable]
public class DetailFormat
{
	public readonly int titleId;

	public readonly int descId;

	public readonly string[] param = new string[0];

	public DetailFormat(int titleId, int descId, string[] param)
	{
		this.titleId = titleId;
		this.descId = descId;
		this.param = param;
	}
}
