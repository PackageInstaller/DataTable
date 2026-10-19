using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class UIEffectRendering
{
	public bool RenderDirectly;

	public int layer;

	[Range(0f, 1f)]
	public float Intensity = 1f;

	[SerializeReference]
	public List<AbstractUIEffectRenderer> rendererList = new List<AbstractUIEffectRenderer>();

	public void Cleanup()
	{
		for (int i = 0; i < rendererList.Count; i++)
		{
			rendererList[i]?.Cleanup();
		}
	}
}
