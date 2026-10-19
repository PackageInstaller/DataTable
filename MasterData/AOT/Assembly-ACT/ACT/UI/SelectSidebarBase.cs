using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Sound;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SelectSidebarBase : MonoBehaviour
{
	public Animator sidebarAnimator;

	public float showRowInterval = 0.03f;

	public EventReference openReference;

	public AudioEventReference audioOpenReference;

	public EventReference closeReference;

	public AudioEventReference audioCloseReference;

	public LoopScrollRect loopScrollRect;

	public GridLayoutGroup gridLayoutGroup;

	protected int maxVisibleRowNum;

	public bool isMultiSelect;

	public CommonUILifeCycle lifeCycle;

	protected int defaultSelectIndex;

	protected CancellationTokenSource cts;

	private List<Transform> openAnimationAllCellTransform;

	private List<Animation> openAnimationAllCellAnimation;

	public bool initialComplete;

	public bool isOperating
	{
		get
		{
			if (lifeCycle != CommonUILifeCycle.Opening)
			{
				return lifeCycle == CommonUILifeCycle.Closing;
			}
			return true;
		}
	}

	public bool isNormal => lifeCycle == CommonUILifeCycle.Normal;

	public bool isHidden => lifeCycle == CommonUILifeCycle.Hidden;

	public virtual void Init()
	{
		maxVisibleRowNum = GetVisibleRowNum();
		lifeCycle = CommonUILifeCycle.Opening;
		gameObject.SetActive(value: true);
		sidebarAnimator.Play("Show", 0, 0f);
		if (defaultSelectIndex != -1)
		{
			loopScrollRect.ScrollToCellWithinTime(defaultSelectIndex, 0f);
		}
		else
		{
			loopScrollRect.RefillCells();
		}
	}

	public virtual void UnInit()
	{
		cts?.Cancel();
		initialComplete = false;
		sidebarAnimator.Play("Hide");
	}

	public virtual void UnInitImmediately()
	{
		if (!isHidden)
		{
			cts?.Cancel();
			initialComplete = false;
			HideEnd();
		}
	}

	public virtual async void PlayCellAnimationByRow()
	{
		cts = new CancellationTokenSource();
		if (!(await PlayCellAnimationByRowAsync(cts.Token).SuppressCancellationThrow()))
		{
			return;
		}
		foreach (Animation item in openAnimationAllCellAnimation)
		{
			item.Stop();
		}
		ListPool<Animation>.Release(openAnimationAllCellAnimation);
		ListPool<Transform>.Release(openAnimationAllCellTransform);
	}

	protected virtual async UniTask PlayCellAnimationByRowAsync(CancellationToken ct)
	{
		loopScrollRect.vertical = false;
		openAnimationAllCellTransform = ListPool<Transform>.Get();
		openAnimationAllCellAnimation = ListPool<Animation>.Get();
		for (int i = 0; i < loopScrollRect.content.childCount; i++)
		{
			openAnimationAllCellTransform.Add(loopScrollRect.content.GetChild(i));
			openAnimationAllCellAnimation.Add(loopScrollRect.content.GetChild(i).GetComponent<Animation>());
		}
		int childCount = loopScrollRect.content.childCount;
		int numInRow = gridLayoutGroup.constraintCount;
		int curVisibleRowNum = Mathf.Min(Mathf.CeilToInt((float)childCount / (float)numInRow), maxVisibleRowNum);
		for (int r = 0; r < curVisibleRowNum; r++)
		{
			for (int j = r * numInRow; j < (r + 1) * numInRow && j < openAnimationAllCellAnimation.Count; j++)
			{
				openAnimationAllCellAnimation[j].enabled = true;
				openAnimationAllCellAnimation[j].Play("ItemShow");
			}
			if (r != curVisibleRowNum - 1)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(showRowInterval), ignoreTimeScale: false, PlayerLoopTiming.Update, ct);
			}
		}
		loopScrollRect.vertical = true;
		SetAllCellStateAfterOpenAnimation();
		ListPool<Animation>.Release(openAnimationAllCellAnimation);
		ListPool<Transform>.Release(openAnimationAllCellTransform);
		initialComplete = true;
	}

	public virtual void SetAllCellStateBeforeOpenAnimation()
	{
		for (int i = 0; i < loopScrollRect.content.childCount; i++)
		{
			CanvasGroup component = loopScrollRect.content.GetChild(i).GetComponent<CanvasGroup>();
			if (i < maxVisibleRowNum * gridLayoutGroup.constraintCount)
			{
				component.alpha = 0f;
			}
			else
			{
				component.alpha = 1f;
			}
			loopScrollRect.content.GetChild(i).GetComponent<ItemUIComponent>().gameObject.SetActive(value: false);
		}
	}

	public virtual void SetAllCellStateAfterOpenAnimation()
	{
		for (int i = 0; i < loopScrollRect.content.childCount; i++)
		{
			loopScrollRect.content.GetChild(i).GetComponent<ItemUIComponent>().gameObject.SetActive(value: true);
		}
	}

	protected int GetVisibleRowNum()
	{
		float height = loopScrollRect.viewport.rect.height;
		int top = gridLayoutGroup.padding.top;
		float y = gridLayoutGroup.spacing.y;
		float y2 = gridLayoutGroup.cellSize.y;
		return (int)Mathf.Ceil((height - (float)top) / (y2 + y));
	}

	protected virtual void ShowStart()
	{
		lifeCycle = CommonUILifeCycle.Opening;
		gameObject.SetActive(value: true);
	}

	protected virtual void ShowEnd()
	{
		lifeCycle = CommonUILifeCycle.Normal;
	}

	protected virtual void HideStart()
	{
		lifeCycle = CommonUILifeCycle.Closing;
	}

	protected virtual void HideEnd()
	{
		lifeCycle = CommonUILifeCycle.Hidden;
		gameObject.SetActive(value: false);
	}

	public void PlayOpenSound()
	{
		if (!audioOpenReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioOpenReference);
		}
	}

	public void PlayCloseSound()
	{
		if (!audioCloseReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioCloseReference);
		}
	}
}
