namespace UnityEngine.InputSystem.Utilities;

internal interface ISavedState
{
	void StaticDisposeCurrentState();

	void RestoreSavedState();
}
