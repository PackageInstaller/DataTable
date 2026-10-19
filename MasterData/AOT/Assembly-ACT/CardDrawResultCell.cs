using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Sound;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;

public class CardDrawResultCell : MonoBehaviour
{
	public GameObject GoIsNew;

	public BImage ImageTextQuality;

	public List<GameObject> listStar;

	public Sprite[] normalQualitySprites;

	public GameObject GoItemRoot;

	public GameObject GoItem;

	public BImage ImageItemIcon;

	public TextMeshProUGUI TextItemNum;

	public GameObject GoCharacterRoot;

	public BImage ImageCharacterIcon;

	public CharacterProfessionIcon ImageProfessionIcon;

	public BImage ImageElementIcon;

	public GameObject Godestiny;

	public BImage ImageDestinyIcon;

	public LiteItemUIComponent ExtraItem;

	private ImageAssetStation _station;

	public BetterAnimation betterAnimation;

	public BImage itemQualityBoard;

	public GameObject GoFirstGuranteed;

	private int ItemType;

	private ItemData m_itemData;

	private EntityCharacterData m_characterData;

	private int _gachaId;

	private int _gachaType;

	public List<GameObject> QualityList = new List<GameObject>();

	public List<Color> TextColorList = new List<Color>();

	public ActButton BtnClick;

	private bool _canClick;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void Init(GachaCardDrawItem CardDrawItem, ImageAssetStation station, bool isCharacterMaxConstellation, bool isSingle, int gachaId, int gachaType)
	{
		Item poolItem = CardDrawItem.PoolItem;
		_station = station;
		GoIsNew.SetActive(poolItem.IsNew);
		m_itemData = CoreUtils.GetData(poolItem.Id, RuntimeConfigs.data.itemDatas);
		ItemType = m_itemData.type;
		_gachaId = gachaId;
		_gachaType = gachaType;
		GoCharacterRoot.SetActive(m_itemData.type == 5);
		GoItemRoot.SetActive(m_itemData.type != 5);
		RefreshQuality(m_itemData.quality);
		if (m_itemData.type == 5)
		{
			int id = m_itemData.canBeTransited[0].id;
			m_characterData = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
			ShowCharacter(m_itemData, poolItem, isCharacterMaxConstellation);
		}
		else
		{
			ShowItem(m_itemData, poolItem.Count);
		}
		BtnClick.SetBtnClick(OnClick);
		SetClickEnabled(enabled: false);
		CheckNeedPlayAni();
		GoFirstGuranteed.SetActive(value: false);
	}

	public void SetClickEnabled(bool enabled)
	{
		_canClick = enabled;
		if (BtnClick != null)
		{
			BtnClick.Interactable(enabled);
		}
	}

	private void OnClick()
	{
		if (_canClick)
		{
			if (m_itemData.type == 5)
			{
				ReportGachaClick();
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CHARACTER, new CharacterViewData
				{
					defaultCharacterId = m_characterData.id
				});
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
				{
					Id = m_itemData.id
				});
			}
		}
	}

	private void ReportGachaClick()
	{
		GachaClickEvent evt = EventTrackSolver.Instance.GetEvt<GachaClickEvent>();
		evt.gachaId = _gachaId;
		evt.gachaType = _gachaType;
		evt.type = 3;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void RefreshQuality(int quality)
	{
		int num = ((quality >= 3) ? (quality - 3) : 0);
		for (int i = 0; i < QualityList.Count; i++)
		{
			QualityList[i].SetActive(i == num);
		}
		ImageTextQuality.icon.color = TextColorList[num];
		_station.LoadImage(193, quality, itemQualityBoard);
	}

	public void CheckNeedPlayAni()
	{
		betterAnimation.GetSequence("Show").Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward10_Role", new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private void ShowCharacter(ItemData itemData, Item item, bool isCharacterMaxConstellation)
	{
		int id = itemData.canBeTransited[0].id;
		EntityCharacterData data = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
		EntityData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.entityDatas);
		if (data != null)
		{
			ImageProfessionIcon.UpdateDisPlay(id);
		}
		_station.LoadImage(148, id, ImageCharacterIcon);
		Godestiny.SetActive(!item.IsNew);
		if (item.IsNew)
		{
			return;
		}
		int num = 0;
		int num2 = 0;
		if (isCharacterMaxConstellation)
		{
			num2 = RuntimeConfigs.data.game.gachaDrawRoleToken;
			if (data.stars == 4)
			{
				num = RuntimeConfigs.data.game.gachaDraw4StarDestinedNum;
			}
			else if (data.stars >= 5)
			{
				num = RuntimeConfigs.data.game.gachaDraw5StarDestinedNum;
			}
		}
		else
		{
			num2 = data.ConstellationItem;
			num = 1;
		}
		if (num2 != 0)
		{
			ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(num2, num);
			ExtraItem.SetData(item2, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			ExtraItem.UpdatePerformance();
		}
	}

	private void ShowItem(ItemData itemData, int ItemNum)
	{
		_station.LoadItemIcon(itemData.iconAddress, ImageItemIcon);
		TextItemNum.SetText("x{0:0}", ItemNum);
	}

	private void QualityInit(int Quality)
	{
		for (int i = 0; i < listStar.Count; i++)
		{
			listStar[i].SetActive(i < Quality);
		}
	}

	public void SetCanvaGroupAlpha(float value)
	{
		gameObject.GetComponent<CanvasGroup>().alpha = value;
	}
}
