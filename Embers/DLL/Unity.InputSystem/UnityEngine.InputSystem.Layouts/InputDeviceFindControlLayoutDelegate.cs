using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Layouts;

public delegate string InputDeviceFindControlLayoutDelegate(ref InputDeviceDescription description, string matchedLayout, InputDeviceExecuteCommandDelegate executeDeviceCommand);
