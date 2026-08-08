using UnityEngine;
using UnityEngine.UI;

public class P08ButtonUILogic
{
	public const float ALPHA_VALUE = 8f / 85f;

	public const string ATLAS_PATH = "Atlas/";

	public Image abilityIcon;

	public Text cdText;

	public Image cdMaskImage;

	public GameObject disableGo;

	public EffectLevel ChargingController;

	private int _currentCD;

	private int _maxCD;

	private int _chargeCount;

	protected bool useableCD = true;

	public void SetCD(int current, int max, int chargeCount)
	{
		if (current == _currentCD && max == _maxCD && chargeCount == _chargeCount)
		{
			return;
		}
		_currentCD = current;
		_maxCD = max;
		_chargeCount = chargeCount;
		if (current < 0)
		{
			current = 0;
		}
		if (null != ChargingController)
		{
			ChargingController.UpdateChargingCD(chargeCount, current, max);
		}
		if (chargeCount > 0)
		{
			current = 0;
			max = 1;
		}
		if (null != cdText)
		{
			if (current == 0)
			{
				cdText.text = string.Empty;
			}
			else
			{
				int num = Mathf.CeilToInt((float)current / 1000f);
				if (num < CommonString.Numbers.Length)
				{
					cdText.text = CommonString.Numbers[num];
				}
				else
				{
					cdText.text = num.ToString();
				}
			}
		}
		if (null != cdMaskImage)
		{
			if (max != 0)
			{
				cdMaskImage.fillAmount = (float)current / (float)max;
			}
			else
			{
				cdMaskImage.fillAmount = 0f;
			}
		}
		if (current > 0)
		{
			useableCD = false;
		}
		else
		{
			useableCD = true;
		}
	}
}
