using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoBreakPanelView : CharacterSecondViewBase
{
	public class BreakPanelData : UIViewData
	{
		public Character character;
	}

	public BreakPanelData breakPanelData;

	public TextMeshProUGUI level;

	public TextMeshProUGUI maxLevel;

	public LocalizeStringEvent characterName;

	public LocalizeStringEvent professionName;

	public TextMeshProUGUI coinText;

	public PropertyCell[] propertyCells;

	public ItemUIComponent[] items;

	public GameObject SkillGroup;

	public LocalizeStringEvent titleText;

	public LocalizeStringEvent skillText;

	public BImage skillIcon;

	public LocalizeStringEvent lvInfo;

	public Color normalColor;

	public Color lessColor;

	public StartList breakStarList;

	private Character m_Character;

	private List<int> m_NewAddSkills = new List<int>();

	private int m_needCoin;

	private List<float> Fva = new List<float>();

	private List<float> Rva = new List<float>();

	public override async UniTask PreInit()
	{
		breakPanelData = (BreakPanelData)uiViewData;
		m_Character = breakPanelData.character;
		await OpenSecondView();
	}

	protected override void Init()
	{
		base.Init();
		SetBreakDetail();
		MonoECS.instance.PushPauseInput();
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("Show");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("Hide");
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		MonoECS.instance.PopPauseInput();
	}

	protected override void UnInit()
	{
		base.UnInit();
		CloseSecondView();
	}

	public void OnClickBreakBtn()
	{
		long num = G.detailUserInfo.Attributes[2];
		bool flag = true;
		ItemUIComponent[] array = items;
		foreach (ItemUIComponent itemUIComponent in array)
		{
			if (itemUIComponent.gameObject.activeSelf && itemUIComponent.inBagCount < itemUIComponent.needCount)
			{
				flag = false;
				break;
			}
		}
		if (!flag || num < m_needCoin)
		{
			GameUtility.OpenToolTip(81);
			return;
		}
		G.service.CharacterBreakThrou(m_Character.Id, m_Character.Stage + 1, async (bool r) =>
		{
			if (r)
			{
				CharacterUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterUpdateEvt>();
				evt.character = m_Character;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_Break, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				if (EntityHelper.TryGetBattleEntityByCharacter(m_Character, out var entity))
				{
					ConfigCharacter config = entity.GetConfig();
					CompAbility compAbility = entity.GetCompAbility();
					compAbility.ServerSetHP(compAbility.maxHP);
					if ((bool)config && config.abilitiyBindings != null)
					{
						compAbility.AddAbilitiesByBindings(config.abilitiyBindings);
					}
				}
				List<(int, float, float)> list = ListPool<(int, float, float)>.Get();
				List<Properties> gainProperty = RuntimeConfigs.data.entityCharacterLevelDatas[m_Character.GetCharacterLevelId()].gainProperty;
				for (int j = 0; j < Fva.Count; j++)
				{
					int property = gainProperty[j].property;
					list.Add((property, Rva[j], Fva[j]));
				}
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BREAKSUCCESS, new MonoBreakSuccessViewData
				{
					fromLevel = m_Character.Stage - 1,
					toLevel = m_Character.Stage,
					propertyData = list,
					callback = () =>
					{
						CloseAsync();
					}
				});
				RoleBreakEvt evt2 = EventTrackSolver.Instance.GetEvt<RoleBreakEvt>();
				evt2.role = m_Character;
				evt2.breakNum = m_Character.Stage;
				EventTrackSolver.Instance.Dispatch(evt2);
			}
		});
	}

	public void SetBreakDetail()
	{
		EntityData entityData = RuntimeConfigs.data.entityDatas[m_Character.Id];
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[m_Character.Id];
		characterName.StringReference.TableEntryReference = entityData.nameLocal;
		int num = 0;
		switch (entityCharacterData.characterDamageType)
		{
		case 1:
			num = 848;
			break;
		case 2:
			num = 846;
			break;
		case 3:
			num = 852;
			break;
		case 4:
			num = 850;
			break;
		}
		professionName.StringReference.TableEntryReference = num;
		EntityCharacterLevelData entityCharacterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[m_Character.GetCharacterLevelId()];
		EntityCharacterLevelData entityCharacterLevelData2 = RuntimeConfigs.data.entityCharacterLevelDatas[m_Character.GetCharacterNextStageId()];
		level.text = m_Character.Level.ToString();
		TextMeshProUGUI textMeshProUGUI = maxLevel;
		int levelMax = entityCharacterLevelData.levelMax;
		textMeshProUGUI.text = levelMax.ToString();
		lvInfo.StringReference.GetVariable<int>("0").Value = entityCharacterLevelData2.levelMax;
		if (entityCharacterLevelData2.newSkill.Length != 0)
		{
			SkillGroup.SetActive(value: true);
			titleText.StringReference.TableEntryReference = 17L;
			SkillGroupData skillGroupData = RuntimeConfigs.data.skillGroupDatas[entityCharacterLevelData2.newSkill[0]];
			skillText.StringReference.TableEntryReference = RuntimeConfigs.data.skillDetailDatas[skillGroupData.skillTotalIds[0]].nameLocal;
			Station.LoadSprite(GameLoader.meta.characterCircleHeadIconAssetID, entityCharacterLevelData2.newSkill[0], skillIcon);
		}
		else
		{
			SkillGroup.SetActive(value: false);
		}
		breakStarList.BreakInit(m_Character.Stage);
		Fva.Clear();
		Rva.Clear();
		if (m_Character.systemProperty == null)
		{
			m_Character.Refresh();
		}
		CompAbility compAbility = (EntityHelper.TryGetBattleEntityByCharacter(m_Character, out var entity) ? entity.GetCompAbility() : null);
		for (int i = 0; i < propertyCells.Length; i++)
		{
			PropertyCell propertyCell = propertyCells[i];
			if (i >= entityCharacterLevelData2.gainProperty.Count)
			{
				propertyCell.gameObject.SetActive(value: false);
				continue;
			}
			propertyCell.gameObject.SetActive(value: true);
			Properties properties = entityCharacterLevelData2.gainProperty[i];
			PropertyData propertyData = RuntimeConfigs.data.propertyDatas[properties.property];
			if (propertyData.subType != 0)
			{
				propertyCells[i].gameObject.SetActive(value: false);
				continue;
			}
			float num2 = (compAbility?.GetProperty((uint)propertyData.propertyId))?.value ?? m_Character.systemProperty.GetResultPropertyValue(propertyData.propertyId);
			float num3 = num2 + properties.value;
			int propertyDescId = RuntimeConfigs.data.propertyTypeDatas[propertyData.propertyId].propertyDescId;
			string num4 = Mathf.CeilToInt(num3).ToString();
			string num5 = Mathf.CeilToInt(num2).ToString();
			if (propertyData.judge)
			{
				num4 = GameUtility.Topercentage(num3, 1);
				num5 = GameUtility.Topercentage(num2, 1);
			}
			Fva.Add(num3);
			Rva.Add(num2);
			propertyCells[i].InitInNum(propertyDescId, num5, num4);
		}
		for (int j = 0; j < items.Length; j++)
		{
			ItemUIComponent itemUIComponent = items[j];
			if (j >= entityCharacterLevelData.breakRequirement.Count)
			{
				itemUIComponent.gameObject.SetActive(value: false);
				continue;
			}
			itemUIComponent.gameObject.SetActive(value: true);
			int id = entityCharacterLevelData.breakRequirement[j].id;
			int count = entityCharacterLevelData.breakRequirement[j].count;
			if (id == 2)
			{
				m_needCoin = count;
				coinText.text = count.ToString();
				itemUIComponent.gameObject.SetActive(value: false);
			}
			else
			{
				Item item = new Item();
				item.Id = id;
				item.Count = G.localPlayer.Inventory.GetItemInfo(id)?.Count ?? 0;
				items[j].NeedCountContrastItemInit(item, count);
			}
		}
		coinText.color = ((G.detailUserInfo.Attributes[2] < m_needCoin) ? lessColor : normalColor);
	}
}
