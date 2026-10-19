using System;

namespace ACT.Config;

[Serializable]
public class RogueStep
{
	public readonly int id;

	public readonly int difficulty;

	public readonly int stage;

	public readonly int[] triggerList = new int[0];

	public readonly int[] effectList = new int[0];

	public readonly int[] sceneList = new int[0];

	public readonly int[] eventList = new int[0];

	public readonly int shopid;

	public readonly int[] itemKvs = new int[0];

	public readonly int[] roomType = new int[0];

	public readonly int countCoin;

	public readonly float monsterAttackFix;

	public readonly float monsterHpFix;

	public readonly int stepGroupId;

	public readonly float pressureCoef;

	public RogueStep(int id, int difficulty, int stage, int[] triggerList, int[] effectList, int[] sceneList, int[] eventList, int shopid, int[] itemKvs, int[] roomType, int countCoin, float monsterAttackFix, float monsterHpFix, int stepGroupId, float pressureCoef)
	{
		this.id = id;
		this.difficulty = difficulty;
		this.stage = stage;
		this.triggerList = triggerList;
		this.effectList = effectList;
		this.sceneList = sceneList;
		this.eventList = eventList;
		this.shopid = shopid;
		this.itemKvs = itemKvs;
		this.roomType = roomType;
		this.countCoin = countCoin;
		this.monsterAttackFix = monsterAttackFix;
		this.monsterHpFix = monsterHpFix;
		this.stepGroupId = stepGroupId;
		this.pressureCoef = pressureCoef;
	}
}
