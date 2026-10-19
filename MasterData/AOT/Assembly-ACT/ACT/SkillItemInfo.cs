using ACT.UI;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT;

public class SkillItemInfo : BaseUIComponent
{
	public LocalizeStringEvent title;

	public LocalizeStringEvent method;

	public LocalizeStringEvent detailedInfo;

	public string assetReference;

	public RectTransform[] layouts;

	public async void RefreshLayout()
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		RectTransform[] array = layouts;
		for (int i = 0; i < array.Length; i++)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(array[i]);
		}
	}

	public void PlayVideo()
	{
	}
}
