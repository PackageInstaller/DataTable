using UnityEngine;

namespace NodeCanvas.Framework;

public interface ITaskSystem
{
	Component agent { get; }

	IBlackboard blackboard { get; }

	Object contextObject { get; }

	float elapsedTime { get; }

	float IntervalTimer { get; }

	float deltaTime { get; }

	bool FrozenFrameIsPauseTree { get; }

	void UpdateTasksOwner();

	void SendEvent(string name, object value, object sender);

	void SendEvent<T>(string name, T value, object sender);
}
