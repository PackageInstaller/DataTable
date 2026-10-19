namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Interface, Inherited = false)]
[ComVisible(true)]
public sealed class TypeLibImportClassAttribute : Attribute
{
	internal string _importClassName;

	public TypeLibImportClassAttribute(Type importClass)
	{
		_importClassName = importClass.ToString();
	}
}
