namespace Fundamental;

public interface IContext
{
	ContextType ContextType { get; }

	void ContextDestroy();

	void ContextReset();
}
