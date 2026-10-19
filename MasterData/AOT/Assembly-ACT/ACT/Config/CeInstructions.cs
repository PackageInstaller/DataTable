using System;

namespace ACT.Config;

[Serializable]
public class CeInstructions
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly int descLocal;

	public CeInstructions(int id, int nameLocal, int descLocal)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.descLocal = descLocal;
	}
}
