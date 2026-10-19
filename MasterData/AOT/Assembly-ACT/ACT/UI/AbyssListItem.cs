using System.Collections.Generic;
using ACT.Config;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssListItem : LoopScrollBaseItem, ISubmitHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler, ISelectHandler, IDeselectHandler
{
	public ActButton AbyssItemButton;

	public GameObject UnLock;

	public TextMeshProUGUI Index;

	public TextMeshProUGUI Title;

	public List<GameObject> Stars;

	public ActButton Lock;

	public GameObject LockHighlight;

	public TextMeshProUGUI LockIndex;

	public BetterAnimation betterAnimation;

	public CanvasGroup CanvasGroup;

	public GameObject New;

	public GameObject Normal;

	public GameObject Unfinished;

	public GameObject Select;

	public GameObject LockSelect;

	private bool isUnLock;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		MonoAbyssListView monoAbyssListView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		if (monoAbyssListView == null)
		{
			return;
		}
		AbyssData abyssData = monoAbyssListView.GetAbyssData(idx);
		if (abyssData != null)
		{
			AbyssItemButton.SetBtnClick(() =>
			{
				monoAbyssListView.OpenAbyssTeamPanel(idx);
			}, "event:/UI/Interface/Abyss/Unlock");
			Lock.SetBtnClick(OnClickLockButton, "event:/UI/Interface/Abyss/Unlock");
			isUnLock = monoAbyssListView.IsUnlock(idx);
			UnLock.SetActive(isUnLock);
			Lock.gameObject.SetActive(!isUnLock);
			AbyssItemButton.Interactable(isUnLock);
			AbyssItemButton.transform.localPosition = new Vector3(abyssData.iconDeviation[0], abyssData.iconDeviation[1], 0f);
			Index.SetText("{0:00}", idx + 1);
			Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, abyssData.abyssNameLocal);
			LockIndex.text = Index.text;
			int num = Stars.Count - Mathf.Max(0, abyssData.timeReward.Length + 1 - monoAbyssListView.GetStarNum(idx)) - 1;
			for (int num2 = 0; num2 < Stars.Count; num2++)
			{
				Stars[num2].SetActive(num == num2);
			}
			Unfinished.SetActive(isUnLock && num < 0);
			bool flag = isUnLock && !monoAbyssListView.IsUnlock(idx + 1) && !monoAbyssListView.IsComplete(idx);
			New.SetActive(flag);
			Normal.SetActive(!flag);
		}
	}

	public void PlayAnimation()
	{
		CanvasGroup.alpha = 1f;
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			PlayLoopAnimation();
		}).SetLoops(1)
			.Play();
	}

	private void PlayLoopAnimation()
	{
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (!isUnLock)
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2343));
		}
		else if (AbyssItemButton.gameObject.activeSelf && AbyssItemButton.IsInteractable() && isUnLock)
		{
			AbyssItemButton.OnSubmit(eventData);
		}
	}

	private void OnClickLockButton()
	{
		if (!isUnLock)
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2343));
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		LockHighlight.SetActive(value: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		LockHighlight.SetActive(value: false);
	}

	public void OnSelect(BaseEventData eventData)
	{
		Select.SetActive(isUnLock);
		LockSelect.SetActive(!isUnLock);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		Select.SetActive(value: false);
		LockSelect.SetActive(value: false);
	}
}
