using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BookRightPanel : MonoBehaviour
{
	[SerializeField]
	private BImage icon;

	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private GameObject complete;

	[SerializeField]
	private GameObject lockGo;

	[SerializeField]
	private GameObject inProgress;

	[SerializeField]
	private LocalizeStringEvent title;

	[SerializeField]
	private LocalizeStringEvent des;

	[SerializeField]
	private TextMeshProUGUI desText;

	[SerializeField]
	private List<PanelLockItem> lockItem;

	[SerializeField]
	private BetterAnimation anim;

	public ScrollRect scrollRect;

	public RightStickScrollSupport scrollSupport;

	public void Init(BookViewBaseModel bookViewBaseModel, ImageAssetStation station)
	{
		gameObject.SetActive(value: true);
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[bookViewBaseModel.Id];
		title.StringReference.TableEntryReference = systemGuideData.name;
		if (systemGuideData.description == 0)
		{
			des.StringReference.TableEntryReference = string.Empty;
			desText.text = string.Empty;
		}
		else
		{
			des.StringReference.TableEntryReference = systemGuideData.description;
		}
		if (bookViewBaseModel is BookItemMissionModel bookItemMissionModel)
		{
			complete.SetActive(!bookItemMissionModel.InProgress && bookItemMissionModel.Unlock);
			inProgress.SetActive(bookItemMissionModel.InProgress && bookItemMissionModel.Unlock);
			lockGo.SetActive(!bookItemMissionModel.Unlock && !bookItemMissionModel.InProgress);
			lockItem[0].transform.parent.gameObject.SetActive(value: false);
			if (systemGuideData.displayPic.Length != 0)
			{
				station.LoadImage(138, systemGuideData.displayPic[0], icon);
			}
			SetLockStatusMask(bookItemMissionModel.Unlock);
		}
		else if (bookViewBaseModel is BookItemSystemModel bookItemSystemModel)
		{
			inProgress.SetActive(value: false);
			complete.SetActive(bookItemSystemModel.Unlock);
			lockGo.SetActive(!bookItemSystemModel.Unlock);
			lockItem[0].transform.parent.gameObject.SetActive(value: true);
			int[] condition = systemGuideData.condition;
			int num = condition.Length - lockItem.Count;
			if (num > 0)
			{
				for (int i = 0; i < num; i++)
				{
					PanelLockItem item = Object.Instantiate(lockItem[0], lockItem[0].transform.parent, worldPositionStays: false);
					lockItem.Add(item);
				}
			}
			for (int j = 0; j < lockItem.Count; j++)
			{
				if (j < condition.Length)
				{
					lockItem[j].gameObject.SetActive(value: true);
					lockItem[j].Init(condition[j]);
				}
				else
				{
					lockItem[j].gameObject.SetActive(value: false);
				}
			}
			if (systemGuideData.displayPic.Length != 0)
			{
				station.LoadImage(138, systemGuideData.displayPic[0], icon);
			}
			SetLockStatusMask(bookItemSystemModel.Unlock);
		}
		anim.GetSequence("Show").Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrackWay/Window_Open");
	}

	public void Close()
	{
		if (gameObject.activeSelf)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrackWay/Window_Close");
			anim.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
			}).Play();
		}
	}

	public void SetHide()
	{
		if (gameObject.activeSelf)
		{
			gameObject.SetActive(value: false);
		}
	}

	public void SetLockStatusMask(bool isUnlock)
	{
		Material material = new Material(icon.icon.material);
		material.SetFloat("_DeSaturate", isUnlock ? 0f : 1f);
		icon.icon.material = material;
	}

	public void PlayEnterAnimation(bool isSelect)
	{
		animation.GetSequence(isSelect ? "ShowSelected" : "ShowNormal").Play();
	}

	public void PlayScrollToAnimation(bool isSelect)
	{
		animation.GetSequence(isSelect ? "SelectedEnter" : "SelectedOut").Play().Complete();
	}

	public void PlaySwitchSelectAnimation(bool isSelect)
	{
		animation.GetSequence(isSelect ? "SelectedEnter" : "SelectedOut").Play();
	}
}
