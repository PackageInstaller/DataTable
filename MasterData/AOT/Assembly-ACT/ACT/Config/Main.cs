using System;

namespace ACT.Config;

[Serializable]
public class Main
{
	public readonly int id;

	public readonly int numLimit;

	public readonly int cdLimit;

	public readonly int nameCDLimit;

	public Main(int id, int numLimit, int cdLimit, int nameCDLimit)
	{
		this.id = id;
		this.numLimit = numLimit;
		this.cdLimit = cdLimit;
		this.nameCDLimit = nameCDLimit;
	}
}
