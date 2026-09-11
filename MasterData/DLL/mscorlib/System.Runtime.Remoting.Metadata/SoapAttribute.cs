using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Metadata;

[ComVisible(true)]
public class SoapAttribute : Attribute
{
	private bool _useAttribute;

	protected string ProtXmlNamespace;

	protected object ReflectInfo;

	public virtual bool UseAttribute => _useAttribute;

	public virtual string XmlNamespace => ProtXmlNamespace;

	internal virtual void SetReflectionObject(object reflectionObject)
	{
		ReflectInfo = reflectionObject;
	}
}
