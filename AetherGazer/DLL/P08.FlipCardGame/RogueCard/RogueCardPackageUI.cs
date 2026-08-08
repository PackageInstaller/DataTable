using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardPackageUI : RogueCardStateUIBase
{
	private enum PackageState
	{
		package,
		wuChang,
		joker
	}

	private PackageState state;

	public RogueCardWuchangPackageUI wuChangUI;

	public RogueCardJokerPackageUI jokerUI;

	public GameObject packageGo;

	public GameObject btnGo;

	public Button cancelBtn;

	public Button okBtn;

	public Button okBtn_gray;

	public Button packageBtn;

	public Text btnNumText;

	public Text btnNumText2;

	public Image packageImg;

	public Image packageDetailImg;

	public Text packNumText;

	[SerializeField]
	private float wuChangEffectStartDelay = 0.1f;

	public override void Init()
	{
		base.Init();
		AddBtnListener(cancelBtn, delegate
		{
			RogueCardSaveSystem.SendTrackingPoint3(RogueCardGameMain.Instance.saveSystem.GetGameData(), 0, 4, new List<int> { RogueCardGameMain.GameContext.packageJokerIndex });
			StartCoroutine(BackState());
		});
		AddBtnListener(okBtn, delegate
		{
			if (state == PackageState.joker)
			{
				if (RogueCardGameMain.GameContext.jokerData.HandCount >= RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] && (RogueCardGameMain.GameContext.jokerData.HandCount != RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] || RogueCardGameMain.GameContext.GetPackageJokerVersion(RogueCardGameMain.GameContext.packageJokerIndex) != 304))
				{
					LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_POKER_NO_VACANCY");
					return;
				}
				RogueCardGameMain.Instance.PackageGainJoker();
				RogueCardGameMain.GameContext.lastPackageNum--;
				if (RogueCardGameMain.GameContext.lastPackageNum <= 0)
				{
					RogueCardGameMain.GameContext.ClearPackageJokerData();
					ExitCompletedPackage();
				}
				else
				{
					jokerUI.RefreshCards();
					RefreshUI();
				}
				RogueCardGameMain.Instance.saveSystem.SaveGameData();
			}
			else
			{
				int wuChangID = RogueCardGameMain.Instance.gameContext.curPackageWuChangID;
				if (wuChangID == 0)
				{
					int selectWuChangIndex = RogueCardGameMain.GameContext.selectWuChangIndex;
					if (selectWuChangIndex >= 0 && selectWuChangIndex < RogueCardGameMain.GameContext.packageWuChang.Count)
					{
						wuChangID = RogueCardGameMain.GameContext.packageWuChang[selectWuChangIndex];
						RogueCardSaveSystem.SendTrackingPoint4(RogueCardGameMain.Instance.saveSystem.GetGameData(), 1, RogueCardGameMain.GameContext.wuChangWaitCards.handCards, RogueCardGameMain.GameContext.GetWuChangSelect, wuChangID, RogueCardGameMain.GameContext.packageWuChang);
					}
				}
				else
				{
					RogueCardSaveSystem.SendTrackingPoint4(RogueCardGameMain.Instance.saveSystem.GetGameData(), 1, RogueCardGameMain.GameContext.wuChangWaitCards.handCards, RogueCardGameMain.GameContext.GetWuChangSelect, wuChangID);
				}
				RogueCardItemCfg rogueCardItemCfg = ((wuChangID > 0) ? RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == wuChangID) : null);
				if (rogueCardItemCfg != null && rogueCardItemCfg.type == ItemType.BlackWuChang)
				{
					RogueCardGameMain.Instance.ConfirmBlackWuChangCoverIfNeeded(wuChangID, RogueCardGameMain.GameContext.GetWuChangSelect, delegate
					{
						StartCoroutine(PlayWuChangEffect());
					});
				}
				else
				{
					StartCoroutine(PlayWuChangEffect());
				}
			}
			RogueCardGameMain.Instance.HideTips();
		});
		AddBtnListener(okBtn_gray, delegate
		{
			if (state == PackageState.wuChang && RogueCardGameMain.GameContext.selectWuChangIndex == -1)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_SUPPORT");
			}
			else
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_CARD");
			}
		});
		wuChangUI.Init();
		jokerUI.Init();
	}

	private IEnumerator BackState()
	{
		InputLockToken wuChangLock = RogueCardGameMain.Instance.GetInputLock("WuChang_Lock", base.gameObject, 2f);
		try
		{
			yield return new WaitForSecondsRealtime(0.3f);
			yield return StartCoroutine(wuChangUI.ExitPackage());
			if (state == PackageState.joker)
			{
				RogueCardGameMain.GameContext.ClearPackageJokerData();
				RogueCardGameMain.GameContext.packageJokerIndex = -1;
			}
			if (RogueCardGameMain.Instance.CheckBackState())
			{
				RogueCardGameMain.Instance.BackMainState();
			}
			else
			{
				RogueCardGameMain.Instance.ChangeMainState(new ShopState(isRefresh: false));
			}
		}
		finally
		{
			wuChangLock?.Release();
		}
	}

	private void ExitCompletedPackage()
	{
		RogueCardGameMain.GameContext.lastPackageNum = 0;
		RogueCardGameMain.GameContext.curPackageID = 0;
		RogueCardGameMain.GameContext.curPackageWuChangID = 0;
		RogueCardGameMain.GameContext.packageJokerIndex = -1;
		RogueCardGameMain.GameContext.selectWuChangIndex = -1;
		if (RogueCardGameMain.Instance.CheckBackState())
		{
			RogueCardGameMain.Instance.BackMainState();
		}
		else
		{
			RogueCardGameMain.Instance.ChangeMainState(new ShopState(isRefresh: false));
		}
	}

	private IEnumerator PlayWuChangEffect()
	{
		InputLockToken wuChangLock = RogueCardGameMain.Instance.GetInputLock("WuChang_Effect", base.gameObject);
		bool deferredRefreshBegun = false;
		bool deferredRefreshEnded = false;
		bool isSingleWuChangPurchase = RogueCardGameMain.Instance.gameContext.curPackageID == 0 && RogueCardGameMain.Instance.gameContext.curPackageWuChangID != 0;
		int wuChangID = ((RogueCardGameMain.Instance.gameContext.curPackageWuChangID != 0) ? RogueCardGameMain.Instance.gameContext.curPackageWuChangID : RogueCardGameMain.GameContext.packageWuChang[RogueCardGameMain.GameContext.selectWuChangIndex]);
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == wuChangID);
		bool isDeleteEffect = rogueCardItemCfg != null && rogueCardItemCfg.type == ItemType.WhiteWuChang && rogueCardItemCfg.effect_list != null && rogueCardItemCfg.effect_list.Length != 0 && rogueCardItemCfg.effect_list[0] == 5;
		bool isCopyEffect = rogueCardItemCfg != null && rogueCardItemCfg.type == ItemType.WhiteWuChang && rogueCardItemCfg.effect_list != null && rogueCardItemCfg.effect_list.Length != 0 && rogueCardItemCfg.effect_list[0] == 6;
		bool applyEffectBeforeFlip = rogueCardItemCfg != null && rogueCardItemCfg.type == ItemType.WhiteWuChang && rogueCardItemCfg.effect_list != null && rogueCardItemCfg.effect_list.Length != 0 && (rogueCardItemCfg.effect_list[0] == 5 || rogueCardItemCfg.effect_list[0] == 6);
		try
		{
			if (!isSingleWuChangPurchase)
			{
				RogueCardGameMain.GameContext.lastPackageNum--;
				RefreshTextUI();
				HideBtn();
			}
			else
			{
				HideBtn();
			}
			RogueCardGameMain.Instance.BeginDeferredRefreshUI();
			deferredRefreshBegun = true;
			if (applyEffectBeforeFlip)
			{
				if (isDeleteEffect)
				{
					wuChangUI.CacheDestroyCardSnapshot();
				}
				RogueCardGameMain.Instance.AddPackageWuChang();
			}
			yield return new WaitForSecondsRealtime(wuChangEffectStartDelay);
			float time = wuChangUI.PlayWuChangAni();
			float flipChangeDelay = Mathf.Min(0.3f, time);
			yield return new WaitForSecondsRealtime(flipChangeDelay);
			int wuchangIndex = RogueCardGameMain.GameContext.selectWuChangIndex;
			if (RogueCardGameMain.Instance.gameContext.curPackageWuChangID != 0)
			{
				wuchangIndex = 0;
			}
			if (!applyEffectBeforeFlip)
			{
				RogueCardGameMain.Instance.AddPackageWuChang();
			}
			RogueCardGameMain.Instance.DoWuChang();
			if (!isDeleteEffect && !isCopyEffect)
			{
				foreach (RogueCard card in wuChangUI.handHolder.cards)
				{
					RogueCardData cardDataAtDisplayIndex = RogueCardGameMain.GameContext.wuChangWaitCards.GetCardDataAtDisplayIndex(card.ParentIndex());
					if (cardDataAtDisplayIndex != null && card.cardVisual != null)
					{
						(card.cardVisual as VisualRogueCard).ShowCardData(cardDataAtDisplayIndex);
					}
				}
			}
			float b = Mathf.Max(0.6f, time) - flipChangeDelay;
			yield return new WaitForSecondsRealtime(Mathf.Max(0f, b));
			wuChangUI.wuChangList[wuchangIndex].view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
			yield return new WaitForSecondsRealtime(0.4f);
			for (int num = 0; num < wuChangUI.wuChangList.Count; num++)
			{
				wuChangUI.wuChangList[num].SetSelect(isSelect: false);
			}
			if (isDeleteEffect)
			{
				wuChangUI.FinishDestroyAnimation();
			}
			RogueCardGameMain.GameContext.RefreshWuChangData();
			RogueCardGameMain.Instance.EndDeferredRefreshUI();
			deferredRefreshEnded = true;
			wuChangUI.RefreshCards();
			yield return new WaitForSecondsRealtime(0.5f);
			RefreshUI();
			if (RogueCardGameMain.GameContext.lastPackageNum > 0)
			{
				RogueCardGameMain.Instance.saveSystem.SaveGameData();
			}
			if (isSingleWuChangPurchase || RogueCardGameMain.GameContext.lastPackageNum <= 0)
			{
				yield return new WaitForSecondsRealtime(0.3f);
				yield return StartCoroutine(wuChangUI.ExitPackage());
				RogueCardGameMain.Instance.ClearWuChangData();
				ExitCompletedPackage();
			}
		}
		finally
		{
			if (deferredRefreshBegun && !deferredRefreshEnded)
			{
				RogueCardGameMain.Instance.EndDeferredRefreshUI();
			}
			wuChangLock?.Release();
		}
	}

	private IEnumerator PlayPackageAni()
	{
		InputLockToken wuChangLock = RogueCardGameMain.Instance.GetInputLock("WuChang_Effect", base.gameObject, 3f);
		try
		{
			yield return new WaitForSecondsRealtime(1.2f);
			RogueCardGameMain.Instance.OpenPackage();
		}
		finally
		{
			wuChangLock?.Release();
		}
	}

	public override void RefreshUI()
	{
		base.RefreshUI();
		wuChangUI.RefreshUI();
		jokerUI.RefreshUI();
		RefreshTextUI();
	}

	public void RefreshTextUI()
	{
		if (RogueCardGameMain.Instance.gameContext.curPackageID != 0)
		{
			RogueCardPackageCfg rogueCardPackageCfg = RogueCardDataManager.packageDatabase[RogueCardGameMain.GameContext.curPackageID];
			btnNumText.text = $"{RogueCardGameMain.GameContext.lastPackageNum} / {rogueCardPackageCfg.content[1]}";
			btnNumText2.text = $"{RogueCardGameMain.GameContext.lastPackageNum} / {rogueCardPackageCfg.content[1]}";
		}
		else
		{
			btnNumText.text = "";
			btnNumText2.text = "";
		}
		if ((state == PackageState.joker && RogueCardGameMain.GameContext.packageJokerIndex == -1) || (state == PackageState.wuChang && (RogueCardGameMain.GameContext.wuChangWaitCards.GetSelectIndexList().Length == 0 || (RogueCardGameMain.Instance.gameContext.curPackageID != 0 && RogueCardGameMain.GameContext.selectWuChangIndex == -1))))
		{
			okBtn.gameObject.SetActive(value: false);
			okBtn_gray.gameObject.SetActive(value: true);
		}
		else
		{
			okBtn.gameObject.SetActive(value: true);
			okBtn_gray.gameObject.SetActive(value: false);
		}
	}

	public void HideBtn()
	{
		okBtn.gameObject.SetActive(value: false);
		okBtn_gray.gameObject.SetActive(value: true);
	}

	public override void OnEnter()
	{
		if (RogueCardGameMain.Instance.gameContext.curPackageWuChangID != 0 && RogueCardGameMain.Instance.gameContext.curPackageID == 0)
		{
			base.OnEnter();
			ChangeSubWuChangUI();
			return;
		}
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			bool flag = RogueCardGameMain.GameContext.packageJoker != null && RogueCardGameMain.GameContext.packageJoker.Count > 0;
			bool flag2 = (RogueCardGameMain.GameContext.packageWuChang != null && RogueCardGameMain.GameContext.packageWuChang.Count > 0) || (RogueCardGameMain.GameContext.wuChangWaitCards != null && RogueCardGameMain.GameContext.wuChangWaitCards.HandCount > 0) || RogueCardGameMain.Instance.gameContext.curPackageWuChangID != 0;
			if (flag | flag2)
			{
				base.OnEnter();
				if (flag)
				{
					ChangeSubWuJokerUI();
				}
				else
				{
					ChangeSubWuChangUI();
				}
				return;
			}
		}
		RogueCardPackageCfg rogueCardPackageCfg = RogueCardDataManager.packageDatabase[RogueCardGameMain.Instance.gameContext.curPackageID];
		AtlasManager.GetSpriteWithoutAtlas(packageImg, "TextureConfig/Activity_JokerCard/item/" + rogueCardPackageCfg.icon);
		AtlasManager.GetSpriteWithoutAtlas(packageDetailImg, "TextureConfig/Activity_JokerCard/item/" + rogueCardPackageCfg.icon2);
		packNumText.text = $"<size=38>{rogueCardPackageCfg.content[0]}</size>/{rogueCardPackageCfg.content[1]}";
		base.OnEnter();
		state = PackageState.package;
		jokerUI.Show(isShow: false);
		wuChangUI.Show(isShow: false);
		packageGo.SetActive(value: true);
		btnGo.SetActive(value: false);
		StartCoroutine(PlayPackageAni());
	}

	public override void OnExit()
	{
		base.OnExit();
	}

	public void ChangeSubWuChangUI()
	{
		state = PackageState.wuChang;
		jokerUI.Show(isShow: false);
		wuChangUI.Show(isShow: true);
		packageGo.SetActive(value: false);
		btnGo.SetActive(value: true);
		wuChangUI.OnEnter();
	}

	public void ChangeSubWuJokerUI()
	{
		state = PackageState.joker;
		jokerUI.Show(isShow: true);
		wuChangUI.Show(isShow: false);
		packageGo.SetActive(value: false);
		btnGo.SetActive(value: true);
		jokerUI.OnEnter();
	}
}
