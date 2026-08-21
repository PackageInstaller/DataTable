using System;
using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins.Core.PathCore;

[Serializable]
public class Path
{
	private static CatmullRomDecoder _catmullRomDecoder;

	private static LinearDecoder _linearDecoder;

	private static CubicBezierDecoder _cubicBezierDecoder;

	public float[] wpLengths;

	[SerializeField]
	public Vector3[] wps;

	[SerializeField]
	internal PathType type;

	[SerializeField]
	internal int subdivisionsXSegment;

	[SerializeField]
	internal int subdivisions;

	[SerializeField]
	internal ControlPoint[] controlPoints;

	[SerializeField]
	internal float length;

	[SerializeField]
	internal bool isFinalized;

	[SerializeField]
	internal float[] timesTable;

	[SerializeField]
	internal float[] lengthsTable;

	internal int linearWPIndex;

	internal bool addedExtraStartWp;

	internal bool addedExtraEndWp;

	internal PathOptions plugOptions;

	private Path _incrementalClone;

	private int _incrementalIndex;

	private ABSPathDecoder _decoder;

	private bool _changed;

	internal Vector3[] nonLinearDrawWps;

	internal Vector3 targetPosition;

	internal Vector3? lookAtPosition;

	internal Color gizmoColor;

	internal int minInputWaypoints => _decoder.minInputWaypoints;

