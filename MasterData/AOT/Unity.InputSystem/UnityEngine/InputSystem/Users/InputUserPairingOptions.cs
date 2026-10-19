using System;

namespace UnityEngine.InputSystem.Users;

[Flags]
public enum InputUserPairingOptions
{
	None = 0,
	ForcePlatformUserAccountSelection = 1,
	ForceNoPlatformUserAccountSelection = 2,
	UnpairCurrentDevicesFromUser = 8
}
