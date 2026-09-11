using System;
using System.Collections;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardCommonView : MonoBehaviour, IRogueCardNeedTip
{
	private RogueCardData cardData;

	private RogueCardItemCfg itemCfg;

	[HideInInspector]
	public int index;

	[HideInInspector]
	public bool selected;

	[Header("Bind")]
	public ControllerExCollection controllerExCollection;

	public Image enhanceIcon;

	public Image tagIcon;

	public Image deckImg;

	public Animator animator;

	public Animator rootAni;

	private ControllerEx tipController;

	private ControllerEx selectController;

	private ControllerEx modeController;

	private ControllerEx suitController;

	private ControllerEx tagController;

	private ControllerEx enhanceController;

	private ControllerEx spEnhanceController;

	private ControllerEx failureController;

	private ControllerEx wuChangController;

	private ControllerEx employController;

	private ControllerEx shadowController;

	[Header("普通卡")]
	public Text rank1;

	public Text rank2;

	[Header("无常牌")]
	public bool isWuChang;

	public Image wuchangImg;

	public RogueCardFlyNumberUI flyNumber;

	private bool _init;

	private bool _pure;

	private int _pureID;

	[HideInInspector]
	public Canvas canvas;

	public RogueCardItemCfg ItemCfg => itemCfg;

	public void SetData(Suit suit, Rank rank)
	{
		if (!_init)
		{
			Init();
		}
		index = 0;
		isWuChang = false;
		modeController.SetSelectedState("card");
		cardData = new RogueCardData(suit, rank);
		itemCfg = null;
		_pure = false;
		_pureID = 0;
		RefreshUI();
	}

	public void SetData(RogueCardData cardData)
	{
		if (!_init)
		{
			Init();
		}
		index = 0;
		isWuChang = false;
		modeController.SetSelectedState("card");
		this.cardData = cardData;
		itemCfg = null;
		_pure = false;
		_pureID = 0;
		RefreshUI();
	}

	public void SetData(RogueCardData cardData, int index, bool pure = false, int pureID = 0)
	{
		if (!_init)
		{
			Init();
		}
		this.index = index;
		isWuChang = false;
		modeController.SetSelectedState("card");
		this.cardData = cardData;
		itemCfg = null;
		_pure = pure;
		_pureID = pureID;
		RefreshUI();
	}

	public void SetData(RogueCardItemCfg wuChangCfg, int index)
	{
		if (!_init)
		{
			Init();
		}
		this.index = index;
		isWuChang = true;
		modeController.SetSelectedState("wuchang");
		itemCfg = wuChangCfg;
		cardData = null;
		_pure = false;
		_pureID = 0;
		RefreshUI();
	}

	public void Awake()
	{
		Init();
	}

	public void Init()
	{
		_init = true;
		tipController = controllerExCollection.GetController("looktips");
		selectController = controllerExCollection.GetController("select");
		modeController = controllerExCollection.GetController("Mode");
		suitController = controllerExCollection.GetController("cardsuit");
		wuChangController = controllerExCollection.GetController("wuchangsuit");
		employController = controllerExCollection.GetController("employ");
		failureController = controllerExCollection.GetController("failure");
		tagController = controllerExCollection.GetController("Seal");
		enhanceController = controllerExCollection.GetController("reinforce");
		spEnhanceController = controllerExCollection.GetController("SPreinforce");
		shadowController = controllerExCollection.GetController("shadow");
		flyNumber.Init();
		canvas = GetComponent<Canvas>();
	}

	private void OnEnable()
	{
		try
		{
			base.transform.localScale = Vector3.one;
			base.transform.localRotation = Quaternion.identity;
			if (animator != null)
			{
				animator.Rebind();
				animator.Play("empty", -1, 0f);
				animator.Update(0f);
			}
			if (rootAni != null)
			{
				rootAni.Rebind();
				rootAni.Play("empty", -1, 0f);
				rootAni.Update(0f);
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("RogueCardCommonView OnEnable reset failed: " + ex.Message);
		}
	}

	public void SetSelect(bool isSelect)
	{
		selected = isSelect;
		bool flag = rootAni != null && rootAni.isActiveAndEnabled && rootAni.gameObject.activeInHierarchy;
		if (isSelect)
		{
			if (flag && !rootAni.GetCurrentAnimatorStateInfo(0).IsName("UI_Com_RogueCardBaseItem_select"))
			{
				rootAni.Play("UI_Com_RogueCardBaseItem_select", -1, 0f);
			}
			selectController.SetSelectedState("on");
		}
		else
		{
			if (flag)
			{
				rootAni.Play("empty", -1, 0f);
			}
			selectController.SetSelectedState("off");
		}
	}

	public void SetActive(bool isActive)
	{
		base.gameObject.SetActive(isActive);
	}

	public void RefreshUI()
	{
		if (!_init)
		{
			Init();
		}
		if (isWuChang)
		{
			if (itemCfg.rare == 1)
			{
				wuChangController.SetSelectedState((itemCfg.type == ItemType.WhiteWuChang) ? "white" : "black");
			}
			else
			{
				wuChangController.SetSelectedState((itemCfg.type == ItemType.WhiteWuChang) ? "whiteup" : "blackup");
			}
			AtlasManager.GetSpriteWithoutAtlas(wuchangImg, "TextureConfig/Activity_JokerCard/itembg/" + itemCfg.icon);
		}
		else
		{
			string rankStr = cardData.GetRankStr();
			rank1.text = rankStr;
			rank2.text = rankStr;
			if (suitController == null)
			{
				suitController = controllerExCollection.GetController("cardsuit");
			}
			suitController.SetSelectedIndex((int)(cardData.suit - 1));
			if (cardData.enhanceID > 0 && _pureID != cardData.enhanceID)
			{
				RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[cardData.enhanceID];
				rank2.text += rogueCardEnhanceCfg.name;
				if (cardData.enhanceID == 104)
				{
					spEnhanceController.SetSelectedState("on");
					enhanceController.SetSelectedState("off");
				}
				else
				{
					spEnhanceController.SetSelectedState("off");
					enhanceController.SetSelectedState("on");
					AtlasManager.GetSpriteWithoutAtlas(enhanceIcon, "TextureConfig/Activity_JokerCard/itembg/" + rogueCardEnhanceCfg.icon);
				}
			}
			else
			{
				spEnhanceController.SetSelectedState("off");
				enhanceController.SetSelectedState("off");
			}
			if (cardData.tagID > 0 && _pureID != cardData.tagID)
			{
				RogueCardEnhanceCfg rogueCardEnhanceCfg2 = RogueCardDataManager.enhanceDatabase[cardData.tagID];
				rank2.text += rogueCardEnhanceCfg2.name;
				tagController.SetSelectedState("on");
				AtlasManager.GetSpriteWithoutAtlas(tagIcon, "TextureConfig/Activity_JokerCard/itembg/" + rogueCardEnhanceCfg2.icon);
			}
			else
			{
				tagController.SetSelectedState("off");
			}
			if (cardData.effectDisable)
			{
				failureController.SetSelectedState("on");
			}
			else
			{
				failureController.SetSelectedState("off");
			}
		}
		AtlasManager.GetSpriteWithoutAtlas(deckImg, $"TextureConfig/Activity_JokerCard/itembg/rogue_card_back_{RogueCardGameMain.GameContext.rogueDeck.deckID}_02");
		SetShadow(isShadow: false);
	}

	public void PlayAnimation(string name, float speed = 1f)
	{
		if (!(animator == null) && animator.isActiveAndEnabled && animator.gameObject.activeInHierarchy && !animator.GetCurrentAnimatorStateInfo(0).IsName(name))
		{
			animator.Play(name, 0, 0f);
			animator.speed = speed;
		}
	}

	public IEnumerator PlayFlyNum(string text, FlyNumberType type, bool speed = false)
	{
		flyNumber.ShowFlyText(text, type);
		yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_FlyText", speed));
		flyNumber.HideText();
	}

	public void SetLookTips(bool isSelect)
	{
		tipController.SetSelectedState(isSelect ? "on" : "off");
	}

	public void SetShadow(bool isShadow)
	{
		shadowController.SetSelectedState(isShadow ? "on" : "off");
	}
}
