using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractAnimationCurve : ExtractorNode<AnimationCurve, Keyframe[], float, WrapMode, WrapMode>
{
	public override void Invoke(AnimationCurve curve, out Keyframe[] keys, out float length, out WrapMode postWrapMode, out WrapMode preWrapMode)
	{
		keys = curve.keys;
		length = curve.length;
		postWrapMode = curve.postWrapMode;
		preWrapMode = curve.preWrapMode;
	}
}
