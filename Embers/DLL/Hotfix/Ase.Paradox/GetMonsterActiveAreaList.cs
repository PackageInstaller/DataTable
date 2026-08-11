using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.Paradox;

[Name("获取怪物活动区内实体Id", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取怪物活动区域内的实体Id列表")]
public class GetMonsterActiveAreaList : ActionTaskBase
{
	[Name("返回的实体列表", 0)]
	[Description("存储怪物活动区域内实体Id的列表")]
	public BBParameter<List<int>> _returnIdBBP;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			EndAction();
			return;
		}
		if (_returnIdBBP.value == null)
		{
			_returnIdBBP.value = new List<int>(5);
		}
		List<int> value = _returnIdBBP.value;
		if (value == null)
		{
			EndAction();
			return;
		}
		value.Clear();
		if ((Object)(object)ownerEntity.GetData<MonsterNode>(MonsterGroup.MONSTERNODE_KEY) == null || !ownerEntity.IsSurvival)
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
		float activityAreaRange = data.GetActivityAreaRange();
		Vector3 vector = data.GetActivityAreaRangeOffset();
		List<int> teamEntityId = ownerEntity.GetSystem<EntitySystem>().GetTeamEntityId(0, isIncludeEntity: true);
		for (int i = 0; i < teamEntityId.Count; i++)
		{
			BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(teamEntityId[i]);
			if (entity != null && (entity.transform.position - (((Component)(object)data).transform.position + vector)).sqrMagnitude <= activityAreaRange * activityAreaRange)
			{
				value.Add(teamEntityId[i]);
			}
		}
		CollectionPool<List<int>, int>.Release(teamEntityId);
		EndAction();
	}
}
