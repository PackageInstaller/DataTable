using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class ParadoxTimelineSystem : BaseSystem
{
	private Dictionary<int, ParadoxTimeline> timelineGroup = new Dictionary<int, ParadoxTimeline>();

	private List<int> removeGroup = new List<int>();

	private Dictionary<string, IObjectPool<GameObject>> timelinePools = new Dictionary<string, IObjectPool<GameObject>>();

	public int CastingGroup = 1000;

	public int CastingPriority = 10;

	private ParadoxTimelineCasting castingTimeline;

	protected override bool IsLogicSystem => false;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (data is WorldData worldData)
		{
			if (worldData.PreloadBattleData == null)
			{
				return true;
			}
			foreach (KeyValuePair<string, GameObject> item in worldData.PreloadBattleData.CacheHeroTimeline)
			{
				string timeLineAsset = AssetUtility.GetTimeLineAsset(item.Key);
				if (!timelinePools.ContainsKey(timeLineAsset))
				{
					timelinePools.Add(timeLineAsset, new ObjectPool<GameObject>(new ParadoxTimeLineFactory(timeLineAsset, item.Value, GameEntry.Canvas.GetCanvasGroup("Timeline")?.Root), 1, 5));
				}
			}
		}
		return true;
	}

	public async Task<GameObject> LoadTimeline(string fullPath)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		if (timelinePools == null)
		{
			return null;
		}
		timelinePools.TryGetValue(fullPath, out var value);
		if (value == null)
		{
			GameObject template = await (GetSystem<GameResourceSystem>()?.LoadAssetAsync<GameObject>(fullPath) ?? default(UniTask<GameObject>));
			if (!timelinePools.ContainsKey(fullPath))
			{
				value = new ObjectPool<GameObject>(new ParadoxTimeLineFactory(fullPath, template, GameEntry.Canvas.GetCanvasGroup("Timeline")?.Root), 2);
				timelinePools.Add(fullPath, value);
			}
			else
			{
				value = timelinePools[fullPath];
			}
		}
		return value.Allocate();
	}

	public void FreeTimeline(string fullPath, GameObject gameObject)
	{
		if (SystemIsNeedExecute && timelinePools != null)
		{
			timelinePools.TryGetValue(fullPath, out var value);
			value?.Free(gameObject);
		}
	}

	public override void OnLateUpdate(float deltaTime)
	{
		if (timelineGroup.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, ParadoxTimeline> item in timelineGroup)
		{
			item.Value?.OnLateUpdate(deltaTime);
		}
		if (removeGroup.Count > 0)
		{
			for (int i = 0; i < removeGroup.Count; i++)
			{
				timelineGroup.Remove(removeGroup[i]);
			}
			removeGroup.Clear();
		}
	}

	public async void StartParadoxTimeline(DRParadoxTimeline dRParadoxTimeline, BaseEntity ownerEntity, List<int> multiList)
	{
		if (timelineGroup.TryGetValue(dRParadoxTimeline.Group, out var value))
		{
			value.Finish(isDispose: true);
		}
		ParadoxTimeline paradoxTimeline = new ParadoxTimeline(this);
		timelineGroup[dRParadoxTimeline.Group] = paradoxTimeline;
		await paradoxTimeline.StartParadoxTimeline(dRParadoxTimeline, ownerEntity, multiList);
		HandlePriority();
	}

	private void HandlePriority()
	{
		if (timelineGroup.Count <= 0)
		{
			return;
		}
		ParadoxTimeline paradoxTimeline = null;
		List<ParadoxTimeline> list = new List<ParadoxTimeline>();
		List<ParadoxTimeline> list2 = new List<ParadoxTimeline>();
		foreach (ParadoxTimeline value in timelineGroup.Values)
		{
			if (value != null && !removeGroup.Contains(value.Group))
			{
				if (paradoxTimeline == null)
				{
					paradoxTimeline = value;
				}
				else if (paradoxTimeline.Priority < value.Priority)
				{
					list2.Add(paradoxTimeline);
					paradoxTimeline = value;
				}
				else if (paradoxTimeline.Priority == value.Priority)
				{
					list.Add(value);
				}
				else
				{
					list2.Add(value);
				}
			}
		}
		paradoxTimeline?.SetShow();
		for (int i = 0; i < list.Count; i++)
		{
			list[i].SetShow();
		}
		for (int j = 0; j < list2.Count; j++)
		{
			list2[j].SetHide();
		}
	}

	public void FinishTimeline(int Group)
	{
		removeGroup.Add(Group);
		HandlePriority();
	}

	public async void LoadCastingWindow(string path)
	{
		if (!(castingTimeline?.CastingPath == path))
		{
			if (castingTimeline != null)
			{
				castingTimeline.Dispose();
			}
			castingTimeline = new ParadoxTimelineCasting(this);
			await castingTimeline.LoadCasting(path);
		}
	}

	public async void ShowCasting()
	{
		if (timelineGroup.TryGetValue(CastingGroup, out var value))
		{
			value.Finish(isDispose: true);
		}
		if (castingTimeline != null)
		{
			timelineGroup[CastingGroup] = castingTimeline;
			HandlePriority();
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (timelineGroup != null)
		{
			foreach (KeyValuePair<int, ParadoxTimeline> item in timelineGroup)
			{
				item.Value.Dispose();
			}
			timelineGroup = null;
		}
		if (castingTimeline != null)
		{
			castingTimeline.Dispose();
			castingTimeline = null;
		}
		ClearPools();
	}

	private void ClearPools()
	{
		if (timelinePools == null)
		{
			return;
		}
		foreach (KeyValuePair<string, IObjectPool<GameObject>> timelinePool in timelinePools)
		{
			if (timelinePool.Value != null)
			{
				timelinePool.Value.Dispose();
			}
		}
		timelinePools.Clear();
	}
}
