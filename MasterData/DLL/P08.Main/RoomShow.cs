using UnityEngine;

public class RoomShow : MonoBehaviour
{
	public int index = -1;

	public Vector3 size = Vector3.one;

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.green;
		Gizmos.DrawWireCube(base.transform.position, size);
		Gizmos.color = Color.white;
	}
}
