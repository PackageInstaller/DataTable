using System;

namespace MemoryPack;

public record MemoryPackSerializerOptions
{
	public StringEncoding StringEncoding { get; init; }

	public IServiceProvider? ServiceProvider { get; init; }

	public static readonly MemoryPackSerializerOptions Default = new MemoryPackSerializerOptions
	{
		StringEncoding = StringEncoding.Utf8
	};

	public static readonly MemoryPackSerializerOptions Utf8 = Default with
	{
		StringEncoding = StringEncoding.Utf8
	};

	public static readonly MemoryPackSerializerOptions Utf16 = Default with
	{
		StringEncoding = StringEncoding.Utf16
	};
}
