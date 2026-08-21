namespace System.ComponentModel;

public interface ITypedList
{
	string GetListName(PropertyDescriptor[] listAccessors);

	PropertyDescriptorCollection GetItemProperties(PropertyDescriptor[] listAccessors);
}
