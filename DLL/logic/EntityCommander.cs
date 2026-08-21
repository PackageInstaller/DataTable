using System.Collections.Generic;
using Entitas;

[Sim]
[IgnoreClone]
public class EntityCommander : IComponent
{
	public List<EnemyInfo> enemyInfos;

	public List<TargetInfo> targetInfos;

	public bool ContainsEnemy(int enemyID)
	{
		for (int i = 0; i < enemyInfos.Count; i++)
		{
			if (enemyInfos[i].entityID == enemyID)
			{
				return true;
			}
		}
		return false;
	}
}
