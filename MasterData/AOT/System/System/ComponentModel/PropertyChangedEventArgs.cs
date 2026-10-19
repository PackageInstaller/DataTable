namespace System.ComponentModel;

public class PropertyChangedEventArgs : EventArgs
{
	private readonly string _propertyName;

	public PropertyChangedEventArgs(string propertyName)
	{
		_propertyName = propertyName;
	}
}
