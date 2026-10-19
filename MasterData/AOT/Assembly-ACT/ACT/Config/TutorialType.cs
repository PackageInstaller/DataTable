using System;

namespace ACT.Config;

[Serializable]
public class TutorialType
{
	public readonly int id;

	public readonly int name;

	public TutorialType(int id, int name)
	{
		this.id = id;
		this.name = name;
	}
}
