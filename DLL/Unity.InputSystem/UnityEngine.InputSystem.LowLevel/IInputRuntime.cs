using System;

namespace UnityEngine.InputSystem.LowLevel;

internal interface IInputRuntime
{
	InputUpdateDelegate onUpdate { get; set; }

	Action<InputUpdateType> onBeforeUpdate { get; set; }

	Func<InputUpdateType, bool> onShouldRunUpdate { get; set; }

	Action<int, string> onDeviceDiscovered { get; set; }

	Action<bool> onPlayerFocusChanged { get; set; }

	bool isPlayerFocused { get; }

	Action onShutdown { get; set; }

	float pollingFrequency { get; set; }

	double currentTime { get; }

	double currentTimeForFixedUpdate { get; }

	float unscaledGameTime { get; }

	double currentTimeOffsetToRealtimeSinceStartup { get; }

	bool runInBackground { get; set; }

	Vector2 screenSize { get; }

	ScreenOrientation screenOrientation { get; }

	bool isInBatchMode { get; }

	int AllocateDeviceId();

	void Update(InputUpdateType type);

	unsafe void QueueEvent(InputEvent* ptr);

	unsafe long DeviceCommand(int deviceId, InputDeviceCommand* commandPtr);
}
