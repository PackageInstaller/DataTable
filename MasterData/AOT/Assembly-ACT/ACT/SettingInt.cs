using System;

namespace ACT;

[Serializable]
public class SettingInt : SettingWithValue<int>
{
	public override SettingData.DataType DataType => SettingData.DataType.Int;

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
