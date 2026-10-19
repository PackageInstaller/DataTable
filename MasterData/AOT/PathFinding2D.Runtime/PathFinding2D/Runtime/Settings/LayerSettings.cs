using System;
using UnityEngine;

namespace PathFinding2D.Runtime.Settings;

[Serializable]
public class LayerSettings
{
	[SerializeField]
	[Tooltip("寻路层编号（0-30）。一般不需要手改。")]
	private int index;

	[SerializeField]
	[Tooltip("给策划看的名字，例如：地面、高台、可穿透平台。")]
	private string name;

	[SerializeField]
	[Tooltip("编辑器 gizmos / 层列表中的显示颜色，仅影响可视化。")]
	private Color color;

	public int Index => index;

	public string Name => name;

	public Color Color => color;

	public void Set(int index, string name, Color color)
	{
		this.index = index;
		this.name = name;
		this.color = color;
	}
}
