namespace Unity.VisualScripting;

public struct CustomEventArgs(string name, params object[] arguments)
{
	public readonly string name = name;

	public readonly object[] arguments = arguments;
}
