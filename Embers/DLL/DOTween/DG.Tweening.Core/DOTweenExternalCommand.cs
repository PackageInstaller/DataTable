using System;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Core;

public static class DOTweenExternalCommand
{
	public static event Action<PathOptions, Tween, Quaternion, Transform> SetOrientationOnPath;

	internal static void Dispatch_SetOrientationOnPath(PathOptions options, Tween t, Quaternion newRot, Transform trans)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		if (SetOrientationOnPath != null)
		{
			SetOrientationOnPath(options, t, newRot, trans);
		}
	}
}
