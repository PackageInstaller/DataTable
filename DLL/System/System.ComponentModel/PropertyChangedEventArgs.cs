namespace System.ComponentModel;

public class PropertyChangedEventArgs : EventArgs
{
	private readonly string _propertyName;

	public virtual string PropertyName => _propertyName;

	public PropertyChangedEventArgs(string propertyName)
	{
		_propertyName = propertyName;
	}
}
