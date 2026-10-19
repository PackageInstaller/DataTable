using System;

namespace ACT;

[Serializable]
public class SettingString : SettingWithValue<string>
{
	public override SettingData.DataType DataType => SettingData.DataType.String;

	public override bool CheckMatchValue(string value)
	{
		return value == GetValue();
	}

	protected override bool DoDeserializeValueFromData(SettingData data, out string value)
	{
		value = string.Empty;
		if (data != null && data.Type == DataType && data.StringValues != null && data.StringValues.Length != 0)
		{
			value = data.StringValues[0];
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
		settingData.StringValues = new string[1] { GetAppliedValue() };
		return settingData;
	}
}
