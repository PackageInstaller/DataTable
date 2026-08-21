using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GetPackViewModel : OptionBase
{
	private int index;

	private int selectedIndex;

	private List<PackItemData> packItemDataList;

	private PackItemData curPackItemData;

	private List<int> packIdList;

	private List<int> serialNumberList;

	private SimpleCommand confirmCmd;

	private SimpleCommand cancelCmd;

	private string btnText;

	private InteractionRequest refreshPackRequest;

	private bool isPassport;

	private long mailId;

	public long MailId => mailId;

	public int SelectedIndex => selectedIndex;

	public SimpleCommand ConfirmCmd => confirmCmd;

	public SimpleCommand CancelCmd => cancelCmd;

	public List<PackItemData> PackItemDataList => packItemDataList;

	public InteractionRequest RefreshPackRequest => refreshPackRequest;

	public string BtnText
	{
		get
		{
			return btnText;
		}
		set
		{
			Set(ref btnText, value, "BtnText");
		}
	}

	public GetPackViewModel(OptionBase parent, List<int> packIdList, List<int> serialNumberList)
	{
		base.parent = parent;
		packItemDataList = new List<PackItemData>();
		this.packIdList = packIdList;
		this.serialNumberList = serialNumberList;
		LoadPackList(packIdList[index]);
		confirmCmd = new SimpleCommand(Confirm);
		cancelCmd = new SimpleCommand(Cancel);
		confirmCmd.Enabled = false;
		refreshPackRequest = new InteractionRequest();
		isPassport = true;
		Singleton<ServiceSystem>.Instance.GetService<IPassportService>().ClearPackReward();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg { Obj: PackItemData obj2 })
		{
			ItemOnClick(obj2);
		}
	}

	private void LoadPackList(int packId)
	{
		PackItemDataList.Clear();
		if (GameEntry.DataTable.GetDataRow<DRPacks>(packId) != null)
		{
			DRPacksInclude[] dataRows = GameEntry.DataTable.GetDataRows((DRPacksInclude p) => p.PacksID == packId);
			foreach (DRPacksInclude dRPacksInclude in dataRows)
			{
				PackItemData item = new PackItemData(this, dRPacksInclude.IncludeID, dRPacksInclude.IncludeType, dRPacksInclude.Id, dRPacksInclude.IncludeNUM);
				PackItemDataList.Add(item);
			}
		}
		else
		{
			Toast.ShowInfo($"礼包Id:{packId}数据不存在!");
			Close();
		}
		SetText();
	}

	public void RefreshPack(int newPackId, long mailId = 0L)
	{
		this.mailId = mailId;
		LoadPackList(newPackId);
		refreshPackRequest.Raise();
	}

	private void SetText()
	{
		if (isPassport)
		{
			BtnText = ((index == packIdList.Count) ? "取消" : "跳过");
		}
	}

	public void SetText(bool hasNext)
	{
		if (!isPassport)
		{
			BtnText = (hasNext ? "跳过" : "取消");
		}
	}

	private void ItemOnClick(PackItemData packItemData)
	{
		curPackItemData?.SetSelect(value: false);
		curPackItemData = packItemData;
		curPackItemData.SetSelect(value: true);
		selectedIndex = packItemData.ItemIndex;
		confirmCmd.Enabled = true;
	}

	private void Cancel()
	{
		cancelCmd.Enabled = false;
		if (index != packIdList.Count - 1)
		{
			index++;
			RefreshPack(packIdList[index], 0L);
			cancelCmd.Enabled = true;
		}
		else
		{
			parent?.ItemOnClick(new OptionArg(this, "Cancel"));
		}
	}

	private async void Confirm()
	{
		confirmCmd.Enabled = false;
		if (isPassport)
		{
			Loading loading = await Loading.Show();
			if (await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetPackRequest(serialNumberList[index], selectedIndex))
			{
				confirmCmd.Enabled = true;
				parent?.ItemOnClick(new OptionArg(this, "Confirm"));
			}
			loading?.Dispose();
			return;
		}
		Loading loading2 = await Loading.Show();
		confirmCmd.Enabled = true;
		if (index != packIdList.Count - 1)
		{
			index++;
			RefreshPack(packIdList[index], 0L);
			loading2?.Dispose();
		}
		else
		{
			parent?.ItemOnClick(new OptionArg(this, "Confirm"));
			loading2?.Dispose();
		}
	}

	public GetPackViewModel(OptionBase parent, long mailId, int packId, bool OpenMail)
	{
		base.parent = parent;
		refreshPackRequest = new InteractionRequest();
		packItemDataList = new List<PackItemData>();
		LoadPackList(packId);
		this.mailId = mailId;
		confirmCmd = new SimpleCommand(ConfirmMail);
		cancelCmd = new SimpleCommand(CancelMail);
		confirmCmd.Enabled = false;
		isPassport = false;
	}

	private void ConfirmMail()
	{
		parent.ItemOnClick(new OptionArg(this, "Confirm"));
	}

	private void CancelMail()
	{
		parent.ItemOnClick(new OptionArg(this, "Cancel"));
	}
}
