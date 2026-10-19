using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class EnergyLine : EnergyWidget
{
	[SerializeReference]
	private Image fillImage;

	public override void UpdateVal(float newVal)
	{
		base.UpdateVal(newVal);
		fillImage.fillAmount = _val;
	}
}
