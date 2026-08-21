using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyPermitViewModel : OptionBase
{
	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private List<PermitTaskItemViewModel> taskList;

	private int curPermitLevel;

	private bool isAllComplete;

	private string curPermitDesc;

	private CopyViewModel copyVM;

	public int CurPermitLevel
	{
		get
		{
			return curPermitLevel;
		}
		private set
		{
			Set(ref curPermitLevel, value, "CurPermitLevel");
		}
	}

	public bool IsAllComplete
	{
		get
		{
			return isAllComplete;
		}
		private set
		{
			Set(ref isAllComplete, value, "IsAllComplete");
		}
	}

	public string CurPermitDesc
	{
		get
		{
			return curPermitDesc;
		}
		private set
		{
			Set(ref curPermitDesc, value, "CurPermitDesc");
		}
	}

	public List<PermitTaskItemViewModel> TaskList => taskList;

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public CopyPermitViewModel()
	{
	}

	public CopyPermitViewModel(OptionBase parent)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		CurPermitLevel = copyVM.CopyPermitLevel;
		SetPermitData();
		copyVM.AddPermitRefreshListener(OnRefresh);
	}

	private void OnRefresh(bool upgrade)
	{
		if (upgrade)
		{
			SetPermitData();
		}
		else
		{
			taskList.Sort(new PermitTaskItemSort());
		}
	}

	private void SetPermitData()
	{
		List<CopyPermitData> permitDataList = copyVM.PermitDataList;
		CurPermitLevel = copyVM.CopyPermitLevel;
		if (permitDataList == null || permitDataList.Count == 0)
		{
			IsAllComplete = true;
		}
		DRPermit dataRow = GameEntry.DataTable.GetDataRow((DRPermit p) => p.Id == curPermitLevel);
		if (dataRow != null)
		{
			CurPermitDesc = dataRow.Desc;
		}
		else
		{
			CurPermitDesc = "暂无数据！";
		}
		if (taskList == null)
		{
			taskList = new List<PermitTaskItemViewModel>();
		}
		else
		{
			taskList.Clear();
		}
		for (int num = 0; num < permitDataList.Count; num++)
		{
			taskList.Add(new PermitTaskItemViewModel(this, permitDataList[num]));
		}
		taskList.Sort(new PermitTaskItemSort());
		optRequest.Raise("RefreshAllPermit");
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OnOpenBig".Equals(optName))
		{
			optRequest.Raise(optName);
		}
		else if ("OnCloseBig".Equals(optName))
		{
			optRequest.Raise(optName);
		}
		optCommand.Enabled = true;
	}

	public void EnableOpt(bool isLight)
	{
		optCommand.Enabled = true;
	}

	public void RemoveListener()
	{
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().RemovePermitRefreshListener(OnRefresh);
	}
}
