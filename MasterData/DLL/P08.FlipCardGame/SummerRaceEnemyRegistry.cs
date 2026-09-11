using System.Collections.Generic;

public static class SummerRaceEnemyRegistry
{
	private static readonly List<SummerRaceEnemy> Enemies = new List<SummerRaceEnemy>(64);

	public static int Count => Enemies.Count;

	public static SummerRaceEnemy Get(int index)
	{
		if (index < 0 || index >= Enemies.Count)
		{
			return null;
		}
		return Enemies[index];
	}

	public static void Register(SummerRaceEnemy enemy)
	{
		if (!(enemy == null) && !Enemies.Contains(enemy))
		{
			Enemies.Add(enemy);
		}
	}

	public static void Unregister(SummerRaceEnemy enemy)
	{
		if (!(enemy == null))
		{
			Enemies.Remove(enemy);
		}
	}
}
