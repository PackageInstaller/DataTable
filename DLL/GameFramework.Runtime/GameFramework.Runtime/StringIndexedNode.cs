using System;
using System.Text;

namespace GameFramework.Runtime;

[Serializable]
public class StringIndexedNode : IndexedNode<string>
{
	public StringIndexedNode(string indexValue)
		: base(indexValue)
	{
	}

	public override void AppendTo(StringBuilder output)
	{
		output.AppendFormat("[\"{0}\"]", base.Value);
	}
}
