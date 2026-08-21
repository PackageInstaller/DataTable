using System.Collections.Generic;

namespace Ase;

public class PropSourceItemData : ItemOptionBase
{
	private string _text;

	private bool _jumpEnable;

	private bool _jumpWindowUnlock;

	private JumpWindowParams _skipWindowParams;

	public string Text
	{
		get
		{
			return _text;
		}
		set
		{
			Set(ref _text, value, "Text");
		}
	}

	public bool JumpEnable
	{
		get
		{
			return _jumpEnable;
		}
		set
		{
			Set(ref _jumpEnable, value, "JumpEnable");
		}
	}

	public bool JumpWindowUnlock
	{
		get
		{
			return _jumpWindowUnlock;
		}
		set
		{
			Set(ref _jumpWindowUnlock, value, "JumpWindowUnlock");
		}
	}

	public JumpWindowParams SkipWindowParams => _skipWindowParams;

	public PropSourceItemData()
	{
	}

	public PropSourceItemData(PropWindowViewModel parent, string text)
	{
		base.parent = parent;
		Text = text;
		JumpEnable = false;
	}

	public PropSourceItemData(PropWindowViewModel parent, string text, string sourceWindow, List<int> sourceParams)
	{
		base.parent = parent;
		Init(text, sourceWindow, sourceParams);
	}

	public PropSourceItemData(PropInfoViewModel parent, string text)
	{
		base.parent = parent;
		Text = text;
		JumpEnable = false;
	}

	public PropSourceItemData(PropInfoViewModel parent, string text, string sourceWindow, List<int> sourceParams)
	{
		base.parent = parent;
		Init(text, sourceWindow, sourceParams);
	}

	private void Init(string text, string sourceWindow, List<int> sourceParams)
	{
		if (string.IsNullOrEmpty(sourceWindow))
		{
			JumpEnable = false;
			Text = text;
			return;
		}
		List<object> list = new List<object>();
		if (sourceParams != null)
		{
			foreach (int sourceParam in sourceParams)
			{
				list.Add(sourceParam);
			}
		}
		_skipWindowParams = new JumpWindowParams(sourceWindow, list);
		JumpEnable = true;
		JumpWindowUnlock = GetJumpWindowState(sourceWindow, sourceParams);
		Text = (JumpWindowUnlock ? text : ("<color=#7f7575>" + text + "</color>"));
	}

	private bool GetJumpWindowState(string windowName, List<int> args)
	{
		ISOService service = Singleton<ServiceSystem>.Instance.GetService<ISOService>();
		ICopyService service2 = Singleton<ServiceSystem>.Instance.GetService<ICopyService>();
		IMapService service3 = Singleton<ServiceSystem>.Instance.GetService<IMapService>();
		int num = ((args.Count > 0) ? args[0] : 0);
		if (args.Count > 1)
		{
			_ = args[1];
		}
		switch (windowName)
		{
		case "HeroWarehouseWindow":
			return service.GetState(70008);
		case "WorldMapWindow":
			return service3.GetSectionOpenState(num);
		case "LevelMapWindow":
			return service3.GetLevelOpenState(num);
		case "CopySecondType1Window":
			if (service.GetState(70019))
			{
				return service2.CheckCopyTypeOpen(num);
			}
			return false;
		case "CopyFirstWindow":
			return service.GetState(70010);
		case "CopySecondType3Window":
			return service.GetState(70016);
		case "CopySecondType4Window":
			return service.GetState(70017);
		case "HomelandMainWindow":
			return service.GetState(70014);
		default:
			return true;
		}
	}

	public void OnItemClick()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() != GameProcessType.Outer)
		{
			Toast.ShowInfo("当前不可进行跳转");
		}
		else
		{
			parent.ItemOnClick(SkipWindowParams);
		}
	}
}
