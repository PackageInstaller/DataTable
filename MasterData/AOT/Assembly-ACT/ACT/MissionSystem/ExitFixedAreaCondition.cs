using ACT.Battle.Configs;
using ACT.World;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.MissionSystem;

public class ExitFixedAreaCondition : MissionCondition
{
	private AreaConditionHelper helper;

	private MissionPointData missionPointData;

	private MapLayer mapLayer;

	public override bool AllowRepeat => true;

	protected override async void OnInMissionWorld()
	{
		ExitFixedAreaConditionParam exitFixedAreaConditionParam = Param as ExitFixedAreaConditionParam;
		Transform transform = Flow.Env.transform.Find(exitFixedAreaConditionParam.areaName);
		if (transform == null)
		{
			return;
		}
		GameObject gameObject = Object.Instantiate(transform.gameObject, Flow.Env.transform);
		gameObject.name = $"ExitFixedAreaConditionHelper:{Id}";
		Collider[] componentsInChildren = gameObject.GetComponentsInChildren<Collider>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].isTrigger = true;
		}
		gameObject.SetActive(value: true);
		helper = gameObject.AddComponent<AreaConditionHelper>();
		helper.SetInitInArea(b: true);
		if (IsRepeat)
		{
			do
			{
				if (!CheckCondition())
				{
					await UniTask.Yield();
					continue;
				}
				MarkSuccess();
				while (InMissionWorld && CheckCondition())
				{
					await UniTask.Yield();
				}
			}
			while (InMissionWorld);
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	protected override void OnOutMissionWorld()
	{
		if ((bool)helper)
		{
			Object.Destroy(helper.gameObject);
			helper = null;
		}
	}

	private bool CheckCondition()
	{
		if (!helper.InArea)
		{
			return true;
		}
		return false;
	}
}
