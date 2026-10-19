using System;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Serializable]
public sealed class OneTreatTierRowBinding
{
	[SerializeField]
	private GameObject root;

	[SerializeField]
	private string tier;

	[SerializeField]
	private TMP_Text tierText;

	[SerializeField]
	private TMP_Text rewardText;

	[SerializeField]
	private TMP_Text countText;

	[SerializeField]
	private Image iconImage;

	[SerializeField]
	private ActButton iconButton;

	[SerializeField]
	private Selectable selectionTarget;

	private BImage _iconBImage;

	private BImage _tierRewardBImage;

	private Image _tierRewardImage;

	private Action<OneTreatPrizeInfo> _onIconClick;

	private OneTreatPrizeInfo _prize;

	public string Tier => tier;

	public Selectable SelectionTarget => selectionTarget;

	public void Bind(Action<OneTreatPrizeInfo> onIconClick)
	{
		_onIconClick = onIconClick;
		if (iconImage != null)
		{
			iconImage.preserveAspect = true;
			_iconBImage = new BImage
			{
				icon = iconImage
			};
		}
		_tierRewardImage = OneTreatPrizeViewUtility.FindChildImage(root, "imgTierIcon");
		_tierRewardBImage = OneTreatPrizeViewUtility.CreateImageTarget(_tierRewardImage);
		iconButton?.SetBtnClick(OnIconClick);
	}

	public void Refresh(OneTreatPrizeInfo prize, int tierSlotCount, ImageAssetStation station)
	{
		_prize = prize;
		SetActive(prize != null);
		if (prize == null)
		{
			if (iconButton != null)
			{
				iconButton.Interactable(active: false);
			}
			return;
		}
		if (iconButton != null)
		{
			iconButton.Interactable(prize.RewardId > 0);
		}
		if (tierText != null)
		{
			tierText.text = prize.Tier;
		}
		if (rewardText != null)
		{
			rewardText.text = prize.RewardName;
		}
		if (countText != null)
		{
			countText.SetText("x{0:0}", Mathf.Max(1, tierSlotCount));
		}
		RefreshIcon(prize, station);
		RefreshTierRewardIcon(prize, station);
	}

	private void OnIconClick()
	{
		_onIconClick?.Invoke(_prize);
	}

	private void RefreshIcon(OneTreatPrizeInfo prize, ImageAssetStation station)
	{
		if (!(iconImage == null))
		{
			if (station == null || _iconBImage == null || prize.RewardId <= 0 || !RuntimeConfigs.data.itemDatas.TryGetValue(prize.RewardId, out var value))
			{
				iconImage.sprite = null;
			}
			else
			{
				station.LoadItemIcon(value.iconAddress, _iconBImage);
			}
		}
	}

	private void RefreshTierRewardIcon(OneTreatPrizeInfo prize, ImageAssetStation station)
	{
		if (!(_tierRewardImage == null))
		{
			if (station == null || _tierRewardBImage == null || prize.RewardId <= 0 || RuntimeConfigs.data == null || RuntimeConfigs.data.itemDatas == null || !RuntimeConfigs.data.itemDatas.TryGetValue(prize.RewardId, out var value))
			{
				_tierRewardImage.sprite = null;
			}
			else
			{
				station.LoadItemIcon(value.iconAddress, _tierRewardBImage);
			}
		}
	}

	private void SetActive(bool active)
	{
		OneTreatPrizeViewUtility.SetActiveIfChanged(root, active);
	}
}
