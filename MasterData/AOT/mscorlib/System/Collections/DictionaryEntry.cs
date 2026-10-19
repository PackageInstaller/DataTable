namespace System.Collections;

[Serializable]
public struct DictionaryEntry(object key, object value)
{
	private object _key = key;

	private object _value = value;

	public object Key => _key;

	public object Value => _value;
}
