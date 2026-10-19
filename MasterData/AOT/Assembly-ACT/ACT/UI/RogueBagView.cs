using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.UI;

public class RogueBagView : BaseUIView<RogueBagViewInputController>
{
	private RogueBagViewData m_data;

	public ActButton btnClose;

	public Transform tfInScription;

	public GameObject noinscription;

	public GameObject rogueBagInscriptionItemPrefab;

	public List<RogueBagItem> CharacterItems;

	public RogueBagItem bloodbottleItem;

	public List<RogueBagItem> PropItems;

	public GameObject goInfo;

	public GameObject ItemInfo;

	public GameObject BloodbottleInfo;

	public LocalizeStringEvent BloodbottleUseNum;

	public GameObject noDetails;

	public BImage imageItemIcon;

	public LocalizeStringEvent itemName;

	public LocalizeStringEvent itemInfoDes;

	public LocalizeStringEvent itemDes;

	public Transform tfInfoInScription;

	public GameObject InScriptionPrefab;

	public GameObject CharacterInfo;

	public ActButton BtnCharacterInfo;

	public BImage imageCharacterIcon;

	public TextMeshProUGUI characterLevel;

	public BImage imageCharacterSkillIcon;

	public LocalizeStringEvent SkillName;

	public Transform TfDesc;

	public LocalizeStringEvent SkillDesc;

	public GameObject InscriptionInfo;

	public HudRogueTwoInscriptionInfo ItemInscriptionInfo;

	public ActButton BtnHideInfo;

	public BImage InscriptionIcon;

	public LocalizeStringEvent InscriptionName;

	public Transform TfSynergyItem;

	public GameObject SynergyItemPrefab;

	public ActButton btnDetails;

	public ActButton btnDecomposition;

	public TextMeshProUGUI DecompositionNum;

	public GamePadTipsComp gamePadGroup;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	private Dictionary<int, List<RogueBagItemData>> rogueBags = new Dictionary<int, List<RogueBagItemData>>();

	private Dictionary<int, Inscription> inscriptions = new Dictionary<int, Inscription>();

	private List<RogueBagItemData> _characters = new List<RogueBagItemData>();

	private List<RogueBagItemData> _bloodbottle = new List<RogueBagItemData>();

	private List<RogueBagItemData> _props = new List<RogueBagItemData>();

	private int CurrentSelectId;

	private RogueBagItem _lastSelectedItem;

