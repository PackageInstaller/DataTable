using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Metadata;

[AttributeUsage(AttributeTargets.Method)]
[ComVisible(true)]
public sealed class SoapMethodAttribute : SoapAttribute
{
	private string _responseElement;

	private string _responseNamespace;

	private string _returnElement;

	private string _soapAction;

	private bool _useAttribute;

	private string _namespace;

	public override bool UseAttribute => _useAttribute;

	public override string XmlNamespace => _namespace;

	internal override void SetReflectionObject(object reflectionObject)
	{
		MethodBase methodBase = (MethodBase)reflectionObject;
		if (_responseElement == null)
		{
			_responseElement = methodBase.Name + "Response";
		}
		if (_responseNamespace == null)
		{
			_responseNamespace = SoapServices.GetXmlNamespaceForMethodResponse(methodBase);
		}
		if (_returnElement == null)
		{
			_returnElement = "return";
		}
		if (_soapAction == null)
		{
			_soapAction = SoapServices.GetXmlNamespaceForMethodCall(methodBase) + "#" + methodBase.Name;
		}
		if (_namespace == null)
		{
			_namespace = SoapServices.GetXmlNamespaceForMethodCall(methodBase);
		}
	}
}
