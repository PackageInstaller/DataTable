using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT;

[RequireComponent(typeof(TMP_Text))]
[RequireComponent(typeof(LocalizeStringEvent))]
public class TMP_LocalizeCustomTags : TMP_BaseCustomTags
{
	private TMP_Text tmpComponent;

	private LocalizeStringEvent localizeStringEvent;

	public string TextWithoutCustomTags { get; private set; } = string.Empty;

	private void TryInitialize()
	{
		tmpComponent = GetComponent<TMP_Text>();
		localizeStringEvent = GetComponent<LocalizeStringEvent>();
	}

	private void Awake()
	{
		TryInitialize();
	}

	private void OnEnable()
	{
		if ((bool)localizeStringEvent)
		{
			localizeStringEvent.OnUpdateString.AddListener(OnUpdateString);
		}
	}

	private void OnDisable()
	{
		if ((bool)localizeStringEvent)
		{
			localizeStringEvent.OnUpdateString.RemoveListener(OnUpdateString);
		}
	}

	private void OnUpdateString(string arg0)
	{
		if ((bool)tmpComponent)
		{
			tmpComponent.text = ProcessText(arg0);
		}
	}
}
