using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class IndicatorSetViewModel : OptionBase
{
	public enum SubTabEnum
	{
		Indicator = 1
	}

	private SubTabEnum _curSubTabEnum;

	private RoleDecorateData _curSelectIndicatorData;

	private int _curAppliedIndicatorId;

	private int _previewIndex = -1;

	private List<DRIndicatorRing> _previewConfigList = new List<DRIndicatorRing>();

	private List<TabItemData> _subTabItemDataList = new List<TabItemData>();

	private List<IndicatorItemData> _indicatorItemDataList = new List<IndicatorItemData>();

	private InteractionRequest _subTabChangedRst = new InteractionRequest();

	private InteractionRequest<SubTabEnum> _dataListChangeRst = new InteractionRequest<SubTabEnum>();

	private InteractionRequest _curSelectChangedRst = new InteractionRequest();

	private SimpleCommand _applyCmd;

	private bool _curSelectGot;

	private bool _curSelectIsUse;

	public SubTabEnum CurSubTabEnum
	{
		get
		{
			return _curSubTabEnum;
		}
		set
		{
			Set(ref _curSubTabEnum, value, "CurSubTabEnum");
		}
	}

	public RoleDecorateData CurSelectIndicatorData
	{
		get
		{
			return _curSelectIndicatorData;
		}
		set
		{
			Set(ref _curSelectIndicatorData, value, "CurSelectIndicatorData");
		}
	}

	public int CurAppliedIndicatorId => _curAppliedIndicatorId;

	public List<TabItemData> SubTabItemDataList => _subTabItemDataList;

	public List<IndicatorItemData> IndicatorItemDataList => _indicatorItemDataList;

	public InteractionRequest SubTabChangedRst => _subTabChangedRst;

	public InteractionRequest<SubTabEnum> DataListChangeRst => _dataListChangeRst;

	public InteractionRequest CurSelectChangedRst => _curSelectChangedRst;

	public SimpleCommand ApplyCmd => _applyCmd;

	public bool CurSelectGot
	{
		get
		{
			return _curSelectGot;
		}
		private set
		{
			Set(ref _curSelectGot, value, "CurSelectGot");
		}
	}

	public bool CurSelectIsUse
	{
		get
		{
			return _curSelectIsUse;
		}
		private set
		{
			Set(ref _curSelectIsUse, value, "CurSelectIsUse");
		}
	}

	public IndicatorSetViewModel()
	{
	}

	public IndicatorSetViewModel(OptionBase parent, SubTabEnum defaultTabEnum = SubTabEnum.Indicator)
	{
		base.parent = parent;
		_applyCmd = new SimpleCommand(OnApplyClicked);
		foreach (SubTabEnum value in Enum.GetValues(typeof(SubTabEnum)))
		{
			string subTabName = GetSubTabName(value);
			_subTabItemDataList.Add(new TabItemData(this, (int)value)
			{
				TextNormal = subTabName,
				TextSelected = subTabName
			});
		}
		OnInit();
		SetSubTabSelected(defaultTabEnum);
	}

	private void OnInit()
	{
		_curAppliedIndicatorId = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetIndicatorSetting() ?? 0;
		RefreshIndicatorDatas();
	}

	private void RefreshIndicatorDatas()
	{
		_indicatorItemDataList.Clear();
		List<RoleDecorateData> obj = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.Indicator) ?? new List<RoleDecorateData>();
		Dictionary<int, RoleDecorateData> dictionary = new Dictionary<int, RoleDecorateData> { 
		{
			0,
			new RoleDecorateData
			{
				id = 0,
				DecorateType = RoleDecorateEnum.Indicator,
				expireTime = 0L,
				isNew = false
			}
		} };
		foreach (RoleDecorateData item in obj)
		{
			if (!dictionary.ContainsKey(item.id))
			{
				dictionary.Add(item.id, item);
			}
		}
		List<DRIndicatorRing> list = GameEntry.DataTable.GetAllDataRow<DRIndicatorRing>().ToList();
		list.Sort((DRIndicatorRing a, DRIndicatorRing b) => a.Sort.CompareTo(b.Sort) * 10 + a.Id.CompareTo(b.Id));
		foreach (DRIndicatorRing item2 in list)
		{
			bool flag = dictionary.TryGetValue(item2.Id, out var value);
			if (!flag)
			{
				value = new RoleDecorateData
				{
					id = item2.Id,
					DecorateType = RoleDecorateEnum.Indicator,
					expireTime = ((item2.Id != 0) ? (-1) : 0),
					isNew = false
				};
			}
			_indicatorItemDataList.Add(new IndicatorItemData(this, value, flag, isUse: false));
		}
		if (!_indicatorItemDataList.Exists((IndicatorItemData p) => !p.IsActive && p.Data.id == _curAppliedIndicatorId))
		{
			_curAppliedIndicatorId = _indicatorItemDataList.Find((IndicatorItemData p) => !p.IsActive && p.Data.id == 0)?.Data.id ?? _indicatorItemDataList.Find((IndicatorItemData p) => !p.IsActive)?.Data.id ?? 0;
		}
		RefreshApplyState();
		SortIndicatorDatas();
		if (_indicatorItemDataList.Count > 0)
		{
			IndicatorItemData itemData = _indicatorItemDataList.Find((IndicatorItemData p) => p.IsUse) ?? _indicatorItemDataList[0];
			OnIndicatorItemClick(itemData, rebuildPreview: true, raiseEvent: false);
		}
		else
		{
			CurSelectIndicatorData = null;
			CurSelectGot = false;
			CurSelectIsUse = false;
		}
		_dataListChangeRst.Raise(SubTabEnum.Indicator);
	}

	private void RefreshApplyState()
	{
		foreach (IndicatorItemData indicatorItemData in _indicatorItemDataList)
		{
			indicatorItemData.IsUse = !indicatorItemData.IsActive && indicatorItemData.Data.id == _curAppliedIndicatorId;
		}
	}

	private void SortIndicatorDatas()
	{
		_indicatorItemDataList.Sort(delegate(IndicatorItemData a, IndicatorItemData b)
		{
			int num = (a.IsUse ? 1 : 0);
			int value = (b.IsUse ? 1 : 0);
			int num2 = ((!a.IsActive) ? 1 : 0);
			int value2 = ((!b.IsActive) ? 1 : 0);
			int num3 = a.Config?.Sort ?? int.MaxValue;
			int value3 = b.Config?.Sort ?? int.MaxValue;
			int num4 = a.Config?.Id ?? int.MaxValue;
			int value4 = b.Config?.Id ?? int.MaxValue;
			return -num.CompareTo(value) * 10000 - num2.CompareTo(value2) * 1000 + num3.CompareTo(value3) * 10 + num4.CompareTo(value4);
		});
	}

	private void OnIndicatorItemClick(IndicatorItemData itemData, bool rebuildPreview = true, bool raiseEvent = true)
	{
		if (itemData != null && itemData.Config != null)
		{
			_indicatorItemDataList.ForEach(delegate(IndicatorItemData p)
			{
				p.IsSelected = p.Data.id == itemData.Data.id;
			});
			CurSelectIndicatorData = itemData.Data;
			CurSelectGot = !itemData.IsActive;
			CurSelectIsUse = itemData.IsUse;
			if (rebuildPreview)
			{
				BuildPreviewList(itemData.Config.GroupId, itemData.Data.id);
			}
			else
			{
				SyncPreviewIndex(itemData.Data.id);
			}
			if (itemData.Data.isNew)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetDecorateItemRead(itemData.Data.DecorateType, itemData.Data.id);
			}
			if (raiseEvent)
			{
				_curSelectChangedRst.Raise();
			}
		}
	}

	private void BuildPreviewList(int groupId, int focusId)
	{
		_previewConfigList.Clear();
		List<DRIndicatorRing> list = GameEntry.DataTable.GetAllDataRow<DRIndicatorRing>().ToList();
		if (list.Count == 0)
		{
			_previewIndex = -1;
			return;
		}
		_previewConfigList.AddRange(list.FindAll((DRIndicatorRing p) => p.GroupId == groupId));
		if (_previewConfigList.Count == 0)
		{
			DRIndicatorRing dRIndicatorRing = list.Find((DRIndicatorRing p) => p.Id == focusId);
			if (dRIndicatorRing != null)
			{
				_previewConfigList.Add(dRIndicatorRing);
			}
		}
		_previewConfigList.Sort((DRIndicatorRing a, DRIndicatorRing b) => a.Sort.CompareTo(b.Sort) * 10 + a.Id.CompareTo(b.Id));
		_previewIndex = _previewConfigList.FindIndex((DRIndicatorRing p) => p.Id == focusId);
		if (_previewIndex < 0 && _previewConfigList.Count > 0)
		{
			_previewIndex = 0;
		}
	}

	private void SyncPreviewIndex(int indicatorId)
	{
		if (_previewConfigList.Count <= 0)
		{
			_previewIndex = -1;
			return;
		}
		int num = _previewConfigList.FindIndex((DRIndicatorRing p) => p.Id == indicatorId);
		if (num >= 0)
		{
			_previewIndex = num;
		}
		else if (_previewIndex < 0 || _previewIndex >= _previewConfigList.Count)
		{
			_previewIndex = 0;
		}
	}

	private async void OnApplyClicked()
	{
		if (CurSelectIndicatorData == null)
		{
			return;
		}
		IndicatorItemData indicatorItemData = _indicatorItemDataList.Find((IndicatorItemData p) => p.Data.id == CurSelectIndicatorData.id);
		if (indicatorItemData == null || indicatorItemData.IsActive || indicatorItemData.IsUse)
		{
			return;
		}
		_curAppliedIndicatorId = CurSelectIndicatorData.id;
		if (await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().SetIndicatorSetting(_curAppliedIndicatorId))
		{
			RefreshApplyState();
			SortIndicatorDatas();
			_dataListChangeRst.Raise(SubTabEnum.Indicator);
			IndicatorItemData indicatorItemData2 = _indicatorItemDataList.Find((IndicatorItemData p) => p.Data.id == _curAppliedIndicatorId);
			if (indicatorItemData2 != null)
			{
				OnIndicatorItemClick(indicatorItemData2, rebuildPreview: false);
			}
		}
	}

	public void SetSubTabSelected(SubTabEnum subTabEnum)
	{
		TabItemData tabItemData = _subTabItemDataList.Find((TabItemData p) => p.TabIndex == (int)subTabEnum);
		if (tabItemData != null)
		{
			SetSubTabSelected(tabItemData);
		}
	}

	private void SetSubTabSelected(TabItemData tabItemData)
	{
		CurSubTabEnum = (SubTabEnum)tabItemData.TabIndex;
		_subTabItemDataList.ForEach(delegate(TabItemData p)
		{
			p.IsSelected = p.TabIndex == tabItemData.TabIndex;
		});
		_subTabChangedRst.Raise();
	}

	public string GetSubTabName(SubTabEnum subTabEnum)
	{
		if (subTabEnum == SubTabEnum.Indicator)
		{
			return "战斗辉环";
		}
		return "";
	}

	public int GetDisplayDataCount()
	{
		if (CurSubTabEnum == SubTabEnum.Indicator)
		{
			return _indicatorItemDataList.Count;
		}
		return 0;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is IndicatorItemData itemData)
		{
			OnIndicatorItemClick(itemData);
		}
		else if (obj is JumpWindowParams jumpWindowParams)
		{
			parent?.ItemOnClick(jumpWindowParams);
		}
		base.ItemOnClick(obj);
	}
}
