using System.Collections;
using UnityEngine;

namespace RogueCard;

public class RogueCardStoryBossUI : RogueCardStoryBaseUI
{
	public Animator allAni;

	public Animator falseAni;

	public Animator truthAni;

	public GameObject effectGo;

	private bool isAni;

	private int currentDisplayIndex = -1;

	private int pendingDisplayIndex = -1;

	public override void Init()
	{
	}

	public override void SetData()
	{
		stageCfg = RogueCardDataManager.stageDatabase[RogueCardGameMain.GameContext.stageID];
		currentDisplayIndex = GetCurrentDisplayIndex();
		ApplyDisplay(currentDisplayIndex);
	}

	public override void RefreshUI()
	{
		stageCfg = RogueCardDataManager.stageDatabase[RogueCardGameMain.GameContext.stageID];
		if (RogueCardGameMain.Instance.CurState == null || (!(RogueCardGameMain.Instance.CurState is StateWithSubstates) && RogueCardGameMain.Instance.CurState.GetIndex() > 2 && RogueCardGameMain.GameContext.curRound != 1))
		{
			falseImg.gameObject.SetActive(value: false);
			trueImg.gameObject.SetActive(value: false);
		}
		if (!isAni)
		{
			if (currentDisplayIndex < 0)
			{
				currentDisplayIndex = GetCurrentDisplayIndex();
			}
			ApplyDisplay(currentDisplayIndex);
		}
	}

	public override void OnStartChallengeState()
	{
		if (RogueCardGameMain.GameContext.curRound != 1)
		{
			effectGo.SetActive(value: true);
			currentDisplayIndex = ((pendingDisplayIndex >= 0) ? pendingDisplayIndex : GetTransitionDisplayIndex());
			pendingDisplayIndex = -1;
			ApplyDisplay(currentDisplayIndex);
			falseAni.Rebind();
			falseImg.gameObject.SetActive(value: true);
			isAni = false;
		}
	}

	public override void OnFinishChallengeStage()
	{
		isAni = true;
		pendingDisplayIndex = GetTransitionDisplayIndex();
		truthAni.enabled = false;
		effectGo.SetActive(value: false);
		falseAni.Play("UI_False_xs", 0, 0f);
	}

	public override void SetAll()
	{
		StartCoroutine(All());
	}

	private IEnumerator All()
	{
		allAni.Play("UI_effect_cx", -1, 0f);
		yield return new WaitForSeconds(0.4f);
		falseImg.gameObject.SetActive(value: false);
		yield return new WaitForSeconds(0.6f);
		effectGo.SetActive(value: true);
		trueImg.gameObject.SetActive(value: true);
		yield return new WaitForSeconds(0.8f);
	}

	private int GetCurrentDisplayIndex()
	{
		if (stageCfg == null || stageCfg.false_picture == null || stageCfg.false_picture.Length == 0)
		{
			return 0;
		}
		return Mathf.Clamp(RogueCardGameMain.GameContext.curRound - 1, 0, stageCfg.false_picture.Length - 1);
	}

	private int GetTransitionDisplayIndex()
	{
		if (stageCfg == null || stageCfg.false_picture == null || stageCfg.false_picture.Length == 0)
		{
			return 0;
		}
		int num = RogueCardGameMain.GameContext.curRound - 1;
		if (RogueCardGameMain.Instance.CurState.GetIndex() >= 7 && num < RogueCardGameMain.GameContext.allRoundNum - 1)
		{
			num++;
		}
		return Mathf.Clamp(num, 0, stageCfg.false_picture.Length - 1);
	}

	private void ApplyDisplay(int displayIndex)
	{
		if (stageCfg != null && stageCfg.false_picture != null && stageCfg.false_picture.Length != 0)
		{
			int num = Mathf.Clamp(displayIndex, 0, stageCfg.false_picture.Length - 1);
			AtlasManager.GetSpriteWithoutAtlas(falseImg, "TextureBg/Activity_JokerCard/" + stageCfg.false_picture[num]);
			RogueCardGameMain.Instance.clueTitle.text = RogueCardTipSystem.GetTip($"ROGUE_CARD_STAGE{num + 1}_TITLE");
		}
	}
}
