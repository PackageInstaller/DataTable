#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignTimelineItem : UGuiView
{
	[SerializeField]
	private Button btnOnClick;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject lockImg;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private GameObject playerImg;

	private CampaignTimelineItemData viewModel;

	private int loadImgVersion;

	public void Init(CampaignTimelineItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<CampaignTimelineItem, CampaignTimelineItemData> bindingSet = this.CreateBindingSet(viewModel);
		if (redPoint != null)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((CampaignTimelineItemData vm) => vm.IsNew);
		}
		if (btnOnClick != null)
		{
			bindingSet.Bind(btnOnClick).For((Button v) => v.onClick).To((CampaignTimelineItemData vm) => vm.OnClick);
		}
		bindingSet.Bind(lockImg).For((GameObject v) => v.activeSelf).To((CampaignTimelineItemData vm) => vm.IsLock);
		bindingSet.Bind(playerImg).For((GameObject v) => v.activeSelf).ToExpression((CampaignTimelineItemData vm) => !vm.IsLock);
		bindingSet.Build();
		LoadImg();
	}

	private async void LoadImg()
	{
		int version = ++loadImgVersion;
		if (icon == null)
		{
			return;
		}
		string iconPath = viewModel?.IconPath;
		if (string.IsNullOrEmpty(iconPath))
		{
			icon.sprite = null;
			icon.gameObject.SetActive(value: false);
			return;
		}
		string timelineSmallImageSprite = AssetUtility.GetTimelineSmallImageSprite(iconPath + ".png");
		try
		{
			Sprite sprite = await LoadSpriteAsync(timelineSmallImageSprite);
			if (version == loadImgVersion && viewModel != null && !(viewModel.IconPath != iconPath))
			{
				icon.sprite = sprite;
				icon.gameObject.SetActive(value: true);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.ToString());
		}
	}

	public void RefreshStoryGuideItem(CampaignTimelineItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		LoadImg();
	}
}
