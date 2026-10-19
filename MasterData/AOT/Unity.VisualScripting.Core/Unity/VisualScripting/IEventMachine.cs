using UnityEngine;

namespace Unity.VisualScripting;

public interface IEventMachine : IMachine, IGraphRoot, IGraphParent, IGraphNester, IAotStubbable
{
	void TriggerAnimationEvent(AnimationEvent animationEvent);

	void TriggerUnityEvent(string name);
}