	private RogueBagInscriptionItem _lastSelectedInfoInScriptionItem;

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		btnClose.SetBtnClick(Close);
		btnDecomposition.SetBtnClick(OnDecomposition);
		btnDetails.SetBtnClick(OnDetails);
		BtnHideInfo.SetBtnClick(() =>
		{
			SetItemInscriptionInfoActive(active: false, needsound: true);
		});
		BtnCharacterInfo.SetBtnClick(OpenAttributeDetail);
	}

	protected override void Init()
	{
		base.Init();
		CurrentSelectId = 0;
		InitPanel();
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/BagOpen");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_lastSelectedItem?.SetSelected(isSelected: false);
		_lastSelectedItem = null;
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void InitPanel()
	{
		rogueBags.Clear();
		rogueBags.AddRange(Model<RogueNewModel>.Interface.GetCurrentRogueBag());
		SetBagList();
		SetInscriptions();
		SetMiddleItemInfo();
		noDetails.SetActive(CurrentSelectId == 0);
		noinscription.SetActive(_props.Count <= 0);
		goInfo.SetActive(CurrentSelectId != 0);
		SetItemInscriptionInfoActive(active: false);
		InscriptionInfo.SetActive(value: false);
	}

	private void SetInscriptions()
	{
		inscriptions.Clear();
		for (int i = 0; i < _props.Count; i++)
		{
			ACT.Config.RogueItem data = CoreUtils.GetData(_props[i].RogueItem.ItemId, RuntimeConfigs.data.rogueItems);
			for (int j = 0; j < data.inscriptionIds.Length; j++)
			{
				if (!inscriptions.ContainsKey(data.inscriptionIds[j]))
				{
					Inscription data2 = CoreUtils.GetData(data.inscriptionIds[j], RuntimeConfigs.data.inscriptions);
					if (data2 != null)
					{
						inscriptions.Add(data.inscriptionIds[j], data2);
					}
				}
			}
		}
	}

	private void OpenAttributeDetail()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid && mainEntity.IsCharacter() && mainEntity.GetCompCharacter().characterSource is Character character)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERBATTLEATTRIBUTE, new AttributeData
			{
				character = character
			});
		}
	}

	private void CreateInscriptionsItem()
	{
		if (tfInScription.childCount > 0)
		{
			tfInScription.DestroyChildren();
		}
		List<Inscription> list = inscriptions.Values.ToList();
		list.Sort((Inscription a, Inscription b) => -Model<RogueNewModel>.Interface.GetInscriptionById(a.id).CompareTo(Model<RogueNewModel>.Interface.GetInscriptionById(b.id)));
		if (_props.Count <= 0)
		{
			return;
		}
		for (int num = 0; num < list.Count; num++)
		{
			RogueBagInscriptionItem item = UIUtility.AddWidget<RogueBagInscriptionItem>(tfInScription, rogueBagInscriptionItemPrefab);
			item.Init(list[num].id, Station);
			item.ClickButton.SetBtnClick(() =>
			{
				InfoInScriptionClick(item.Id, item);
			});
		}
	}

	private void InfoInScriptionClick(int id, RogueBagInscriptionItem item)
	{
		if (_lastSelectedInfoInScriptionItem != null)
		{
			_lastSelectedInfoInScriptionItem?.GoSelect.SetActive(value: false);
		}
		ShowInfo(id, 2);
		item?.GoSelect.SetActive(value: true);
		_lastSelectedInfoInScriptionItem = item;
	}

	private void SetMiddleItemInfo()
	{
		SetPropsItem();
		SetCharacterItem();
		SetBloodbottleItem();
		CreateInscriptionsItem();
	}

	private void SetCharacterItem()
	{
		for (int i = 0; i < CharacterItems.Count; i++)
		{
			RogueBagItem item = CharacterItems[i];
			RogueBagItemData rogueBagItemDataByPosIndex = GetRogueBagItemDataByPosIndex(i, 2);
			if (rogueBagItemDataByPosIndex != null)
			{
				item.Init(rogueBagItemDataByPosIndex.RogueItem.ItemId, RogueItemType.AssistCharacter, Station);
				item.BtnClick.SetBtnClick(() =>
				{
					RogueItemClick(item.Itemid, item);
				});
			}
			else
			{
				item.Init(0, RogueItemType.None);
			}
		}
	}

	private RogueBagItemData GetRogueBagItemDataByPosIndex(int PosIndex, int RogueItemType)
	{
		List<RogueBagItemData> list = rogueBags[RogueItemType];
		RogueBagItemData result = null;
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].RogueItem.Position == PosIndex)
			{
				result = list[i];
			}
		}
		return result;
	}

	private void SetBloodbottleItem()
	{
		if (0 < _bloodbottle.Count)
		{
			bloodbottleItem.Init(_bloodbottle[0].RogueItem.ItemId, RogueItemType.Bloodbottle, Station);
			bloodbottleItem.BtnClick.SetBtnClick(() =>
			{
				RogueItemClick(bloodbottleItem.Itemid, bloodbottleItem);
			});
		}
		else
		{
			bloodbottleItem.Init(0, RogueItemType.None);
		}
	}

	private void SetPropsItem()
	{
		for (int i = 0; i < PropItems.Count; i++)
		{
			RogueBagItem item = PropItems[i];
			RogueBagItemData rogueBagItemDataByPosIndex = GetRogueBagItemDataByPosIndex(i, 3);
			if (rogueBagItemDataByPosIndex != null)
			{
				item.Init(rogueBagItemDataByPosIndex.RogueItem.ItemId, RogueItemType.Prop, Station);
				item.BtnClick.SetBtnClick(() =>
				{
					RogueItemClick(item.Itemid, item);
				});
			}
			else
			{
				item.Init(0, RogueItemType.None);
			}
		}
	}

	private void RogueItemClick(int id, RogueBagItem item)
	{
		_lastSelectedItem?.SetSelected(isSelected: false);
		ShowInfo(id, 1);
		item?.SetSelected(isSelected: true);
		_lastSelectedItem = item;
	}

	private void SetBagList()
	{
		_props = rogueBags[3];
		_characters = rogueBags[2];
		_bloodbottle = rogueBags[1];
	}

	private void ShowInfo(int id, int type)
	{
		if (type == 1)
		{
			if (_lastSelectedInfoInScriptionItem != null)
			{
				_lastSelectedInfoInScriptionItem.GoSelect.SetActive(value: false);
				_lastSelectedInfoInScriptionItem = null;
			}
			SetDetailsInfo(id);
		}
		else
		{
			if (_lastSelectedItem != null)
			{
				_lastSelectedItem.SetSelected(isSelected: false);
				_lastSelectedItem = null;
			}
			SetInscriptionsInfo(id);
		}
		CurrentSelectId = id;
		noDetails.SetActive(CurrentSelectId == 0);
		goInfo.SetActive(type == 1);
		InscriptionInfo.SetActive(type == 2);
		SetItemInscriptionInfoActive(active: false);
	}

	private void SetInscriptionsInfo(int id)
	{
		if (TfSynergyItem.childCount > 0)
		{
			TfSynergyItem.DestroyChildren();
		}
		Inscription data = CoreUtils.GetData(id, RuntimeConfigs.data.inscriptions);
		InscriptionName.StringReference.TableEntryReference = data.name;
		Station.LoadImage(189, data.iconAddress, InscriptionIcon);
		List<Synergy> synergysByInscriptionId = GetSynergysByInscriptionId(id);
		for (int i = 0; i < synergysByInscriptionId.Count; i++)
		{
			UIUtility.AddWidget<RogueBagSynergyDesItem>(TfSynergyItem, SynergyItemPrefab).Init(synergysByInscriptionId[i]);
		}
	}

	private List<Synergy> GetSynergysByInscriptionId(int InscriptionId)
	{
		List<Synergy> list = new List<Synergy>();
		foreach (KeyValuePair<int, Synergy> synergy in RuntimeConfigs.data.synergys)
		{
			if (synergy.Value.inscriptionId == InscriptionId)
			{
				list.Add(synergy.Value);
			}
		}
		return list;
	}

	private void SetDetailsInfo(int id)
	{
		RogueElement data = CoreUtils.GetData(id, RuntimeConfigs.data.rogueElements);
		if (data != null)
		{
			goInfo.SetActive(CurrentSelectId != 0);
			ItemInfo.SetActive(data.elementType == 1 || data.elementType == 3);
			CharacterInfo.SetActive(data.elementType == 2);
			BloodbottleInfo.SetActive(data.elementType == 1);
			itemName.StringReference.TableEntryReference = data.name;
			itemDes.StringReference.TableEntryReference = data.description;
			if (ItemInfo.activeSelf)
			{
				Station.LoadImage(188, data.iconAddress, imageItemIcon);
			}
			if (CharacterInfo.activeSelf)
			{
				RogueAssistCharacter data2 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueAssistCharacters);
				characterLevel.SetText("等阶{0:0}", data2.tier);
				Station.LoadImage(188, data.iconAddress, imageCharacterIcon);
				SetDescription(data2.skID, 1);
			}
			if (BloodbottleInfo.activeSelf)
			{
				RogueHealthPotion data3 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueHealthPotions);
				BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(data3.potionDataId);
				BloodbottleUseNum.GetComponent<TextMeshProUGUI>().text = LocalizationUtility.GetLocalizeString("Common", 2792, new object[2]
				{
					bloodBottleById.maxUseCount - bloodBottleById.alreadyUseCount,
					bloodBottleById.maxUseCount
				});
			}
			if (data.elementType == 3)
			{
				CreateInfoInscriptionsItem(id);
			}
			tfInfoInScription.gameObject.SetActive(data.elementType == 3);
			DecompositionNum.SetText("{0:0}", data.recyclePrice);
		}
	}

	private void SetDescription(int SkillGroupId, int level)
	{
		SkillGroupData data = CoreUtils.GetData(SkillGroupId, RuntimeConfigs.data.skillGroupDatas);
		if (data == null)
		{
			return;
		}
		SkillName.SetTable(LocalizeTable.ShortCommon);
		SkillName.StringReference.TableEntryReference = data.skillSetLocal;
		SkillGroupLevelData data2 = CoreUtils.GetData(data.GetSkillGroupLevelId(level), RuntimeConfigs.data.skillGroupLevelDatas);
		if (TfDesc.childCount > 0)
		{
			TfDesc.DestroyChildren();
		}
		for (int i = 0; i < data2.skillDes.Length; i++)
		{
			LocalizeStringEvent descitem = UIUtility.AddWidget<LocalizeStringEvent>(TfDesc, SkillDesc.gameObject);
			descitem.gameObject.SetActive(value: true);
			SkillDetailMessageData messageInfo = CoreUtils.GetData(data2.skillDes[i], RuntimeConfigs.data.skillDetailMessageDatas);
			AsyncOperationHandle<StringTable> tableAsync = LocalizationSettings.StringDatabase.GetTableAsync("longcommon");
			tableAsync.Completed += (AsyncOperationHandle<StringTable> l) =>
			{
				StringTableEntry entry = l.Result.GetEntry(messageInfo.detailDescLocal);
				if (entry != null)
				{
					entry.IsSmart = false;
					string arg = CustomTagParser.ReplaceText(messageInfo.skillid, entry.GetLocalizedString(), level);
					descitem.OnUpdateString?.Invoke(arg);
				}
				else
				{
					_ = LuminApplication.LogEnabled;
				}
			};
		}
	}

	private void CreateInfoInscriptionsItem(int id)
	{
		ACT.Config.RogueItem data = CoreUtils.GetData(id, RuntimeConfigs.data.rogueItems);
		if (tfInfoInScription.childCount > 0)
		{
			tfInfoInScription.DestroyChildren();
		}
		if (data != null)
		{
			for (int i = 0; i < data.inscriptionIds.Length; i++)
			{
				RogueInfoInScriptionIconItem rogueInfoInScriptionIconItem = UIUtility.AddWidget<RogueInfoInScriptionIconItem>(tfInfoInScription, InScriptionPrefab);
				rogueInfoInScriptionIconItem.Init(data.inscriptionIds[i], Station);
				rogueInfoInScriptionIconItem.BtnClick.SetBtnClick(InfoInScriptionIconItemClick);
			}
			ItemInscriptionInfo.Init(data.inscriptionIds);
		}
	}

	private void InfoInScriptionIconItemClick()
	{
		SetItemInscriptionInfoActive(active: true, needsound: true);
	}

	private void SetItemInscriptionInfoActive(bool active, bool needsound = false)
	{
		if (active)
		{
			if (needsound)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/BagClick");
			}
			betterAnimation.GetSequence("Choose").Play();
		}
		else
		{
			if (needsound)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/Return_Click");
			}
			betterAnimation.GetSequence("ChooseHide").Play();
		}
		ItemInscriptionInfo.gameObject.gameObject.SetActive(active);
	}

	public void ToggleItemInscriptionInfo()
	{
		RogueElement data = CoreUtils.GetData(CurrentSelectId, RuntimeConfigs.data.rogueElements);
		if (data != null && data.elementType == 3)
		{
			SetItemInscriptionInfoActive(!ItemInscriptionInfo.gameObject.activeSelf, needsound: true);
		}
	}

	public void OnDecomposition()
	{
		if (CurrentSelectId != 0)
		{
			Model<RogueNewModel>.Interface.SendOnRecycleItem(CurrentSelectId, (RogueRecycleItemAck ack) =>
			{
				OnRogueRecycleItemAck(ack);
			});
		}
	}

	private void OnRogueRecycleItemAck(RogueRecycleItemAck ack)
	{
		CurrentSelectId = 0;
		InitPanel();
	}

	private void OnDetails()
	{
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction> { ["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		} };
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
