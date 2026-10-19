using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class ParallaxLayer
{
	public RectTransform layerTransform;

	[Range(0f, 5f)]
	public float parallaxFactor = 1f;

	public Vector2 movementDirection = Vector2.one;

	public bool inverseX;

	public bool inverseY;

	private Vector2 _initialPosition;

	public void Initialize()
	{
		if (layerTransform != null)
		{
			_initialPosition = layerTransform.anchoredPosition;
		}
	}

	public void UpdatePosition(Vector2 input, float maxRange)
	{
		if (layerTransform != null)
		{
			Vector2 vector = new Vector2(input.x * movementDirection.x * (float)((!inverseX) ? 1 : (-1)), input.y * movementDirection.y * (float)((!inverseY) ? 1 : (-1)));
			layerTransform.anchoredPosition = _initialPosition + vector * parallaxFactor * maxRange;
		}
	}
}
