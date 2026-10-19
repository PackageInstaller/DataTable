using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityEnemyData
{
	public readonly int id;

	public readonly string config = "";

	public readonly int[] collectionId = new int[0];

	public readonly string ai = "";

	public readonly List<Properties> characterPorpertyBase;

	public readonly int attrType;

	public readonly List<PropertiesMulti> attrSer;

	public readonly int[] skill = new int[0];

	public readonly int isAir;

	public readonly int nativePlace;

	public readonly int enemyType;

	public readonly int enemyRace;

	public readonly string showMonsterModel = "";

	public readonly int monsterIcon;

	public readonly List<ItemKv> monsterItemShow;

	public readonly bool isShowInMonsterBook;

	public readonly int trainBossScene;

	public readonly int tierHPBase;

	public readonly bool skipJumpTraverse;

	public EntityEnemyData(int id, string config, int[] collectionId, string ai, List<Properties> characterPorpertyBase, int attrType, List<PropertiesMulti> attrSer, int[] skill, int isAir, int nativePlace, int enemyType, int enemyRace, string showMonsterModel, int monsterIcon, List<ItemKv> monsterItemShow, bool isShowInMonsterBook, int trainBossScene, int tierHPBase, bool skipJumpTraverse)
	{
		this.id = id;
		this.config = config;
		this.collectionId = collectionId;
		this.ai = ai;
		this.characterPorpertyBase = characterPorpertyBase;
		this.attrType = attrType;
		this.attrSer = attrSer;
		this.skill = skill;
		this.isAir = isAir;
		this.nativePlace = nativePlace;
		this.enemyType = enemyType;
		this.enemyRace = enemyRace;
		this.showMonsterModel = showMonsterModel;
		this.monsterIcon = monsterIcon;
		this.monsterItemShow = monsterItemShow;
		this.isShowInMonsterBook = isShowInMonsterBook;
		this.trainBossScene = trainBossScene;
		this.tierHPBase = tierHPBase;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
