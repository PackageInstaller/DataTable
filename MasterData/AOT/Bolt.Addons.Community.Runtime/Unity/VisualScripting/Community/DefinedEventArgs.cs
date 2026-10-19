namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Support.DefinedEventArgs")]
public struct DefinedEventArgs(object eventData)
{
	public object eventData = eventData;
}
