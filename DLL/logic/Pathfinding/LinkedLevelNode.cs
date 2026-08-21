using UnityEngine;

namespace Pathfinding;

internal class LinkedLevelNode
{
	public Vector3 position;

	public bool walkable;

	public RaycastHit hit;

	public float height;

	public LinkedLevelNode next;
}
