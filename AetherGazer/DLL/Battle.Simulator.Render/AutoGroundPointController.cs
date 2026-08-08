using UnityEngine;

public class AutoGroundPointController : MonoBehaviour
{
	public void UpdateHeigh(Vector3 positoin)
	{
		base.transform.position = positoin;
	}
}
