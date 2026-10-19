using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class GuideConfigs : ScriptableObject
{
	public List<GuideConfig> guideConfigs = new List<GuideConfig>();

	public GuideConfig GetConfig(int id)
	{
		for (int i = 0; i < guideConfigs.Count; i++)
		{
			if (guideConfigs[i].id == id)
			{
				return guideConfigs[i];
			}
		}
		return null;
	}

	public GuideConfig GetUnlockConfig()
	{
		return null;
	}
}
