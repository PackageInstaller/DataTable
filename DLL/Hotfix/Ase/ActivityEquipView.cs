using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityEquipView : ActivityViewBase
{
	public Image bgImg;

	public TextMeshProUGUI activityDesc;

	public TextMeshProUGUI buffDesc;

	public GameObject gotoRed;

	public Button btnOpenMain;

	public LoopListView2 rewardList;

	private ActivityEquipViewModel viewModel;

	private string bgImgPath;

	public override async void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (ActivityEquipViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ActivityEquipView, ActivityEquipViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((ActivityEquipView v) => v.OnVisibleChanged).To((ActivityEquipViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(activityDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityEquipViewModel vm) => vm.ActivityDesc);
		bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityEquipViewModel vm) => vm.BuffDesc);
		bindingSet.Bind(btnOpenMain).For((Button v) => v.onClick).To((ActivityEquipViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenCopyEquipMain");
		bindingSet.Bind(gotoRed).For((GameObject v) => v.activeSelf).To((ActivityEquipViewModel vm) => vm.Red);
		bindingSet.Bind().For((ActivityEquipView v) => v.OnOpt).To((ActivityEquipViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		rewardList.InitListView(this.viewModel.RewardItemViewModels.Count, OnGetRewardItemByIndex);
		bgImgPath = ActivityEquipBgIdMapper.GetBgAssetPath(this.viewModel.ActivityTypeId);
		Image component = (await GameEntry.Resource.LoadAssetAsync<GameObject>(bgImgPath)).GetComponent<Image>();
		bgImg.sprite = component.sprite;
		bgImg.color = new Color(1f, 1f, 1f, 1f);
		this.viewModel.SetBgSprite(bgImg.sprite);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.RewardItemViewModels[index].IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(viewModel.RewardItemViewModels[index].CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		bgImg.sprite = null;
		if (viewModel != null)
		{
			viewModel.RemoveTimeDura();
			viewModel.RemoveBgSprite();
		}
		if (!string.IsNullOrEmpty(bgImgPath))
		{
			GameEntry.Resource.UnloadAsset(bgImgPath);
		}
		base.OnDestroy();
	}
}
