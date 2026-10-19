using System.Xml;

namespace Newtonsoft.Json.Converters;

internal class XmlDeclarationWrapper : XmlNodeWrapper, IXmlDeclaration, IXmlNode
{
	private readonly XmlDeclaration _declaration;

	public string? Version => _declaration.Version;

	public string? Encoding => _declaration.Encoding;

	public string? Standalone => _declaration.Standalone;

	public XmlDeclarationWrapper(XmlDeclaration declaration)
		: base(declaration)
	{
		_declaration = declaration;
	}
}
