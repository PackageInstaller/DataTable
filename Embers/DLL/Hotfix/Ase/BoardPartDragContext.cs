using UnityEngine;

namespace Ase;

public struct BoardPartDragContext
{
	public string PartId;

	public int PointerId;

	public Vector2 ScreenPos;

	public Vector2 LocalPos;

	public Vector2 Delta;

	public float Normalized;

	public BoardPartDragPhase Phase;

	public float Time;

	public GameObject Source;
}
