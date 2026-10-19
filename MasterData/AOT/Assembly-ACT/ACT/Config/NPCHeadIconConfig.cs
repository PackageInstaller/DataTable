using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class NPCHeadIconConfig : LuminSerializedScriptableObject
{
	public enum ShowType
	{
		None,
		AlwaysShow,
		EnterShow,
		HideDelay
	}

	[Serializable]
	public class IconConfig
	{
		public int id;

		public int icon;

		public ShowType showType;

		public float delayTime;
	}

	public List<IconConfig> configs;

	[Range(0f, 1f)]
	public float minScaleFactor = 0.9f;

	public float minScaleDistance;

	public float maxVisibleDistance;

	public IconConfig FindConfigById(int id)
	{
		foreach (IconConfig config in configs)
		{
			if (config.id == id)
			{
				return config;
			}
		}
		return null;
	}
}
