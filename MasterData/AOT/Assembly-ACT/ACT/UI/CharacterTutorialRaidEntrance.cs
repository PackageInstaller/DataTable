using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterTutorialRaidEntrance : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	[SerializeReference]
	private BImage raidIcon;

	[SerializeReference]
	private LocalizeStringEvent raidNameLocalize;

	[SerializeReference]
	private ActButton enterBtn;

	[SerializeReference]
	private GameObject raidIsFinish;

	[SerializeReference]
	private ScrollRect rewardScrollRect;

	[SerializeReference]
	private GameObject rewardPrefab;

	private CharacterTutorialEntranceBaseView _view;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string ShowAnimation = "Show";

	private const string HideAnimation = "Hide";

	private CharacterTutorialRaidInfo _raidInfo;

	private static readonly ObjectPool<Stack<ItemUIComponentBase>> s_RewardItemPool = new ObjectPool<Stack<ItemUIComponentBase>>(null, (Stack<ItemUIComponentBase> rewardItems) =>
	{
		rewardItems.Clear();
	});

	private Stack<ItemUIComponentBase> _rewardItemPool;

	private bool _gamepadPromptInited;

	[SerializeField]
	private OperateBtnPrompt _operateBtnPromptSelectItem;

	[SerializeField]
	private OperateBtnPrompt _operateBtnPromptA;

	public void GotoShow()
	{
		if (_betterAnimation != null)
		{
			_betterAnimation.GetSequence("Show").Goto(0f);
		}
	}

	public void PlayAnimation()
	{
		if (_betterAnimation != null)
		{
			_betterAnimation.GetSequence("Show").Play();
		}
	}

	public void InitData(CharacterTutorialRaidInfo raidInfo)
	{
		_view = gameObject.GetComponentInParent<CharacterTutorialEntranceBaseView>();
		Init(raidInfo, _view.Station);
	}

	public void Init(CharacterTutorialRaidInfo raidInfo, ImageAssetStation station)
	{
		_raidInfo = raidInfo;
		gameObject.SetActive(value: true);
		InitGamepadPrompts();
		ClearRewardItems();
		station.LoadImage(raidInfo.RaidImageData.GroupId, raidInfo.RaidImageData.ImageId, raidIcon);
		raidNameLocalize.SetReference(raidInfo.RaidNameLocalizedStringData);
		enterBtn.SetBtnClick(OnClickEnterBtn);
		bool flag = false;
		ACT.Game.Data.Raid raidInfo2 = Model<RaidModel>.Interface.GetRaidInfo(raidInfo.RaidId);
		if (raidInfo2 != null)
		{
			flag = raidInfo2.CleanNum > 0;
		}
		raidIsFinish.SetActive(flag);
		foreach (ItemKv item2 in raidInfo.Reward)
		{
			ItemUIComponentBase rewardItem = GetRewardItem();
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
			rewardItem.SetData(item, long.MinValue, flag ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.Hide, autoReleaseData: true);
			rewardItem.UpdatePerformance();
			rewardItem.gameObject.SetActive(value: true);
		}
	}

	public bool TryGetRewardLayer(out ViewControlLayer rewardLayer)
	{
		rewardLayer = null;
		if (!HasRewardItems() || rewardScrollRect == null || rewardScrollRect.content == null)
		{
			return false;
		}
		rewardLayer = rewardScrollRect.content.GetComponent<ViewControlLayer>();
		return rewardLayer != null;
	}

	public void EnterRaidByGamepad()
	{
		if (_raidInfo != null)
		{
			OnClickEnterBtn();
		}
	}

	private ItemUIComponentBase GetRewardItem()
	{
		if (_rewardItemPool == null)
		{
			_rewardItemPool = s_RewardItemPool.Get();
		}
		ItemUIComponentBase itemUIComponentBase = ((_rewardItemPool.Count > 0) ? _rewardItemPool.Pop() : Object.Instantiate(rewardPrefab, rewardScrollRect.content).GetComponent<ItemUIComponentBase>());
		itemUIComponentBase.transform.SetParent(rewardScrollRect.content, worldPositionStays: false);
		return itemUIComponentBase;
	}

	private void ClearRewardItems()
	{
		if (_rewardItemPool == null)
		{
			_rewardItemPool = s_RewardItemPool.Get();
		}
		RectTransform content = rewardScrollRect.content;
		for (int num = content.childCount - 1; num >= 0; num--)
		{
			Transform child = content.GetChild(num);
			if (!(child.gameObject == rewardPrefab) && child.TryGetComponent<ItemUIComponentBase>(out var component))
			{
				component.Release();
				child.SetParent(content.parent, worldPositionStays: false);
				child.gameObject.SetActive(value: false);
				_rewardItemPool.Push(component);
			}
		}
	}

	protected override void OnUnityDestroy()
	{
		ClearRewardItems();
		if (_rewardItemPool != null)
		{
			s_RewardItemPool.Release(_rewardItemPool);
			_rewardItemPool = null;
		}
		base.OnUnityDestroy();
	}

	private void OnClickEnterBtn()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Play");
		MonoECS.instance.SyncGameInfos();
		TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(_raidInfo.RaidId);
		G.service.RaidEnterInfo(_raidInfo.RaidId, raidTrialTeamUsage, async (bool r) =>
		{
			if (r)
			{
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
			}
		});
	}

	public void OnSelect(BaseEventData eventData)
	{
		RefreshGamepadPrompts();
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetGamepadPromptsVisible(visible: false);
	}

	private bool HasRewardItems()
	{
		if (_raidInfo != null && _raidInfo.Reward != null)
		{
			return _raidInfo.Reward.Count > 0;
		}
		return false;
	}

	private void InitGamepadPrompts()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			ConfigurePrompt(_operateBtnPromptA, "UI/Confirm");
			ConfigurePrompt(_operateBtnPromptSelectItem, "UI/SelectItemCell");
		}
	}

	private void RefreshGamepadPrompts()
	{
		InitGamepadPrompts();
		MonoHandbookView componentInParent = GetComponentInParent<MonoHandbookView>();
		bool flag = componentInParent != null && componentInParent.GetCurSubControllerType() == HandBookSubController.characterTeamTutorialContent && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		SetPromptVisible(_operateBtnPromptA, flag);
		SetPromptVisible(_operateBtnPromptSelectItem, flag && HasRewardItems());
	}

	private void SetGamepadPromptsVisible(bool visible)
	{
		SetPromptVisible(_operateBtnPromptA, visible);
		SetPromptVisible(_operateBtnPromptSelectItem, visible);
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetVisible(vis: false);
			prompt.RefreshIcon();
		}
	}

	private static void SetPromptVisible(OperateBtnPrompt prompt, bool visible)
	{
		if (!(prompt == null))
		{
			prompt.SetVisible(visible);
		}
	}
}
