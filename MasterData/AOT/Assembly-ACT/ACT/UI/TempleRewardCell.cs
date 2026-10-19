using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleRewardCell : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	private InstanceDungeonStarReward m_Data;

	public Button getBtn;

	public GameObject got;

	public GameObject cantGet;

	public TextMeshProUGUI leftStarCount;

	public GameObject rewardCellPrefab;

	public Transform rewardCellParent;

	public TempleRewardView view;

	public GameObject gotDi;

	public GameObject canGetDi;

	public GameObject Select;

	public ViewControlLayer ViewControlLayer;

	public GameObject BtnPrompt_A;

	private TempleRewardView _templeRewardView;

	public override void Init(object param)
	{
		if (_templeRewardView == null)
		{
			_templeRewardView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_TEMPLEREWARD) as TempleRewardView;
		}
		m_Data = param as InstanceDungeonStarReward;
		leftStarCount.text = m_Data.stars.FastToString();
		InitRewards();
		UpdateRewardState();
		base.Init(param);
	}

	private void InitRewards()
	{
		Dictionary<int, bool> dictionary = Model<TempleModel>.Interface.areaRewardDatas[m_Data.area];
		bool flag = dictionary != null && dictionary.Count > 0 && Model<TempleModel>.Interface.areaRewardDatas[m_Data.area].ContainsKey(m_Data.stars) && Model<TempleModel>.Interface.areaRewardDatas[m_Data.area][m_Data.stars];
		int num = Mathf.Max(rewardCellParent.childCount, m_Data.reward.Count);
		for (int i = 0; i < num; i++)
		{
			ItemUIComponentBase itemUIComponentBase = null;
			if (i <= rewardCellParent.childCount - 1)
			{
				itemUIComponentBase = rewardCellParent.GetChild(i).GetComponent<ItemUIComponentBase>();
			}
			else
			{
				GameObject gameObject = Object.Instantiate(rewardCellPrefab, rewardCellParent);
				gameObject.SetActive(value: true);
				itemUIComponentBase = gameObject.GetComponent<ItemUIComponentBase>();
			}
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(m_Data.reward[i].id, m_Data.reward[i].count);
			itemUIComponentBase.Station = _templeRewardView?.Station;
			itemUIComponentBase.IsComplete = false;
			itemUIComponentBase.SetData(item, long.MinValue, flag ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			itemUIComponentBase.UpdatePerformance();
		}
	}

	private void RefreshReward()
	{
		foreach (Transform item in rewardCellParent)
		{
			ItemUIComponentBase component = item.GetComponent<ItemUIComponentBase>();
			if (!component.IsComplete)
			{
				component.IsComplete = true;
				component.UpdatePerformance();
			}
		}
	}

	private void UpdateRewardState()
	{
		if (!Model<TempleModel>.Interface.areaRewardDatas.TryGetValue(m_Data.area, out var value))
		{
			return;
		}
		int curAreaTempleStarCount = Model<TempleModel>.Interface.GetCurAreaTempleStarCount(m_Data.area);
		if (value.TryGetValue(m_Data.stars, out var value2))
		{
			getBtn.gameObject.SetActive(!value2);
			got.gameObject.SetActive(value2);
			gotDi.gameObject.SetActive(value2);
			canGetDi.gameObject.SetActive(!value2);
			if (cantGet.activeSelf)
			{
				cantGet.SetActive(value: false);
			}
			ColorUtility.TryParseHtmlString(value2 ? "#8D9091" : "#000000", out var color);
			leftStarCount.color = color;
		}
		else
		{
			gotDi.gameObject.SetActive(value: false);
			canGetDi.gameObject.SetActive(value: true);
			cantGet.SetActive(curAreaTempleStarCount < m_Data.stars);
			getBtn.gameObject.SetActive(curAreaTempleStarCount >= m_Data.stars);
			got.gameObject.SetActive(value: false);
			ColorUtility.TryParseHtmlString("#000000", out var color2);
			leftStarCount.color = color2;
		}
	}

	public void OnRewardBtn()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Reward/Reward_Click");
		G.service.SendGetTempleRewards(m_Data.area, m_Data.stars, (bool b, TempleTakeStarRewardAck ack) =>
		{
			if (b)
			{
				Model<TempleModel>.Interface.SetAreaRewardClaimed(m_Data.area, m_Data.stars);
				UpdateRewardState();
				RefreshReward();
				UpdateAreaRewardEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateAreaRewardEvt>();
				evt.AreaId = m_Data.area;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaRewardState, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				List<Item> list = new List<Item>();
				foreach (Item reward in ack.Rewards)
				{
					list.Add(reward);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
			}
		});
	}

	public void OnSelect(BaseEventData eventData)
	{
		BtnPrompt_A?.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && getBtn.gameObject.activeSelf);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		BtnPrompt_A?.SetActive(value: false);
	}

	public void OnSubmit()
	{
		if (getBtn.gameObject.activeSelf)
		{
			OnRewardBtn();
		}
	}
}
