using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnButtonClickMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<Button>()?.onClick?.AddListener(() =>
		{
			EventBus.Trigger("OnButtonClick", gameObject);
		});
	}
}
