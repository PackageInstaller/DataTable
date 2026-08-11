namespace GameFramework;

internal interface ITaskAgent<T> where T : TaskBase
{
	T Task { get; }

	void Initialize();

	void Update(float elapseSeconds, float realElapseSeconds);

	void Shutdown();

	StartTaskStatus Start(T task);

	void Reset();
}
