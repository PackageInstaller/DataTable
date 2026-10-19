namespace Unity.VisualScripting;

public interface IGraphEventListener
{
	void StartListening(GraphStack stack);

	void StopListening(GraphStack stack);

	bool IsListening(GraphPointer pointer);
}
