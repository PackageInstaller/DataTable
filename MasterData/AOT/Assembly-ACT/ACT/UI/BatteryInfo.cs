using System;

namespace ACT.UI;

[Serializable]
public class BatteryInfo : DeviceInfo
{
	public override void SetValue(int value)
	{
		base.SetValue(value);
		mainImage.fillAmount = (float)value / 100f;
	}
}
