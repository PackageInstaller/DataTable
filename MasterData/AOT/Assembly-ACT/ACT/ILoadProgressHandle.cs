namespace ACT;

public interface ILoadProgressHandle
{
	float Progress { get; }

	bool IsDone { get; }

	bool CouldDispose { get; }

	void Dispose();
}
