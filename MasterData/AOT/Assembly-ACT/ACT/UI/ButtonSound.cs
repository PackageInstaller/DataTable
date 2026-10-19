using System;
using ACT.LocalizationExtension;
using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[Obsolete("用ACTbutton")]
public class ButtonSound : MonoBehaviour
{
	private Toggle toggle;

	private Button button;

	private InteractVarietyBtn interactVarietyBtn;

	private LocalizeTMP_Dropdown dropdown;

	private EventTrigger eventTrigger;

	public EventReference normalReference;

	public AudioEventReference audioNormalReference;

	public EventReference forbideClickReference;

	public AudioEventReference audioForbideClickReference;

	private void Start()
	{
		toggle = GetComponent<Toggle>();
		if (toggle == null)
		{
			button = GetComponent<Button>();
		}
		if (button == null)
		{
			interactVarietyBtn = GetComponent<InteractVarietyBtn>();
		}
		if (interactVarietyBtn == null)
		{
			dropdown = GetComponent<LocalizeTMP_Dropdown>();
		}
		if (dropdown == null)
		{
			eventTrigger = GetComponent<EventTrigger>();
		}
	}

	public void PlaySound(float scale)
	{
		if (audioNormalReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click", new AudioPlayOptions
			{
				attachTarget = Camera.main.transform,
				volume = scale
			});
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioNormalReference, new AudioPlayOptions
			{
				attachTarget = Camera.main.transform,
				volume = scale
			});
		}
	}

	public void PlaySound()
	{
		bool flag = false;
		if (toggle != null)
		{
			flag = toggle.interactable;
		}
		else if (button != null)
		{
			flag = button.interactable;
		}
		else if (interactVarietyBtn != null)
		{
			flag = interactVarietyBtn.interactable;
		}
		else if ((bool)dropdown)
		{
			flag = dropdown.interactable;
		}
		else
		{
			if (!eventTrigger)
			{
				return;
			}
			flag = true;
		}
		if (flag)
		{
			if (audioNormalReference.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(audioNormalReference);
			}
		}
		else if (audioForbideClickReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioForbideClickReference);
		}
	}

	private void OnDestroy()
	{
		toggle = null;
		button = null;
		interactVarietyBtn = null;
		dropdown = null;
		eventTrigger = null;
	}
}
