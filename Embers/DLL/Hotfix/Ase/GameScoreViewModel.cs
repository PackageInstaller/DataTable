using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GameScoreViewModel : OptionBase
{
	private string title;

	private string content;

	private List<TabItemNormalData> starList;

	private SimpleCommand rantCmd;

	private SimpleCommand evaluateCmd;

	private bool showThank;

	private bool isIos;

	private string cancelText;

	private string confirmText;

	private Timer timer;

	private int duration;

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public string Content
	{
		get
		{
			return content;
		}
		set
		{
			Set(ref content, value, "Content");
		}
	}

	public List<TabItemNormalData> StarList => starList;

	public SimpleCommand RantCmd => rantCmd;

	public SimpleCommand EvaluateCmd => evaluateCmd;

	public bool IsIos => isIos;

	public string CancelText => cancelText;

	public string ConfirmText => confirmText;

	public bool ShowThank
	{
		get
		{
			return showThank;
		}
		set
		{
			Set(ref showThank, value, "ShowThank");
		}
	}

	public GameScoreViewModel(OptionBase parent, int id, string exText = "")
	{
		base.parent = parent;
		DRGameScore dataRow = GameEntry.DataTable.GetDataRow<DRGameScore>(id);
		Title = string.Format(dataRow.Title, exText);
		Content = dataRow.Content;
		rantCmd = new SimpleCommand(JumpRant);
		evaluateCmd = new SimpleCommand(JumpRant);
		starList = new List<TabItemNormalData>();
		for (int i = 0; i < 5; i++)
		{
			TabItemNormalData item = new TabItemNormalData(this, "empty", i + 1);
			starList.Add(item);
		}
		isIos = false;
		cancelText = (isIos ? "下次再说" : "取消");
		confirmText = (isIos ? "去评价" : "去TapTap评价");
		timer = Timer.Register(1f, AutoAddDuration, null, isLooped: true, useRealTime: true);
		BannerService.SendTDAEventPopup(IsIos ? 99 : 98, "system");
	}

	private void AutoAddDuration()
	{
		duration++;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData tabItemNormalData)
		{
			SetStar(tabItemNormalData.ID);
		}
	}

	private void SetStar(int index)
	{
		foreach (TabItemNormalData star in starList)
		{
			star.SetSelected(star.ID <= index);
		}
		if (index == 5)
		{
			SendEvaluate();
		}
	}

	private void SendEvaluate()
	{
		ShowThank = true;
		Close();
	}

	private void JumpRant()
	{
		evaluateCmd.Enabled = false;
		rantCmd.Enabled = false;
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>().OpenTapReview();
		ShowThank = true;
		string text = (IsIos ? "IOS商店" : "TapTap平台");
		BannerService.SendTDAEventClick(IsIos ? 99 : 98, "用户点击跳转" + text, duration);
	}

	public void BtnCancel()
	{
		BannerService.SendTDAEventClose(IsIos ? 99 : 98, "用户点击关闭", duration);
		parent?.ItemOnClick(new ViewBackArg(this));
	}

	public override void Close()
	{
		if (timer != null)
		{
			Timer.Cancel(timer);
			timer = null;
		}
		base.Close();
	}
}
