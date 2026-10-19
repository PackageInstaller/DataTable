using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BookItemMission : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private BImage image;

	[SerializeField]
	private LocalizeStringEvent nameDes;

	[SerializeField]
	public ActButton btn;

	[SerializeField]
	private GameObject selectGo;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private GameObject[] completedRoot;

	[SerializeField]
	private GameObject[] lockedRoot;

	[SerializeField]
	private GameObject[] inProgress;

	[SerializeField]
	private PublicToggle unlockToggle;

	[SerializeField]
	private CanvasGroup canvasGroup;

	private bool isUnlock = true;

	public void Init(int id, ImageAssetStation station, bool unlock, bool inProgressState, bool canPlayAnimation)
	{
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[id];
		nameDes.StringReference.TableEntryReference = systemGuideData.name;
		isUnlock = unlock;
		if (systemGuideData.displayPic.Length != 0)
		{
			station.LoadImage(138, systemGuideData.displayPic[0], image);
		}
		if (unlock)
		{
			GameObject[] array = completedRoot;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(!inProgressState);
			}
			array = inProgress;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(inProgressState);
			}
			array = lockedRoot;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(value: false);
			}
		}
		else
		{
			GameObject[] array = lockedRoot;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(value: true);
			}
			array = completedRoot;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(value: false);
			}
			array = inProgress;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(value: false);
			}
		}
		unlockToggle.isOn = unlock;
		canvasGroup.alpha = 1f;
		if (canPlayAnimation)
		{
			PlayEnterAnimation(systemGuideData.Prefab);
		}
	}

	public void SetSelect(bool isSelect)
	{
		selectGo.SetActive(isSelect);
		select.SetActive(isSelect);
	}

	public bool getUnlockStatus()
	{
		return isUnlock;
	}

	public void PlayEnterAnimation(int index)
	{
		animation?.GetSequence("Show").Play();
	}
}
