using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class AbyssData
{
	public readonly int id;

	public readonly int abyssGoalType;

	public readonly int[] abyssGoal = new int[0];

	public readonly int[] timeReward = new int[0];

	public readonly List<ItemKv> abyssReward;

	public readonly List<ItemKv> targetReward;

	public readonly int[] subabyss = new int[0];

	public readonly bool quicklyStage;

	public readonly List<ItemKv> preconditionParam;

	public readonly int firstCompletedCollection;

	public readonly int abyssNameLocal;

	public readonly int abyssDisplayName;

	public readonly int abyssIcon;

	public readonly int abyssRecommendedLevel;

	public readonly List<ItemKv> enemyShowList;

	public readonly List<ItemKv> enemyShowListDown;

	public readonly int[] iconDeviation = new int[0];

	public readonly int buffDesc;

	public readonly int abyssStafeDesc;

	public readonly bool skipJumpTraverse;

	public AbyssData(int id, int abyssGoalType, int[] abyssGoal, int[] timeReward, List<ItemKv> abyssReward, List<ItemKv> targetReward, int[] subabyss, bool quicklyStage, List<ItemKv> preconditionParam, int firstCompletedCollection, int abyssNameLocal, int abyssDisplayName, int abyssIcon, int abyssRecommendedLevel, List<ItemKv> enemyShowList, List<ItemKv> enemyShowListDown, int[] iconDeviation, int buffDesc, int abyssStafeDesc, bool skipJumpTraverse)
	{
		this.id = id;
		this.abyssGoalType = abyssGoalType;
		this.abyssGoal = abyssGoal;
		this.timeReward = timeReward;
		this.abyssReward = abyssReward;
		this.targetReward = targetReward;
		this.subabyss = subabyss;
		this.quicklyStage = quicklyStage;
		this.preconditionParam = preconditionParam;
		this.firstCompletedCollection = firstCompletedCollection;
		this.abyssNameLocal = abyssNameLocal;
		this.abyssDisplayName = abyssDisplayName;
		this.abyssIcon = abyssIcon;
		this.abyssRecommendedLevel = abyssRecommendedLevel;
		this.enemyShowList = enemyShowList;
		this.enemyShowListDown = enemyShowListDown;
		this.iconDeviation = iconDeviation;
		this.buffDesc = buffDesc;
		this.abyssStafeDesc = abyssStafeDesc;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
