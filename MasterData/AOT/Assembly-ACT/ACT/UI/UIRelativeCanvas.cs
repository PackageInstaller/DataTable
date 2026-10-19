using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class UIRelativeCanvas : MonoBehaviour
{
	public int relativeLayer;

	public Canvas canvas;

	private void Awake()
	{
		if (!canvas)
		{
			canvas = GetComponent<Canvas>();
		}
	}

	public void SetSortingLayer(int layer)
	{
		UIUtility.SetSortingLayer(canvas, layer + relativeLayer);
	}
}
