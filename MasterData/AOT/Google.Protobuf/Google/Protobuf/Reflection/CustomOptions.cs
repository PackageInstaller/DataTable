using System.Collections.Generic;

namespace Google.Protobuf.Reflection;

public sealed class CustomOptions
{
	private static readonly object[] EmptyParameters = new object[0];

	private readonly IDictionary<int, IExtensionValue> values;

	internal CustomOptions(IDictionary<int, IExtensionValue> values)
	{
		this.values = values;
	}
}
