using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class BuffConditionTeamCountByDistance : BuffConditionBase
{
	private EntityTeamType teamType;

	private float distance;

	private float count;

	private CompareMethodType compare1;

	private CompareMethodType compare2;

	private float distanceSqr;

	public override BuffConditionType BuffConditionType => BuffConditionType.TeamCountByDistance;

	protected override int paramsMinCount => 5;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		compare1 = Utility.Convert.StringToEnum<CompareMethodType>(paramList[1]);
		distance = Utility.Convert.StringToFloat(paramList[2]);
		compare2 = Utility.Convert.StringToEnum<CompareMethodType>(paramList[3]);
		count = Utility.Convert.StringToFloat(paramList[4]);
		distanceSqr = Mathf.Pow(distance, 2f);
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{compare1},{distance},{compare2},{count}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		List<BaseEntity> targetByTeamTypeList = BuffExtension.GetTargetByTeamTypeList(entityFrom, entityTarget, teamType, null, isCreateNewList: false);
		if (targetByTeamTypeList == null)
		{
			return false;
		}
		if ((float)targetByTeamTypeList.Count < count)
		{
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
			return false;
		}
		int num = 0;
		for (int i = 0; i < targetByTeamTypeList.Count; i++)
		{
			BaseEntity baseEntity = targetByTeamTypeList[i];
			float v = TSUtil.Vector3DistanceSqr(entityTarget.transform.position, baseEntity.transform.position);
			if (ConditionExtensions.CompareValueMethod(compare1, v, distanceSqr))
			{
				num++;
			}
		}
		if (ConditionExtensions.CompareValueMethod(compare2, num, count))
		{
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
			return true;
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
		return false;
	}

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType != EntityTeamType.Actor)
		{
			_ = teamType;
			_ = 12;
		}
	}
}
