using System;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
public class CanvasGroup
{
	public string name;

	public Rect rect;

	public Color color;

	public CanvasGroup()
	{
	}

	public CanvasGroup(Rect rect, string name)
	{
		this.rect = rect;
		this.name = name;
	}
}
