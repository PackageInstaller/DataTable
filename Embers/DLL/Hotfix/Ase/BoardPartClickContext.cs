using UnityEngine;

namespace Ase;

public struct BoardPartClickContext
{
	public string PartId;

	public bool CheckFrequentlyUsed;

	public int PointerId;

	public Vector2 ScreenPos;

	public Vector2 LocalPos;

	public int ClickCount;

	public float Time;

	public GameObject Source;

	public ISpinePlayCommand PlayCommand;
}
