using System;
using System.Collections.Generic;
using UnityEngine;

namespace PathFinding2D.Runtime.Settings;

[Serializable]
public class NavigationRuntimeProfile : ScriptableObject
{
	[SerializeField]
	[Tooltip("定义每个寻路层的显示名称和颜色，方便策划在编辑器中区分平台类型。")]
	private List<LayerSettings> layerSettings = new List<LayerSettings>(31);

	[SerializeField]
	[Tooltip("开启后可记录/显示运行时寻路调试信息（需配合调试窗口或可视化）。")]
	private bool debugEnabled;

	[SerializeField]
	[Tooltip("角色起点到目标允许的最远寻路范围。超出可直接判定不可达，避免远距离乱搜。当前部分查询逻辑可能尚未完全接入。")]
	private float maxNavigationRange = 50f;

	public List<LayerSettings> LayerSettings => layerSettings;

	public bool DebugEnabled
	{
		get
		{
			return debugEnabled;
		}
		set
		{
			debugEnabled = value;
		}
	}

	public float MaxNavigationRange
	{
		get
		{
			return maxNavigationRange;
		}
		set
		{
			maxNavigationRange = value;
		}
	}

	public int NameToLayer(string layerName)
	{
		foreach (LayerSettings layerSetting in layerSettings)
		{
			if (layerSetting.Name == layerName)
			{
				return layerSetting.Index;
			}
		}
		return 0;
	}

	public void OnCreate()
	{
		for (int i = 0; i < 31; i++)
		{
			LayerSettings layerSettings = new LayerSettings();
			layerSettings.Set(i, string.Empty, Color.green);
			this.layerSettings.Add(layerSettings);
		}
	}
}
