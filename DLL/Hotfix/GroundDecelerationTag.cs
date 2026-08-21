using UnityEngine;

public class GroundDecelerationTag : MonoBehaviour
{
	[SerializeField]
	private float decelerationValue = 1f;

	public float DecelerationValue => decelerationValue;
}
