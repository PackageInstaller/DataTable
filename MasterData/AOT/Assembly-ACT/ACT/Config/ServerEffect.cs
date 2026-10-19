using System;

namespace ACT.Config;

[Serializable]
public class ServerEffect
{
	public readonly int id;

	public readonly int[] directivies = new int[0];

	public readonly string[] operands = new string[0];

	public ServerEffect(int id, int[] directivies, string[] operands)
	{
		this.id = id;
		this.directivies = directivies;
		this.operands = operands;
	}
}
