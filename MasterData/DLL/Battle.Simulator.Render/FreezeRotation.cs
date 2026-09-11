using UnityEngine;

[ExecuteInEditMode]
public class FreezeRotation : MonoBehaviour
{
	public bool FreezeX;

	public bool FreezeY;

	public bool FreezeZ;

	private void Update()
	{
		if (FreezeX)
		{
			base.transform.eulerAngles = base.transform.eulerAngles.NewX(0f);
		}
		if (FreezeY)
		{
			base.transform.eulerAngles = base.transform.eulerAngles.NewY(0f);
		}
		if (FreezeZ)
		{
			base.transform.eulerAngles = base.transform.eulerAngles.NewZ(0f);
		}
	}
}
