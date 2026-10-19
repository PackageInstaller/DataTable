using UnityEngine.UI;

namespace ACT.UI;

public class TwoPartsPostureBar : TargetValueMaskedBarBase
{
	public Image imageL;

	public Image imageLBack;

	public Image imageLMask;

	public Image imageR;

	public Image imageRBack;

	public Image imageRMask;

	protected override void SetValue()
	{
		if ((bool)imageLBack)
		{
			imageLBack.fillAmount = Value;
		}
		if ((bool)imageRBack)
		{
			imageRBack.fillAmount = Value;
		}
	}

	protected override void SetTargetValue()
	{
		imageL.fillAmount = TargetValue;
		imageR.fillAmount = TargetValue;
		if ((bool)imageLMask)
		{
			imageLMask.fillAmount = TargetValue;
		}
		if ((bool)imageRMask)
		{
			imageRMask.fillAmount = TargetValue;
		}
	}
}
