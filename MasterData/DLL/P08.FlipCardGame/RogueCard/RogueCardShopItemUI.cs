using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardShopItemUI : MonoBehaviour, IRogueCardNeedTip
{
	public Text costNum;

	public ControllerExCollection controllerEx;

	public Button button;

	private ControllerEx tipCon;

	private ControllerEx selectCon;

	private ControllerEx qualityCon;

	private ControllerEx typeCon;

	private ControllerEx wuchangCon;

	[HideInInspector]
	public int index;

	public Image jokerIconImg;

	public Image wuchangIconImg;

	public Image packageIconImg;

	public Image packageDetailImg;

	public GameObject versionGo;

	public Image versionImg;

	public Text packageText;

	private ShopItemData itemData;

	private ShopPackageData packageData;

	public Animator mainAni;

	public Animator rootAni;

	public GameObject newGo;

	public void Awake()
	{
		tipCon = controllerEx.GetController("looktips");
		selectCon = controllerEx.GetController("select");
		qualityCon = controllerEx.GetController("quality");
		typeCon = controllerEx.GetController("Type");
		wuchangCon = controllerEx.GetController("WuChang");
	}

	public void SetSelected(bool isSelect)
	{
		selectCon.SetSelectedState(isSelect ? "on" : "off");
		if (isSelect)
		{
			if (!rootAni.GetCurrentAnimatorStateInfo(0).IsName("UI_Com_RogueCardBaseItem_select"))
			{
				rootAni.Play("UI_Com_RogueCardBaseItem_select");
			}
		}
		else
		{
			rootAni.Play("empty");
			rootAni.Rebind();
		}
	}

	public void Show(bool isShow)
	{
		base.transform.SetActive(isShow);
	}

	public void SetData(ShopItemData data)
	{
		bool flag = false;
		if (itemData == data)
		{
			flag = true;
		}
		itemData = data;
		packageData = null;
		RefreshUI();
		if (itemData.versionID <= 0)
		{
		}
	}

	public void SetData(ShopPackageData data)
	{
		packageData = data;
		itemData = null;
		RefreshUI();
	}

	public void RefreshUI()
	{
		versionGo.SetActive(value: false);
		mainAni.Rebind();
		if (itemData != null)
		{
			costNum.text = itemData.GetPrice().ToString();
			if (itemData.GetPrice() > RogueCardGameMain.GameContext.gold)
			{
				costNum.color = Color.red;
			}
			else
			{
				costNum.SetColor(Color.white);
			}
			qualityCon.SetSelectedIndex(itemData.cfg.rare);
			if (itemData.cfg.type == ItemType.Joker)
			{
				typeCon.SetSelectedState("cards");
				AtlasManager.GetSpriteWithoutAtlas(jokerIconImg, "TextureConfig/Activity_JokerCard/item/" + itemData.cfg.icon);
				if (itemData.versionID > 0)
				{
					versionGo.SetActive(value: true);
					RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[itemData.versionID];
					AtlasManager.GetSpriteWithoutAtlas(versionImg, "TextureConfig/Activity_JokerCard/itembg/" + rogueCardEnhanceCfg.icon);
				}
			}
			else
			{
				qualityCon.SetSelectedIndex(0);
				if (itemData.cfg.rare > 1)
				{
					if (itemData.cfg.type == ItemType.BlackWuChang)
					{
						wuchangCon.SetSelectedState("blackhigh");
					}
					else
					{
						wuchangCon.SetSelectedState("whitehigh");
					}
				}
				else if (itemData.cfg.type == ItemType.BlackWuChang)
				{
					wuchangCon.SetSelectedState("black");
				}
				else
				{
					wuchangCon.SetSelectedState("white");
				}
				typeCon.SetSelectedState("wuchang");
				AtlasManager.GetSpriteWithoutAtlas(wuchangIconImg, "TextureConfig/Activity_JokerCard/itembg/" + itemData.cfg.icon);
			}
			if (RogueCardGameMain.Instance.CheckIsNew(1, itemData.cfg.id) || RogueCardGameMain.Instance.CheckIsNew(2, itemData.versionID))
			{
				newGo.SetActive(value: true);
			}
			else
			{
				newGo.SetActive(value: false);
			}
		}
		if (packageData != null)
		{
			typeCon.SetSelectedState("cardbag");
			costNum.text = packageData.GetPrice().ToString();
			if (packageData.GetPrice() > RogueCardGameMain.GameContext.gold)
			{
				costNum.color = Color.red;
			}
			else
			{
				costNum.SetColor(Color.white);
			}
			AtlasManager.GetSpriteWithoutAtlas(packageIconImg, "TextureConfig/Activity_JokerCard/item/" + packageData.cfg.icon);
			AtlasManager.GetSpriteWithoutAtlas(packageDetailImg, "TextureConfig/Activity_JokerCard/item/" + packageData.cfg.icon2);
			packageText.text = $"<size=19>{packageData.cfg.content[0]}</size>/{packageData.cfg.content[1]}";
			newGo.SetActive(value: false);
		}
	}

	public void BindBtn(Action<int> action)
	{
		button.onClick.RemoveAllListeners();
		button.onClick.AddListener(delegate
		{
			if (!RogueCardGameMain.CheckDisableInput(LockItemType.shopItem, index))
			{
				action(index);
				if (itemData != null)
				{
					if (RogueCardGameMain.GameContext.shopData.selectIndex == index)
					{
						RogueCardGameMain.Instance.ShowTips(itemData, this);
					}
					else
					{
						RogueCardGameMain.Instance.ShowTips(itemData, this);
					}
				}
				if (packageData != null)
				{
					if (RogueCardGameMain.GameContext.shopData.selectIndex == index)
					{
						RogueCardGameMain.Instance.ShowTips(packageData.cfg, this);
					}
					else
					{
						RogueCardGameMain.Instance.ShowTips(packageData.cfg, this);
					}
				}
			}
		});
	}

	public void SetLookTips(bool isSelect)
	{
		tipCon.SetSelectedState(isSelect ? "on" : "off");
	}
}
