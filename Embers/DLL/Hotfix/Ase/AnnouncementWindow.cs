using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AnnouncementWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private GameObject noContent;

	[SerializeField]
	private AnnouncementTabItem sysBtn;

	[SerializeField]
	private AnnouncementTabItem actBtn;

	[SerializeField]
	private AnnouncementTabItem playerGuideBtn;

	[SerializeField]
	private AnnouncementDetailView detailView;

	[SerializeField]
	private LoopListView2 itemList;

	private AnnouncementViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AnnouncementViewModel>();
		BindingSet<AnnouncementWindow, AnnouncementViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((AnnouncementWindow v) => v.OnDismissRequest).To((AnnouncementViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AnnouncementWindow v) => v.RefreshAnnounceItem).To((AnnouncementViewModel vm) => vm.RefreshItemRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((AnnouncementViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((AnnouncementViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(noContent).For((GameObject v) => v.activeSelf).ToExpression((AnnouncementViewModel vm) => !vm.HasAnn);
		bindingSet.Build();
		if (viewModel.ItemListShow.Count > 0)
		{
			itemList.InitListView(viewModel.ItemListShow.Count, OnGetItemItemByIndex);
		}
		InitTab();
		detailView.Init(viewModel.Detail);
		detailView.SetVisibility(viewModel.ItemListShow.Count > 0);
		detailView.gameObject.SetActive(value: true);
	}

	private void InitTab()
	{
		sysBtn.Init(viewModel.TabDatas[0]);
		actBtn.Init(viewModel.TabDatas[1]);
		playerGuideBtn.Init(viewModel.TabDatas[2]);
		sysBtn.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.AnnouncementUnRead).SetFuncOnMessage(delegate
		{
			IAnnouncementService service = Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>();
			foreach (long unRead in service.GetUnReadList())
			{
				AnnouncementData announcementById = service.GetAnnouncementById(unRead);
				if (announcementById != null && announcementById.Type == 1)
				{
					return true;
				}
			}
			return false;
		})
			.Invoke();
		actBtn.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.AnnouncementUnRead).SetFuncOnMessage(delegate
		{
			IAnnouncementService service = Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>();
			foreach (long unRead2 in service.GetUnReadList())
			{
				AnnouncementData announcementById = service.GetAnnouncementById(unRead2);
				if (announcementById != null && announcementById.Type == 2)
				{
					return true;
				}
			}
			return false;
		})
			.Invoke();
		playerGuideBtn.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.AnnouncementUnRead).SetFuncOnMessage(delegate
		{
			IAnnouncementService service = Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>();
			foreach (long unRead3 in service.GetUnReadList())
			{
				AnnouncementData announcementById = service.GetAnnouncementById(unRead3);
				if (announcementById != null && announcementById.Type == 3)
				{
					return true;
				}
			}
			return false;
		})
			.Invoke();
	}

	private void RefreshAnnounceItem(object sender, InteractionEventArgs e)
	{
		if (!itemList.IsInited)
		{
			itemList.InitListView(viewModel.ItemListShow.Count, OnGetItemItemByIndex);
		}
		else
		{
			itemList.SetListItemCount(viewModel.ItemListShow.Count);
			itemList.RefreshAllShownItem();
		}
		detailView.SetVisibility(viewModel.ItemListShow.Count > 0);
	}

	private LoopListViewItem2 OnGetItemItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ItemListShow.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AnnouncnementItem");
		if (loopListViewItem != null)
		{
			AnnouncementItem component = loopListViewItem.GetComponent<AnnouncementItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemListShow[index]);
			}
			else
			{
				component.RefreshData(viewModel.ItemListShow[index]);
			}
		}
		return loopListViewItem;
	}
}
