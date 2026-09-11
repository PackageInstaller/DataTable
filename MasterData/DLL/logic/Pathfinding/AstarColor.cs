using System;
using UnityEngine;

namespace Pathfinding;

[Serializable]
public class AstarColor
{
	public Color _NodeConnection;

	public Color _UnwalkableNode;

	public Color _BoundsHandles;

	public Color _ConnectionLowLerp;

	public Color _ConnectionHighLerp;

	public Color _MeshEdgeColor;

	public Color[] _AreaColors;

	public static Color NodeConnection;

	public static Color UnwalkableNode;

	public static Color BoundsHandles;

	public static Color ConnectionLowLerp;

	public static Color ConnectionHighLerp;

	public static Color MeshEdgeColor;

	private static Color[] AreaColors;

	public static Color GetAreaColor(uint area)
	{
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		if (AreaColors == null || area >= AreaColors.Length)
		{
			return AstarMath.IntToColor((int)area, 1f);
		}
		return AreaColors[area];
	}

	public void OnEnable()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		NodeConnection = _NodeConnection;
		UnwalkableNode = _UnwalkableNode;
		BoundsHandles = _BoundsHandles;
		ConnectionLowLerp = _ConnectionLowLerp;
		ConnectionHighLerp = _ConnectionHighLerp;
		MeshEdgeColor = _MeshEdgeColor;
		AreaColors = _AreaColors;
	}

	public AstarColor()
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		_NodeConnection = new Color(1f, 1f, 1f, 0.9f);
		_UnwalkableNode = new Color(1f, 0f, 0f, 0.5f);
		_BoundsHandles = new Color(0.29f, 0.454f, 0.741f, 0.9f);
		_ConnectionLowLerp = new Color(0f, 1f, 0f, 0.5f);
		_ConnectionHighLerp = new Color(1f, 0f, 0f, 0.5f);
		_MeshEdgeColor = new Color(0f, 0f, 0f, 0.5f);
	}

	static AstarColor()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_00aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		NodeConnection = new Color(1f, 1f, 1f, 0.9f);
		UnwalkableNode = new Color(1f, 0f, 0f, 0.5f);
		BoundsHandles = new Color(0.29f, 0.454f, 0.741f, 0.9f);
		ConnectionLowLerp = new Color(0f, 1f, 0f, 0.5f);
		ConnectionHighLerp = new Color(1f, 0f, 0f, 0.5f);
		MeshEdgeColor = new Color(0f, 0f, 0f, 0.5f);
	}
}
