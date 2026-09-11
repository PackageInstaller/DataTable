using System.Configuration;
using System.Xml;
using Unity;

namespace System.Diagnostics;

[Obsolete("This class has been deprecated.  http://go.microsoft.com/fwlink/?linkid=14202")]
public class DiagnosticsConfigurationHandler : IConfigurationSectionHandler
{
	public DiagnosticsConfigurationHandler()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public virtual object Create(object parent, object configContext, XmlNode section)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
		return null;
	}
}
