using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TopAchievementGroupCell : MonoBehaviour
{
	[SerializeField]
	private BImage bg;

	[SerializeField]
	private TextMeshProUGUI _achievementGroupText;

	[SerializeField]
	private TextMeshProUGUI _achievementGroupProcessText;

	[SerializeField]
	private ActButton _btnReward;

	[SerializeField]
	private TextMeshProUGUI _benStateText;

	[SerializeField]
	private Image slider;

	[SerializeField]
	private LiteItemUIComponent _itemUIComponent;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptX;

	[SerializeField]
	private GamePadSelectComponent _gamePadSelect;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptPressLeftStick;

	private const string InProgressText = "进行中";

	private const string ClaimedText = "已领取";

	private const string HiddenAchievementText = "？？？";

	private int _groupId;

	private bool _gamepadInputInited;

	public bool IsRewardItemHighlighted
	{
		get
		{
			if (_itemUIComponent != null)
			{
				return _itemUIComponent.IsHighLight;
			}
			return false;
		}
	}

	public void Init(int groupId, ImageAssetStation station)
	{
		_groupId = groupId;
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel == null || !RuntimeConfigs.data.achievementGroups.TryGetValue(groupId, out var value))
		{
			return;
		}
		float groupMilestonePercentValue = accomplishmentModel.GetGroupMilestonePercentValue(groupId);
		if (_achievementGroupText != null)
		{
			_achievementGroupText.SetText(accomplishmentModel.HasRevealedContentName(groupId) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.groupName) : "？？？");
		}
		string groupMilestonePercent = accomplishmentModel.GetGroupMilestonePercent(groupId);
		if (_achievementGroupProcessText != null)
		{
			_achievementGroupProcessText.text = groupMilestonePercent;
		}
		if (slider != null)
		{
			slider.fillAmount = Mathf.Clamp01(groupMilestonePercentValue / 100f);
		}
		if (bg != null)
		{
			int backgroundIcon = value.backgroundIcon;
			if (backgroundIcon > 0)
			{
				station.LoadImage(202, backgroundIcon, bg);
			}
		}
		BindRewardItem(accomplishmentModel);
		RefreshRewardState(accomplishmentModel);
		RefreshGamepadInputState(GetComponentInParent<MonoAccomplishmentDetailsView>());
	}

	private void BindRewardItem(AccomplishmentModel model)
	{
		if (_itemUIComponent == null)
		{
			return;
		}
		if (!model.TryGetGroupMilestoneCollectionId(_groupId, out var collectionId) || collectionId.Length == 0)
		{
			_itemUIComponent.gameObject.SetActive(value: false);
			return;
		}
		if (RuntimeConfigs.data.collections.TryGetValue(collectionId[0], out var value))
		{
			List<ItemKv> certain = value.certain;
			if (certain != null && certain.Count > 0)
			{
				ItemKv itemKv = value.certain[0];
				_itemUIComponent.gameObject.SetActive(value: true);
				_itemUIComponent.IsComplete = model.IsGroupMilestoneTaken(_groupId);
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
				_itemUIComponent.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				_itemUIComponent.UpdatePerformance();
				_itemUIComponent.showDetailPanel = true;
				return;
			}
		}
		_itemUIComponent.gameObject.SetActive(value: false);
	}

	private void RefreshRewardState(AccomplishmentModel model)
	{
		bool flag = model.IsGroupMilestoneClaimable(_groupId);
		bool flag2 = model.IsGroupMilestoneTaken(_groupId);
		if (_btnReward != null)
		{
			_btnReward.gameObject.SetActive(flag);
			_btnReward.SetBtnClick(() =>
			{
				model.ClaimCurrentGroupRewardAsync(_groupId).Forget();
				RefreshRewardState(model);
			});
		}
		if (_benStateText != null)
		{
			_benStateText.text = (flag2 ? "已领取" : "进行中");
		}
		_benStateText.gameObject.SetActive(!flag);
		if (_itemUIComponent != null && _itemUIComponent.gameObject.activeSelf)
		{
			_itemUIComponent.IsComplete = flag2;
		}
	}

	public void RefreshGamepadInputState(MonoAccomplishmentDetailsView view)
	{
		InitGamepadInput();
		bool num = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType? accomplishmentDetailsViewControllerType = view?.GetController()?.ControllerType;
		bool flag = num && gameObject.activeInHierarchy && accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup;
		bool flag2 = num && gameObject.activeInHierarchy && accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem;
		bool visible = num && gameObject.activeInHierarchy && accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList;
		_gamePadSelect?.SetSelectState(flag);
		SetPromptVisible(operateBtnPromptX, visible);
		SetPromptVisible(operateBtnPromptPressLeftStick, (flag | flag2) && HasRewardItem());
	}

	public void SelectRewardItem()
	{
		if (HasRewardItem())
		{
			_itemUIComponent.IsHighLight = true;
		}
	}

	public void ClearRewardItemSelection()
	{
		if (!(_itemUIComponent == null))
		{
			_itemUIComponent.IsHighLight = false;
			if (EventSystemHelper.Available && EventSystemHelper.CurrentSelected == _itemUIComponent.gameObject)
			{
				EventSystemHelper.SetSelectedGameObject(null);
			}
		}
	}

	public bool OpenRewardItemDetail()
	{
		if (!HasRewardItem())
		{
			return false;
		}
		ExecuteEvents.Execute(_itemUIComponent.gameObject, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
		return true;
	}

	private void InitGamepadInput()
	{
		if (!_gamepadInputInited)
		{
			_gamepadInputInited = true;
			ConfigurePrompt(operateBtnPromptX, "UI/UISpecial2", 0);
			ConfigurePrompt(operateBtnPromptPressLeftStick, "UI/SelectItemCell", 0);
		}
	}

	private bool HasRewardItem()
	{
		if (_itemUIComponent != null)
		{
			return _itemUIComponent.gameObject.activeSelf;
		}
		return false;
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
			prompt.SetVisible(vis: false);
			prompt.RefreshIcon();
		}
	}

	private static void SetPromptVisible(OperateBtnPrompt prompt, bool visible)
	{
		if (!(prompt == null))
		{
			prompt.SetVisible(visible);
			if (visible)
			{
				prompt.RefreshIcon();
			}
		}
	}
}
