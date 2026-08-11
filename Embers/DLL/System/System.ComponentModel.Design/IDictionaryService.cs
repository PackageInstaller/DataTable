namespace System.ComponentModel.Design;

public interface IDictionaryService
{
	object GetValue(object key);

	void SetValue(object key, object value);
}
