#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ArmourCustomViewModel : OptionBase
{
	private int _usePropId;

	private string _title;

	private List<ArmourCustomGroupData> _optionGroupDataList = new List<ArmourCustomGroupData>();

	private bool _enableConfirm;

	private SimpleCommand _confirmCmd;

	public string Title
	{
		get
		{
			return _title;
		}
		set
		{
			Set(ref _title, value, "Title");
		}
	}

	public List<ArmourCustomGroupData> OptionGroupDataList => _optionGroupDataList;

	public bool EnableConfirm
	{
		get
		{
			return _enableConfirm;
		}
		set
		{
			Set(ref _enableConfirm, value, "EnableConfirm");
		}
	}

	public SimpleCommand ConfirmCmd => _confirmCmd;

	public ArmourCustomViewModel()
	{
	}

	public ArmourCustomViewModel(OptionBase parent, int usePropId)
	{
		base.parent = parent;
		_confirmCmd = new SimpleCommand(Confirm);
		Refresh(usePropId);
	}

	private void Refresh(int usePropId)
	{
		_usePropId = usePropId;
		DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(usePropId);
		if (dataRow != null)
		{
			Refresh(dataRow);
		}
	}

	private void Refresh(DREquipmentPacks config)
	{
		Title = config.Name;
		_optionGroupDataList.Clear();
		if (config.Equipments.Count <= 0)
		{
			Log.Error($"EquipmentPacks表 无效配置 id:{config.Id} 无效列 Equipments 数量为0");
			return;
		}
		DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(config.Equipments[0]);
		if (dataRow == null)
		{
			Log.Error($"EquipmentPacks表 无效配置 id:{config.Id} 无效列 Equipments 索引为0的Id在Equipment表中不存在");
			return;
		}
		if (Enum.IsDefined(typeof(ArmourCustomMode), config.EquipmentsType))
		{
			_optionGroupDataList.Add(new ArmourCustomGroupData(this, (ArmourCustomMode)config.EquipmentsType, ArmourCustomType.MainEntry, 1, config.Equipments));
		}
		else
		{
			Log.Error($"EquipmentPacks表 无效配置 id:{config.Id} 无效列 EquipmentsType:{config.EquipmentsType}");
		}
		if (Enum.IsDefined(typeof(ArmourCustomMode), config.MainAttributeType))
		{
			_optionGroupDataList.Add(new ArmourCustomGroupData(this, (ArmourCustomMode)config.MainAttributeType, ArmourCustomType.MainAttribute, 1, config.DefenseAttribute));
		}
		else
		{
			Log.Error($"EquipmentPacks表 无效配置 id:{config.Id} 无效列 MainAttributeType:{config.MainAttributeType}");
		}
		if (Enum.IsDefined(typeof(ArmourCustomMode), config.SecondaryAttributeType))
		{
			List<DRAttributeStore> list = GameEntry.DataTable.GetDataRows((DRAttributeStore p) => p.StoreId == config.AttributeStore).ToList();
			if (list != null && list.Count > 0)
			{
				List<int> subAttrIdList = new List<int>();
				list.ForEach(delegate(DRAttributeStore p)
				{
					subAttrIdList.Add(p.AttributeId);
				});
				_optionGroupDataList.Add(new ArmourCustomGroupData(this, (ArmourCustomMode)config.SecondaryAttributeType, ArmourCustomType.SubAttribute, dataRow.AttributeMaxNum, subAttrIdList));
			}
			else
			{
				Log.Error($"EquipmentPacks表 无效配置 id:{config.Id} 无效列 AttributeStore：在AttributeStore表中不存在");
			}
		}
		else
		{
			Log.Error($"EquipmentPacks表 无效配置 id:{config.Id} 无效列 SecondaryAttributeType:{config.SecondaryAttributeType}");
		}
		RefreshConfirmState();
	}

	private void OnGroupItemSelectChanged(ArmourCustomGroupData groupData)
	{
		RefreshConfirmState();
	}

	private void RefreshConfirmState()
	{
		EnableConfirm = _optionGroupDataList.Count > 0 && !_optionGroupDataList.Exists((ArmourCustomGroupData p) => p.Mode == ArmourCustomMode.ManualSelection && p.CurSelCount < p.MaxSelCount);
	}

	private async void Confirm()
	{
		_confirmCmd.Enabled = false;
		int targetEquipId = 0;
		ArmourCustomGroupData armourCustomGroupData = _optionGroupDataList.Find((ArmourCustomGroupData p) => p.Type == ArmourCustomType.MainEntry);
		if (armourCustomGroupData != null && armourCustomGroupData.Mode == ArmourCustomMode.ManualSelection)
		{
			ArmourCustomOptionItemData armourCustomOptionItemData = armourCustomGroupData.OptionList.Find((ArmourCustomOptionItemData p) => p.Selected);
			if (armourCustomOptionItemData != null)
			{
				targetEquipId = armourCustomOptionItemData.Id;
			}
		}
		int mainAttrId = 0;
		ArmourCustomGroupData armourCustomGroupData2 = _optionGroupDataList.Find((ArmourCustomGroupData p) => p.Type == ArmourCustomType.MainAttribute);
		if (armourCustomGroupData2 != null && armourCustomGroupData2.Mode == ArmourCustomMode.ManualSelection)
		{
			ArmourCustomOptionItemData armourCustomOptionItemData2 = armourCustomGroupData2.OptionList.Find((ArmourCustomOptionItemData p) => p.Selected);
			if (armourCustomOptionItemData2 != null)
			{
				mainAttrId = armourCustomOptionItemData2.Id;
			}
		}
		List<int> subAttrIds = new List<int>();
		ArmourCustomGroupData armourCustomGroupData3 = _optionGroupDataList.Find((ArmourCustomGroupData p) => p.Type == ArmourCustomType.SubAttribute);
		if (armourCustomGroupData3 != null && armourCustomGroupData3.Mode == ArmourCustomMode.ManualSelection)
		{
			List<ArmourCustomOptionItemData> list = armourCustomGroupData3.OptionList.FindAll((ArmourCustomOptionItemData p) => p.Selected);
			if (list.Count > 0)
			{
				list.ForEach(delegate(ArmourCustomOptionItemData p)
				{
					subAttrIds.Add(p.Id);
				});
			}
		}
		Loading loading = await Loading.Show();
		(bool, RewardGetData) tuple = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RequestMakeCustomEquip(_usePropId, targetEquipId, mainAttrId, subAttrIds);
		loading?.Dispose();
		if (tuple.Item1)
		{
			if (tuple.Item2 != null)
			{
				PropGetViewModel propGetViewModel = new PropGetViewModel(parent, tuple.Item2);
				propGetViewModel.MergeProp();
				OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), propGetViewModel, "ArmourCustom");
				parent?.ItemOnClick(obj);
			}
			Close();
		}
		else
		{
			_confirmCmd.Enabled = true;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ArmourCustomGroupData groupData)
		{
			OnGroupItemSelectChanged(groupData);
		}
	}
}
