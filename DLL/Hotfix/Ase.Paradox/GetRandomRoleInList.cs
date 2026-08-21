using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取不重复的随机敌人", 0)]
[Description("从指定的敌人列表中获取一个不重复的随机敌人，并可选择将该敌人添加到指定的忽略列表中。")]
[Category("✫ DragonLost/Target")]
public class GetRandomRoleInList : ActionTaskBase
{
	[Name("需要被筛选掉的敌人，该节点返回的敌人会自动加入该数组", 0)]
	[Description("存储需要被筛选掉的敌人的实体ID列表。")]
	public BBParameter<List<int>> Ignore;

	[Name("所有敌人", 0)]
	[Description("存储所有可选敌人的实体ID列表。")]
	public BBParameter<List<int>> RangeList;

	[Name("返回的敌人", 0)]
	[Description("存储获取的随机敌人的实体ID。")]
	public BBParameter<int> result;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (RangeList.value != null && RangeList.value.Count > 0)
		{
			List<int> enemyResult = GetEnemyResult();
			if (enemyResult.Count > 0)
			{
				int index = ownerEntity.RandomInt(0, enemyResult.Count);
				result.value = enemyResult[index];
				Ignore.value.Add(result.value);
			}
			else
			{
				Ignore.value = new List<int>();
				enemyResult = GetEnemyResult();
				int index2 = ownerEntity.RandomInt(0, enemyResult.Count);
				result.value = enemyResult[index2];
				Ignore.value.Add(result.value);
			}
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"怪物随机获取的实体ID {result.value}", ownerEntity);
		}
		EndAction();
	}

	private List<int> GetEnemyResult()
	{
		List<int> list = new List<int>();
		if (Ignore.value == null)
		{
			Ignore.value = new List<int>();
		}
		if (ownerEntity.GetSystem<EntitySystem>() == null)
		{
			return null;
		}
		foreach (int item in RangeList.value)
		{
			if (!Ignore.value.Contains(item))
			{
				list.Add(item);
			}
		}
		return list;
	}

	protected override void OnStop()
	{
		base.OnStop();
		Ignore.value = new List<int>();
	}
}
