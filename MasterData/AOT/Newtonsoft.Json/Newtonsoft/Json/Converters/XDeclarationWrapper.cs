using System.Xml;
using System.Xml.Linq;

namespace Newtonsoft.Json.Converters;

internal class XDeclarationWrapper : XObjectWrapper, IXmlDeclaration, IXmlNode
{
	internal XDeclaration Declaration { get; }

	public override XmlNodeType NodeType => XmlNodeType.XmlDeclaration;

	public string? Version => Declaration.Version;

	public string? Encoding => Declaration.Encoding;

	public string? Standalone => Declaration.Standalone;

	public XDeclarationWrapper(XDeclaration declaration)
		: base(null)
	{
		Declaration = declaration;
	}
}
