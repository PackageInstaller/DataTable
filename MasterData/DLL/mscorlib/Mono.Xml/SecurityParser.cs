using System.Collections;
using System.IO;
using System.Security;

namespace Mono.Xml;

internal class SecurityParser : SmallXmlParser, SmallXmlParser.IContentHandler
{
	private SecurityElement root;

	private SecurityElement current;

	private Stack stack;

	public SecurityParser()
	{
		stack = new Stack();
	}

	public void LoadXml(string xml)
	{
		root = null;
		stack.Clear();
		Parse(new StringReader(xml), this);
	}

	public SecurityElement ToXml()
	{
		return root;
	}

	public void OnStartParsing(SmallXmlParser parser)
	{
	}

	public void OnProcessingInstruction(string name, string text)
	{
	}

	public void OnIgnorableWhitespace(string s)
	{
	}

	public void OnStartElement(string name, IAttrList attrs)
	{
		SecurityElement securityElement = new SecurityElement(name);
		if (root == null)
		{
			root = securityElement;
			current = securityElement;
		}
		else
		{
			((SecurityElement)stack.Peek()).AddChild(securityElement);
		}
		stack.Push(securityElement);
		current = securityElement;
		int length = attrs.Length;
		for (int i = 0; i < length; i++)
		{
			current.AddAttribute(attrs.GetName(i), SecurityElement.Escape(attrs.GetValue(i)));
		}
	}

	public void OnEndElement(string name)
	{
		current = (SecurityElement)stack.Pop();
	}

	public void OnChars(string ch)
	{
		current.Text = SecurityElement.Escape(ch);
	}

	public void OnEndParsing(SmallXmlParser parser)
	{
	}
}
