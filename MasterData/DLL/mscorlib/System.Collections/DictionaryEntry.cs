namespace System.Collections;

[Serializable]
public struct DictionaryEntry(object key, object value)
{
	private object _key = key;

	private object _value = value;

	public object Key
	{
		get
		{
			return _key;
		}
		set
		{
			_key = value;
		}
	}

	public object Value
	{
		get
		{
			return _value;
		}
		set
		{
			_value = value;
		}
	}
}
