using System;

namespace ACT.Config;

[Serializable]
public class EliteTrainingHint
{
	public readonly int id;

	public readonly int hint;

	public EliteTrainingHint(int id, int hint)
	{
		this.id = id;
		this.hint = hint;
	}
}
