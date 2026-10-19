using System;

namespace ACT.Config;

[Serializable]
public class TipsSubScence
{
	public readonly int id;

	public readonly int iconAddress;

	public readonly int variables;

	public TipsSubScence(int id, int iconAddress, int variables)
	{
		this.id = id;
		this.iconAddress = iconAddress;
		this.variables = variables;
	}
}
