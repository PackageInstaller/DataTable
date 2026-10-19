using System.Xml.Linq;

namespace Newtonsoft.Json.Converters;

internal class XCommentWrapper : XObjectWrapper
{
	private XComment Text => (XComment)WrappedNode;

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

	public XCommentWrapper(XComment text)
		: base(text)
	{
	}
}
