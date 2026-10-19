using System;

namespace ACT.Config;

[Serializable]
public class Name
{
	public readonly int id;

	public readonly int firstName;

	public readonly int maleName;

	public readonly int femaleName;

	public Name(int id, int firstName, int maleName, int femaleName)
	{
		this.id = id;
		this.firstName = firstName;
		this.maleName = maleName;
		this.femaleName = femaleName;
	}
}
