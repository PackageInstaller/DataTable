using System;
using ACT.Core;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Serializable]
public class DataInfo : DeviceInfo
{
	public Image frame;

	public Color normalSignalColor;

	public Color weakSignalColor;

	public override void SetValue(int value)
	{
		base.SetValue(value);
		int[] dataPingConfig = RuntimeConfigs.data.game.dataPingConfig;
		for (int i = 0; i < dataPingConfig.Length + 1; i++)
		{
			int num = 0;
			int num2 = 0;
			if (i == 0)
			{
				num = int.MinValue;
				num2 = dataPingConfig[0];
			}
			else if (i == dataPingConfig.Length)
			{
				num = dataPingConfig[i - 1];
				num2 = int.MaxValue;
			}
			else
			{
				num = dataPingConfig[i - 1];
				num2 = dataPingConfig[i];
			}
			if (value >= num && value < num2)
			{
				mainImage.fillAmount = 1f - (float)i * 1f / (float)(dataPingConfig.Length + 1);
				if (mainImage.fillAmount <= 0.25f)
				{
					mainImage.color = weakSignalColor;
					frame.color = weakSignalColor;
				}
				else
				{
					mainImage.color = normalSignalColor;
					frame.color = normalSignalColor;
				}
				break;
			}
		}
	}
}
