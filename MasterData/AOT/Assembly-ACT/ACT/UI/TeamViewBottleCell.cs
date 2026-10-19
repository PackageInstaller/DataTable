using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TeamViewBottleCell : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	[SerializeField]
	private ActButton _btn;

	[SerializeField]
	private BImage icon;

	[SerializeField]
	private List<GameObject> qualityBoards;

	[SerializeField]
	private GameObject equipIcon;

	[SerializeField]
	private TextMeshProUGUI curLevel;

	[SerializeField]
	private TextMeshProUGUI maxLevel;

	[SerializeField]
	private LocalizeStringEvent nameText;

	[SerializeField]
	private TextMeshProUGUI useCountText;

	[SerializeField]
	private StartList slots;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject _gamePadHandle;

	private bool _isGamePadSelected;

	public ActButton btn => _btn;

	private void OnEnable()
	{
		MonoECS.instance?.onInputModeChange.AddListener(OnInputModeChanged);
		RefreshGamePadHandle();
	}

	private void OnDisable()
	{
		MonoECS.instance?.onInputModeChange.RemoveListener(OnInputModeChanged);
		SetGamePadSelected(selected: false);
	}

	public void Refresh(BloodBottleData bottleData, ImageAssetStation station, PresetTeam curTeamProfile, StringBuilder sb)
	{
		ItemData data = CoreUtils.GetData(bottleData.id, RuntimeConfigs.data.itemDatas);
		station.LoadItemIcon(data.iconAddress, icon);
		slots.SoltInit(bottleData, station);
		qualityBoards.ForEach((GameObject x) =>
		{
			x.SetActive(value: false);
		});
		if (data.quality > 0)
		{
			qualityBoards[data.quality - 1].SetActive(value: true);
		}
		if (Model<TeamModel>.Interface.source == TeamProfileSource.Temple)
		{
			equipIcon.SetActive(bottleData.isEquip);
		}
		else
		{
			equipIcon.SetActive(curTeamProfile != null && curTeamProfile.EquipPotionId == bottleData.uid && bottleData.isEquip);
		}
		curLevel.text = bottleData.curLevel.FastToString();
		maxLevel.text = bottleData.maxLevel.FastToString();
		nameText.StringReference.TableEntryReference = data.nameLocal;
		sb.Clear();
		TeamProfileSource source = Model<TeamModel>.Interface.source;
		if ((uint)(source - 1) <= 1u)
		{
			useCountText.SetText(sb.Append(bottleData.maxUseCount).Append("/").Append(bottleData.maxUseCount));
		}
		else
		{
			useCountText.SetText(sb.Append(bottleData.maxUseCount - bottleData.alreadyUseCount).Append("/").Append(bottleData.maxUseCount));
		}
		selected.SetActive(value: false);
		SetGamePadSelected(selected: false);
		gameObject.SetActive(value: true);
	}

	public void SetEquipState(bool isEquip)
	{
		equipIcon.SetActive(isEquip);
	}

	public void SetSelectState(bool isSelect)
	{
		selected.SetActive(isSelect);
	}

	public void OnSelect(BaseEventData eventData)
	{
		if (!(MonoECS.instance == null) && (MonoECS.instance.InputMode == DeviceInputMode.Gamepad || MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse))
		{
			_btn.OnSubmit(eventData);
			SetGamePadSelected(selected: true);
		}
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetGamePadSelected(selected: false);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		if (mode != DeviceInputMode.Gamepad)
		{
			SetGamePadSelected(selected: false);
		}
		else
		{
			RefreshGamePadHandle();
		}
	}

	private void SetGamePadSelected(bool selected)
	{
		_isGamePadSelected = selected;
		RefreshGamePadHandle();
	}

	private void RefreshGamePadHandle()
	{
		if (!(_gamePadHandle == null))
		{
			_gamePadHandle.SetActive(_isGamePadSelected && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}
}
