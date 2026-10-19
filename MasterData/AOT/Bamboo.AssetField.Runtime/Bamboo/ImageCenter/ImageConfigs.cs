using System.Collections.Generic;
using UnityEngine;

namespace Bamboo.ImageCenter;

public class ImageConfigs : ScriptableObject
{
	public List<ConfigData> imageConfigs = new List<ConfigData>();

	public bool ContainsKey(int index)
	{
		for (int i = 0; i < imageConfigs.Count; i++)
		{
			if (imageConfigs[i].id == index)
			{
				return true;
			}
		}
		return false;
	}

	public bool TryGetConfigData(int index, out ImageConfig config)
	{
		for (int i = 0; i < imageConfigs.Count; i++)
		{
			if (imageConfigs[i].id == index)
			{
				config = imageConfigs[i].config;
				return true;
			}
		}
		config = null;
		return false;
	}

	public ConfigData GetConfigData(int index)
	{
		for (int i = 0; i < imageConfigs.Count; i++)
		{
			if (imageConfigs[i].id == index)
			{
				return imageConfigs[i];
			}
		}
		return null;
	}
}
