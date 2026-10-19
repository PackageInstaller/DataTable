using ACT.Sound;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class InputLine_KeyboardRebinding : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	public TextMeshProUGUI Label;

	public Button BtnRebinding0;

	public Button BtnRebinding1;

	public TextMeshProUGUI Text0;

	public TextMeshProUGUI Text1;

	public InputPromptByBindingPath InputPrompt0;

	public InputPromptByBindingPath InputPrompt1;

	public bool Editable = true;

	public bool Editable1 = true;

	public string ButtonBindingKey;

	[HideInInspector]
	public string ActionPath;

	[HideInInspector]
	public int BindingIndex0 = -1;

	[HideInInspector]
	public int BindingIndex1 = -1;

	private void Awake()
	{
		BtnRebinding0.onClick.AddListener(OnButtonClick);
		BtnRebinding1.onClick.AddListener(OnButtonClick);
	}

	public void OnSubmit(BaseEventData eventData)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Select", new AudioPlayOptions
		{
			attachTarget = Camera.main.transform
		});
	}

	private void OnButtonClick()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Select", new AudioPlayOptions
		{
			attachTarget = Camera.main.transform
		});
	}
}
