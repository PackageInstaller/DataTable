using System;
using UnityEngine;

namespace frame8.Logic.Misc.Visual.UI;

public interface IScrollRectProxy
{
	GameObject gameObject { get; }

	bool IsInitialized { get; }

	Vector2 Velocity { get; set; }

	bool IsHorizontal { get; }

	bool IsVertical { get; }

	RectTransform Content { get; }

	RectTransform Viewport { get; }

	double ContentInsetFromViewportStart { get; }

	double ContentInsetFromViewportEnd { get; }

	event Action<double> ScrollPositionChanged;

	void SetNormalizedPosition(double normalizedPosition);

	double GetNormalizedPosition();

	double GetContentSize();

	double GetViewportSize();

	void StopMovement();
}
