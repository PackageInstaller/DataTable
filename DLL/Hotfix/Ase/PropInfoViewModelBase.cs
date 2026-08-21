using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PropInfoViewModelBase : OptionBase
{
	private PropDataBase _data;

	private Vector3 _pos;

	private Vector2 _anchorMin = Vector2.one * 0.5f;

	private Vector2 _anchorMax = Vector2.one * 0.5f;

	private Vector2 _pivot = Vector2.one * 0.5f;

	private bool _showOutsideMask = true;

	private bool _showOwnCount = true;

	private bool _allowSkipWindow = true;

	private InteractionRequest _refreshRst = new InteractionRequest();

	private InteractionRequest _rectInfoChangeRst = new InteractionRequest();

	private SimpleCommand<JumpWindowParams> _openWindowCmd;

	public PropDataBase Data
	{
		get
		{
			return _data ?? (_data = new PropDataBase());
		}
		protected set
		{
			Set(ref _data, value, "Data");
		}
	}

	public Vector3 Pos
	{
		get
		{
			return _pos;
		}
		protected set
		{
			Set(ref _pos, value, "Pos");
		}
	}

	public Vector2 AnchorMin => _anchorMin;

	public Vector2 AnchorMax => _anchorMax;

	public Vector2 Pivot => _pivot;

	public bool ShowOutsideMask
	{
		get
		{
			return _showOutsideMask;
		}
		protected set
		{
			Set(ref _showOutsideMask, value, "ShowOutsideMask");
		}
	}

	public bool ShowOwnCount
	{
		get
		{
			return _showOwnCount;
		}
		protected set
		{
			Set(ref _showOwnCount, value, "ShowOwnCount");
		}
	}

	public bool AllowSkipWindow => _allowSkipWindow;

	public InteractionRequest RefreshRst => _refreshRst;

	public InteractionRequest RectInfoChangeRst => _rectInfoChangeRst;

	public PropInfoViewModelBase()
	{
	}

	public PropInfoViewModelBase(OptionBase parent, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true)
	{
		Init(parent, showOutsideMask, showOwnCount, allowSkipWindow);
	}

	protected void Init(OptionBase parent, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true)
	{
		_openWindowCmd = new SimpleCommand<JumpWindowParams>(OpenWindowCommand);
		base.parent = parent;
		ShowOutsideMask = showOutsideMask;
		ShowOwnCount = showOwnCount;
		_allowSkipWindow = allowSkipWindow;
	}

	public virtual void RefreshData(PropDataBase data)
	{
		if (data != null)
		{
			Data = data;
			_refreshRst.Raise();
		}
	}

	public void SetPosition(Vector3 pos)
	{
		Pos = pos;
		_rectInfoChangeRst.Raise();
	}

	public void SetRectInfo(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		_anchorMin = anchorMin;
		_anchorMax = anchorMax;
		_pivot = pivot;
		_rectInfoChangeRst.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is JumpWindowParams jumpWindowParams)
		{
			_openWindowCmd.Execute(jumpWindowParams);
		}
		else
		{
			parent.ItemOnClick(obj);
		}
	}

	private async void OpenWindowCommand(JumpWindowParams jumpParams)
	{
		if (parent.CheckOpen(this, jumpParams))
		{
			_openWindowCmd.Enabled = false;
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(jumpParams, parent, "PropInfo", delegate
			{
				_openWindowCmd.Enabled = true;
			});
			if (openViewArg == null)
			{
				_openWindowCmd.Enabled = true;
				return;
			}
			parent?.ItemOnClick(openViewArg);
			Close();
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
