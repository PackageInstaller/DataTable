using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Utilities/Converters")]
[Obsolete]
public class CastTo<T> : PureFunctionNode<T, object>
{
	public override T Invoke(object obj)
	{
		try
		{
			return (T)obj;
		}
		catch
		{
			return default(T);
		}
	}
}
