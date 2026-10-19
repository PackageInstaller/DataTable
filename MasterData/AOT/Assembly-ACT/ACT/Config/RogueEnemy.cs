using System;

namespace ACT.Config;

[Serializable]
public class RogueEnemy
{
	public readonly int id;

	public readonly int entityEnemyDataId;

	public readonly int[] rogueGoldDifficultyFactor10k = new int[0];

	public readonly int[] rogueGoldProgressFactor10k = new int[0];

	public readonly int baseRogueGoldDrop;

	public RogueEnemy(int id, int entityEnemyDataId, int[] rogueGoldDifficultyFactor10k, int[] rogueGoldProgressFactor10k, int baseRogueGoldDrop)
	{
		this.id = id;
		this.entityEnemyDataId = entityEnemyDataId;
		this.rogueGoldDifficultyFactor10k = rogueGoldDifficultyFactor10k;
		this.rogueGoldProgressFactor10k = rogueGoldProgressFactor10k;
		this.baseRogueGoldDrop = baseRogueGoldDrop;
	}
}
