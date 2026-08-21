using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Metadata;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Interface)]
public sealed class SoapTypeAttribute : SoapAttribute
{
	private bool _useAttribute;

	private string _xmlElementName;

	private string _xmlNamespace;

	private string _xmlTypeName;

	private string _xmlTypeNamespace;

	private bool _isType;

	private bool _isElement;

	public override bool UseAttribute => _useAttribute;

	public string XmlElementName => _xmlElementName;

	public override string XmlNamespace => _xmlNamespace;

	public string XmlTypeName => _xmlTypeName;

	public string XmlTypeNamespace => _xmlTypeNamespace;

	internal bool IsInteropXmlElement => _isElement;

	internal bool IsInteropXmlType => _isType;

	internal override void SetReflectionObject(object reflectionObject)
	{
		Type type = (Type)reflectionObject;
		if (_xmlElementName == null)
		{
			_xmlElementName = type.Name;
		}
		if (_xmlTypeName == null)
		{
			_xmlTypeName = type.Name;
		}
		if (_xmlTypeNamespace == null)
		{
			_xmlTypeNamespace = SoapServices.CodeXmlNamespaceForClrTypeNamespace(assemblyName: (!(type.Assembly == typeof(object).Assembly)) ? type.Assembly.GetName().Name : string.Empty, typeNamespace: type.Namespace);
		}
		if (_xmlNamespace == null)
		{
			_xmlNamespace = _xmlTypeNamespace;
		}
	}
}
