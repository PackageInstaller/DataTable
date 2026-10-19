using System;
using ACT.Core;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Serializable]
public sealed class OneTreatPrizeSlotBinding
{
	[SerializeField]
	private GameObject root;

	[SerializeField]
	private string tier;

	[SerializeField]
	private int slotIndex;

	[SerializeField]
	private bool isFinalReward;

	[SerializeField]
	private TMP_Text tierText;

	[SerializeField]
	private TMP_Text rewardText;

	[SerializeField]
	private TMP_Text slotNumberText;

	[SerializeField]
	private TMP_Text countText;

	[SerializeField]
	private TMP_Text stampText;

	[SerializeField]
	private GameObject stampRoot;

	[SerializeField]
	private Image iconImage;

	[SerializeField]
	private ActButton iconButton;

	[SerializeField]
	private Image ticketBody;

	[SerializeField]
	private Selectable selectionTarget;

	private BImage _iconBImage;

	private BImage _tierIconBImage;

	private Image _tierIconImage;

	private Action<OneTreatPrizeInfo> _onIconClick;

	private OneTreatPrizeInfo _prize;

	public string Tier => tier;

	public int SlotIndex => slotIndex;

	public bool IsFinalReward => isFinalReward;

	public void Bind(Action<OneTreatPrizeInfo> onIconClick)
	{
		_onIconClick = onIconClick;
		if (!isFinalReward && iconImage != null)
		{
			iconImage.preserveAspect = true;
			_iconBImage = new BImage
			{
				icon = iconImage
			};
		}
		_tierIconImage = OneTreatPrizeViewUtility.FindChildImage(root, "img_tier");
		_tierIconBImage = OneTreatPrizeViewUtility.CreateImageTarget(_tierIconImage);
		iconButton?.SetBtnClick(OnIconClick);
	}

	public void Refresh(OneTreatPrizeInfo prize, bool claimed, ImageAssetStation station)
	{
		_prize = prize;
		if (prize == null)
		{
			SetTierIconActive(active: false);
			if (iconButton != null)
			{
				iconButton.Interactable(active: false);
			}
			SetActive(active: false);
			return;
		}
		SetActive(active: true);
		if (iconButton != null)
		{
			iconButton.Interactable(prize.RewardId > 0);
		}
		if (tierText != null)
		{
			tierText.text = prize.Tier;
			OneTreatPrizeViewUtility.SetActiveIfChanged(tierText.gameObject, _tierIconImage == null);
		}
		if (rewardText != null)
		{
			rewardText.text = prize.RewardName;
		}
		if (slotNumberText != null)
		{
			if (prize.IsFinalReward)
			{
				slotNumberText.SetText(string.Empty);
			}
			else
			{
				slotNumberText.SetText("{0:00}", prize.TierIndex + 1);
			}
		}
		if (countText != null)
		{
			if (prize.IsFinalReward)
			{
				countText.SetText(string.Empty);
			}
			else
			{
				countText.SetText("x{0:0}", Mathf.Max(1, prize.RewardCount));
			}
		}
		if (stampText != null)
		{
			stampText.text = "兑";
		}
		OneTreatPrizeViewUtility.SetActiveIfChanged(stampRoot, claimed);
		RefreshIcon(prize, station);
		RefreshTierIcon(prize.Tier, station);
	}

	private void OnIconClick()
	{
		_onIconClick?.Invoke(_prize);
	}

	private void RefreshIcon(OneTreatPrizeInfo prize, ImageAssetStation station)
	{
		if (!isFinalReward && !(iconImage == null))
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

	private void RefreshTierIcon(string prizeTier, ImageAssetStation station)
	{
		if (!(_tierIconImage == null))
		{
			bool flag = OneTreatPrizeViewUtility.LoadTierIcon(prizeTier, station, _tierIconBImage);
			SetTierIconActive(flag);
			if (tierText != null)
			{
				OneTreatPrizeViewUtility.SetActiveIfChanged(tierText.gameObject, !flag);
			}
		}
	}

	private void SetTierIconActive(bool active)
	{
		OneTreatPrizeViewUtility.SetActiveIfChanged((_tierIconImage == null) ? null : _tierIconImage.gameObject, active);
	}

	public void SetActive(bool active)
	{
		OneTreatPrizeViewUtility.SetActiveIfChanged(root, active);
	}

	public void SetSelected(bool selected)
	{
		if (root == null)
		{
			return;
		}
		if (ticketBody != null)
		{
			ticketBody.transform.localScale = (selected ? (Vector3.one * 1.04f) : Vector3.one);
		}
		if (selected)
		{
			GameObject gameObject = ((selectionTarget != null) ? selectionTarget.gameObject : root);
			if (gameObject.activeInHierarchy)
			{
				EventSystemHelper.SetSelectedGameObject(gameObject);
			}
			else
			{
				EventSystemHelper.SetSelectedGameObject(root);
			}
		}
	}
}
