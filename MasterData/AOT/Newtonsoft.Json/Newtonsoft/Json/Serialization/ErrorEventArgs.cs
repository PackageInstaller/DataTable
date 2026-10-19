using System;
using System.Runtime.CompilerServices;

namespace Newtonsoft.Json.Serialization;

public class ErrorEventArgs : EventArgs
{
	[CompilerGenerated]
	private readonly object? CurrentObject__BackingField;

	[CompilerGenerated]
	private readonly ErrorContext ErrorContext__BackingField;

	public ErrorEventArgs(object? currentObject, ErrorContext errorContext)
	{
		CurrentObject__BackingField = currentObject;
		ErrorContext__BackingField = errorContext;
	}
}
