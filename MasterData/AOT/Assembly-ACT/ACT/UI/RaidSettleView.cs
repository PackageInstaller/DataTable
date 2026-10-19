using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RaidSettleView : BaseUIView
{
	public GameObject TargetParent;

	public GameObject Target1;

	public TextMeshProUGUI Time;

	public GameObject Target2;

	public GameObject GoldIcon;

	public GameObject ExpIcon;

	public TextMeshProUGUI Count;

	public GameObject Rewards;

	public CommonScrollBagComponent CommonScrollBagComponent;

	public GameObject PowerObj;

	public TextMeshProUGUI PowerCost;

	public GameObject timesTotal;

	public TextMeshProUGUI timesTotalText;

	public TextMeshProUGUI timesLeftText;

	public Color extraEnoughNormal;

	public Color extraNotEnoughNormal;

	private RaidSettleViewData raidSettleViewData;

	private RaidTypeData _raidTypeData;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
	}

	protected override void Init()
	{
		base.Init();
		raidSettleViewData = uiViewData as RaidSettleViewData;
		ACT.Config.Raid raid = RuntimeConfigs.data.raids[Model<RaidModel>.Interface.CurrentRaidId];
		RuntimeConfigs.data.raidParkourDatas.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
		TargetParent.SetActive(value: true);
		Target1.SetActive(value: true);
		int num = (int)Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
		int num2 = num / 60;
		int num3 = num - num2 * 60;
		Time.SetText("{0:00}:{1:00}", num2, num3);
		Target2.SetActive(value: false);
		if (raid.mainTarget.Length != 0 && value != null)
		{
			for (int i = 0; i < raid.mainTarget.Length; i++)
			{
				int key = raid.mainTarget[i];
				RaidMissionTarget raidMissionTarget = RuntimeConfigs.data.raidMissionTargets[key];
				if (raidMissionTarget.targetType == 1)
				{
					Target2.SetActive(value: true);
					int stateWorldAssetInStateNumberByTag = MonoECS.instance.ruleManager.GetStateWorldAssetInStateNumberByTag(ServiceSaveTag.RaidCollection, 1);
					int total = value.total;
					Count.SetText("{0:0}/{1:0}", stateWorldAssetInStateNumberByTag, total);
					GoldIcon.SetActive(raidMissionTarget.targetIcon == 1);
					ExpIcon.SetActive(raidMissionTarget.targetIcon != 1);
					break;
				}
			}
		}
		if (raidSettleViewData == null || raidSettleViewData.scrollBagParam.allItems.items.Count <= 0)
		{
			Rewards.SetActive(value: false);
		}
		else
		{
			Rewards.SetActive(value: true);
			List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
			ItemUnifierProxy.ItemUnifierPool.GetList(raidSettleViewData.scrollBagParam.allItems.items, list);
			CommonScrollBagComponent.ItemSource = list;
			CommonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		}
		_raidTypeData = GetRaidTypeByRaidId(Model<RaidModel>.Interface.CurrentRaidId);
		if (_raidTypeData != null)
		{
			if (_raidTypeData.cost != null && _raidTypeData.cost.Count > 0)
			{
				PowerObj.SetActive(value: true);
				PowerCost.SetText("{0:0}", Model<RaidModel>.Interface.PowerCost);
				PowerCost.color = ((Model<PowerModel>.Interface.PowerCount >= Model<RaidModel>.Interface.PowerCost) ? extraEnoughNormal : extraNotEnoughNormal);
			}
			else
			{
				PowerObj.SetActive(value: false);
			}
			if (_raidTypeData.cycleType == 2)
			{
				int leftTimesByTypeId = GetLeftTimesByTypeId(_raidTypeData.id);
				timesLeftText.color = ((leftTimesByTypeId > 0) ? extraEnoughNormal : extraNotEnoughNormal);
				timesLeftText.SetText("{0:0}", leftTimesByTypeId);
				timesTotalText.SetText("{0:0}", _raidTypeData.cycleParm[1]);
				timesTotal.SetActive(value: true);
			}
			else
			{
				timesTotal.SetActive(value: false);
			}
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	private int GetUsedTimesByEnteranceId(int entranceId)
	{
		RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[entranceId];
		int num = 0;
		int[] raidId = raidEntranceData.raidId;
		foreach (int raidId2 in raidId)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId2);
			if (raidInfo != null)
			{
				num += raidInfo.TakeRewardCount;
			}
		}
		return num;
	}

	private int GetLeftTimesByTypeId(int typeId)
	{
		int num = 0;
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[typeId];
		int num2 = 0;
		int[] raidEntranceId = raidTypeData.raidEntranceId;
		foreach (int entranceId in raidEntranceId)
		{
			num2 += GetUsedTimesByEnteranceId(entranceId);
		}
		num = raidTypeData.cycleParm[1] - num2;
		return Mathf.Max(0, num);
	}

	private RaidTypeData GetRaidTypeByRaidId(int raidId)
	{
		int value = -1;
		foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData.Value.raidId.Contains(raidId))
			{
				value = raidEntranceData.Value.id;
				break;
			}
		}
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidTypeData.Value.raidEntranceId.Contains(value))
			{
				return raidTypeData.Value;
			}
		}
		return null;
	}

	private void OnPowerRefresh(BaseEventContent baseEventContent)
	{
		if (_raidTypeData != null)
		{
			if (_raidTypeData.cost != null && _raidTypeData.cost.Count > 0)
			{
				PowerObj.SetActive(value: true);
				PowerCost.SetText("{0:0}", Model<RaidModel>.Interface.PowerCost);
				PowerCost.color = ((Model<PowerModel>.Interface.PowerCount >= Model<RaidModel>.Interface.PowerCost) ? extraEnoughNormal : extraNotEnoughNormal);
			}
			else
			{
				PowerObj.SetActive(value: false);
			}
		}
	}

	public async void OnReopenRaid()
	{
		if (_raidTypeData != null)
		{
			if (_raidTypeData.cost != null && _raidTypeData.cost.Count > 0 && Model<PowerModel>.Interface.PowerCount < Model<RaidModel>.Interface.PowerCost)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
				return;
			}
			if (_raidTypeData.cycleType == 2 && GetLeftTimesByTypeId(_raidTypeData.id) <= 0)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELRAID, new TextPanelRaidView.TextPanelRaidParam
				{
					titleId = 483,
					commonId = 1609,
					OnConfirm = () =>
					{
						ReopenRaid();
					},
					CancelCommonId = 14,
					ConfirmCommonId = 13
				});
				return;
			}
		}
		ReopenRaid();
	}

	private async void ReopenRaid()
	{
		G.service.ReopenRaid((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.ReopenCurrentWorld().Forget();
				CloseAsync().Forget();
			}
		});
	}

	public async void OnLeaveRaid()
	{
		await CloseAsync();
		G.service.LeaveRaid(async (bool r) =>
		{
			if (r)
			{
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			}
		});
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}
}
