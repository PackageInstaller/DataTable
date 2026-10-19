using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT;

public class MonoBreakRewardsPanel : BaseUIView
{
	public class BreakRewardData : UIViewData
	{
		public Character character;

		public int curStage = -1;
	}

	public BreakRewardData breakRewardData;

	public GameObject[] stars;

	public GameObject[] lights;

	public LocalizeStringEvent stringEvent;

	public GameObject confirmBtn;

	public ItemUIComponent[] items;

	public TextMeshProUGUI coinNum;

	public ItemUIComponent[] rewardItems;

	public int breakId;

	public GameObject[] hideObjs;

	private int m_curStage;

	private int m_totalPage;

	private Character m_Character;

	private int m_breakId;

	public GameObject Rewarded;

	public float delayTime;

	protected override async void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("CommonWinShow").Play().OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		});
	}

	protected override async void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("CommonWinHide").Play().OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		});
	}

	protected override void Init()
	{
		breakRewardData = (BreakRewardData)uiViewData;
		if (breakRewardData != null)
		{
			m_Character = breakRewardData.character;
			if (breakRewardData.curStage >= 0)
			{
				m_curStage = breakRewardData.curStage;
			}
		}
		for (int i = 0; i < 6; i++)
		{
			if (!m_Character.StageRewards.ContainsKey(i))
			{
				int characterLevelId = TableRule.GetCharacterLevelId(m_Character.Id, i);
				EntityCharacterLevelData entityCharacterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[characterLevelId];
				List<ItemKv> certain = RuntimeConfigs.data.collections[entityCharacterLevelData.rewardId].certain;
				if (certain != null && certain.Count != 0)
				{
					m_curStage = i;
					break;
				}
			}
			if (i >= m_Character.Stage)
			{
				m_curStage = i;
				break;
			}
			if (i == 5)
			{
				m_curStage = 5;
			}
		}
		lights[m_curStage].SetActive(value: true);
		JudgeCount();
		SetPageData();
	}

	protected override void UnInit()
	{
		base.UnInit();
		lights[m_curStage].SetActive(value: false);
	}

	private void SetPageData()
	{
		int key = (m_breakId = TableRule.GetCharacterLevelId(m_Character.Id, m_curStage));
		EntityCharacterLevelData entityCharacterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[key];
		List<ItemKv> certain = RuntimeConfigs.data.collections[entityCharacterLevelData.rewardId].certain;
		List<ItemKv> breakRequirement = entityCharacterLevelData.breakRequirement;
		for (int i = 0; i < stars.Length; i++)
		{
			stars[i].SetActive(i < m_Character.Stage);
		}
		for (int j = 0; j < items.Length; j++)
		{
			bool flag = j < breakRequirement.Count;
			items[j].gameObject.SetActive(flag);
			if (flag)
			{
				if (breakRequirement[j].id == 2)
				{
					TextMeshProUGUI textMeshProUGUI = coinNum;
					int count = breakRequirement[j].count;
					textMeshProUGUI.text = count.ToString();
					items[j].gameObject.SetActive(value: false);
				}
				else
				{
					Item item = new Item();
					item.Id = breakRequirement[j].id;
					items[j].NeedCountContrastItemInit(item, breakRequirement[j].count);
				}
			}
		}
		for (int k = 0; k < rewardItems.Length; k++)
		{
			bool flag2 = k < certain.Count;
			rewardItems[k].gameObject.SetActive(flag2);
			if (!flag2)
			{
				continue;
			}
			Item item2 = new Item();
			item2.Id = certain[k].id;
			item2.Count = certain[k].count;
			rewardItems[k].RewardItemInit(item2);
			if (m_Character.StageRewards.ContainsKey(m_curStage))
			{
				rewardItems[k].IsComplete = true;
				confirmBtn.SetActive(value: false);
				Invoke("HasConfirm", delayTime);
				continue;
			}
			rewardItems[k].IsComplete = false;
			if (m_Character.Stage <= m_curStage)
			{
				confirmBtn.SetActive(value: false);
				Rewarded.SetActive(value: false);
			}
			else
			{
				confirmBtn.SetActive(value: true);
				Rewarded.SetActive(value: false);
			}
		}
		if (certain == null || certain.Count == 0)
		{
			confirmBtn.SetActive(value: false);
		}
		for (int l = 0; l < hideObjs.Length; l++)
		{
			hideObjs[l].SetActive(certain.Count != 0);
		}
		if (m_Character.Stage <= m_curStage)
		{
			stringEvent.gameObject.SetActive(value: true);
			stringEvent.StringReference.TableEntryReference = 452L;
			stringEvent.StringReference.GetVariable<int>("0").Value = entityCharacterLevelData.levelMax;
		}
		else if (breakId != 0)
		{
			stringEvent.gameObject.SetActive(value: true);
			stringEvent.StringReference.TableEntryReference = breakId;
		}
		else
		{
			stringEvent.gameObject.SetActive(value: false);
		}
	}

	private void JudgeCount()
	{
		m_totalPage = 0;
		foreach (KeyValuePair<int, EntityCharacterLevelData> entityCharacterLevelData in RuntimeConfigs.data.entityCharacterLevelDatas)
		{
			if (entityCharacterLevelData.Value.character == m_Character.Id)
			{
				m_totalPage++;
			}
		}
		m_totalPage--;
	}

	public void ChangePage(int num)
	{
		lights[m_curStage].SetActive(value: false);
		m_curStage += num;
		m_curStage = (m_curStage + 6) % 6;
		lights[m_curStage].SetActive(value: true);
		SetPageData();
	}

	public void TurnPage(int num)
	{
		lights[m_curStage].SetActive(value: false);
		m_curStage = num;
		lights[m_curStage].SetActive(value: true);
		SetPageData();
	}

	public void ConfirmBtn()
	{
		G.service.CharacterBreakReward(m_Character.Id, m_curStage, (bool r) =>
		{
			if (r)
			{
				int rewardId = RuntimeConfigs.data.entityCharacterLevelDatas[m_breakId].rewardId;
				Collection collection = RuntimeConfigs.data.collections[rewardId];
				MonoScrollBagComponent.Param param = default;
				List<Item> items = ListPool<Item>.Get();
				foreach (ItemKv item2 in collection.certain)
				{
					Item item = new Item
					{
						Id = item2.id,
						Count = item2.count
					};
					items.Add(item);
				}
				param.paramType = MonoScrollBagComponent.ParamType.Item;
				if (collection.certain.Count != 0)
				{
					GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items), notSort: false, () =>
					{
						ListPool<Item>.Release(items);
					});
				}
				m_Character.StageRewards.Add(m_curStage, value: true);
				SetPageData();
			}
			else
			{
				GameUtility.OpenToolTip(100);
			}
		});
	}

	public void HasConfirm()
	{
		Rewarded.SetActive(value: true);
	}
}
