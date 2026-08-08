public interface IEventReceiver
{
	void AddHandler<T>(EventHandler<T> handler) where T : NEventBase;

	void RemoveAllHandlers();

	void RemoveHandler<T>(EventHandler<T> handler) where T : NEventBase;
}
