using UnityEngine;

namespace DG.Tweening.Plugins.Core.PathCore;

internal abstract class ABSPathDecoder
{
	internal abstract int minInputWaypoints { get; }

	internal abstract void FinalizePath(Path p, Vector3[] wps, bool isClosedPath);

	internal abstract Vector3 GetPoint(float perc, Vector3[] wps, Path p, ControlPoint[] controlPoints);
}
