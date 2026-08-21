using UnityEngine;
using UnityEngine.UI;

public class EnergyController : MonoBehaviour, IPowerController
{
	public Slider Power;

	public Text CurrentValue;

	public Text MaxValue;

	private int max = -1;

	private int current = -1;

	public void SetActive(bool active)
	{
		base.gameObject.SetActive(active);
	}

	public void SetPower(int power, int max)
	{
		Power.value = (float)power * 1f / (float)max;
		if (this.max != max && null != MaxValue)
		{
			MaxValue.text = max.ToString();
			this.max = max;
		}
		if (current != power && CurrentValue != null)
		{
			CurrentValue.text = power.ToString();
			current = power;
		}
	}

	public void SetSlowPower(int power, int max)
	{
	}

	public void UpdatePowerMax(int max)
	{
		Power.value = (float)current * 1f / (float)max;
		if (this.max != max && MaxValue != null)
		{
			MaxValue.text = max.ToString();
			this.max = max;
		}
	}
}
