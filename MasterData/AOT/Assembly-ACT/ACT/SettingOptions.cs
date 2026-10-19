using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT;

[Serializable]
public class SettingOptions : SettingWithValue<int>
{
	public override SettingData.DataType DataType => SettingData.DataType.Int;

	protected override int VerifyValue(int value)
	{
		return Mathf.Clamp(value, 0, GetOptionLabelCount() - 1);
	}

	public override bool CheckMatchValue(string value)
	{
		if (int.TryParse(value, out var result))
		{
			if (result >= 0)
			{
				return result == GetValue();
			}
			return true;
		}
		return false;
	}

	public IConnectionWithOptions GetConnectionWithOptions()
	{
		return GetConnection() as IConnectionWithOptions;
	}

	public int GetOptionLabelCount()
	{
		if (GetConnection() is IConnectionWithOptions connectionWithOptions)
		{
			return connectionWithOptions.GetOptionCount();
		}
		return 0;
	}

	public List<TOption> GetOptionLabels<TOption>()
	{
		if (GetConnection() is IConnectionWithOptions<TOption> connectionWithOptions)
		{
			return connectionWithOptions.GetOptionLabels();
		}
		return null;
	}

	protected override bool DoDeserializeValueFromData(SettingData data, out int value)
	{
		value = 0;
		if (data != null && data.Type == DataType && data.IntValues != null && data.IntValues.Length != 0)
		{
			value = data.IntValues[0];
			return true;
		}
		return false;
	}

	protected override SettingData DoSerializeValueToData()
	{
		SettingData settingData = new SettingData();
		settingData.Id = Id;
		settingData.Version = Version;
		settingData.Type = DataType;
		settingData.IntValues = new int[1] { GetAppliedValue() };
		return settingData;
	}
}
