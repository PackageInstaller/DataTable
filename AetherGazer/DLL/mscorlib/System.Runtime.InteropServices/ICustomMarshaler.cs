namespace System.Runtime.InteropServices;

public interface ICustomMarshaler
{
	object MarshalNativeToManaged(IntPtr pNativeData);

	IntPtr MarshalManagedToNative(object ManagedObj);

	void CleanUpNativeData(IntPtr pNativeData);

	void CleanUpManagedData(object ManagedObj);

	int GetNativeDataSize();
}
