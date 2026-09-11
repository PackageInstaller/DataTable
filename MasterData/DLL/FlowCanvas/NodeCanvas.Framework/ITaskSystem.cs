using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.Framework;

public interface ITaskSystem
{
	Component agent { get; }

	IBlackboard blackboard { get; }

	float elapsedTime { get; }

	Object contextObject { get; }

	void SendTaskOwnerDefaults();

	void SendEvent(EventData eventData, object sender);

	void RecordUndo(string name);
}
