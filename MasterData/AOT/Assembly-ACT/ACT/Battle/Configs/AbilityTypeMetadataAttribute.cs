using System;

namespace ACT.Battle.Configs;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct, AllowMultiple = false, Inherited = true)]
public class AbilityTypeMetadataAttribute : Attribute
{
	public string Description { get; }

	public string Category { get; }

	public string[] Tags { get; }

	public AbilityTypeMetadataAttribute(string description, string category, params string[] tags)
	{
		Description = description;
		Category = category;
		Tags = tags ?? new string[0];
	}
}
