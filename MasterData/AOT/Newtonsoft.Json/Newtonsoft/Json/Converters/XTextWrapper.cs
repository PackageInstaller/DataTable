using System.Xml.Linq;

namespace Newtonsoft.Json.Converters;

internal class XTextWrapper : XObjectWrapper
{
	private XText Text => (XText)WrappedNode;

	public override string? Value => Text.Value;

	public override IXmlNode? ParentNode
	{
		get
		{
			if (Text.Parent == null)
			{
				return null;
			}
			return XContainerWrapper.WrapNode(Text.Parent);
		}
	}

	public XTextWrapper(XText text)
		: base(text)
	{
	}
}
