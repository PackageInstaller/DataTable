using System;
using System.Collections.Generic;
using System.Text;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class BottleProperty : MonoBehaviour
{
	public List<GameObject> commonRoot;

	public TextMeshProUGUI leftNum;

	public TextMeshProUGUI rightNum;

	public TextMeshProUGUI maxLevelInfo;

	public GameObject LevelUpIcon;

	public BetterAnimation anim;

	private void PlayAnim()
	{
		anim?.GetSequence("LevelUp").Play();
	}

	public void UpdateHealProperty((float, float) curNum, (float, float) nextNum, StringBuilder sb)
	{
		SetComponentState(maxLevel: false);
		sb.Clear();
		leftNum.SetText(sb.Append(curNum.Item2).Append("+").Append(curNum.Item1 * 100f)
			.Append("%"));
		sb.Clear();
		if (ApproximatelyEquals(curNum, nextNum))
		{
			rightNum.gameObject.SetActive(value: false);
			LevelUpIcon.SetActive(value: false);
			maxLevelInfo.gameObject.SetActive(value: true);
			maxLevelInfo.SetText(sb.Append(nextNum.Item2).Append("+").Append(nextNum.Item1 * 100f)
				.Append("%"));
		}
		else
		{
			LevelUpIcon.SetActive(value: true);
			rightNum.SetText(sb.Append(nextNum.Item2).Append("+").Append(nextNum.Item1 * 100f)
				.Append("%"));
			PlayAnim();
		}
	}

	public void UpdateMaxLevelHealProperty((float, float) maxNum, StringBuilder sb)
	{
		SetComponentState(maxLevel: true);
		sb.Clear();
		maxLevelInfo.SetText(sb.Append(maxNum.Item2).Append("+").Append(maxNum.Item1 * 100f)
			.Append("%"));
		PlayAnim();
	}

	public void UpdateUseCountProperty(int curCount, int nextCount)
	{
		SetComponentState(maxLevel: false);
		leftNum.SetText(curCount.FastToString());
		if (curCount != nextCount)
		{
			rightNum.SetText(nextCount.FastToString());
			LevelUpIcon.SetActive(value: true);
			return;
		}
		rightNum.gameObject.SetActive(value: false);
		LevelUpIcon.SetActive(value: false);
		maxLevelInfo.gameObject.SetActive(value: true);
		maxLevelInfo.SetText(nextCount.FastToString());
		PlayAnim();
	}

	public void UpdateMaxLevelUseCountProperty(int maxCount)
	{
		SetComponentState(maxLevel: true);
		maxLevelInfo.SetText(maxCount.FastToString());
		PlayAnim();
	}

	public void UpdateSlotProperty(int curCount, int nextCount)
	{
		SetComponentState(maxLevel: false);
		leftNum.SetText(curCount.FastToString());
		if (curCount != nextCount)
		{
			rightNum.SetText(nextCount.FastToString());
			LevelUpIcon.SetActive(value: true);
			return;
		}
		rightNum.gameObject.SetActive(value: false);
		LevelUpIcon.SetActive(value: false);
		maxLevelInfo.gameObject.SetActive(value: true);
		maxLevelInfo.SetText(nextCount.FastToString());
		PlayAnim();
	}

	public void UpdateMaxLevelSlotProperty(int maxCount)
	{
		SetComponentState(maxLevel: true);
		maxLevelInfo.SetText(maxCount.FastToString());
		PlayAnim();
	}

	private void SetComponentState(bool maxLevel)
	{
		if (maxLevel)
		{
			commonRoot.ForEach((GameObject x) =>
			{
				x.SetActive(value: false);
			});
			maxLevelInfo.gameObject.SetActive(value: true);
			return;
		}
		commonRoot.ForEach((GameObject x) =>
		{
			if (!x.activeInHierarchy)
			{
				x.SetActive(value: true);
			}
		});
		maxLevelInfo.gameObject.SetActive(value: false);
	}

	private bool ApproximatelyEquals((float x, float y) a, (float x, float y) b, float epsilon = 0.0001f)
	{
		if (Math.Abs(a.x - b.x) < epsilon)
		{
			return Math.Abs(a.y - b.y) < epsilon;
		}
		return false;
	}
}
