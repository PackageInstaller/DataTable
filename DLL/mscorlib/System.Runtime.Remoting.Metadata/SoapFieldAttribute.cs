using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Metadata;

[AttributeUsage(AttributeTargets.Field)]
[ComVisible(true)]
public sealed class SoapFieldAttribute : SoapAttribute
{
	private string _elementName;

	private bool _isElement;

	public string XmlElementName => _elementName;

	public bool IsInteropXmlElement()
	{
		return _isElement;
	}

	internal override void SetReflectionObject(object reflectionObject)
	{
		FieldInfo fieldInfo = (FieldInfo)reflectionObject;
		if (_elementName == null)
		{
			_elementName = fieldInfo.Name;
		}
	}
}
