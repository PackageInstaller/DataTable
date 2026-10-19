using System;
using UnityEngine;

namespace ACT;

[Serializable]
public class SettingFloat : SettingWithValue<float>
{
	public override SettingData.DataType DataType => SettingData.DataType.Float;

	public override bool CheckMatchValue(string value)
	{
		if (float.TryParse(value, out var result))
		{
			return Mathf.Approximately(result, GetValue());
		}
		return false;
	}

	protected override bool DoDeserializeValueFromData(SettingData data, out float value)
	{
		value = 0f;
		if (data != null && data.Type == DataType && data.FloatValues != null && data.FloatValues.Length != 0)
		{
			value = data.FloatValues[0];
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
		settingData.FloatValues = new float[1] { GetAppliedValue() };
		return settingData;
	}
}
