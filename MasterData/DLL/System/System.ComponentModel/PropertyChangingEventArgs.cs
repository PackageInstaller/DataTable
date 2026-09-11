namespace System.ComponentModel;

public class PropertyChangingEventArgs : EventArgs
{
	private readonly string _propertyName;

	public PropertyChangingEventArgs(string propertyName)
	{
		_propertyName = propertyName;
	}
}
