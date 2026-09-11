using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractKeyFrame : ExtractorNode<Keyframe, float, float, float, float>
{
	public override void Invoke(Keyframe key, out float inTangent, out float outTangent, out float time, out float value)
	{
		inTangent = key.inTangent;
		outTangent = key.outTangent;
		time = key.time;
		value = key.value;
	}
}
