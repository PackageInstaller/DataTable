using UnityEngine;

public class DecorateShow : MonoBehaviour
{
	private static Color _color = Color.red;

	public int index;

	private void OnDrawGizmos()
	{
		Gizmos.color = _color;
		Gizmos.DrawWireSphere(base.transform.position, 10f);
		Gizmos.color = Color.white;
	}
}
