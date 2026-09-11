using System.Runtime.CompilerServices;

namespace System.Diagnostics.Tracing;

[AttributeUsage(AttributeTargets.Class)]
public sealed class EventSourceAttribute : Attribute
{
	[CompilerGenerated]
	private string _003CGuid_003Ek__BackingField;

	[CompilerGenerated]
	private string _003CName_003Ek__BackingField;

	public string Guid
	{
		[CompilerGenerated]
		set
		{
			_003CGuid_003Ek__BackingField = value;
		}
	}

	public string Name
	{
		[CompilerGenerated]
		set
		{
			_003CName_003Ek__BackingField = value;
		}
	}
}
