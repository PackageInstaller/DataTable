namespace System.Diagnostics.Tracing;

[AttributeUsage(AttributeTargets.Class)]
public sealed class EventSourceAttribute : Attribute
{
	public string Guid { set; }

	public string Name { set; }
}
