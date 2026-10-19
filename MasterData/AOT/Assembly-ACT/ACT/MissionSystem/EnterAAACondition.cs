using System;
using System.Collections.Generic;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Core;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.MissionSystem;

public sealed class EnterAAACondition : MissionCondition
{
	private List<NpcExternalShowControlHandle> m_Handles = new List<NpcExternalShowControlHandle>();

	public override ConditionPriority Priority => ConditionPriority.Pre;

	protected override void OnActivate()
	{
		EnterAAAConditionParam enterAAAConditionParam = Param as EnterAAAConditionParam;
		HashSet<int> hashSet = CollectionPool<HashSet<int>, int>.Get();
		HashSet<int> hashSet2 = CollectionPool<HashSet<int>, int>.Get();
		try
		{
			foreach (KeyValuePair<int, MissionFocusModeData> missionFocusModeData in RuntimeConfigs.data.missionFocusModeDatas)
			{
				if (missionFocusModeData.Value.groupId == enterAAAConditionParam.groupId)
				{
					hashSet.Add(missionFocusModeData.Value.chunkId);
					hashSet2.Add(missionFocusModeData.Value.npcId);
				}
			}
			Singleton<MissionManager>.instance.AddBlockedMapArea(Flow.Data.Config.MissionBase.subMapArea);
			List<int> list = ListPool<int>.Get();
			foreach (int item2 in hashSet)
			{
				if (!Singleton<RuntimeNpcManager>.instance.TryGetNpcInChunk(Flow.Data.Config.World, item2, out var npcUids))
				{
					continue;
				}
				foreach (int item3 in npcUids)
				{
					if (!hashSet2.Contains(item3))
					{
						list.Add(item3);
					}
				}
			}
			foreach (int item4 in list)
			{
				NpcExternalShowControlHandle item = Singleton<RuntimeNpcManager>.instance.SetNpcExternalShow(item4, visible: false);
				m_Handles.Add(item);
			}
			ListPool<int>.Release(list);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		finally
		{
			CollectionPool<HashSet<int>, int>.Release(hashSet);
			CollectionPool<HashSet<int>, int>.Release(hashSet2);
		}
	}

	protected override void OnDeactivate()
	{
		if (Flow.Data.Config.MissionBase.mapArea <= 0)
		{
			return;
		}
		Singleton<MissionManager>.instance.RemoveBlockedMapArea(Flow.Data.Config.MissionBase.subMapArea);
		foreach (NpcExternalShowControlHandle handle in m_Handles)
		{
			Singleton<RuntimeNpcManager>.instance.ReleaseNpcExternalShowControl(handle);
		}
		m_Handles.Clear();
	}
}
