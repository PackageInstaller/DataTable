namespace System.Threading;

internal interface IAsyncLocal
{
	void OnValueChanged(object previousValue, object currentValue, bool contextChanged);
}
