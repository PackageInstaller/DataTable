using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BookItemChapter : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private LocalizeStringEvent titleTop;

	[SerializeField]
	private LocalizeStringEvent nameDes;

	[SerializeField]
	private PublicToggle activeToggle;

	[SerializeField]
	private CanvasGroup canvasGroup;

	public int CurrentChapter { get; set; }

	public void Init(int id, ImageAssetStation station, bool unlock, bool canPlayAnimation)
	{
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[id];
		if (RuntimeConfigs.data.chapterIndexs.ContainsKey(systemGuideData.chapter))
		{
			CurrentChapter = systemGuideData.chapter;
			titleTop.StringReference.TableEntryReference = RuntimeConfigs.data.chapterIndexs[systemGuideData.chapter].name;
		}
		nameDes.StringReference.TableEntryReference = systemGuideData.name;
		if ((bool)activeToggle)
		{
			activeToggle.isOn = unlock;
		}
		canvasGroup.alpha = 1f;
		if (canPlayAnimation)
		{
			PlayEnterAnimation();
		}
	}

	public void PlayEnterAnimation()
	{
		animation?.GetSequence("Show").Play();
	}
}
