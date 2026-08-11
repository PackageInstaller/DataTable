using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins.Core;

internal static class SpecialPluginsUtils
{
	internal static bool SetLookAt(TweenerCore<Quaternion, Vector3, QuaternionOptions> t)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		object target = t.target;
		Transform val = (Transform)((target is Transform) ? target : null);
		Vector3 endValue = t.endValue;
		endValue -= val.position;
		switch (t.plugOptions.axisConstraint)
		{
		case AxisConstraint.X:
			endValue.x = 0f;
			break;
		case AxisConstraint.Y:
			endValue.y = 0f;
			break;
		case AxisConstraint.Z:
			endValue.z = 0f;
			break;
		}
		Quaternion val2 = Quaternion.LookRotation(endValue, t.plugOptions.up);
		Vector3 eulerAngles = ((Quaternion)(ref val2)).eulerAngles;
		t.endValue = eulerAngles;
		return true;
	}

	internal static bool SetPunch(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val;
		try
		{
			val = t.getter();
		}
		catch
		{
			return false;
		}
		t.isRelative = (t.isSpeedBased = false);
		t.easeType = Ease.OutQuad;
		t.customEase = null;
		int num = t.endValue.Length;
		for (int i = 0; i < num; i++)
		{
			t.endValue[i] = t.endValue[i] + val;
		}
		return true;
	}

	internal static bool SetShake(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t)
	{
		if (!SetPunch(t))
		{
			return false;
		}
		t.easeType = Ease.Linear;
		return true;
	}

	internal static bool SetCameraShakePosition(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t)
	{
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		if (!SetShake(t))
		{
			return false;
		}
		object target = t.target;
		Camera val = (Camera)((target is Camera) ? target : null);
		if ((Object)(object)val == (Object)null)
		{
			return false;
		}
		Vector3 val2 = t.getter();
		Transform transform = ((Component)val).transform;
		int num = t.endValue.Length;
		for (int i = 0; i < num; i++)
		{
			Vector3 val3 = t.endValue[i];
			t.endValue[i] = transform.localRotation * (val3 - val2) + val2;
		}
		return true;
	}
}
