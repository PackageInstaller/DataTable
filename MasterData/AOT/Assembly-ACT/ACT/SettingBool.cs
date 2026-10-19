using System;

namespace ACT;

[Serializable]
public class SettingBool : SettingWithValue<bool>
{
	private const string True = "true";

	public override SettingData.DataType DataType => SettingData.DataType.Bool;

	public override bool CheckMatchValue(string value)
	{
		return value.Equals("true", StringComparison.OrdinalIgnoreCase) == GetValue();
	}

	protected override bool DoDeserializeValueFromData(SettingData data, out bool value)
	{
		value = false;
		if (data != null && data.Type == SettingData.DataType.Bool && data.BoolValues != null && data.BoolValues.Length != 0)
		{
			value = data.BoolValues[0];
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
		settingData.BoolValues = new bool[1] { GetAppliedValue() };
		return settingData;
	}
}
