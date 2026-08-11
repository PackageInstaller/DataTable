using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取怪物召唤的怪物ID", 0)]
[Description("根据指定的怪物ID 获取该怪物召唤的怪物")]
[Category("✫ DragonLost/Entity")]
public class GetSummonMonster : ActionTaskBase
{
	[Name("怪物的实体ID", 0)]
	[Description("怪物的实体ID")]
	public BBParameter<int> MonsterEntityId;

	[Name("召唤的怪物ID列表", 0)]
	[Description("该怪物对应的召唤怪物ID")]
	public BBParameter<List<int>> SummonMonsterList;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (SummonMonsterList == null)
		{
			EndAction();
			return;
		}
		if (SummonMonsterList.value == null)
		{
			SummonMonsterList.value = new List<int>();
		}
		SummonMonsterList.value.Clear();
		if (GetEntity(MonsterEntityId.value, isSyncEntity: true) is MonsterEntity monsterEntity)
		{
			for (int i = 0; i < monsterEntity.MonsterAttrConfig.SummonMonster.Count; i++)
			{
				SummonMonsterList.value.Add(monsterEntity.MonsterAttrConfig.SummonMonster[i]);
			}
		}
		EndAction();
	}
}
