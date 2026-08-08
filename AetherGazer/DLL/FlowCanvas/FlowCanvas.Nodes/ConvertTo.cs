using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Utilities/Converters")]
[Obsolete]
public class ConvertTo<T> : PureFunctionNode<T, IConvertible> where T : IConvertible
{
	public override T Invoke(IConvertible obj)
	{
		return (T)Convert.ChangeType(obj, typeof(T));
	}
}
