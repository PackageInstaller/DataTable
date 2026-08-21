using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取怪物警戒区内实体Id", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取怪物警戒区域内符合条件的实体Id列表")]
public class GetMonsterAlertAreaListAction : ActionTaskBase
{
	[Name("目标阵营", 0)]
	[Description("需要获取实体的目标阵营")]
	public BBParameter<RelationTypeEnum> teamBBP = new BBParameter<RelationTypeEnum>();

	[Name("警戒区范围", 0)]
	[Description("警戒区域的半径范围")]
	public BBParameter<float> alertRange = new BBParameter<float>();

	[Name("活动区实体列表", 0)]
	[Description("怪物活动区域内的实体Id列表")]
	public BBParameter<List<int>> activeIds = new BBParameter<List<int>>();

	[Name("返回的实体列表", 0)]
	[Description("存储怪物警戒区域内符合条件实体Id的列表")]
	public BBParameter<List<int>> _returnIdBBP;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			EndAction();
			return;
		}
		_returnIdBBP.value = new List<int>();
		List<int> value = _returnIdBBP.value;
		if (value == null)
		{
			EndAction();
			return;
		}
		value.Clear();
		if (activeIds.value == null || activeIds.value.Count == 0 || ownerEntity.IsStandby)
		{
			EndAction();
			return;
		}
		MonsterGroup data = ownerEntity.GetData<MonsterGroup>(MonsterGroup.MONSTERGROUP_KEY);
		if ((Object)(object)data == null)
		{
			EndAction();
			return;
		}
		for (int i = 0; i < activeIds.value.Count; i++)
		{
			BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(activeIds.value[i]);
			if (entity != null && (entity.transform.position - ((Component)(object)data).transform.position).sqrMagnitude <= alertRange.value * alertRange.value && AIUtility.GetRelation(entity.GetEntityCampType(), ownerEntity.GetEntityCampType()) == teamBBP.value)
			{
				value.Add(entity.Id);
			}
		}
		EndAction();
	}
}
