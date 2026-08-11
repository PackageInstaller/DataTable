using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GlovesEnergyItem : MonoBehaviour
{
	public Image fill;

	public GameObject effect;

	private float curFill;

	[SerializeField]
	private Animation fillAni;

	public bool SetVal(float val)
	{
		bool result = false;
		effect.SetActive(val >= 1f);
		fill.fillAmount = val;
		if (curFill != val)
		{
			if (val > curFill)
			{
				result = true;
				fillAni.Play("GlovesEnergy_enter");
			}
			else
			{
				fillAni.Play("GlovesEnergy_out");
			}
			curFill = val;
		}
		return result;
	}
}
