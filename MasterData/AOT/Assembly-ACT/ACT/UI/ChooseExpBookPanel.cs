using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class ChooseExpBookPanel : BaseUIView
{
	public class ChooseExpData : UIViewData
	{
		public Character character;
	}

	public ChooseExpData expData;

	public TextMeshProUGUI confirmTex;

	public Color confirmNormalColor;

	public Color confirmLessColor;

	public TextMeshProUGUI CharacterLevel;

	public TextMeshProUGUI CharacterMaxLevel;

	public TextMeshProUGUI experience;

	public TextMeshProUGUI currentLevelExperience;

	public TextMeshProUGUI Expectecperience;

	public Slider ExperienceFill;

	public Slider ExperienceAddFill;

	public Image MaxImage;

	public GameObject ExpBookPool;

	public TextMeshProUGUI UseCount;

	public Button AddBtn;

	public Button MinusBtn;

	public Button ConfirmBtn;

	public GameObject itemCell;

	public TextMeshProUGUI MaxCount;

	public LimitedSlider CountSlider;

	public TextMeshProUGUI coinUseCount;

	public TextMeshProUGUI coinTotalCount;

	public LayoutGroup layoutGroup;

	public Color coinNormalColor;

	public Color coinLessColor;

	private Character m_Character;

	private int m_OriginalExp;

	private int m_CurrentNeedExp;

	private int m_Num;

	private int m_CurrentNum;

	private int m_ChooseItemId;

	private int m_Idx = -1;

	private Item m_ChooseItem;

	private List<Item> m_ChooseItems;

	private int m_OverFlowExp;

	private int m_Addlevel;

	private List<ItemUIComponent> m_ExpItems;

	private int m_LevelUpRemainExp;

	private int m_Uplevel;

	private bool m_IsPing;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		if (m_ExpItems != null)
		{
			return;
		}
		m_ExpItems = new List<ItemUIComponent>();
		for (int i = 0; i < RuntimeConfigs.data.game.xpBook.Length; i++)
		{
			int idx = i;
			ItemUIComponent component = UnityEngine.Object.Instantiate(itemCell, ExpBookPool.transform).GetComponent<ItemUIComponent>();
			m_ExpItems.Add(component);
			int num = RuntimeConfigs.data.game.xpBook[idx];
			Item item = new Item();
			item.Id = num;
			if (G.localPlayer.Inventory.GetItemInfo(num) != null)
			{
				item.Count = G.localPlayer.Inventory.GetItemInfo(num).Count;
			}
			else
			{
				item.Count = 0;
			}
			component.RewardItemInit(item);
			component.OnItemClick = null;
			component.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(component.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnClick(idx);
			}));
		}
	}

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

	private void Start()
	{
		m_ChooseItem = new Item();
		m_ChooseItems = new List<Item> { m_ChooseItem };
	}

	protected override void Init()
	{
		base.Init();
		expData = ((uiViewData != null) ? ((ChooseExpData)uiViewData) : null);
		if (expData != null)
		{
			m_Character = expData.character;
		}
		if (m_Character.Level != RuntimeConfigs.data.game.maxLevel)
		{
			UICharacterScene.instance.OpenTouch(open: false);
			InitPanel();
		}
	}

	private void InitPanel()
	{
		int idx = 0;
		if (m_ExpItems.Count != 0)
		{
			for (int i = 0; i < m_ExpItems.Count; i++)
			{
				if (G.localPlayer.Inventory.GetItemInfo(m_ExpItems[i].item.Id) != null)
				{
					int count = G.localPlayer.Inventory.GetItemInfo(m_ExpItems[i].item.Id).Count;
					m_ExpItems[i].itemCount.text = count.ToString();
					m_ExpItems[i].count = count;
					if (count <= 0)
					{
						m_ExpItems[i].itemMask.SetActive(value: true);
						continue;
					}
					idx = i;
					m_ExpItems[i].itemMask.SetActive(value: false);
				}
				else
				{
					m_ExpItems[i].count = 0;
					m_ExpItems[i].itemCount.text = "0";
					m_ExpItems[i].itemMask.SetActive(value: true);
				}
			}
			if (m_Idx != -1 && m_ExpItems[m_Idx].count > 0)
			{
				idx = m_Idx;
			}
		}
		Refresh(idx);
		if (G.detailUserInfo.Attributes.ContainsKey(2))
		{
			coinTotalCount.text = G.detailUserInfo.Attributes[2].ToString();
		}
		else
		{
			coinTotalCount.text = "0";
		}
	}

	private void calculateMaxCount(int num)
	{
		int count = RuntimeConfigs.data.itemDatas[m_ChooseItemId].canBeTransited[0].count;
		int xpTotal = RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterXpId()].xpTotal;
		int num2 = (RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterMaxXpId()].xpTotal - m_Character.Exp - xpTotal) / count + 1;
		if (num2 >= num)
		{
			MaxCount.text = num.ToString();
			CountSlider.maxValue = num;
			CountSlider.limit = num;
		}
		else
		{
			MaxCount.text = num2.ToString();
			m_CurrentNum = num2;
			CountSlider.maxValue = num2;
			CountSlider.limit = num2;
		}
	}

	private void OnClick(int idx)
	{
		if (!m_ExpItems[idx].holding)
		{
			Refresh(idx);
		}
	}

	private void Refresh(int idx)
	{
		for (int i = 0; i < m_ExpItems.Count; i++)
		{
			ItemUIComponent itemUIComponent = m_ExpItems[i];
			if (i == idx)
			{
				itemUIComponent.isChosen = true;
			}
			else
			{
				itemUIComponent.isChosen = false;
			}
		}
		if (G.localPlayer.Inventory.GetItemInfo(m_ExpItems[idx].item.Id) != null)
		{
			m_CurrentNum = G.localPlayer.Inventory.GetItemInfo(m_ExpItems[idx].item.Id).Count;
		}
		else
		{
			m_CurrentNum = 0;
		}
		m_ChooseItemId = RuntimeConfigs.data.game.xpBook[idx];
		calculateMaxCount(m_CurrentNum);
		DataClear();
		if (m_CurrentNum > 0)
		{
			AddBtn.interactable = true;
		}
		m_Idx = idx;
	}

	public void setCountSlider()
	{
		m_Num = (int)CountSlider.value;
		UseCount.text = m_Num.ToString();
		if (m_Num == 0)
		{
			AddBtn.interactable = m_CurrentNum > 0;
			MinusBtn.interactable = false;
			ConfirmBtn.interactable = false;
			if (UseCount.gameObject.activeSelf)
			{
				UseCount.gameObject.SetActive(value: false);
			}
			confirmTex.color = confirmLessColor;
		}
		else
		{
			if (!UseCount.gameObject.activeSelf)
			{
				UseCount.gameObject.SetActive(value: true);
			}
			AddBtn.interactable = m_CurrentNum >= m_Num;
			MinusBtn.interactable = true;
			ConfirmBtn.interactable = true;
			confirmTex.color = confirmNormalColor;
		}
		CalculateAddAttribute();
	}

	protected override void UnInit()
	{
		base.UnInit();
		DataClear();
		UICharacterScene.instance.OpenTouch(open: true);
	}

	public void ClickAddBtn()
	{
		if (m_Num < m_CurrentNum)
		{
			m_Num++;
			UseCount.text = m_Num.ToString();
			CalculateAddAttribute();
			CountSlider.value = m_Num;
		}
		if (m_Num > 0)
		{
			MinusBtn.enabled = true;
			ConfirmBtn.interactable = true;
		}
		if (m_Num == m_CurrentNum)
		{
			AddBtn.interactable = false;
		}
	}

	public void ClickMinusBtn()
	{
		if (m_Num >= 1)
		{
			m_Num--;
			UseCount.text = m_Num.ToString();
			CalculateAddAttribute();
			CountSlider.value = m_Num;
		}
		if (m_Num == 0)
		{
			CharacterMaxLevel.text = " ";
			Expectecperience.text = " ";
			ConfirmBtn.interactable = false;
			MinusBtn.interactable = false;
		}
		if (m_Num < m_CurrentNum)
		{
			AddBtn.interactable = true;
		}
	}

	public void CalculateAddAttribute()
	{
		EntityCharacterLevelData entityCharacterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[m_Character.GetCharacterLevelId()];
		int count = RuntimeConfigs.data.itemDatas[m_ChooseItemId].canBeTransited[0].count;
		int num = CoreUtils.CalculateCharacterExp(new List<Item>
		{
			new Item
			{
				Id = m_ChooseItemId,
				Count = m_Num
			}
		});
		coinUseCount.text = (num / 5).ToString();
		m_Addlevel = GameUtility.CalculateExpAttribute(m_Character, num)[0];
		m_LevelUpRemainExp = GameUtility.CalculateExpAttribute(m_Character, num)[1];
		if (m_Num <= 0)
		{
			Expectecperience.text = " ";
		}
		else
		{
			Expectecperience.text = "+" + m_Num * count;
		}
		if (m_Addlevel <= 0)
		{
			CharacterMaxLevel.text = " ";
		}
		else
		{
			CharacterMaxLevel.text = "+" + m_Addlevel;
		}
		ExperienceAddFill.value = (float)(m_Num * count + m_OriginalExp) / (float)m_CurrentNeedExp;
		m_Uplevel = m_Character.Level + m_Addlevel;
		int num2 = m_Character.Exp + num + RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterXpId()].xpTotal;
		if (m_Uplevel == entityCharacterLevelData.levelMax)
		{
			MaxImage.gameObject.SetActive(value: true);
			m_OverFlowExp = num2 - RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterXpId(m_Uplevel)].xpTotal;
			Expectecperience.text = "+" + (RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterMaxXpId()].xpTotal - m_Character.Exp - RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterXpId()].xpTotal);
			AddBtn.interactable = false;
			ExperienceAddFill.value = 1f;
		}
		else
		{
			AddBtn.interactable = true;
			MaxImage.gameObject.SetActive(value: false);
		}
		coinTotalCount.color = coinNormalColor;
		if (num / 5 > G.detailUserInfo.Attributes[2])
		{
			ConfirmBtn.interactable = false;
			coinTotalCount.color = coinLessColor;
		}
	}

	public void DataClear()
	{
		m_Num = 0;
		ConfirmBtn.interactable = false;
		UseCount.text = m_Num.ToString();
		MinusBtn.interactable = false;
		AddBtn.interactable = false;
		CharacterMaxLevel.text = " ";
		Expectecperience.text = " ";
		coinUseCount.text = "0";
		CharacterLevel.text = m_Character.Level.ToString();
		coinTotalCount.color = coinNormalColor;
		m_OriginalExp = m_Character.Exp;
		experience.text = m_OriginalExp.ToString();
		m_CurrentNeedExp = RuntimeConfigs.data.entityCharacterXPDatas[m_Character.GetCharacterXpId()].xpEachLv;
		currentLevelExperience.text = m_CurrentNeedExp.ToString();
		ExperienceFill.value = (float)m_OriginalExp / (float)m_CurrentNeedExp;
		ExperienceAddFill.value = (float)m_OriginalExp / (float)m_CurrentNeedExp;
		MaxImage.gameObject.SetActive(value: false);
		CountSlider.value = 0f;
		confirmTex.color = confirmLessColor;
		UseCount.gameObject.SetActive(value: false);
		m_Idx = -1;
	}

	public void ClickConfirmBtn()
	{
		if (m_Num == 0)
		{
			ConfirmBtn.interactable = false;
			return;
		}
		EntityCharacterLevelData entityCharacterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[m_Character.GetCharacterLevelId()];
		m_ChooseItem.Id = m_ChooseItemId;
		m_ChooseItem.Count = m_Num;
		if (m_Uplevel != entityCharacterLevelData.levelMax || m_OverFlowExp == 0)
		{
			OnConfirm();
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			texts = new string[1] { m_OverFlowExp.ToString() },
			OnConfirm = OnConfirm,
			OnCancel = OnCancle,
			commonId = 15
		});
	}

	public void OnConfirm()
	{
		if (m_IsPing)
		{
			return;
		}
		MonoECS.instance.PushPauseInput();
		EntityCharacterLevelData characterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[m_Character.GetCharacterLevelId()];
		if (m_Character.systemProperty == null)
		{
			m_Character.Refresh();
		}
		CompAbility compAbility = (EntityHelper.TryGetBattleEntityByCharacter(m_Character, out var entity) ? entity.GetCompAbility() : null);
		List<Properties> characterPorpertyAdd = RuntimeConfigs.data.entityCharacterDatas[m_Character.Id].characterPorpertyAdd;
		List<float> results = new List<float>();
		for (int i = 0; i < characterPorpertyAdd.Count; i++)
		{
			int property = characterPorpertyAdd[i].property;
			PropertyData propertyData = RuntimeConfigs.data.propertyDatas[property];
			float item = Mathf.Ceil(compAbility?.GetProperty((uint)propertyData.propertyId).value ?? m_Character.systemProperty.GetResultPropertyValue(propertyData.propertyId));
			results.Add(item);
		}
		int formSkillPoint = m_Character.SkillPoint;
		m_IsPing = true;
		G.service.CharacterLevelUp(m_Character.Id, m_ChooseItems, (bool r) =>
		{
			if (r)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Character_Attribute_Update, null);
				int addlevel = m_Addlevel;
				if (m_Addlevel < 1)
				{
					m_Character.Exp = m_LevelUpRemainExp;
				}
				else
				{
					if (m_Character.Level == characterLevelData.levelMax)
					{
						m_Character.Exp = 0;
						Close();
					}
					CharacterUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterUpdateEvt>();
					evt.character = m_Character;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_LevelUp, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
					List<(int, float, float)> list = ListPool<(int, float, float)>.Get();
					int num = m_Character.Level - addlevel;
					CompAbility compAbility2 = (EntityHelper.TryGetBattleEntityByCharacter(m_Character, out var entity2) ? entity2.GetCompAbility() : null);
					List<Properties> characterPorpertyAdd2 = RuntimeConfigs.data.entityCharacterDatas[m_Character.Id].characterPorpertyAdd;
					for (int j = 0; j < characterPorpertyAdd2.Count; j++)
					{
						int property2 = characterPorpertyAdd2[j].property;
						PropertyData propertyData2 = RuntimeConfigs.data.propertyDatas[property2];
						float item2 = Mathf.Ceil(compAbility2?.GetProperty((uint)propertyData2.propertyId).value ?? m_Character.systemProperty.GetResultPropertyValue(propertyData2.propertyId));
						float item3 = results[j];
						list.Add((property2, item3, item2));
					}
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LEVELUPSUCCESS, new MonoLevelUpSuccessViewData
					{
						fromLevel = num,
						toLevel = m_Character.Level,
						propertyData = list,
						fromSkillPoint = formSkillPoint,
						toSkillPoint = m_Character.SkillPoint
					});
					RoleLevelUpEvt evt2 = EventTrackSolver.Instance.GetEvt<RoleLevelUpEvt>();
					evt2.role = m_Character;
					evt2.levelBefore = num;
					evt2.levelAfter = m_Character.Level;
					evt2.levelUpReason = "经验书";
					EventTrackSolver.Instance.Dispatch(evt2);
				}
				m_IsPing = false;
				InitPanel();
			}
			MonoECS.instance.PopPauseInput();
		});
	}

	public void OnCancle()
	{
	}
}
