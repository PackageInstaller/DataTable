using Fundamental;

namespace ACT;

internal interface IUpdateableManager
{
	ContextType ContextType { get; }

	ContextState State { get; set; }

	GizmosDrawType GizmosDrawType { get; }

	void DrawGizmos();

	void Update();

	void LateUpdate();

	void FixedUpdate();

	void FixedLateUpdate();

	void Reset();

	void Initialize();
}
