using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Google.Protobuf.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class ItemUIComponent : ItemUIComponentBase
{
	public int ItemId = -1;

	public GameObject IconManager;

	public CanvasGroup canvasGroup;

	public Animator anim;

	public Button reduceBtn;

	public Image addIcon;

	public GameObject NotOwned;

	public GameObject mainIconRoot;

	public UIAtlasImage mainIcon;

	public GameObject notEnoughMask;

	public Vector2 defaultSize = new Vector2(128f, 128f);

	public Image normalQualityBg;

	public Sprite[] normalQualitySprites;

	public StartList qualityStars;

	public GameObject characterIconRoot;

	public UIAtlasImage characterIcon;

	public GameObject ownerRoot;

	public UIAtlasImage ownerIcon;

	public GameObject lockobj;

	[SerializeField]
	public GameObject[] indexIcon = new GameObject[3];

	public GameObject blackMask;

	public GameObject itemRoot;

	public TextMeshProUGUI itemCount;

	public bool show0;

	public bool maskshow0;

	public GameObject levelText;

	public TextMeshProUGUI level;

	public GameObject countContrast;

	[FormerlySerializedAs("inBagCountText")]
	public TextMeshProUGUI leftCountText;

	public GameObject contrastSlash;

	[FormerlySerializedAs("needCountText")]
	public TextMeshProUGUI rightCountText;

	public Color enoughLeftColor;

	public Color notEnoughLeftColor;

	public Color defaultContrastColor;

	public int inBagCount;

	public int needCount;

	public GameObject refineTextRoot;

	public TextMeshProUGUI refineText;

	public GameObject refineLimitRoot;

	public TextMeshProUGUI refineLimitText;

	public Image mask;

	public Weapon weapon;

	[SerializeField]
	private GemHoleItems simpleHoleItem;

	[SerializeField]
	private LocalizeStringEvent equipType;

	[SerializeField]
	private BImage equipTypeIcon;

	private List<GameObject> gemType;

	public Equip equip;

	public Gem gem;

	public GameObject[] chipSpaceDot;

	public GameObject isNewRoot;

	public Chip chip;

	private bool isPanelChip;

	public GameObject teamRoot;

	public UIAtlasImage teamInstrUIAtlasImage;

	public Image bottleEquip;

	public Image bottleMatEquip;

	public Image[] positions;

	public UIAtlasImage[] teamCharIcon;

	public Image battleImage;

	public TextMeshProUGUI battleText;

	public TextMeshProUGUI teamName;

	public Color chosenColor;

	public Color normalColor;

	public PresetTeam team;

	public Image inTeam;

	public Image inTrial;

	[FormerlySerializedAs("element")]
	public UIAtlasImage elementIcon;

	public Character character;

	public GameObject itemMask;

	public Item item;

	private int m_count;

	public TextMeshProUGUI countText;

	public bool haveRedDot;

	public GameObject itemRedDot;

	public GameObject cookItemRoot;

	public TextMeshProUGUI mainCookItemValue;

	public GameObject mainCookItemRoot;

	public GameObject sideCookItemFlag;

	public GameObject getRewardBg;

	public TextMeshProUGUI surplusTime;

	public GameObject time;

	[Header("选中状态")]
	public GameObject selected;

	public ActToggle itemButton;

	[SerializeField]
	public GameObject m_DoubleRewardTag;

	[Header("完成状态")]
	public GameObject complete;

	public GameObject weaponAndChipRoot;

	public StartList bloodBottleSlot;

	public List<GameObject> allRootList;

	public List<InitTypeOpRoot> InitTypeOpRootList;

	private bool m_isLock;

	private int m_IndexAtTeam;

	private bool m_IsInTeam;

	private bool m_isTrial;

	private bool m_bottleIsEquip;

	private bool m_bottleMatIsEquip;

	private bool m_IsChosenCell;

	private int m_EquipCharacterId;

	private bool m_IsFormDeleteBag;

	public UnityEvent<ItemUIComponent, int> onShow;

	public UnityEvent<ItemUIComponent, int> onLoad;

	public UnityEvent<ItemUIComponent, int> onUnLoad;

	public int count
	{
		get
		{
			return m_count;
		}
		set
		{
			m_count = value;
		}
	}

	public new bool IsComplete
	{
		get
		{
			return complete.activeSelf;
		}
		set
		{
			complete.SetActive(value);
		}
	}

	public new bool isLock
	{
		get
		{
			return m_isLock;
		}
		set
		{
			m_isLock = value;
			if ((bool)lockobj)
			{
				lockobj.SetActive(m_isLock);
			}
		}
	}

	public int indexAtTeam
	{
		get
		{
			return m_IndexAtTeam;
		}
		set
		{
			m_IndexAtTeam = value;
			try
			{
				for (int i = 0; i < indexIcon.Length; i++)
				{
					indexIcon[i]?.SetActive(value == i + 1);
				}
			}
			catch (Exception value2)
			{
				Console.WriteLine(value2);
				throw;
			}
		}
	}

	public bool isInTeam
	{
		get
		{
			return m_IsInTeam;
		}
		set
		{
			m_IsInTeam = value;
			inTeam.gameObject.SetActive(m_IsInTeam);
		}
	}

	public bool isTrial
	{
		get
		{
			return m_isTrial;
		}
		set
		{
			m_isTrial = value;
			inTrial.gameObject.SetActive(m_isTrial);
		}
	}

	public bool bottleIsEquip
	{
		get
		{
			return m_bottleIsEquip;
		}
		set
		{
			m_bottleIsEquip = value;
			if (bottleEquip != null)
			{
				bottleEquip.gameObject.SetActive(value);
			}
		}
	}

	public bool bottleMatIsEquip
	{
		get
		{
			return m_bottleMatIsEquip;
		}
		set
		{
			m_bottleMatIsEquip = value;
			if (bottleMatEquip != null)
			{
				bottleMatEquip.gameObject.SetActive(value);
			}
		}
	}

	public bool isChosen
	{
		get
		{
			return IsChosen;
		}
		set
		{
			IsChosen = value;
			if (selected != null)
			{
				selected.gameObject.SetActive(value);
			}
			EventSystemHelper.SetSelectedGameObject(value ? gameObject : null);
		}
	}

	public bool isChosenCell
	{
		get
		{
			return m_IsChosenCell;
		}
		set
		{
			m_IsChosenCell = value;
		}
	}

	public int equipCharacterId
	{
		get
		{
			return m_EquipCharacterId;
		}
		set
		{
			m_EquipCharacterId = value;
			bool flag = m_EquipCharacterId > 0;
			ownerRoot.SetActive(flag);
			ownerIcon.icon.gameObject.SetActive(flag);
			if (flag)
			{
				Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.characterCircleHeadIconAssetID, equipCharacterId, ownerIcon);
			}
		}
	}

	private int quality
	{
		set
		{
			SetQuality(value, isPanelChip);
		}
	}

	public bool IsFormDeleteBag
	{
		get
		{
			return m_IsFormDeleteBag;
		}
		set
		{
			m_IsFormDeleteBag = value;
		}
	}

	protected override void UpdateUniversalItemTag()
	{
		SetUniversalItemExtraTag(m_DoubleRewardTag);
	}

	public void ResetRoot(InitType initType)
	{
		if (allRootList == null)
		{
			return;
		}
		foreach (GameObject allRoot in allRootList)
		{
			if ((bool)allRoot)
			{
				allRoot.SetActive(value: false);
			}
		}
		foreach (GameObject root in InitTypeOpRootList.Find((InitTypeOpRoot _) => _.initType == initType).rootList)
		{
			root.SetActive(value: true);
		}
		mainIcon.icon.rectTransform.sizeDelta = defaultSize;
	}

	protected override void SetQualityBg()
	{
		normalQualityBg.gameObject.SetActive(value: true);
		if (Quality - 1 < normalQualitySprites.Length)
		{
			normalQualityBg.sprite = normalQualitySprites[Quality - 1];
		}
	}

	public void SetChipSpaceDot(Chip chip)
	{
	}

	public void SetEquip()
	{
		if (equipType != null)
		{
			LocalizedString stringReference = equipType.StringReference;
			stringReference.TableEntryReference = equip.TypeIndex switch
			{
				1 => LocalizationCommonData.CommonString.Power, 
				2 => LocalizationCommonData.CommonString.Move, 
				3 => LocalizationCommonData.CommonString.Can, 
				4 => LocalizationCommonData.CommonString.Assist, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
		}
		if (equipTypeIcon != null)
		{
			GetComponentInParent<IBaseUIView>().Station.LoadImage(135, equip.TypeIndex + 1, equipTypeIcon);
		}
		simpleHoleItem.gameObject.SetActive(value: true);
		simpleHoleItem.Init(equip);
	}

	public void RefreshIsNew()
	{
		isNewRoot.gameObject.SetActive(chip.IsNew);
	}

	[Obsolete("宝箱道具类型已经改成35，红点需求暂时没有，等有包箱红点需求的时候迭代，先不要用了")]
	public void RefreshItemIsNew()
	{
		if (haveRedDot && item.itemType == 35)
		{
			MapField<int, bool> items = G.localPlayer.redPoints.Items;
			itemRedDot.gameObject.SetActive(items.ContainsKey(item.Id) && items[item.Id]);
		}
	}

	public void ResetItem()
	{
		if (cookItemRoot != null)
		{
			cookItemRoot.SetActive(value: false);
		}
	}

	public void SetQuality(int quality, bool isPanelChip)
	{
		if (!isPanelChip)
		{
			SetQualityBg();
		}
		qualityStars.QualityInit(quality);
	}

	public void UpdateQualityStar(bool active)
	{
		qualityStars.gameObject.SetActive(active);
		if (bloodBottleSlot != null)
		{
			bloodBottleSlot.gameObject.SetActive(!active);
		}
	}

	public void UpdateReduceBtn(bool active)
	{
		reduceBtn.gameObject.SetActive(active);
	}

	public void UpdateCountTexUI(bool showMutiple, int _count = 0)
	{
		itemRoot.SetActive(!showMutiple);
		countContrast.SetActive(showMutiple);
		if (showMutiple)
		{
			count = _count;
			leftCountText.SetText("{0:0}", _count);
			rightCountText.SetText("{0:0}", item.Count);
		}
	}

	public void UpdateCountText(bool acticve, int count = 0)
	{
		countText.gameObject.SetActive(acticve);
		if (acticve)
		{
			countText.SetText("{0:0}", count);
		}
	}

	public void UpdateItemCount(bool active, int count = 0)
	{
		if (!active || (count == 0 && !show0))
		{
			itemCount.gameObject.SetActive(value: false);
			return;
		}
		itemCount.gameObject.SetActive(value: true);
		itemCount.SetText("{0:0}", count);
	}

	public void AddSelectCount(bool isShow)
	{
		UpdateReduceBtn(active: true);
		UpdateCountText(acticve: true, ++m_count);
		isChosen = true;
	}

	public void ReduceSelectCount(ItemUIComponent item)
	{
		switch (item.ItemType)
		{
		case InitType.BagItem:
		case InitType.CookItem:
			m_count--;
			if (m_count >= 1)
			{
				UpdateReduceBtn(active: true);
				UpdateCountText(acticve: true, m_count);
			}
			else
			{
				m_count = 0;
				UpdateReduceBtn(active: false);
				UpdateCountText(acticve: false);
			}
			break;
		case InitType.BagWeapon:
			UnMulitSelect();
			break;
		case InitType.BagChip:
		case InitType.BagEquip:
		case InitType.BagGem:
			UnMulitSelect();
			break;
		case InitType.TeamViewBagCharacter:
		case InitType.SelectMaterialItem:
		case InitType.NoneItem:
		case InitType.LittleItem:
			break;
		}
	}

	public void UnMulitSelect()
	{
		reduceBtn.gameObject.SetActive(value: false);
		isChosen = false;
	}

	public void OnMulitSelect()
	{
		reduceBtn.gameObject.SetActive(value: true);
	}

	public void SingleSelect()
	{
		reduceBtn.gameObject.SetActive(value: false);
	}

	public void Reset()
	{
		ItemId = -1;
		equipCharacterId = -1;
		isLock = false;
		isChosen = false;
	}

	private void isNew(int id)
	{
		if (G.localPlayer.newItem.Contains(id))
		{
			G.localPlayer.newItem.Remove(id);
		}
	}

	public void SetTeamCellTextColor()
	{
		teamName.color = (isChosen ? chosenColor : normalColor);
		battleText.color = (isChosen ? chosenColor : normalColor);
	}

	public void LoadMainIconSprite(YooAssetReference spriteAtlas, int iconAddress)
	{
		Singleton<UIAtlasManager>.instance.LoadSprite(spriteAtlas, iconAddress, mainIcon);
	}

	public void LoadCharacterIconSprite(YooAssetReference spriteAtlas, int iconAddress)
	{
		Singleton<UIAtlasManager>.instance.LoadSprite(spriteAtlas, iconAddress, characterIcon);
	}

	public void InitTeam(PresetTeam selectTeam, bool isBattle)
	{
		team = selectTeam;
		isChosen = false;
		battleText.gameObject.SetActive(isBattle);
		battleText.color = normalColor;
		battleImage.gameObject.SetActive(isBattle);
		teamName.text = team.Name;
		teamName.color = normalColor;
		for (int i = 0; i < team.CharacterIds.Count; i++)
		{
			Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, team.CharacterIds[i], teamCharIcon[i]);
		}
	}

	public void ShowCookItem(Item item)
	{
		isChosen = false;
		IconManager.gameObject.SetActive(value: true);
		addIcon.gameObject.SetActive(value: false);
		countContrast.SetActive(value: false);
		weaponAndChipRoot.SetActive(value: false);
		levelText.SetActive(value: false);
		itemRoot.gameObject.SetActive(value: false);
		mainCookItemRoot.gameObject.SetActive(value: true);
		mainCookItemValue.SetText("{0:0}", RuntimeConfigs.data.itemCookDatas[item.Id].capacityCost);
		Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, item.Id, mainIcon);
		quality = RuntimeConfigs.data.itemDatas[item.Id].quality;
	}

	public void ShowSelectItem(Item item)
	{
		ShowCookItem(item);
		itemRoot.gameObject.SetActive(value: true);
		itemCount.SetText("{0:0}", item.Count);
	}

	public void ShowSelectSetItem(Item item)
	{
		ShowCookItem(item);
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(item.Id);
		if (item.notEnough && itemInfo != null && itemInfo.Count != 0 && item.Count <= itemInfo.Count)
		{
			item.notEnough = false;
		}
		itemRoot.gameObject.SetActive(value: true);
		itemCount.SetText("{0:0}", item.Count);
		if (item.notEnough)
		{
			itemCount.color = notEnoughLeftColor;
		}
		else
		{
			itemCount.color = defaultContrastColor;
		}
	}

	public void ShowSelectCookItem(Item item)
	{
		ShowCookItem(item);
		countContrast.SetActive(value: true);
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(item.Id);
		if (itemInfo != null && itemInfo.Count > 0)
		{
			leftCountText.SetText("{0:0}", itemInfo.Count);
			if (itemInfo.Count < item.Count)
			{
				item.notEnough = true;
				leftCountText.color = notEnoughLeftColor;
			}
			else
			{
				leftCountText.color = defaultContrastColor;
			}
		}
		else
		{
			item.notEnough = true;
			leftCountText.SetText("{0:0}", 0f);
			leftCountText.color = notEnoughLeftColor;
		}
		rightCountText.SetText("{0:0}", item.Count);
	}

	public void InitAddItem(bool isTrue)
	{
		IconManager.gameObject.SetActive(!isTrue);
		addIcon.gameObject.SetActive(isTrue);
		isChosen = false;
		ItemId = -1;
	}

	public void ShowSubItem(Item item, int needCount, bool isOwned = false)
	{
		IconManager.gameObject.SetActive(value: true);
		addIcon.gameObject.SetActive(value: false);
		NeedCountContrastItemInit(item, needCount);
		if (isOwned)
		{
			ItemOwned();
		}
		showDetailPanel = !isOwned;
	}

	public void ShowSelectBar(Item item)
	{
		isChosen = false;
		IconManager.gameObject.SetActive(value: true);
		addIcon.gameObject.SetActive(value: false);
		countContrast.SetActive(value: true);
		weaponAndChipRoot.SetActive(value: false);
		levelText.SetActive(value: false);
		leftCountText.SetText("{0:0}", item.Count);
		rightCountText.SetText("{0:0}", G.localPlayer.Inventory.GetItemInfo(item.Id).Count);
		Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, item.Id, mainIcon);
		quality = RuntimeConfigs.data.itemDatas[item.Id].quality;
	}

	public void ShowSelectWeaponBar(Weapon weapon)
	{
		isChosen = false;
		IconManager.gameObject.SetActive(value: true);
		addIcon.gameObject.SetActive(value: false);
		weaponAndChipRoot.SetActive(value: false);
		countContrast.SetActive(value: false);
		level.SetText("{0:0}", weapon.Level);
		refineText.SetText("{0:0}", weapon.Refine);
		Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, weapon.WeaponId, mainIcon);
		quality = weapon.GetQuality();
		ItemId = weapon.WeaponId;
	}

	public void ResetToAdd()
	{
		item = null;
		IconManager.gameObject.SetActive(value: false);
		addIcon.gameObject.SetActive(value: true);
		weaponAndChipRoot.SetActive(value: false);
		countContrast.SetActive(value: false);
	}

	public async void SetTeam(bool show, int index = 0)
	{
		if (show)
		{
			await Singleton<UIAtlasManager>.instance.LoadSpriteAsync(GameLoader.meta.abyssTeamAtlasNameAssetID, index, teamInstrUIAtlasImage);
			teamInstrUIAtlasImage.icon.gameObject.SetActive(value: true);
		}
		else
		{
			teamInstrUIAtlasImage.icon.gameObject.SetActive(value: false);
		}
	}

	public void UnLoadSprite()
	{
		mainIcon.UnLoad();
		ownerIcon.UnLoad();
		characterIcon.UnLoad();
		teamInstrUIAtlasImage.UnLoad();
		elementIcon.UnLoad();
		UIAtlasImage[] array = teamCharIcon;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].UnLoad();
		}
	}

	protected override void LoadMainIcon()
	{
		ItemData data = CoreUtils.GetData(m_ItemUnifier.Id, RuntimeConfigs.data.itemDatas);
		UIAtlasImage uIAtlasImage = mainIcon;
		switch (ItemType)
		{
		case InitType.BagWeapon:
		case InitType.RewardWeapon:
			Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, data.id, uIAtlasImage);
			break;
		case InitType.BagChip:
		case InitType.RewardChip:
			Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, data.id, uIAtlasImage);
			break;
		case InitType.BagItem:
		case InitType.SelectMaterialItem:
		case InitType.CookItem:
		case InitType.LittleItem:
		case InitType.BagEquip:
		case InitType.BagGem:
		case InitType.RewardItem:
		case InitType.RewardItemReceived:
			Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.itemAtlasNameAssetID, data.id, uIAtlasImage);
			break;
		case InitType.TeamViewBagCharacter:
			Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, data.id, uIAtlasImage);
			break;
		case InitType.NoneItem:
		{
			Item item = m_ItemUnifier.Source as Item;
			Singleton<UIAtlasManager>.instance.LoadItemSprite((item.itemType != 5) ? GameLoader.meta.itemAtlasNameAssetID : GameLoader.meta.CharacterSquareHeadIconAssetID, data.id, uIAtlasImage);
			break;
		}
		}
	}

	public override void UnLoadMainIcon()
	{
		switch (ItemType)
		{
		case InitType.BagWeapon:
		case InitType.RewardWeapon:
			Singleton<UIAtlasManager>.instance.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
			break;
		case InitType.BagChip:
		case InitType.RewardChip:
			Singleton<UIAtlasManager>.instance.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
			break;
		case InitType.BagItem:
		case InitType.SelectMaterialItem:
		case InitType.CookItem:
		case InitType.LittleItem:
		case InitType.BagEquip:
		case InitType.BagGem:
		case InitType.RewardItem:
		case InitType.RewardItemReceived:
			Singleton<UIAtlasManager>.instance.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
			break;
		case InitType.TeamViewBagCharacter:
			Singleton<UIAtlasManager>.instance.UnloadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID);
			break;
		case InitType.NoneItem:
		{
			Item item = m_ItemUnifier.Source as Item;
			Singleton<UIAtlasManager>.instance.UnloadSprite((item.itemType != 5) ? GameLoader.meta.itemAtlasNameAssetID : GameLoader.meta.CharacterSquareHeadIconAssetID);
			break;
		}
		}
	}

	public override void ScrollCellIndex(int index)
	{
		base.ScrollCellIndex(index);
	}

	public override void OnLoad(int index)
	{
		onLoad.Invoke(this, index);
	}

	public override void OnUnLoad()
	{
		onUnLoad.Invoke(this, Index);
		UnLoadSprite();
		base.OnUnLoad();
	}

	public override void OnHide()
	{
		canvasGroup.alpha = 0f;
		canvasGroup.interactable = false;
		canvasGroup.blocksRaycasts = false;
	}

	public override void OnShow()
	{
		canvasGroup.alpha = 1f;
		canvasGroup.interactable = true;
		canvasGroup.blocksRaycasts = true;
		onShow.Invoke(this, Index);
	}

	public void UpdateLevelText(bool active, int level = 0)
	{
		levelText.SetActive(active);
		if (active)
		{
			this.level.SetText("{0:0}", level);
		}
	}

	public void UpdateRefineText(bool active, int curRefineLevel = 0, int maxRefineLevel = 0)
	{
		if (!active)
		{
			refineTextRoot.SetActive(value: false);
			refineLimitRoot.SetActive(value: false);
		}
		else if (curRefineLevel == maxRefineLevel)
		{
			refineTextRoot.SetActive(value: false);
			refineLimitRoot.SetActive(value: true);
			refineLimitText.SetText("{0:0}", maxRefineLevel);
		}
		else
		{
			refineTextRoot.SetActive(value: true);
			refineLimitRoot.SetActive(value: false);
			refineText.SetText("{0:0}", curRefineLevel);
		}
	}

	public void UpdateCookIcon(bool active, ItemData itemData = null)
	{
		if (!active || !RuntimeConfigs.data.itemCookDatas.ContainsKey(itemData.id))
		{
			mainCookItemRoot.SetActive(value: false);
			return;
		}
		mainCookItemRoot.SetActive(value: true);
		mainCookItemValue.gameObject.SetActive(value: true);
		mainCookItemValue.SetText("{0:0}", RuntimeConfigs.data.itemCookDatas[itemData.id].capacityCost);
	}

	public void UpdateContrastCount(bool active, InitType contrastType = InitType.SelectedCountContrastItem, int leftCount = 0, int rightCount = 0)
	{
		if (!active)
		{
			leftCountText.gameObject.SetActive(value: false);
			contrastSlash.SetActive(value: false);
			rightCountText.gameObject.SetActive(value: false);
			return;
		}
		leftCountText.gameObject.SetActive(value: true);
		contrastSlash.SetActive(value: true);
		rightCountText.gameObject.SetActive(value: true);
		rightCountText.SetText("{0:0}", rightCount);
		switch (contrastType)
		{
		case InitType.NeedCountContrastItem:
			leftCountText.SetText("{0:0}", leftCount);
			leftCountText.color = ((leftCount >= rightCount) ? enoughLeftColor : notEnoughLeftColor);
			break;
		case InitType.SelectedCountContrastItem:
			leftCountText.SetText("{0:0}", leftCount);
			leftCountText.color = defaultContrastColor;
			break;
		case InitType.CharacterViewBagCharacter:
			leftCountText.SetText("{0:0}", leftCount);
			leftCountText.color = ((rightCount >= leftCount) ? enoughLeftColor : notEnoughLeftColor);
			break;
		}
	}

	public void ItemCraftUpdateContrastCount(bool active, int leftCount, int rightCount, Color leftColor, Color rightColor)
	{
		if (!active)
		{
			leftCountText.gameObject.SetActive(value: false);
			contrastSlash.SetActive(value: false);
			rightCountText.gameObject.SetActive(value: false);
			return;
		}
		leftCountText.gameObject.SetActive(value: true);
		contrastSlash.SetActive(value: true);
		rightCountText.gameObject.SetActive(value: true);
		leftCountText.SetText("{0:0}", leftCount);
		rightCountText.SetText("{0:0}", rightCount);
		leftCountText.color = leftColor;
		rightCountText.color = rightColor;
	}

	public void UpdateTeam(bool active, Character character, int teamIndex, int[] teamCharacters, bool isFromSingle)
	{
		if (!active)
		{
			inTeam.gameObject.SetActive(value: false);
			inTrial.gameObject.SetActive(value: false);
			elementIcon.icon.gameObject.SetActive(value: false);
			return;
		}
		if (!isFromSingle)
		{
			isInTeam = false;
			for (int i = 0; i < teamCharacters.Length; i++)
			{
				indexAtTeam = (teamCharacters.Contains(character.Id) ? ((teamCharacters[i] == character.Id) ? (i + 1) : indexAtTeam) : 0);
			}
		}
		else
		{
			if (indexAtTeam != 0)
			{
				indexAtTeam = 0;
			}
			isInTeam = teamCharacters.Contains(character.Id);
		}
		elementIcon.icon.gameObject.SetActive(value: true);
		Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.attributeNameAssetID, (int)character.element, elementIcon);
	}

	public void AddItemSelectCount()
	{
		UpdateReduceBtn(active: true);
		itemRoot.SetActive(value: false);
		countContrast.SetActive(value: true);
		count++;
		UpdateContrastCount(active: true, InitType.SelectedCountContrastItem, count, G.localPlayer.Inventory.GetItemInfo(item.Id).Count);
	}

	public void ReduceSelectCount()
	{
		if (ItemType == InitType.BagItem || ItemType == InitType.CookItem)
		{
			count--;
			UpdateReduceBtn(count >= 1);
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(item.Id);
			int rightCount = 0;
			if (itemInfo != null)
			{
				rightCount = itemInfo.Count;
			}
			if (count > 0)
			{
				UpdateContrastCount(active: true, InitType.CharacterViewBagCharacter, count, rightCount);
				return;
			}
			countContrast.SetActive(value: false);
			itemRoot.SetActive(value: true);
			UpdateItemCount(active: true, rightCount);
		}
		else
		{
			UnMulitSelect();
		}
	}

	public void BagWeaponInit(Weapon weapon, bool needRefreshState = false)
	{
		ResetRoot(InitType.BagWeapon);
		this.weapon = weapon;
		ItemId = weapon.Uid;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(weapon);
		SetData(itemUnifierProxy, long.MinValue, InitType.BagWeapon);
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[this.weapon.WeaponId].iconAddress);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(weapon.GetQuality());
		UpdateLevelText(active: true, weapon.Level);
		UpdateRefineText(active: true, weapon.Refine, weapon.MaxRefineLevel);
		UpdateCookIcon(active: false);
		isLock = weapon.Lock;
		equipCharacterId = this.weapon.GetEquiperID();
		UpdateReduceBtn(active: false);
		if (needRefreshState)
		{
			bool flag = GameUtility.canDelete(equipCharacterId > 0, this.weapon.WeaponId, this);
			blackMask.gameObject.SetActive(!flag);
			interactable = flag;
		}
		else
		{
			blackMask.gameObject.SetActive(value: false);
			interactable = true;
		}
	}

	public void BagChipInit(Chip chip)
	{
	}

	public void BagEquipInit(Equip equip)
	{
		ResetRoot(InitType.BagEquip);
		this.equip = equip;
		ItemId = equip.Uid;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(equip);
		SetData(itemUnifierProxy, long.MinValue, InitType.BagEquip);
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[equip.Id].iconAddress);
		SetQualityBg();
		quality = Quality;
		SetEquip();
		UpdateLevelText(active: true, equip.Level);
		UpdateRefineText(active: false);
		UpdateCookIcon(active: false);
		UpdateReduceBtn(active: false);
		isLock = equip.IsLock;
		equipCharacterId = equip.WearCharacter;
	}

	public void BagGemInit(Gem gem)
	{
		ResetRoot(InitType.BagGem);
		this.gem = gem;
		ItemId = gem.Uid;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(this.gem);
		SetData(itemUnifierProxy, long.MinValue, InitType.BagGem);
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[gem.Id].iconAddress);
		SetQualityBg();
		quality = Quality;
		UpdateItemCount(active: true, 1);
		UpdateRefineText(active: false);
		UpdateCookIcon(active: false);
		UpdateReduceBtn(active: false);
		isLock = gem.IsLock;
	}

	public void BagItemInit(Item item, bool needRefreshState = false)
	{
		ResetRoot(InitType.BagItem);
		this.item = item;
		ItemId = item.Id;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy);
		ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
		isLock = false;
		if (item.itemType != 5)
		{
			LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		}
		else
		{
			mainIconRoot.SetActive(value: false);
			characterIconRoot.SetActive(value: true);
			qualityStars.gameObject.SetActive(value: false);
			LoadCharacterIconSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		}
		SetQualityBg();
		RefreshItemIsNew();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(itemData.quality);
		UpdateItemCount(active: true, item.Count);
		UpdateCookIcon(active: true, itemData);
		UpdateRefineText(active: false);
		UpdateReduceBtn(active: false);
		UpdateCountTexUI(showMutiple: false);
		if (needRefreshState)
		{
			bool flag = GameUtility.canDelete(isEquip: false, this.item.Id, this);
			blackMask.gameObject.SetActive(!flag);
			interactable = flag;
			return;
		}
		blackMask.gameObject.SetActive(value: false);
		interactable = true;
		if (maskshow0)
		{
			notEnoughMask.SetActive(item.Count == 0);
		}
	}

	public void LittleItemInit(Item item, bool needRefreshState = false)
	{
		ResetRoot(InitType.LittleItem);
		this.item = item;
		ItemId = item.Id;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy, long.MinValue, InitType.LittleItem);
		ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
		isLock = false;
		bottleIsEquip = false;
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		SetQualityBg();
		UpdateQualityStar(active: true);
		qualityStars.QualityInit(itemData.quality);
		UpdateItemCount(active: true, item.Count);
		UpdateCookIcon(active: true, itemData);
		UpdateRefineText(active: false);
		UpdateReduceBtn(active: false);
		UpdateCountTexUI(showMutiple: false);
		if (needRefreshState)
		{
			bool flag = GameUtility.canDelete(isEquip: false, this.item.Id, this);
			blackMask.gameObject.SetActive(!flag);
			interactable = flag;
		}
		else
		{
			blackMask.gameObject.SetActive(value: false);
			interactable = true;
		}
	}

	public void BloodBottleInit(Item bottle, ImageAssetStation station)
	{
		ResetRoot(InitType.BloodBottle);
		int key = RuntimeConfigs.data.potionDatas.FirstOrDefault((KeyValuePair<int, PotionData> b) => b.Value.itemId == bottle.Id).Key;
		item = bottle;
		ItemId = bottle.Id;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy, long.MinValue, InitType.BloodBottle);
		isLock = false;
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		SetQualityBg();
		BloodBottleData bloodBottleData = Model<BloodBottleModel>.Interface.curSceneBloodBottleInfo._allBottles[key];
		bloodBottleSlot.SoltInit(bloodBottleData, station);
		bottleIsEquip = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId == key;
		UpdateLevelText(active: true, bloodBottleData.curLevel);
		UpdateRefineText(active: false);
		UpdateReduceBtn(active: false);
		UpdateQualityStar(active: false);
	}

	public void BloodBottleMaterialInit(Item mat)
	{
		ResetRoot(InitType.BloodBottleMaterial);
		item = mat;
		ItemId = mat.Id;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy, long.MinValue, InitType.BloodBottleMaterial);
		ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
		isLock = false;
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		foreach (KeyValuePair<int, BloodBottleMaterial> bottleMaterial in Model<BloodBottleModel>.Interface.bottleMaterials)
		{
			if (mat.Id == bottleMaterial.Value.id)
			{
				bottleMatIsEquip = bottleMaterial.Value.isEquip;
				break;
			}
		}
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(itemData.quality);
		UpdateItemCount(active: true, mat.Count);
		UpdateCookIcon(active: true, itemData);
		UpdateRefineText(active: false);
		UpdateReduceBtn(active: false);
	}

	public void NoneItemInit(Item item)
	{
		ResetRoot(InitType.BagItem);
		this.item = item;
		ItemId = item.Id;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy);
		ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
		isLock = false;
		if (item.itemType != 5)
		{
			LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		}
		else
		{
			mainIconRoot.SetActive(value: false);
			characterIconRoot.SetActive(value: true);
			qualityStars.gameObject.SetActive(value: false);
			LoadCharacterIconSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		}
		UpdateItemCount(active: true, item.Count);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(itemData.quality);
		UpdateCookIcon(active: true, itemData);
		UpdateRefineText(active: false);
		UpdateReduceBtn(active: false);
	}

	public void SelectMaterialItemInit(Item item, int selectCount, bool cookitem = false)
	{
		ResetRoot(InitType.SelectMaterialItem);
		this.item = item;
		ItemId = item.Id;
		if (cookitem)
		{
			Release();
			ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
			SetData(itemUnifierProxy, long.MinValue, InitType.CookItem);
		}
		else
		{
			Release();
			ItemUnifierProxy itemUnifierProxy2 = ItemUnifierProxy.ItemUnifierPool.Get(item);
			SetData(itemUnifierProxy2);
		}
		count = selectCount;
		isLock = false;
		inBagCount = ((G.localPlayer.Inventory.GetItemInfo(item.Id) != null) ? G.localPlayer.Inventory.GetItemInfo(item.Id).Count : 0);
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[ItemId].iconAddress);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(RuntimeConfigs.data.itemDatas[item.Id].quality);
		UpdateReduceBtn(selectCount > 0);
		UpdateCookIcon(active: true, RuntimeConfigs.data.itemDatas[item.Id]);
		UpdateRefineText(active: false);
		if (selectCount > 0)
		{
			UpdateContrastCount(active: true, cookitem ? InitType.CharacterViewBagCharacter : InitType.SelectedCountContrastItem, selectCount, inBagCount);
			UpdateItemCount(active: false);
		}
		else
		{
			UpdateContrastCount(active: false);
			UpdateItemCount(active: true, inBagCount);
		}
		notEnoughMask.SetActive(inBagCount == 0);
	}

	public void BagCharacterInit(Character character, int[] teamCharacters, int teamIndex = -1, bool isFromSingle = true)
	{
		ResetRoot(InitType.TeamViewBagCharacter);
		this.character = character;
		Release();
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(character);
		SetData(itemUnifierProxy, long.MinValue, InitType.TeamViewBagCharacter);
		LoadCharacterIconSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, character.Id);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(character.GetQuality());
		UpdateLevelText(active: true, character.Level);
		UpdateTeam(teamIndex != -1, character, teamIndex, teamCharacters, isFromSingle);
	}

	public void RewardItemInit(Item item, bool receiveRewards = false, bool unLoadMainIcon = true)
	{
		ResetRoot(InitType.RewardItem);
		this.item = item;
		ItemId = item.Id;
		if (unLoadMainIcon)
		{
			Release();
		}
		else if (m_ItemUnifier != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(ref m_ItemUnifier);
		}
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy, long.MinValue, InitType.RewardItem);
		ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[item.Id].iconAddress);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(itemData.quality);
		UpdateItemCount(active: true, item.Count);
		UpdateCookIcon(active: true, itemData);
		IsComplete = receiveRewards;
	}

	public void NeedCountContrastItemInit(Item item, int needCount)
	{
		ResetRoot(InitType.NeedCountContrastItem);
		this.item = item;
		ItemId = item.Id;
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy);
		this.needCount = needCount;
		inBagCount = ((G.localPlayer.Inventory.GetItemInfo(item.Id) != null) ? G.localPlayer.Inventory.GetItemInfo(item.Id).Count : 0);
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[ItemId].iconAddress);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(RuntimeConfigs.data.itemDatas[item.Id].quality);
		UpdateContrastCount(active: true, InitType.NeedCountContrastItem, inBagCount, this.needCount);
	}

	public void ItemOwned()
	{
		IconManager.gameObject.SetActive(value: false);
		addIcon.gameObject.SetActive(value: false);
		NotOwned.SetActive(value: true);
	}

	public void ItemCraftInit(Item item, int leftCount, int rightCount, Color leftColor, Color rightColor)
	{
		ResetRoot(InitType.NeedCountContrastItem);
		this.item = item;
		ItemId = item.Id;
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item);
		SetData(itemUnifierProxy);
		LoadMainIconSprite(GameLoader.meta.itemAtlasNameAssetID, RuntimeConfigs.data.itemDatas[ItemId].iconAddress);
		SetQualityBg();
		UpdateQualityStar(active: true);
		bottleIsEquip = false;
		qualityStars.QualityInit(RuntimeConfigs.data.itemDatas[item.Id].quality);
		ItemCraftUpdateContrastCount(active: true, leftCount, rightCount, leftColor, rightColor);
	}

	public void SimpleCharacterInit(Character character)
	{
		this.character = character;
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(character);
		SetData(itemUnifierProxy, long.MinValue, InitType.TeamViewBagCharacter);
		isChosen = false;
		LoadMainIconSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, character.Id);
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		switch (ItemType)
		{
		case InitType.BagWeapon:
			BagWeaponInit(m_ItemUnifier.As<Weapon>());
			break;
		case InitType.CookItem:
			ShowSelectItem(m_ItemUnifier.As<Item>());
			break;
		case InitType.BagItem:
		case InitType.RewardItem:
			BagItemInit(m_ItemUnifier.As<Item>());
			break;
		case InitType.NoneItem:
			NoneItemInit(m_ItemUnifier.As<Item>());
			break;
		case InitType.BagGem:
			BagGemInit(m_ItemUnifier.As<Gem>());
			break;
		case InitType.BagEquip:
			BagEquipInit(m_ItemUnifier.As<Equip>());
			break;
		case InitType.BagChip:
		case InitType.TeamViewBagCharacter:
		case InitType.SelectMaterialItem:
		case InitType.LittleItem:
		case InitType.RewardWeapon:
		case InitType.RewardChip:
			break;
		}
	}
}
