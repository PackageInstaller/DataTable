using UnityEngine;

public class EffectRandomRotation : MonoBehaviour
{
	public float RangeX;

	public float RangeY;

	public float RangeZ;

	private void OnEnable()
	{
		Vector3 eulerAngles = base.transform.eulerAngles;
		if (RangeX > 0f)
		{
			eulerAngles.x = Random.Range(0f - RangeX, RangeX);
		}
		if (RangeY > 0f)
		{
			eulerAngles.y = Random.Range(0f - RangeY, RangeY);
		}
		if (RangeZ > 0f)
		{
			eulerAngles.z = Random.Range(0f - RangeZ, RangeZ);
		}
		base.transform.eulerAngles = eulerAngles;
	}
}
