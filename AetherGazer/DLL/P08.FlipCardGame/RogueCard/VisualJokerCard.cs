using System;
using System.Collections;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class VisualJokerCard : VisualCardBase
{
	[SerializeField]
	public GameObject qualityGo;

	public ControllerExCollection mainController;

	private ControllerEx lookTipsCon;

	private ControllerEx qualityCon;

	private ControllerEx validCon;

	private ControllerEx versionCon;

	private ControllerEx copyCon;

	private ControllerEx damoCon;

	[SerializeField]
	private Image cardImage;

	public Animator mainAnimator;

	public Image versionImg;

	public RogueCardFlyNumberUI flyNumber;

	public Animator versionAni;

	public GameObject versionAniGo;

	public Animator validAni;

	public GameObject validGo;

	private int leftID;

	public float hideAnimDuration = 0.3f;

	public override void Initialize(RogueCard target, int index = 0)
	{
		base.Initialize(target, index);
		lookTipsCon = mainController.GetController("looktips");
		qualityCon = mainController.GetController("quality");
		validCon = mainController.GetController("state");
		versionCon = mainController.GetController("reinforce");
		copyCon = mainController.GetController("copy");
		damoCon = mainController.GetController("damo");
		flyNumber.Init();
	}

	protected override void BeginDrag(RogueCard card)
	{
		base.BeginDrag(card);
		RogueCardGameMain.Instance.HideTips();
		RogueCardGameMain.Instance.OnJokerDrag(isDrag: true, parentCard.ParentIndex());
	}

	protected override void EndDrag(RogueCard card)
	{
		RogueCardGameMain.Instance?.OnJokerDrag(isDrag: false, parentCard.ParentIndex());
		base.EndDrag(card);
	}

	public void SetValid(bool show)
	{
		LeanTween.cancel(validGo);
		if (show)
		{
			validCon.SetSelectedState("invalid");
		}
		else if (validGo.activeInHierarchy)
		{
			validAni.Play("UI_mask_xs");
			LeanTween.delayedCall(validGo, hideAnimDuration, (Action)delegate
			{
				validCon.SetSelectedState("normal");
			});
		}
	}

	public void ShowCardData(RogueCardJokerData data)
	{
		if (data == null)
		{
			return;
		}
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == data.realID);
		RogueCardItemCfg itemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == data.id);
		qualityCon.SetSelectedIndex(rogueCardItemCfg.rare - 1);
		versionCon.SetSelectedState((data.versionID > 0) ? "on" : "off");
		copyCon.SetSelectedState("off");
		damoCon.SetSelectedState("off");
		if (data.realID == 311)
		{
			leftID = 0;
			if (data.realID == data.id)
			{
				validCon.SetSelectedState("invalid");
			}
			else
			{
				damoCon.SetSelectedState("on");
				if (validCon.GetSelectedState() == "invalid")
				{
					SetValid(show: false);
				}
				else
				{
					validCon.SetSelectedState("normal");
				}
			}
		}
		else if (data.realID == 306)
		{
			RogueCardJokerData leftJoker = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
			if (leftJoker.realID != leftID)
			{
				leftID = leftJoker.realID;
				PlayAnimation("UI_Com_JokerCarditem_refresh");
				float delayTime = 0.28f;
				LeanTween.cancel(base.gameObject);
				LeanTween.delayedCall(base.gameObject, delayTime, (Action)delegate
				{
					if (leftJoker != null)
					{
						RogueCardItemCfg rogueCardItemCfg3 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == leftJoker.realID);
						if (rogueCardItemCfg3.no_copy)
						{
							validCon.SetSelectedState("invalid");
						}
						else
						{
							itemCfg = rogueCardItemCfg3;
							copyCon.SetSelectedState("on");
							if (validCon.GetSelectedState() == "invalid")
							{
								SetValid(show: false);
							}
							else
							{
								validCon.SetSelectedState("normal");
							}
						}
					}
					else
					{
						copyCon.SetSelectedState("off");
						if (validCon.GetSelectedState() == "invalid")
						{
							SetValid(show: false);
						}
						else
						{
							validCon.SetSelectedState("normal");
						}
					}
					AtlasManager.GetSpriteWithoutAtlas(cardImage, "TextureConfig/Activity_JokerCard/item/" + itemCfg.icon);
				});
				bool flag = false;
				if (!RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == leftJoker.realID).no_copy)
				{
					for (int num = 0; num < leftJoker.effect.Count; num++)
					{
						RogueCardGameEffect rogueCardGameEffect = leftJoker.effect[num];
						if (rogueCardGameEffect == null)
						{
							break;
						}
						RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[rogueCardGameEffect.effectID];
						if (rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire && rogueCardEffectCfg != null && rogueCardEffectCfg.action == ActionType.ChangeGlobalData)
						{
							data.CopySelf(rogueCardGameEffect.effectID);
							flag = true;
							break;
						}
					}
				}
				if (!flag && data.copyEffect != null)
				{
					data.copyEffect.OnDisabled();
					data.copyEffect = null;
				}
			}
			else
			{
				if (leftJoker != null)
				{
					RogueCardItemCfg rogueCardItemCfg2 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == leftJoker.realID);
					if (rogueCardItemCfg2.no_copy)
					{
						validCon.SetSelectedState("invalid");
					}
					else
					{
						itemCfg = rogueCardItemCfg2;
						copyCon.SetSelectedState("on");
						if (validCon.GetSelectedState() == "invalid")
						{
							SetValid(show: false);
						}
						else
						{
							validCon.SetSelectedState("normal");
						}
					}
					bool flag2 = false;
					if (!rogueCardItemCfg2.no_copy)
					{
						for (int num2 = 0; num2 < leftJoker.effect.Count; num2++)
						{
							RogueCardGameEffect rogueCardGameEffect2 = leftJoker.effect[num2];
							if (rogueCardGameEffect2 == null)
							{
								break;
							}
							RogueCardEffectCfg rogueCardEffectCfg2 = RogueCardDataManager.effectDatabase[rogueCardGameEffect2.effectID];
							if (rogueCardGameEffect2.triggerMoment == TriggerMoment.OnAcquire && rogueCardEffectCfg2 != null && rogueCardEffectCfg2.action == ActionType.ChangeGlobalData)
							{
								data.CopySelf(leftJoker.effect[num2].effectID);
								flag2 = true;
								break;
							}
						}
					}
					if (!flag2 && data.copyEffect != null)
					{
						data.copyEffect.OnDisabled();
						data.copyEffect = null;
					}
				}
				else
				{
					copyCon.SetSelectedState("off");
					if (validCon.GetSelectedState() == "invalid")
					{
						SetValid(show: false);
					}
					else
					{
						validCon.SetSelectedState("normal");
					}
					if (data.copyEffect != null)
					{
						data.copyEffect.OnDisabled();
						data.copyEffect = null;
					}
				}
				AtlasManager.GetSpriteWithoutAtlas(cardImage, "TextureConfig/Activity_JokerCard/item/" + itemCfg.icon);
			}
		}
		else
		{
			leftID = 0;
			if (validCon.GetSelectedState() == "invalid")
			{
				SetValid(show: false);
			}
			else
			{
				validCon.SetSelectedState("normal");
			}
		}
		if (data.versionID > 0)
		{
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[data.versionID];
			AtlasManager.GetSpriteWithoutAtlas(versionImg, "TextureConfig/Activity_JokerCard/itembg/" + rogueCardEnhanceCfg.icon);
		}
		if (data.realID != 306)
		{
			AtlasManager.GetSpriteWithoutAtlas(cardImage, "TextureConfig/Activity_JokerCard/item/" + itemCfg.icon);
		}
	}

	public override void SetLookTips(bool isSelect)
	{
		lookTipsCon.SetSelectedState(isSelect ? "on" : "off");
	}

	public void PlayAnimation(string aniName, float speed = 1f)
	{
		mainAnimator.Play(aniName, -1, 0f);
		mainAnimator.speed = speed;
	}

	public void PlayFlyNum(string text, FlyNumberType type, bool speed = false)
	{
		StartCoroutine(playFlyNum(text, type, speed));
	}

	public void ShowVersionAni()
	{
		versionAniGo.SetActive(value: true);
		versionAni.Play("UI_sg", 0, 0f);
	}

	private IEnumerator playFlyNum(string text, FlyNumberType type, bool speed)
	{
		flyNumber.ShowFlyText(text, type);
		yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_FlyText", speed));
		flyNumber.HideText();
	}
}
