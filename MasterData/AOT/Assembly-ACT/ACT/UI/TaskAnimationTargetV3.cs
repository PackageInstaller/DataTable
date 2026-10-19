using System;
using UnityEngine;

namespace ACT.UI;

public readonly struct TaskAnimationTargetV3
{
	public CanvasGroup CanvasGroup { get; }

	public Func<bool> PlayNormalShow { get; }

	public TaskAnimationTargetV3(CanvasGroup canvasGroup, Func<bool> playNormalShow)
	{
		CanvasGroup = canvasGroup;
		PlayNormalShow = playNormalShow;
	}
}
