using System;

namespace ACT.Config;

[Serializable]
public class GameWorld
{
	public readonly int id;

	public readonly int config;

	public readonly int type;

	public readonly int packLimit;

	public readonly int AudioData;

	public GameWorld(int id, int config, int type, int packLimit, int AudioData)
	{
		this.id = id;
		this.config = config;
		this.type = type;
		this.packLimit = packLimit;
		this.AudioData = AudioData;
	}
}
