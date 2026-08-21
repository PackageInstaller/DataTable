namespace UnityEngine.InputSystem.LowLevel;

internal interface IEventPreProcessor
{
	bool PreProcessEvent(InputEventPtr currentEventPtr);
}
