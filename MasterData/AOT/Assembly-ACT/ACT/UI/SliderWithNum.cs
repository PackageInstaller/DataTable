using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SliderWithNum : MonoBehaviour
{
	public Slider slider;

	public Text text;

	private void Start()
	{
		slider.onValueChanged.AddListener((float value) =>
		{
			text.text = Mathf.RoundToInt(value * 100f).ToString();
		});
	}
}
