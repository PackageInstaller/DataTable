using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PropInfoViewModel : OptionBase
{
	private PropData _propData;

	private Vector3 vector3;

	private Vector2 anchorMin = Vector2.one * 0.5f;

	private Vector2 anchorMax = Vector2.one * 0.5f;

	private Vector2 pivot = Vector2.one * 0.5f;

	private bool _showOutsideMask = true;

	private bool showOutsideMask2 = true;

	private bool _showOwnCount = true;

	private bool _showArmourRank;

	private Color _armourRankColor;

	private string _armourRankText;

	private string _armourTypeIcon = "";

	private bool _allowSkipWindow = true;

	private InteractionRequest refreshRst;

	private InteractionRequest onAnchorAndPivotChanged = new InteractionRequest();

	private SimpleCommand<JumpWindowParams> _openWindowCmd;

	public PropData PropData
	{
		get
		{
			return _propData ?? (_propData = new PropData());
		}
		set
		{
			Set(ref _propData, value, "PropData");
		}
	}

	public Vector3 Vector3
	{
		get
		{
			return vector3;
		}
		set
		{
			Set(ref vector3, value, "Vector3");
		}
	}

	public Vector2 AnchorMin => anchorMin;

	public Vector2 AnchorMax => anchorMax;

	public Vector2 Pivot => pivot;

	public bool ShowOutsideMask
	{
		get
		{
			return _showOutsideMask;
		}
		set
		{
			Set(ref _showOutsideMask, value, "ShowOutsideMask");
		}
	}

	public bool ShowOutsideMask2
	{
		get
		{
			return showOutsideMask2;
		}
		set
		{
			Set(ref showOutsideMask2, value, "ShowOutsideMask2");
		}
	}

	public bool ShowOwnCount
	{
		get
		{
			return _showOwnCount;
		}
		set
		{
			Set(ref _showOwnCount, value, "ShowOwnCount");
		}
	}

	public bool ShowArmourRank
	{
		get
		{
			return _showArmourRank;
		}
		set
		{
			Set(ref _showArmourRank, value, "ShowArmourRank");
		}
	}

	public Color ArmourRankColor
	{
		get
		{
			return _armourRankColor;
		}
		set
		{
			Set(ref _armourRankColor, value, "ArmourRankColor");
		}
	}

	public string ArmourRankText
	{
		get
		{
			return _armourRankText;
		}
		set
		{
			Set(ref _armourRankText, value, "ArmourRankText");
		}
	}

	public string ArmourTypeIcon
	{
		get
		{
			return _armourTypeIcon;
		}
		set
		{
			Set(ref _armourTypeIcon, value, "ArmourTypeIcon");
		}
	}

	public bool AllowSkipWindow => _allowSkipWindow;

	public InteractionRequest RefreshRst => refreshRst;

	public InteractionRequest OnAnchorAndPivotChanged => onAnchorAndPivotChanged;

	public PropInfoViewModel()
	{
	}

	public PropInfoViewModel(OptionBase parent, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true)
	{
		Init(parent, Vector3.zero, showOutsideMask, showOwnCount, allowSkipWindow);
	}

	public PropInfoViewModel(OptionBase parent, Vector3 vec3, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true)
	{
		Init(parent, vec3, showOutsideMask, showOwnCount, allowSkipWindow);
	}

	public PropInfoViewModel(OptionBase parent, PropData data, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true)
	{
		Init(parent, Vector3.zero, showOutsideMask, showOwnCount, allowSkipWindow);
		RefreshData(data);
	}

	public PropInfoViewModel(OptionBase parent, PropData data, Vector3 vec3, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true, bool showOutsideMask2 = false)
	{
		Init(parent, vec3, showOutsideMask, showOwnCount, allowSkipWindow, showOutsideMask2);
		RefreshData(data);
	}

	private void Init(OptionBase parent, Vector3 vec3, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true, bool showOutsideMask2 = false)
	{
		refreshRst = new InteractionRequest();
		_openWindowCmd = new SimpleCommand<JumpWindowParams>(OpenWindowCommand);
		base.parent = parent;
		Vector3 = vec3;
		ShowOutsideMask = showOutsideMask;
		ShowOutsideMask2 = showOutsideMask2;
		ShowOwnCount = showOwnCount;
		_allowSkipWindow = allowSkipWindow;
	}

	public void RefreshData(PropData data)
	{
		if (data == null)
		{
			visibleRequest.Raise(context: false);
			return;
		}
		PropData = data;
		RefreshArmourRank(data);
		refreshRst.Raise();
		visibleRequest.Raise(context: true);
	}

	private void RefreshArmourRank(PropData data)
	{
		ArmourTypeIcon = "";
		if (data != null)
		{
			if (data.UseType.Contains(21))
			{
				DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(data.Id);
				if (dataRow == null || dataRow.Equipments.Count <= 0)
				{
					ShowArmourRank = false;
					return;
				}
				DREquipment dataRow2 = GameEntry.DataTable.GetDataRow<DREquipment>(dataRow.Equipments[0]);
				if (dataRow2 == null)
				{
					ShowArmourRank = false;
					return;
				}
				ShowArmourRank = true;
				ArmourRankColor = EquipSlotNew.RankBgColor(dataRow2.Rarity);
				ArmourRankText = $"R{dataRow2.RankMin}";
				ArmourTypeIcon = $"ArmourEnum_{dataRow2.Position}";
				return;
			}
		}
		ShowArmourRank = false;
	}

	public void SetAnchorAndPivot(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		this.anchorMin = anchorMin;
		this.anchorMax = anchorMax;
		this.pivot = pivot;
		onAnchorAndPivotChanged.Raise();
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
			}
			else
			{
				parent?.ItemOnClick(openViewArg);
			}
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}

	public void Hide()
	{
		parent?.ItemOnClick(this);
		base.IsVisible = false;
	}
}
