using Newtonsoft.Json.Utilities;

namespace Newtonsoft.Json.Serialization;

public class SnakeCaseNamingStrategy : NamingStrategy
{
	public SnakeCaseNamingStrategy(bool processDictionaryKeys, bool overrideSpecifiedNames)
	{
		ProcessDictionaryKeys = processDictionaryKeys;
		OverrideSpecifiedNames = overrideSpecifiedNames;
	}

	public SnakeCaseNamingStrategy(bool processDictionaryKeys, bool overrideSpecifiedNames, bool processExtensionDataNames)
		: this(processDictionaryKeys, overrideSpecifiedNames)
	{
		ProcessExtensionDataNames = processExtensionDataNames;
	}

	public SnakeCaseNamingStrategy()
	{
	}

	protected override string ResolvePropertyName(string name)
	{
		return StringUtils.ToSnakeCase(name);
	}
}
