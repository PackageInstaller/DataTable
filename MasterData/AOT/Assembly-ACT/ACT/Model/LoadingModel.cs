using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.World;
using UnityEngine;

namespace ACT.Model;

public class LoadingModel : Model<LoadingModel>
{
	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	private IEnumerable<TipsDetailMessageData> GetTipsData(ACT.World.MapArea area, SceneStatus status)
	{
		TipsSubScence tipsGroupData = GetTipsGroupData(area, status);
		if (tipsGroupData == null || tipsGroupData.variables == 0)
		{
			return null;
		}
		return RuntimeConfigs.data.tipsDetailMessageDatas.Values.Where((TipsDetailMessageData x) => x.groupId == tipsGroupData.variables);
	}

	public TipsSubScence GetTipsGroupData(ACT.World.MapArea area, SceneStatus targetSceneStatus)
	{
		if (area == ACT.World.MapArea.None)
		{
			Debug.LogWarning("要到达的目标区域找不到，TP的坐标在目标场景的Bounds里找不到");
		}
		try
		{
			ACT.Config.MapArea data = CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas);
			if (data != null)
			{
				int[] subSceneType = data.subSceneType;
				if (subSceneType != null && subSceneType.Length > 0)
				{
					goto IL_0049;
				}
			}
			data = CoreUtils.GetData(1002, RuntimeConfigs.data.mapAreas);
			goto IL_0049;
			IL_0049:
			int num = data.subSceneType[(targetSceneStatus != SceneStatus.Main) ? 1u : 0u];
			if (num == 0)
			{
				return null;
			}
			return CoreUtils.GetData(num, RuntimeConfigs.data.tipsSubScences);
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	public TipsDetailMessageData RandomGetTipsFormTipsGroup(ACT.World.MapArea area, SceneStatus sceneStatus)
	{
		List<TipsDetailMessageData> list = GetTipsData(area, sceneStatus).ToList();
		if (list == null || list.Count <= 0)
		{
			return null;
		}
		int count = list.Count;
		int index = UnityEngine.Random.Range(0, count);
		return list[index];
	}

	public TipsDetailMessageData GetDefultTipsMassageData()
	{
		return null;
	}
}
