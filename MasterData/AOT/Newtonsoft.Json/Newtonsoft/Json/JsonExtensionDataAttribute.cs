using System;

namespace Newtonsoft.Json;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false)]
public class JsonExtensionDataAttribute : Attribute
{
	public bool WriteData { get; }

	public bool ReadData { get; }
}
