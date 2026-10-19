using System;
using System.Runtime.CompilerServices;

namespace Newtonsoft.Json.Serialization;

public class ErrorContext
{
	[CompilerGenerated]
	private readonly object? OriginalObject__BackingField;

	[CompilerGenerated]
	private readonly object? Member__BackingField;

	[CompilerGenerated]
	private readonly string Path__BackingField;

	internal bool Traced { get; set; }

	public Exception Error { get; }

	public bool Handled { get; }

	internal ErrorContext(object? originalObject, object? member, string path, Exception error)
	{
		OriginalObject__BackingField = originalObject;
		Member__BackingField = member;
		Error = error;
		Path__BackingField = path;
	}
}
