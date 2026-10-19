using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoItem : MonoBehaviour
{
	public enum PropPickingCellStage
	{
		Hidden,
		Opening,
		Remain,
		Closing
	}

	[SerializeField]
	private Image borad1Image;

	[SerializeField]
	private Image borad2Image;

	public BImage itemPic;

	public LocalizeStringEvent itemName;

	public TextMeshProUGUI itemNum;

	public bool isFinish = true;

	public CanvasGroup canvas;

	public Animator animator;

	[SerializeField]
	private List<Sprite> board1Sprites;

	[SerializeField]
	private List<Sprite> board2Sprites;

	private ItemAchieveinfo info;

	public PropPickingCellStage stage;

	public void Init(ItemAchieveinfo info)
	{
		this.info = info;
		isFinish = false;
		canvas.alpha = 1f;
		ItemData data = CoreUtils.GetData(info.itemId, RuntimeConfigs.data.itemDatas);
		this.GetImageStation().LoadItemIconAsync(data.iconAddress, itemPic).Forget();
		itemName.StringReference.TableEntryReference = info.itemName;
		itemNum.SetText("{0:0}", info.itemNum);
		gameObject.SetActive(value: false);
		stage = PropPickingCellStage.Hidden;
	}

	public void UnLoad()
	{
		itemPic.UnLoad();
	}

	public void SetInvisible()
	{
		SetAlpha(itemPic.icon);
		static void SetAlpha(Image image)
		{
			Color color = image.color;
			color.a = 0f;
			image.color = color;
		}
	}

	public void UpdateStage(PropPickingCellStage targetStage)
	{
		stage = targetStage;
	}

	public void PlayShowAnimationByQuality()
	{
		gameObject.SetActive(value: true);
		switch (info.itemQuality)
		{
		case 1:
			animator.Play("WhiteShow");
			break;
		case 2:
			animator.Play("GreenShow");
			break;
		case 3:
			animator.Play("BlueShow");
			break;
		case 4:
			animator.Play("PurpleShow");
			break;
		case 5:
			animator.Play("OrangeShow");
			break;
		}
	}

	public void PlayHideAnimation()
	{
		animator.Play("Hide");
	}
}
