using System.Collections.Generic;
using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public static class QueryCache
{
	public static readonly List<EntityEnemy> TempEnemyList = new List<EntityEnemy>(64);

	public static readonly List<EntityPlayer> TempPlayerList = new List<EntityPlayer>(64);
}
