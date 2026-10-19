namespace Newtonsoft.Json.Converters;

internal interface IXmlDeclaration : IXmlNode
{
	string? Version { get; }

	string? Encoding { get; }

	string? Standalone { get; }
}
