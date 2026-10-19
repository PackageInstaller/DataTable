using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BottleMaterialCell : UIBehaviour
{
	[SerializeField]
	private ActButton _btn;

	[SerializeField]
	private BImage _matIcon;

	[SerializeField]
	private LocalizeStringEvent _matName;

	[SerializeField]
	private TextMeshProUGUI _matDes;

	[SerializeField]
	private BImage _typeIcon;

	[SerializeField]
	private GameObject _selected;

	[SerializeField]
	private LocalizeStringEvent _lockAndEmptyStateDes;

	[SerializeField]
	private GameObject _lcokState;

	[SerializeField]
	private GameObject _emptyState;

	[SerializeField]
	private GameObject _select;

	[SerializeField]
	private List<GameObject> _TypeIcons;

	[SerializeField]
	private GameObject fillRoot;

	[SerializeField]
	private GameObject _lockOrEmptyRoot;

	[SerializeField]
	private GameObject matDetailDesRoot;

	[SerializeField]
	private TextMeshProUGUI _materialDetailDes;

	[SerializeField]
	private Color[] _matQualityColor;

	[SerializeField]
	private Image _equipIcon;

	public int index;

	private StringBuilder sb = new StringBuilder();

	public Action OnCellSelected;

	public bool matDetailIsShow { get; set; }

	public BottleMaterialSlot slotData { get; private set; }

	public ActButton btn => _btn;

	public void Refresh(BottleMaterialSlot slot, int bottleId, int slotIndex, ImageAssetStation station)
	{
		slotData = slot;
		switch (slot.curState)
		{
		case SlotState.IsLock:
			LockStateDisPlay(bottleId, slotIndex);
			break;
		case SlotState.Empty:
			EmptyStateDisPlay();
			break;
		case SlotState.Filled:
		{
			BloodBottleMaterial bottleMatById = Model<BloodBottleModel>.Interface.GetBottleMatById(slot.matId);
			FilledStateDisPlay(bottleMatById, station);
			break;
		}
		}
		_btn.SetBtnClick(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Click");
			OnCellSelected?.Invoke();
		});
		_selected.SetActive(value: false);
	}

	private void LockStateDisPlay(int bottleId, int slotIndex)
	{
		fillRoot.SetActive(value: false);
		_lockOrEmptyRoot.SetActive(value: true);
		_lockAndEmptyStateDes.gameObject.SetActive(value: true);
		_lcokState.SetActive(value: true);
		_emptyState.SetActive(value: false);
		_matIcon.icon.transform.localScale = Vector3.zero;
		int unlockNextSlotLevel = Model<BloodBottleModel>.Interface.GetUnlockNextSlotLevel(bottleId, slotIndex);
		_TypeIcons.ForEach((GameObject x) =>
		{
			x.SetActive(value: false);
		});
		foreach (BottleMatType type in slotData.types)
		{
			_TypeIcons[(int)(type - 1)].SetActive(value: true);
		}
		_lockAndEmptyStateDes.StringReference.TableEntryReference = 2052L;
		_lockAndEmptyStateDes.StringReference.GetVariable<int>("0").Value = unlockNextSlotLevel;
	}

	public void EmptyStateDisPlay()
	{
		fillRoot.SetActive(value: false);
		_lockOrEmptyRoot.SetActive(value: true);
		_lockAndEmptyStateDes.gameObject.SetActive(value: true);
		_lcokState.SetActive(value: false);
		_emptyState.SetActive(value: true);
		_matIcon.icon.transform.localScale = Vector3.zero;
		_TypeIcons.ForEach((GameObject x) =>
		{
			x.SetActive(value: false);
		});
		foreach (BottleMatType type in slotData.types)
		{
			_TypeIcons[(int)(type - 1)].SetActive(value: true);
		}
		_lockAndEmptyStateDes.StringReference.TableEntryReference = 41000080L;
	}

	public void FilledStateDisPlay(BloodBottleMaterial matData, ImageAssetStation station)
	{
		if (matData != null)
		{
			fillRoot.SetActive(value: true);
			_lockOrEmptyRoot.SetActive(value: false);
			_matIcon.icon.transform.localScale = Vector3.one;
			station.LoadImage(157, matData.type, _typeIcon);
			ItemData data = CoreUtils.GetData(matData.id, RuntimeConfigs.data.itemDatas);
			station.LoadItemIcon(data.iconAddress, _matIcon);
			_matName.StringReference.TableEntryReference = data.nameLocal;
			_equipIcon.color = _matQualityColor[data.quality - 1];
			_matDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetBottleMatDesc(matData, isDetailDesc: false));
			if (_matDes != null)
			{
				_matDes.overflowMode = TextOverflowModes.Ellipsis;
				_matDes.maxVisibleLines = 2;
			}
		}
	}

	public void OnSelected()
	{
		_select.SetActive(value: true);
	}

	public void OnUnSelected()
	{
		_select.SetActive(value: false);
	}

	public void UpdateMatDetailDesOnShowPanel()
	{
		BloodBottleMaterial bottleMatById = Model<BloodBottleModel>.Interface.GetBottleMatById(slotData.matId);
		if (bottleMatById != null)
		{
			matDetailIsShow = !matDetailIsShow;
			matDetailDesRoot.SetActive(matDetailIsShow);
			if (matDetailIsShow)
			{
				_materialDetailDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetBottleMatDesc(bottleMatById, isDetailDesc: true));
			}
		}
	}
}
