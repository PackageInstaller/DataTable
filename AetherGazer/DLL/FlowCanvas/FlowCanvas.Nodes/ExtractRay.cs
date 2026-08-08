using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractRay : ExtractorNode<Ray, Vector3, Vector3>
{
	public override void Invoke(Ray ray, out Vector3 origin, out Vector3 direction)
	{
		origin = ray.origin;
		direction = ray.direction;
	}
}
