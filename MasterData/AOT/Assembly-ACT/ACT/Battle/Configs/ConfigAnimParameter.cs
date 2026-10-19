using System;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigAnimParameter
{
	public string name;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	public Action<ConfigAnimParameter> onParaChange;

	internal ConfigAnimParameter Clone()
	{
		return (ConfigAnimParameter)MemberwiseClone();
	}
}
