#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopyTrainViewModel : CopyEnterViewModel
{
	private SimpleCommand<string> optCommand;

	private CopyData copyData;

	public ICommand OptCommand => optCommand;

	public CopyTrainViewModel()
	{
	}

	public CopyTrainViewModel(OptionBase parent)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
	}

	public override void ItemOnClick(object obj)
	{
		if ("OpenSingle".Equals(obj))
		{
			OpenSingle();
		}
		else
		{
			base.ItemOnClick(obj);
		}
	}

	public void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		int num = 0;
		if ("OpenTrain1".Equals(optName))
		{
			num = 99000;
		}
		else if ("OpenTrain2".Equals(optName))
		{
			num = 99100;
		}
		copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetTrainCopy(num);
		if (copyData != null)
		{
			OpenSingle();
			return;
		}
		Log.Error($"找不到副本类型为{num}的副本，请检查！");
		optCommand.Enabled = true;
	}

	private void OpenSingle()
	{
		try
		{
			BattleReadyViewModel userData = new BattleReadyViewModel(this, new BattleReadyData(BattleReadyTarget.Copy, copyData.Id));
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}
}
