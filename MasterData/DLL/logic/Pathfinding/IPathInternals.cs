namespace Pathfinding;

public interface IPathInternals
{
	PathHandler PathHandler { get; }

	bool Pooled { get; set; }

	void AdvanceState(PathState s);

	void OnEnterPool();

	void Reset();

	void ReturnPath();

	void PrepareBase(PathHandler handler);

	void Prepare();

	void Initialize();

	void Cleanup();

	void CalculateStep(long targetTick);
}
