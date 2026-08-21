using UnityEngine.InputSystem;

internal static class UISupport
{
	public static void Initialize()
	{
		InputSystem.RegisterLayout("\n            {\n                \"name\" : \"VirtualMouse\",\n                \"extend\" : \"Mouse\"\n            }\n        ");
	}
}
