using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Core.PathCore;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class PathPlugin : ABSTweenPlugin<Vector3, Path, PathOptions>
{
	public const float MinLookAhead = 0.0001f;

	public override void Reset(TweenerCore<Vector3, Path, PathOptions> t)
	{
		t.endValue.Destroy();
		t.startValue = (t.endValue = (t.changeValue = null));
	}

	public override void SetFrom(TweenerCore<Vector3, Path, PathOptions> t, bool isRelative)
	{
	}

	public override void SetFrom(TweenerCore<Vector3, Path, PathOptions> t, Path fromValue, bool setImmediately, bool isRelative)
	{
	}

	public static ABSTweenPlugin<Vector3, Path, PathOptions> Get()
	{
		return PluginsManager.GetCustomPlugin<PathPlugin, Vector3, Path, PathOptions>();
	}

	public override Path ConvertToStartValue(TweenerCore<Vector3, Path, PathOptions> t, Vector3 value)
	{
		return t.endValue;
	}

	public override void SetRelativeEndValue(TweenerCore<Vector3, Path, PathOptions> t)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		if (!t.endValue.isFinalized)
		{
			Vector3 val = t.getter();
			int num = t.endValue.wps.Length;
			for (int i = 0; i < num; i++)
			{
				ref Vector3 reference = ref t.endValue.wps[i];
				reference += val;
			}
		}
	}

	public override void SetChangeValue(TweenerCore<Vector3, Path, PathOptions> t)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0133: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		//IL_014d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0152: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0172: Unknown result type (might be due to invalid IL or missing references)
		//IL_0177: Unknown result type (might be due to invalid IL or missing references)
		object target = t.target;
		GameObject val = (GameObject)((target is GameObject) ? target : null);
		Transform val2 = ((val != null) ? val.transform : ((Component)t.target).transform);
		if (t.plugOptions.orientType == OrientType.ToPath)
		{
			t.plugOptions.parent = val2.parent;
		}
		if (t.endValue.isFinalized)
		{
			t.changeValue = t.endValue;
			return;
		}
		Vector3 val3 = t.getter();
		Path endValue = t.endValue;
		endValue.plugOptions = t.plugOptions;
		int num = endValue.wps.Length;
		int num2 = 0;
		bool flag = false;
		bool flag2 = false;
		if (num <= endValue.minInputWaypoints || !DOTweenUtils.Vector3AreApproximatelyEqual(endValue.wps[0], val3))
		{
			flag = true;
			num2++;
		}
		if (t.plugOptions.isClosedPath)
		{
			Vector3 val4 = endValue.wps[num - 1];
			if (endValue.type == PathType.CubicBezier)
			{
				if (num < 3)
				{
					Debug.LogError((object)"CubicBezier paths must contain waypoints in multiple of 3 excluding the starting point added automatically by DOTween (1: waypoint, 2: IN control point, 3: OUT control point — the minimum amount of waypoints for a single curve is 3)");
				}
				else
				{
					val4 = endValue.wps[num - 3];
				}
			}
			if (val4 != val3)
			{
				flag2 = true;
				num2++;
			}
		}
		Vector3[] array = (Vector3[])(object)new Vector3[num + num2];
		int num3 = (flag ? 1 : 0);
		if (flag)
		{
			array[0] = val3;
		}
		for (int i = 0; i < num; i++)
		{
			array[i + num3] = endValue.wps[i];
		}
		if (flag2)
		{
			array[array.Length - 1] = array[0];
		}
		endValue.wps = array;
		endValue.addedExtraStartWp = flag;
		endValue.addedExtraEndWp = flag2;
		endValue.FinalizePath(t.plugOptions.isClosedPath, t.plugOptions.lockPositionAxis, val3);
		t.plugOptions.startupRot = val2.rotation;
		t.plugOptions.startupZRot = val2.eulerAngles.z;
		t.changeValue = t.endValue;
	}

	public override float GetSpeedBasedDuration(PathOptions options, float unitsXSecond, Path changeValue)
	{
		return changeValue.length / unitsXSecond;
	}

	public override void EvaluateAndApply(PathOptions options, Tween t, bool isRelative, DOGetter<Vector3> getter, DOSetter<Vector3> setter, float elapsed, Path startValue, Path changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		if (t.loopType == LoopType.Incremental && !options.isClosedPath)
		{
			int num = (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
			if (num > 0)
			{
				changeValue = changeValue.CloneIncremental(num);
			}
		}
		float perc = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		float num2 = changeValue.ConvertToConstantPathPerc(perc);
		Vector3 val = (changeValue.targetPosition = changeValue.GetPoint(num2));
		setter(val);
		if (options.mode != PathMode.Ignore && options.orientType != OrientType.None)
		{
			SetOrientation(options, t, changeValue, num2, val, updateNotice);
		}
		bool flag = !usingInversePosition;
		if (t.isBackwards)
		{
			flag = !flag;
		}
		int waypointIndexFromPerc = changeValue.GetWaypointIndexFromPerc(perc, flag);
		if (waypointIndexFromPerc == t.miscInt)
		{
			return;
		}
		int miscInt = t.miscInt;
		t.miscInt = waypointIndexFromPerc;
		if (t.onWaypointChange == null)
		{
			return;
		}
		bool flag2 = t.isBackwards;
		if (t.hasLoops && t.loopType == LoopType.Yoyo)
		{
			flag2 = (!t.isBackwards && t.completedLoops % 2 != 0) || (t.isBackwards && t.completedLoops % 2 == 0);
		}
		if (flag2)
		{
			for (int num3 = miscInt - 1; num3 > waypointIndexFromPerc - 1; num3--)
			{
				if (num3 != waypointIndexFromPerc)
				{
					Tween.OnTweenCallback(t.onWaypointChange, t, num3);
				}
			}
		}
		else
		{
			for (int i = miscInt + 1; i < waypointIndexFromPerc; i++)
			{
				if (i != waypointIndexFromPerc)
				{
					Tween.OnTweenCallback(t.onWaypointChange, t, i);
				}
			}
		}
		if (newCompletedSteps > 0 && !t.isComplete)
		{
			int num4 = ((t.loopType != LoopType.Yoyo) ? ((!t.isBackwards) ? (changeValue.wps.Length - 1) : 0) : ((t.completedLoops % 2 != 0 && !t.isBackwards) ? (changeValue.wps.Length - 1) : 0));
			if (num4 != waypointIndexFromPerc)
			{
				Tween.OnTweenCallback(t.onWaypointChange, t, num4);
			}
		}
		Tween.OnTweenCallback(t.onWaypointChange, t, waypointIndexFromPerc);
	}

	public void SetOrientation(PathOptions options, Tween t, Path path, float pathPerc, Vector3 tPos, UpdateNotice updateNotice)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0186: Unknown result type (might be due to invalid IL or missing references)
		//IL_018b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0112: Unknown result type (might be due to invalid IL or missing references)
		//IL_0120: Unknown result type (might be due to invalid IL or missing references)
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_0138: Unknown result type (might be due to invalid IL or missing references)
		//IL_013d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_03f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_03e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_03e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_03ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_03f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_0216: Unknown result type (might be due to invalid IL or missing references)
		//IL_0218: Unknown result type (might be due to invalid IL or missing references)
		//IL_021d: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01da: Unknown result type (might be due to invalid IL or missing references)
		//IL_01df: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_02fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_02fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_02fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0303: Unknown result type (might be due to invalid IL or missing references)
		//IL_0305: Unknown result type (might be due to invalid IL or missing references)
		//IL_0307: Unknown result type (might be due to invalid IL or missing references)
		//IL_0236: Unknown result type (might be due to invalid IL or missing references)
		//IL_0238: Unknown result type (might be due to invalid IL or missing references)
		//IL_023d: Unknown result type (might be due to invalid IL or missing references)
		//IL_024c: Unknown result type (might be due to invalid IL or missing references)
		//IL_024e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0253: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0373: Unknown result type (might be due to invalid IL or missing references)
		//IL_0374: Unknown result type (might be due to invalid IL or missing references)
		//IL_0348: Unknown result type (might be due to invalid IL or missing references)
		//IL_034a: Unknown result type (might be due to invalid IL or missing references)
		//IL_034b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0356: Unknown result type (might be due to invalid IL or missing references)
		//IL_035b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0360: Unknown result type (might be due to invalid IL or missing references)
		//IL_0362: Unknown result type (might be due to invalid IL or missing references)
		//IL_0363: Unknown result type (might be due to invalid IL or missing references)
		//IL_0365: Unknown result type (might be due to invalid IL or missing references)
		//IL_036a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0314: Unknown result type (might be due to invalid IL or missing references)
		//IL_0319: Unknown result type (might be due to invalid IL or missing references)
		//IL_0279: Unknown result type (might be due to invalid IL or missing references)
		//IL_027b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0280: Unknown result type (might be due to invalid IL or missing references)
		//IL_0282: Unknown result type (might be due to invalid IL or missing references)
		//IL_0266: Unknown result type (might be due to invalid IL or missing references)
		//IL_0259: Unknown result type (might be due to invalid IL or missing references)
		//IL_0334: Unknown result type (might be due to invalid IL or missing references)
		//IL_0336: Unknown result type (might be due to invalid IL or missing references)
		//IL_0338: Unknown result type (might be due to invalid IL or missing references)
		//IL_033d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0320: Unknown result type (might be due to invalid IL or missing references)
		//IL_0328: Unknown result type (might be due to invalid IL or missing references)
		//IL_032d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0332: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_02b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0292: Unknown result type (might be due to invalid IL or missing references)
		//IL_026b: Unknown result type (might be due to invalid IL or missing references)
		//IL_03d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_03dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0399: Unknown result type (might be due to invalid IL or missing references)
		//IL_03a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_02d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_02de: Unknown result type (might be due to invalid IL or missing references)
		//IL_02e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_02cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_02d4: Unknown result type (might be due to invalid IL or missing references)
		object target = t.target;
		GameObject val = (GameObject)((target is GameObject) ? target : null);
		Transform val2 = ((val != null) ? val.transform : ((Component)t.target).transform);
		Quaternion val3 = Quaternion.identity;
		Vector3 position = val2.position;
		if (updateNotice == UpdateNotice.RewindStep)
		{
			val2.rotation = options.startupRot;
		}
		switch (options.orientType)
		{
		case OrientType.LookAtPosition:
			path.lookAtPosition = options.lookAtPosition;
			val3 = Quaternion.LookRotation(options.lookAtPosition - position, options.stableZRotation ? Vector3.up : val2.up);
			break;
		case OrientType.LookAtTransform:
			if ((Object)(object)options.lookAtTransform != (Object)null)
			{
				path.lookAtPosition = options.lookAtTransform.position;
				val3 = Quaternion.LookRotation(options.lookAtTransform.position - position, options.stableZRotation ? Vector3.up : val2.up);
			}
			break;
		case OrientType.ToPath:
		{
			Vector3 val4;
			if (path.type == PathType.Linear && options.lookAhead <= 0.0001f)
			{
				val4 = tPos + path.wps[path.linearWPIndex] - path.wps[path.linearWPIndex - 1];
			}
			else
			{
				float num = pathPerc + options.lookAhead;
				if (num > 1f)
				{
					num = (options.isClosedPath ? (num - 1f) : ((path.type == PathType.Linear) ? 1f : 1.00001f));
				}
				val4 = path.GetPoint(num);
			}
			if (path.type == PathType.Linear)
			{
				Vector3 val5 = path.wps[path.wps.Length - 1];
				if (val4 == val5)
				{
					val4 = ((tPos == val5) ? (val5 + (val5 - path.wps[path.wps.Length - 2])) : val5);
				}
			}
			Vector3 val6 = val2.up;
			bool flag = (Object)(object)options.parent != (Object)null;
			bool flag2 = options.useLocalPosition & flag;
			if (flag2)
			{
				val4 = options.parent.TransformPoint(val4);
			}
			if (options.lockRotationAxis != AxisConstraint.None)
			{
				if ((options.lockRotationAxis & AxisConstraint.X) == AxisConstraint.X)
				{
					Vector3 val7 = val2.InverseTransformPoint(val4);
					val7.y = 0f;
					val4 = val2.TransformPoint(val7);
					val6 = (flag2 ? options.parent.up : Vector3.up);
				}
				if ((options.lockRotationAxis & AxisConstraint.Y) == AxisConstraint.Y)
				{
					Vector3 val8 = val2.InverseTransformPoint(val4);
					if (val8.z < 0f)
					{
						val8.z = 0f - val8.z;
					}
					val8.x = 0f;
					val4 = val2.TransformPoint(val8);
				}
				if ((options.lockRotationAxis & AxisConstraint.Z) == AxisConstraint.Z)
				{
					val6 = ((!flag2) ? val2.TransformDirection(Vector3.up) : options.parent.TransformDirection(Vector3.up));
					val6.z = options.startupZRot;
				}
			}
			if (options.mode == PathMode.Full3D)
			{
				Vector3 val9 = val4 - position;
				if (val9 == Vector3.zero)
				{
					val9 = val2.forward;
				}
				if (flag)
				{
					val9 = DivideVectorByVector(val9, options.parent.localScale);
				}
				val3 = Quaternion.LookRotation(val9, val6);
				break;
			}
			if (flag)
			{
				Vector3 val10 = DivideVectorByVector(val4 - position, options.parent.localScale);
				val4 = position + val10;
			}
			float num2 = 0f;
			float num3 = DOTweenUtils.Angle2D(position, val4);
			if (num3 < 0f)
			{
				num3 = 360f + num3;
			}
			if (options.mode == PathMode.Sidescroller2D)
			{
				num2 = ((val4.x < position.x) ? 180 : 0);
				if (num3 > 90f && num3 < 270f)
				{
					num3 = 180f - num3;
				}
			}
			val3 = Quaternion.Euler(0f, num2, num3);
			break;
		}
		}
		if (options.hasCustomForwardDirection)
		{
			val3 *= options.forward;
		}
		DOTweenExternalCommand.Dispatch_SetOrientationOnPath(options, t, val3, val2);
	}

	private Vector3 DivideVectorByVector(Vector3 vector, Vector3 byVector)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(vector.x / byVector.x, vector.y / byVector.y, vector.z / byVector.z);
	}

	private Vector3 MultiplyVectorByVector(Vector3 vector, Vector3 byVector)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(vector.x * byVector.x, vector.y * byVector.y, vector.z * byVector.z);
	}
}
