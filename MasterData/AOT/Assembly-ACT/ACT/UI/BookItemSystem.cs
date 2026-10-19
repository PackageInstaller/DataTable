using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BookItemSystem : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private LocalizeStringEvent nameDes1;

	[SerializeField]
	private BImage bgImage;

	[SerializeField]
	public ActButton btn;

	[SerializeField]
	private GameObject selectGo;

	[SerializeField]
	private GameObject selectLight;

	[SerializeField]
	private GameObject[] completedRoot;

	[SerializeField]
	private GameObject[] lockedRoot;

	[SerializeField]
	private PublicToggle unlockToggle;

	[SerializeField]
	private CanvasGroup canvasGroup;

	public void Init(int id, ImageAssetStation station, bool unlock, bool canPlayAnimation)
	{
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[id];
		nameDes1.StringReference.TableEntryReference = systemGuideData.name;
		if (systemGuideData.displayPic.Length != 0)
		{
			station.LoadImage(138, systemGuideData.displayPic[0], bgImage);
		}
		unlockToggle.isOn = unlock;
		GameObject[] array = completedRoot;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(unlock);
		}
		array = lockedRoot;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(!unlock);
		}
		SetLockStatusMask(unlock);
		canvasGroup.alpha = 1f;
		if (canPlayAnimation)
		{
			PlayEnterAnimation(systemGuideData.Prefab);
		}
	}

	public void SetSelect(bool isSelect)
	{
		selectGo.SetActive(isSelect);
		selectLight.SetActive(isSelect);
	}

	public void PlayEnterAnimation(int index)
	{
		animation?.GetSequence("Show").Play();
	}

	public void SetLockStatusMask(bool isUnlock)
	{
		Material material = new Material(bgImage.icon.material);
		material.SetFloat("_DeSaturate", isUnlock ? 0f : 1f);
		bgImage.icon.material = material;
	}
}
