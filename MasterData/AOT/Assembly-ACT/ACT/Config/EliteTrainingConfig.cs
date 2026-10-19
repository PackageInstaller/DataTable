using System;

namespace ACT.Config;

[Serializable]
public class EliteTrainingConfig
{
	public readonly int id;

	public readonly string name = "";

	public readonly string define = "";

	public readonly string value = "";

	public EliteTrainingConfig(int id, string name, string define, string value)
	{
		this.id = id;
		this.name = name;
		this.define = define;
		this.value = value;
	}
}
