using System;
using ACT.Core;

namespace ACT.UI;

[Serializable]
public class WifiInfo : DeviceInfo
{
	public override void SetValue(int value)
	{
		base.SetValue(value);
		mainImage.gameObject.SetActive(value <= RuntimeConfigs.data.game.wifiPingConfig[0]);
	}
}
