namespace System.Threading.Tasks;

internal interface ITaskCompletionAction
{
	bool InvokeMayRunArbitraryCode { get; }

	void Invoke(Task completingTask);
}
