using System;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace DG.Tweening.Plugins.Core.PathCore;

[Serializable]
public struct ControlPoint
{
	public Vector3 a;

	public Vector3 b;

	public ControlPoint(Vector3 a, Vector3 b)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		this.a = a;
		this.b = b;
	}

	public static ControlPoint operator +(ControlPoint cp, Vector3 v)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		return new ControlPoint(cp.a + v, cp.b + v);
	}

	public override string ToString()
	{
		return "[" + ((object)System.Runtime.CompilerServices.Unsafe.As<Vector3, Vector3>(ref a)/*cast due to constrained. prefix*/).ToString() + " | " + ((object)System.Runtime.CompilerServices.Unsafe.As<Vector3, Vector3>(ref b)/*cast due to constrained. prefix*/).ToString() + "]";
	}
}
