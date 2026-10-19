using System;
using ACT.Battle;
using ACT.Config;
using ACT.Game;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class DestinyBtn : DestinyBtnBase
{
	[SerializeField]
	private LocalizeStringEvent btnName;

	[SerializeField]
	private ActButton btn;

	[SerializeField]
	private Animation waitActiveAnim;

	[SerializeField]
	private TextMeshProUGUI coloredText;

	[SerializeField]
	private TextMeshProUGUI miniColoredText;

	[SerializeField]
	private Color normalColor;

	[SerializeField]
	private Color activeColor;

	[SerializeField]
	private Color miniNormalColor;

	[SerializeField]
	private Color miniActiveColor;

	private CharacterConstellationData _destinyData;

	private int _destinyId;

	private DestinyTriggerIcon _destinyTriggerIcon;

	public void Init(CharacterConstellationData destinyData, bool active, Action<int, bool> selectDestiny, DestinyTriggerIcon triggerIcon, bool isTrialCharacter = false)
	{
		_destinyId = destinyData.id;
		_selectDestiny = selectDestiny;
		_destinyData = destinyData;
		_destinyTriggerIcon = triggerIcon;
		btnName.SetReference(LocalizeTable.ShortCommon, destinyData.name);
		SetActive(active);
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(Select);
		SetSelectState(active: false);
		UpdateAnim(active, G.localPlayer.Inventory.GetItemCount(_destinyData.costItemId) >= 1, isTrialCharacter);
	}

	public void UpdateAnim(bool isActive, bool costIsEnough, bool isTrialCharacter = false)
	{
		waitActiveAnim.gameObject.SetActive((!isActive & costIsEnough) && !isTrialCharacter);
		if ((!isActive & costIsEnough) && !isTrialCharacter)
		{
			waitActiveAnim.Stop();
			waitActiveAnim.Play("Loop");
		}
	}

	public override void Select()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/Click");
		_selectDestiny(_destinyId, arg2: true);
		SetSelectState(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public void SetActive(bool active)
	{
		GameObject[] array = activeGos;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(active);
		}
		array = inactiveGos;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(!active);
		}
		coloredText.color = (active ? activeColor : normalColor);
		miniColoredText.color = (active ? miniActiveColor : miniNormalColor);
	}

	private void OnDestroy()
	{
		_destinyId = 0;
		_destinyTriggerIcon = null;
		_destinyData = null;
		_selectDestiny = null;
	}
}
