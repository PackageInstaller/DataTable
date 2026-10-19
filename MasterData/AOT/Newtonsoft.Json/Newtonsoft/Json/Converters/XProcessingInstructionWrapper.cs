using System.Xml.Linq;

namespace Newtonsoft.Json.Converters;

internal class XProcessingInstructionWrapper : XObjectWrapper
{
	private XProcessingInstruction ProcessingInstruction => (XProcessingInstruction)WrappedNode;

	public override string? LocalName => ProcessingInstruction.Target;

	public override string? Value => ProcessingInstruction.Data;

	public XProcessingInstructionWrapper(XProcessingInstruction processingInstruction)
		: base(processingInstruction)
	{
	}
}
