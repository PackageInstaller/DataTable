using System;
using TrueSync;

public class MonsterSpawnerInfo : LogicComponent
{
	public Action monsterDied;

	public TSVector2[] strollPoints;

	public bool strollInCircle;

	public bool quitSettlement;

	public int indexOfSpawnWave;

	public int spawnGroupIndex { get; internal set; } = -1;

	public FP _originRefRng { get; protected set; }

	public FP refRng { get; set; } = FP.MaxValue;

	public FP _originActRng { get; protected set; }

	public FP actRng { get; set; } = FP.MaxValue;

	public FP disActRng { get; set; } = FP.MaxValue;

	public int level { get; set; }

	public bool jumpOverSpawnPerformance { get; set; }

	public bool enterActionStateWhenSpawn { get; set; }

	public int callSpawnSrc { get; set; }
}
