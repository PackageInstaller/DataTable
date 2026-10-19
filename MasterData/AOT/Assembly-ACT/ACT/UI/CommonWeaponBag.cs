using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CommonWeaponBag : MonoBehaviour
{
	public MonoScrollBagComponent scrollBag;

	public Animator anim;

	private CancellationTokenSource cts;

	private UniTask lastShowLineUniTask;

	public RectTransform scrollBagContentTransform;

	public RectTransform scrollBagViewPortTransform;

	public GridLayoutGroup scrollBagGridLayoutGroup;

	[HideInInspector]
	public int maxVisibleRowNum;

	public float showRowInterval;

	public float animInterval = 0.15f;

	public void PlayCellAnimationByRow()
	{
		maxVisibleRowNum = GetVisibleRowNum();
		cts = new CancellationTokenSource();
		lastShowLineUniTask = PlayCellAnimationByRowAsync(cts.Token);
	}

	public async UniTask PlayCellAnimationByRowAsync(CancellationToken ct)
	{
		SetAllCellInitState();
		if ((bool)scrollBag)
		{
			scrollBag.loopScrollRect.vertical = false;
		}
		List<Transform> allCellTransform = ListPool<Transform>.Get();
		List<Animation> allCellAnimation = ListPool<Animation>.Get();
		for (int i = 0; i < scrollBagContentTransform.childCount; i++)
		{
			allCellTransform.Add(scrollBagContentTransform.GetChild(i));
			allCellAnimation.Add(scrollBagContentTransform.GetChild(i).GetComponent<Animation>());
		}
		foreach (Transform item in allCellTransform)
		{
			item.GetComponent<ItemUIComponent>().gameObject.SetActive(value: false);
		}
		int childCount = scrollBagContentTransform.childCount;
		int numInRow = scrollBagGridLayoutGroup.constraintCount;
		int a = ((childCount % numInRow != 0) ? (childCount / numInRow + 1) : (childCount / numInRow));
		int curVisibleRowNum = Mathf.Min(a, maxVisibleRowNum);
		await UniTask.Delay(TimeSpan.FromSeconds(animInterval));
		for (int r = curVisibleRowNum - 1; r >= 0; r--)
		{
			for (int j = r * numInRow; j < (r + 1) * numInRow && j < allCellAnimation.Count; j++)
			{
				allCellAnimation[j].enabled = true;
				allCellAnimation[j].Play("ItemShow");
			}
			if (r != 0)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(showRowInterval), ignoreTimeScale: false, PlayerLoopTiming.Update, ct);
				if (ct.IsCancellationRequested)
				{
					foreach (Animation item2 in allCellAnimation)
					{
						item2.Stop();
					}
					if ((bool)scrollBag)
					{
						scrollBag.loopScrollRect.vertical = true;
					}
					foreach (Transform item3 in allCellTransform)
					{
						item3.GetComponent<ItemUIComponent>().gameObject.SetActive(value: true);
					}
					ListPool<Animation>.Release(allCellAnimation);
					ListPool<Transform>.Release(allCellTransform);
					return;
				}
			}
		}
		if ((bool)scrollBag)
		{
			scrollBag.loopScrollRect.vertical = true;
		}
		foreach (Transform item4 in allCellTransform)
		{
			item4.GetComponent<ItemUIComponent>().gameObject.SetActive(value: true);
		}
		ListPool<Animation>.Release(allCellAnimation);
		ListPool<Transform>.Release(allCellTransform);
	}

	public int GetVisibleRowNum()
	{
		float height = scrollBagViewPortTransform.rect.height;
		int top = scrollBagGridLayoutGroup.padding.top;
		float y = scrollBagGridLayoutGroup.spacing.y;
		float y2 = scrollBagGridLayoutGroup.cellSize.y;
		return (int)Mathf.Ceil((height - (float)top) / (y2 + y));
	}

	public async UniTask Close()
	{
		if (anim.isActiveAndEnabled)
		{
			anim.Play("Hide");
		}
		await UniTask.WaitUntil(() => anim.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f || cts.Token.IsCancellationRequested);
		if (!cts.IsCancellationRequested)
		{
			cts?.Cancel();
		}
	}

	private void SetAllCellInitState()
	{
		for (int i = 0; i < scrollBagContentTransform.childCount; i++)
		{
			CanvasGroup component = scrollBagContentTransform.GetChild(i).GetComponent<CanvasGroup>();
			if (i < maxVisibleRowNum * scrollBagGridLayoutGroup.constraintCount)
			{
				component.alpha = 0f;
			}
			else
			{
				component.alpha = 1f;
			}
		}
	}
}
