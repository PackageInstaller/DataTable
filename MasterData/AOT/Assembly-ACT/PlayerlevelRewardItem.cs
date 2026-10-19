using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

public class PlayerlevelRewardItem : MonoBehaviour
{
	public GameObject itemCell;

	public Transform rewardRoot;

	public ActButton disable_Rewared_Btn;

	public LocalizeStringEvent disbaleBtnText;

	public ActButton active_Rewared_Btn;

	public TextMeshProUGUI levelText;

	public TextMeshProUGUI disableLevelText;

	public CanvasGroup canRewardBoard;

	public GameObject icon_Lock;

	public GameObject mask;

	public RedDotItem redDot;

	public BetterAnimation anim;

	public GameObject gamepadSelect;

	public GameObject selectCellPropmt;

	public GameObject receivePropmt;

	private ActivityCenterData _playerLevelInfo;

	private string _redDotPath;

	private List<LiteItemUIComponent> lits;

	private Action receiveAction;

	private int selectItemIndex;

	private ActivityPlayerLevel _activityPlayerLevel;

	private int _groupDetailId;

	private ImageAssetStation _station;

	public bool isCanRewaed { get; private set; }

	public bool isUnLock { get; private set; }

	public void Init(ActivityPlayerLevel activityPlayerLevel, int groupDetailId, ImageAssetStation Station)
	{
		_activityPlayerLevel = activityPlayerLevel;
		_groupDetailId = groupDetailId;
		_station = Station;
		_playerLevelInfo = Model<ActivityCenterModel>.Interface.PlayerLevelActivityInfo;
		ActivityChallengeGroup data = CoreUtils.GetData(groupDetailId, RuntimeConfigs.data.activityChallengeGroups);
		if (data == null)
		{
			return;
		}
		ActivityChallengeData data2 = CoreUtils.GetData(data.challengeId[0], RuntimeConfigs.data.activityChallengeDatas);
		levelText.SetText(data2.challengeConditionParm[0].FastToString());
		disableLevelText.SetText(data2.challengeConditionParm[0].FastToString());
		List<ItemKv> certain = CoreUtils.GetData(data2.challengeReward[0], RuntimeConfigs.data.collections).certain;
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		bool flag = Model<ActivityCenterModel>.Interface.CheckGotReward(data2.id);
		if (rewardRoot.childCount == 0)
		{
			lits = new List<LiteItemUIComponent>();
			for (int i = 0; i < certain.Count; i++)
			{
				LiteItemUIComponent component = UnityEngine.Object.Instantiate(itemCell, rewardRoot).GetComponent<LiteItemUIComponent>();
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(certain[i].id, certain[i].count);
				list.Add(item);
				component.Station = Station;
				component.SetData(item, long.MinValue, flag ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				component.UpdatePerformance();
				component.gameObject.SetActive(value: true);
				lits.Add(component);
			}
		}
		else
		{
			for (int j = 0; j < certain.Count; j++)
			{
				ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(certain[j].id, certain[j].count);
				lits[j].SetData(item2, long.MinValue, flag ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				lits[j].UpdatePerformance();
			}
		}
		_redDotPath = RedDotPathDefine.Activity_PlayerLevel + $"|{data2.id}";
		if (rewardRoot != null)
		{
			redDot.fullPath = _redDotPath.Split("|").ToList();
			redDot.displayAction = new ActivityPlayerLevelRewardItem
			{
				activityChallengeId = data2.id
			};
			redDot.BindTrieNode();
			redDot.UpdateDisplay();
		}
		CanvasGroup component2 = active_Rewared_Btn.gameObject.GetComponent<CanvasGroup>();
		if (Model<ActivityCenterModel>.Interface.CheckPlayerLevel(data2) && !flag)
		{
			isCanRewaed = true;
			isUnLock = true;
			if (component2 != null)
			{
				component2.interactable = true;
				component2.alpha = 1f;
				canRewardBoard.alpha = 1f;
			}
			receiveAction = () =>
			{
				Model<ActivityCenterModel>.Interface.SendRewardGained(_playerLevelInfo.ActivityId, 0, 0, (ActivityGetLevelRewardAck activityGetLevelRewardAck) =>
				{
					GameUtility.OpenPopReward(activityGetLevelRewardAck.GotItems);
					_activityPlayerLevel.OnReceiveItemReward();
					ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
					evt.activityId = Model<ActivityCenterModel>.Interface.OpenActivityID;
					evt.status = 3;
					evt.challengeId = 0;
					evt.challengeGroupId = 0;
					evt.isPopup = false;
					EventTrackSolver.Instance.Dispatch(evt);
				});
			};
			active_Rewared_Btn.SetBtnClick(() =>
			{
				receiveAction();
			}, "event:/UI/Interface/Activity/Level/Claim");
		}
		else if (flag)
		{
			component2.alpha = 0f;
			component2.interactable = false;
			disable_Rewared_Btn.Interactable(active: false);
			disbaleBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.HasRewarded;
			TextMeshProUGUI component3 = disbaleBtnText.gameObject.GetComponent<TextMeshProUGUI>();
			if (component3 != null)
			{
				ColorUtility.TryParseHtmlString("#303030", out var color);
				component3.color = color;
			}
			canRewardBoard.alpha = 0f;
			icon_Lock.SetActive(value: false);
			mask.SetActive(value: true);
			isCanRewaed = false;
			isUnLock = true;
		}
		else
		{
			component2.alpha = 0f;
			component2.interactable = false;
			disbaleBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.WaitGainReward;
			isCanRewaed = false;
			isUnLock = false;
		}
	}

	public void Refresh()
	{
		Init(_activityPlayerLevel, _groupDetailId, _station);
	}

	public void ReceiveReward()
	{
		receiveAction();
	}

	public void PlayAnim(string animName)
	{
		anim?.GetSequence(animName).Play();
	}

	public void SetGamepadSelect(bool value)
	{
		gamepadSelect.SetActive(value);
		selectCellPropmt.SetActive(value);
		receivePropmt.SetActive(value && isCanRewaed);
	}

	public void Left()
	{
		if (selectItemIndex > 0)
		{
			lits[selectItemIndex].SetIsOn(val: false);
			lits[selectItemIndex].SetHighLightVisualOnly(value: false);
			selectItemIndex--;
			lits[selectItemIndex].SetIsOn(val: true);
			lits[selectItemIndex].SetHighLightVisualOnly(value: true);
		}
	}

	public void Right()
	{
		if (selectItemIndex < lits.Count - 1)
		{
			lits[selectItemIndex].SetIsOn(val: false);
			lits[selectItemIndex].SetHighLightVisualOnly(value: false);
			selectItemIndex++;
			lits[selectItemIndex].SetIsOn(val: true);
			lits[selectItemIndex].SetHighLightVisualOnly(value: true);
		}
	}

	public void SelectItem(bool active)
	{
		if (!active)
		{
			for (int i = 0; i < lits.Count; i++)
			{
				lits[i].SetIsOn(val: false);
			}
		}
		else
		{
			selectItemIndex = 0;
			lits[selectItemIndex].SetIsOn(val: true);
			lits[selectItemIndex].SetHighLightVisualOnly(value: true);
		}
	}

	public void OpenItemDetail()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = lits[selectItemIndex].ItemUnifier.Id,
			Count = (int)lits[selectItemIndex].ItemUnifier.Count
		});
	}
}
