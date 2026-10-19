namespace System;

[Serializable]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Event | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited = false)]
public sealed class ObsoleteAttribute : Attribute
{
	private string _message;

	private bool _error;

	public string Message => _message;

	public bool IsError => _error;

	public ObsoleteAttribute()
	{
		_message = null;
		_error = false;
	}

	public ObsoleteAttribute(string message)
	{
		_message = message;
		_error = false;
	}

	public ObsoleteAttribute(string message, bool error)
	{
		_message = message;
		_error = error;
	}
}
