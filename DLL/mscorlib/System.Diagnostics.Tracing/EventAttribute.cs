using System.Runtime.CompilerServices;

namespace System.Diagnostics.Tracing;

[AttributeUsage(AttributeTargets.Method)]
public sealed class EventAttribute : Attribute
{
	[CompilerGenerated]
	private int _003CEventId_003Ek__BackingField;

	[CompilerGenerated]
	private EventLevel _003CLevel_003Ek__BackingField;

	[CompilerGenerated]
	private EventKeywords _003CKeywords_003Ek__BackingField;

	[CompilerGenerated]
	private string _003CMessage_003Ek__BackingField;

	private int EventId
	{
		[CompilerGenerated]
		set
		{
			_003CEventId_003Ek__BackingField = value;
		}
	}

	public EventLevel Level
	{
		[CompilerGenerated]
		set
		{
			_003CLevel_003Ek__BackingField = value;
		}
	}

	public EventKeywords Keywords
	{
		[CompilerGenerated]
		set
		{
			_003CKeywords_003Ek__BackingField = value;
		}
	}

	public string Message
	{
		[CompilerGenerated]
		set
		{
			_003CMessage_003Ek__BackingField = value;
		}
	}

	public EventAttribute(int eventId)
	{
		EventId = eventId;
	}
}
