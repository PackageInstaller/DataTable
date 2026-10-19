namespace Unity.VisualScripting.Community;

internal class OnUnityEventData : EventUnit<EventData>.Data
{
	public object EventListener { get; set; }
}
