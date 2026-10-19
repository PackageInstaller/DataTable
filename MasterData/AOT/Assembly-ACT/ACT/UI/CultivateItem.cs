using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CultivateItem : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler
{
	public BImage icon;

	public LocalizeStringEvent cultivateName;

	public CommonScrollBagComponent rewardBag;

	public ActButton confirmButton;

	public CommonCoinComponent power;

	public BetterAnimation animationComponent;

	public GameObject doubleRewardRoot;

	public LocalizeStringEvent doubleRewardText;

	public GameObject btnPrompt_leftStick;

	public GameObject lockStyle;

	public ActButton lockButton;

	public Action<CultivateItem> OnSelectItem;

	private int _raidEntranceID;

	private RaidEntranceData _raidEntranceData;

	private List<ItemUnifierProxy> _rewards;

	private string _templateName;

	public int RaidEntranceID
	{
		get
		{
			return _raidEntranceID;
		}
		set
		{
			_raidEntranceID = value;
			RefreshGameObjectName();
			_raidEntranceData = CoreUtils.GetData(value, RuntimeConfigs.data.raidEntranceDatas);
			if (_rewards == null)
			{
				_rewards = ListPool<ItemUnifierProxy>.Get();
			}
			UpdateStyle();
			RefreshLockStyle();
		}
	}

	private void RefreshGameObjectName()
	{
		if (string.IsNullOrEmpty(_templateName))
		{
			_templateName = name.Replace("(Clone)", string.Empty);
		}
		name = $"{_templateName}_{_raidEntranceID}";
	}

	private void UpdateStyle()
	{
		if (_raidEntranceData == null)
		{
			return;
		}
		Station.LoadImageAsync(166, _raidEntranceID, icon).Forget();
		cultivateName.SetTable("shortcommon");
		cultivateName.StringReference.TableEntryReference = _raidEntranceData.entranceName;
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		foreach (ItemKv item2 in _raidEntranceData.rewardItemShow)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
			_rewards.Add(item);
		}
		rewardBag.ItemSource = _rewards;
		rewardBag.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
		btnPrompt_leftStick.gameObject.SetActive(_rewards.Count > 0);
		ItemKv itemKv = _raidEntranceData.cost.FirstOrDefault();
		if (itemKv != null)
		{
			power.AttributeMode = AttributeMode.CustomAttribute;
			power.customId = itemKv.id;
			power.Init(itemKv.count);
		}
		RefreshDoubleRewardTag();
	}

	private void RefreshDoubleRewardTag()
	{
		doubleRewardRoot.SetActive(value: false);
		bool activityIsOpening = Model<ActivityCenterModel>.Interface.GetActivityIsOpening(Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId());
		List<int> raidTypeList = Model<ActivityCenterModel>.Interface.GetRaidTypeList(Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId());
		if (raidTypeList != null && raidTypeList.Count > 0)
		{
			int raidTypeByEntranceId = Model<RaidModel>.Interface.GetRaidTypeByEntranceId(_raidEntranceID);
			bool flag = raidTypeList.Contains(raidTypeByEntranceId);
			doubleRewardRoot.SetActive(activityIsOpening & flag);
			doubleRewardText.SetTable("shortcommon");
		}
	}

	private void Awake()
	{
		confirmButton.SetBtnClick(OnClick);
		lockButton?.SetBtnClick(OnLockClick);
	}

	private void RefreshLockStyle()
	{
		bool flag = _raidEntranceData != null && (_raidEntranceData.unlockCondition <= 0 || Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(_raidEntranceData.unlockCondition));
		confirmButton?.gameObject.SetActive(flag);
		lockStyle?.SetActive(!flag);
		lockButton?.gameObject.SetActive(!flag);
	}

	private void OnLockClick()
	{
		RaidEntranceData raidEntranceData = _raidEntranceData;
		if (raidEntranceData == null || raidEntranceData.unlockCondition <= 0)
		{
			return;
		}
		int unlockCondition = _raidEntranceData.unlockCondition;
		if (RuntimeConfigs.data.missionGroups.TryGetValue(unlockCondition, out var value))
		{
			int[] missionId = value.missionId;
			if (missionId != null && missionId.Length > 0 && RuntimeConfigs.data.missions.TryGetValue(value.missionId[0], out var value2))
			{
				GameUtility.OpenToolTip(CustomTagParser.ReplacePreconditionText(value2, value2.number, value2.param));
			}
		}
	}

	private void OnClick()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
		{
			RaidEntranceId = _raidEntranceID
		});
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.HandBookEnterRaidView);
	}

	public void PlayAnimation(float delay = 0f)
	{
		animationComponent?.GetSequence("Show")?.Goto(0f).SetDelay(delay).Play();
	}

	public void OnSelect(BaseEventData eventData)
	{
		OnSelectItem?.Invoke(this);
	}
}
