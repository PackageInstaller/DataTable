public interface XBlackboard
{
	float FrameTime { get; set; }

	float FramePercent { get; set; }

	uint FrameCount { get; set; }

	void Initialize();

	void StartUpdateBlackboard();

	void UpdateBlackboard(SimPersistentState stateFrame);

	void LateUpdateBlackboard(SimPersistentState stateFrame);

	void EndUpdateBlackboard();

	void ResetBlackboard();
}
