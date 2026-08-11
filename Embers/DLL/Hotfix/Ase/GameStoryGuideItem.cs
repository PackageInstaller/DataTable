#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameStoryGuideItem : UGuiView
{
	[SerializeField]
	private Button btnOnClick;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject redPoint;

	private string path = "";

	private GameStoryGuideItemData viewModel;

	private int loadImgVersion;

	public void Init(GameStoryGuideItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<GameStoryGuideItem, GameStoryGuideItemData> bindingSet = this.CreateBindingSet(viewModel);
		if (redPoint != null)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((GameStoryGuideItemData vm) => vm.IsNew);
		}
		if (btnOnClick != null)
		{
			bindingSet.Bind(btnOnClick).For((Button v) => v.onClick).To((GameStoryGuideItemData vm) => vm.OnClick);
		}
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

	public void RefreshStoryGuideItem(GameStoryGuideItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		LoadImg();
	}
}
