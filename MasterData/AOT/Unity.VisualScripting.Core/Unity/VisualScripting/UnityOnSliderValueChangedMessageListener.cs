using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnSliderValueChangedMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<Slider>()?.onValueChanged?.AddListener((float value) =>
		{
			EventBus.Trigger("OnSliderValueChanged", gameObject, value);
		});
	}
}
