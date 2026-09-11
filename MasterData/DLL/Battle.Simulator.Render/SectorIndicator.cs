using UnityEngine;

public class SectorIndicator : MonoBehaviour
{
	public int Angle;

	public float StartValue;

	public float ValidValue;

	public void Init(int angle, float startValue, float validValue)
	{
		Angle = angle;
		WarningManager componentInChildren = base.transform.GetComponentInChildren<WarningManager>();
		if (componentInChildren != null)
		{
			componentInChildren.Angle = validValue;
			componentInChildren.transform.localEulerAngles = new Vector3(0f, startValue, 0f);
		}
	}

	public void Init(int angle, float startValue, float validValue, float innerRadius)
	{
		Angle = angle;
		WarningManager componentInChildren = base.transform.GetComponentInChildren<WarningManager>();
		if (componentInChildren != null)
		{
			componentInChildren.Angle = validValue;
			componentInChildren.transform.localEulerAngles = new Vector3(0f, startValue, 0f);
			componentInChildren.InnerRadius = innerRadius;
		}
	}
}
