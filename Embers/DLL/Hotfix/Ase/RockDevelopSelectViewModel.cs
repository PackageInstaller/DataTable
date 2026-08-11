using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class RockDevelopSelectViewModel : OptionBase
{
	private List<RockPopupViewModel> rockPopupViewModelList;

	private SimpleCommand confirmCmd;

	private long rockUid;

	private int selectIndex;

	private RockPopupViewModel oldPopupViewModel;

	private RockPopupViewModel selectPopupViewModel;

	private InteractionRequest<EntryItemData> showEntryDetailRequest;

	private bool showHeroEntryDetailView;

	private SimpleCommand openHeroEntryDetailViewCmd;

	private float positionX;

	public SimpleCommand ConfirmCmd => confirmCmd;

	public RockPopupViewModel OldPopupViewModel => oldPopupViewModel;

	public List<RockPopupViewModel> RockPopupViewModelList => rockPopupViewModelList;

	public InteractionRequest<EntryItemData> ShowEntryDetailRequest => showEntryDetailRequest;

	public float PositionX => positionX;

	public SimpleCommand OpenHeroEntryDetailViewCmd => openHeroEntryDetailViewCmd;

	public bool ShowHeroEntryDetailView => showHeroEntryDetailView;

	public RockDevelopSelectViewModel(OptionBase parent, RockPopupViewModel oldPopupViewModel, List<RockPopupViewModel> popupList)
	{
		base.parent = parent;
		showEntryDetailRequest = new InteractionRequest<EntryItemData>();
		this.oldPopupViewModel = oldPopupViewModel;
		rockUid = oldPopupViewModel.ArmourData.Uid;
		rockPopupViewModelList = new List<RockPopupViewModel>();
		oldPopupViewModel.SetParent(this);
		foreach (RockPopupViewModel popup in popupList)
		{
			popup.SetParent(this);
			rockPopupViewModelList.Add(popup);
		}
		confirmCmd = new SimpleCommand(ConfirmOnClick);
		openHeroEntryDetailViewCmd = new SimpleCommand(OpenHeroEntryView);
		confirmCmd.Enabled = false;
		CheckHeroEntry();
	}

	public override void ItemOnClick(object obj)
	{
		if (!(obj is OptionArg { Obj: RockPopupViewModel obj2 } optionArg))
		{
			return;
		}
		if ("Select".Equals(optionArg.OptionName))
		{
			if (obj2.Index >= 0)
			{
				selectPopupViewModel?.SetSelect(select: false);
				selectPopupViewModel = obj2;
				selectPopupViewModel.SetSelect(select: true);
				selectIndex = obj2.Index;
				confirmCmd.Enabled = true;
			}
		}
		else if ("OnShowEntryPanel".Equals(optionArg.OptionName) && obj2.Index >= 0)
		{
			selectPopupViewModel?.SetSelect(select: false);
			selectPopupViewModel = obj2;
			selectPopupViewModel.SetSelect(select: true);
			selectIndex = obj2.Index;
			confirmCmd.Enabled = true;
			EntryItemData entryItemData = obj2.EntryItemData;
			positionX = obj2.PositionX;
			showEntryDetailRequest.Raise(entryItemData);
		}
	}

	private void CheckHeroEntry()
	{
		showHeroEntryDetailView = oldPopupViewModel.ArmourData.GetOwnerId() != 0;
	}

	private void OpenHeroEntryView()
	{
		openHeroEntryDetailViewCmd.Enabled = false;
		if (!showHeroEntryDetailView)
		{
			return;
		}
		int ownerId = oldPopupViewModel.ArmourData.GetOwnerId();
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(ownerId);
		if (heroById != null)
		{
			ArmourEntryDetailViewModel userData = new ArmourEntryDetailViewModel(this, heroById);
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourEntryDetailWindow), userData), delegate
			{
				openHeroEntryDetailViewCmd.Enabled = true;
			});
		}
	}

	private void ConfirmOnClick()
	{
		confirmCmd.Enabled = false;
		IAsyncResult<int> result = AlertDialog.Show("提示", "确定选择该手提箱作为改造结果? \n <color=#9c251c>未选择的手提箱将消失</color>", "确认", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				SendConfirm();
			}
			else
			{
				confirmCmd.Enabled = true;
			}
		});
	}

	private async void SendConfirm()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().SelectSuitBox(selectIndex, rockUid);
		loading.Dispose();
		if (num)
		{
			parent?.ItemOnClick(new OptionArg(this, "Success"));
			Close();
		}
		else
		{
			Toast.ShowInfo("选择护石失败!请稍后再试!");
			confirmCmd.Enabled = true;
			await UIHelper.AccountDisconnect();
		}
	}
}