	public Path(PathType type, Vector3[] waypoints, int subdivisionsXSegment, Color? gizmoColor = null)
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		linearWPIndex = -1;
		this.gizmoColor = new Color(1f, 1f, 1f, 0.7f);
		base._002Ector();
		this.type = type;
		this.subdivisionsXSegment = subdivisionsXSegment;
		if (gizmoColor.HasValue)
		{
			this.gizmoColor = gizmoColor.Value;
		}
		AssignWaypoints(waypoints, cloneWps: true);
		AssignDecoder(type);
		if (TweenManager.isUnityEditor)
		{
			DOTween.GizmosDelegates.Add(Draw);
		}
	}

	internal Path()
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		linearWPIndex = -1;
		gizmoColor = new Color(1f, 1f, 1f, 0.7f);
		base._002Ector();
	}

	internal void FinalizePath(bool isClosedPath, AxisConstraint lockPositionAxes, Vector3 currTargetVal)
	{
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		if (lockPositionAxes != AxisConstraint.None)
		{
			bool flag = (lockPositionAxes & AxisConstraint.X) == AxisConstraint.X;
			bool flag2 = (lockPositionAxes & AxisConstraint.Y) == AxisConstraint.Y;
			bool flag3 = (lockPositionAxes & AxisConstraint.Z) == AxisConstraint.Z;
			for (int i = 0; i < wps.Length; i++)
			{
				Vector3 val = wps[i];
				wps[i] = new Vector3(flag ? currTargetVal.x : val.x, flag2 ? currTargetVal.y : val.y, flag3 ? currTargetVal.z : val.z);
			}
		}
		_decoder.FinalizePath(this, wps, isClosedPath);
		isFinalized = true;
	}

	internal Vector3 GetPoint(float perc, bool convertToConstantPerc = false)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		if (convertToConstantPerc)
		{
			perc = ConvertToConstantPathPerc(perc);
		}
		return _decoder.GetPoint(perc, wps, this, controlPoints);
	}

	internal float ConvertToConstantPathPerc(float perc)
	{
		if (type == PathType.Linear)
		{
			return perc;
		}
		if (perc > 0f && perc < 1f)
		{
			if (length <= 0f)
			{
				return perc;
			}
			float num = length * perc;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = 0f;
			float num5 = 0f;
			int num6 = lengthsTable.Length;
			for (int i = 0; i < num6; i++)
			{
				if (lengthsTable[i] > num)
				{
					num4 = timesTable[i];
					num5 = lengthsTable[i];
					if (i > 0)
					{
						num3 = lengthsTable[i - 1];
					}
					break;
				}
				num2 = timesTable[i];
			}
			perc = num2 + (num - num3) / (num5 - num3) * (num4 - num2);
		}
		if (perc > 1f)
		{
			perc = 1f;
		}
		else if (perc < 0f)
		{
			perc = 0f;
		}
		return perc;
	}

	internal int GetWaypointIndexFromPerc(float perc, bool isMovingForward)
	{
		if (perc >= 1f)
		{
			return wps.Length - 1;
		}
		if (perc <= 0f)
		{
			return 0;
		}
		float num = length * perc;
		float num2 = 0f;
		int i = 0;
		for (int num3 = wpLengths.Length; i < num3; i++)
		{
			num2 += wpLengths[i];
			if (i == num3 - 1)
			{
				if (!isMovingForward)
				{
					return i;
				}
				return i - 1;
			}
			if (num2 < num)
			{
				continue;
			}
			if (num2 > num)
			{
				if (!isMovingForward)
				{
					return i;
				}
				return i - 1;
			}
			return i;
		}
		return 0;
	}

	internal static Vector3[] GetDrawPoints(Path p, int drawSubdivisionsXSegment)
	{
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		int num = p.wps.Length;
		if (p.type == PathType.Linear)
		{
			return p.wps;
		}
		int num2 = num * drawSubdivisionsXSegment;
		Vector3[] array = (Vector3[])(object)new Vector3[num2 + 1];
		for (int i = 0; i <= num2; i++)
		{
			float perc = (float)i / (float)num2;
			Vector3 point = p.GetPoint(perc);
			array[i] = point;
		}
		return array;
	}

	internal static void RefreshNonLinearDrawWps(Path p)
	{
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		int num = p.wps.Length * 10;
		if (p.nonLinearDrawWps == null || p.nonLinearDrawWps.Length != num + 1)
		{
			p.nonLinearDrawWps = (Vector3[])(object)new Vector3[num + 1];
		}
		for (int i = 0; i <= num; i++)
		{
			float perc = (float)i / (float)num;
			Vector3 point = p.GetPoint(perc);
			p.nonLinearDrawWps[i] = point;
		}
	}

	internal void Destroy()
	{
		if (TweenManager.isUnityEditor)
		{
			DOTween.GizmosDelegates.Remove(Draw);
		}
		wps = null;
		wpLengths = (timesTable = (lengthsTable = null));
		nonLinearDrawWps = null;
		isFinalized = false;
	}

	internal Path CloneIncremental(int loopIncrement)
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_020b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0210: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		if (_incrementalClone != null)
		{
			if (_incrementalIndex == loopIncrement)
			{
				return _incrementalClone;
			}
			_incrementalClone.Destroy();
		}
		int num = wps.Length;
		Vector3 val = wps[num - 1] - wps[0];
		Vector3[] array = (Vector3[])(object)new Vector3[wps.Length];
		for (int i = 0; i < num; i++)
		{
			array[i] = wps[i] + val * (float)loopIncrement;
		}
		int num2 = controlPoints.Length;
		ControlPoint[] array2 = new ControlPoint[num2];
		for (int j = 0; j < num2; j++)
		{
			array2[j] = controlPoints[j] + val * (float)loopIncrement;
		}
		Vector3[] array3 = null;
		if (nonLinearDrawWps != null)
		{
			int num3 = nonLinearDrawWps.Length;
			array3 = (Vector3[])(object)new Vector3[num3];
			for (int k = 0; k < num3; k++)
			{
				array3[k] = nonLinearDrawWps[k] + val * (float)loopIncrement;
			}
		}
		_incrementalClone = new Path();
		_incrementalIndex = loopIncrement;
		_incrementalClone.type = type;
		_incrementalClone.subdivisionsXSegment = subdivisionsXSegment;
		_incrementalClone.subdivisions = subdivisions;
		_incrementalClone.wps = array;
		_incrementalClone.controlPoints = array2;
		if (TweenManager.isUnityEditor)
		{
			DOTween.GizmosDelegates.Add(_incrementalClone.Draw);
		}
		_incrementalClone.length = length;
		_incrementalClone.wpLengths = wpLengths;
		_incrementalClone.timesTable = timesTable;
		_incrementalClone.lengthsTable = lengthsTable;
		_incrementalClone._decoder = _decoder;
		_incrementalClone.nonLinearDrawWps = array3;
		_incrementalClone.targetPosition = targetPosition;
		_incrementalClone.lookAtPosition = lookAtPosition;
		_incrementalClone.isFinalized = true;
		return _incrementalClone;
	}

	internal void AssignWaypoints(Vector3[] newWps, bool cloneWps = false)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		if (cloneWps)
		{
			int num = newWps.Length;
			wps = (Vector3[])(object)new Vector3[num];
			for (int i = 0; i < num; i++)
			{
				wps[i] = newWps[i];
			}
		}
		else
		{
			wps = newWps;
		}
	}

	internal void AssignDecoder(PathType pathType)
	{
		type = pathType;
		switch (pathType)
		{
		case PathType.Linear:
			if (_linearDecoder == null)
			{
				_linearDecoder = new LinearDecoder();
			}
			_decoder = _linearDecoder;
			break;
		case PathType.CubicBezier:
			if (_cubicBezierDecoder == null)
			{
				_cubicBezierDecoder = new CubicBezierDecoder();
			}
			_decoder = _cubicBezierDecoder;
			break;
		default:
			if (_catmullRomDecoder == null)
			{
				_catmullRomDecoder = new CatmullRomDecoder();
			}
			_decoder = _catmullRomDecoder;
			break;
		}
	}

	internal void Draw()
	{
		Draw(this);
	}

	private static void Draw(Path p)
	{
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0117: Unknown result type (might be due to invalid IL or missing references)
		//IL_0122: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0154: Unknown result type (might be due to invalid IL or missing references)
		//IL_0157: Unknown result type (might be due to invalid IL or missing references)
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0163: Unknown result type (might be due to invalid IL or missing references)
		if (p.timesTable == null)
		{
			return;
		}
		Color color = p.gizmoColor;
		color.a *= 0.5f;
		Gizmos.color = p.gizmoColor;
		int num = p.wps.Length;
		if (p._changed || (p.type != PathType.Linear && p.nonLinearDrawWps == null))
		{
			p._changed = false;
			if (p.type != PathType.Linear)
			{
				RefreshNonLinearDrawWps(p);
			}
		}
		if (p.type == PathType.Linear)
		{
			Vector3 val = ConvertToDrawPoint(p.wps[0], p.plugOptions);
			for (int i = 0; i < num; i++)
			{
				Vector3 val2 = ConvertToDrawPoint(p.wps[i], p.plugOptions);
				Gizmos.DrawLine(val2, val);
				val = val2;
			}
		}
		else
		{
			Vector3 val = ConvertToDrawPoint(p.nonLinearDrawWps[0], p.plugOptions);
			int num2 = p.nonLinearDrawWps.Length;
			for (int j = 1; j < num2; j++)
			{
				Vector3 val3 = ConvertToDrawPoint(p.nonLinearDrawWps[j], p.plugOptions);
				Gizmos.DrawLine(val3, val);
				val = val3;
			}
		}
		Gizmos.color = color;
		for (int k = 0; k < num; k++)
		{
			Gizmos.DrawSphere(ConvertToDrawPoint(p.wps[k], p.plugOptions), 0.075f);
		}
		if (p.lookAtPosition.HasValue)
		{
			Vector3 value = p.lookAtPosition.Value;
			Gizmos.DrawLine(p.targetPosition, value);
			Gizmos.DrawWireSphere(value, 0.075f);
		}
	}

	private static Vector3 ConvertToDrawPoint(Vector3 wp, PathOptions plugOptions)
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		if (!plugOptions.useLocalPosition || (Object)(object)plugOptions.parent == (Object)null)
		{
			return wp;
		}
		return plugOptions.parent.TransformPoint(wp);
	}
}
