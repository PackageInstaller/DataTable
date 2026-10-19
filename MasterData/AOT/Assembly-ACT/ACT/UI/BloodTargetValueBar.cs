using UnityEngine.UI;

namespace ACT.UI;

public class BloodTargetValueBar : TargetValueMaskedBarBase
{
	public Image frontImage;

	public Image frontMask;

	public Image backImage;

	protected override void SetValue()
	{
		backImage.fillAmount = Value;
	}

	protected override void SetTargetValue()
	{
		frontImage.fillAmount = TargetValue;
		frontMask.fillAmount = TargetValue;
	}
}
