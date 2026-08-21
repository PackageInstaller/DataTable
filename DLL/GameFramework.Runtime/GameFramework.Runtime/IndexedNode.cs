using System;
using System.Text;

namespace GameFramework.Runtime;

[Serializable]
public abstract class IndexedNode : IPathNode
{
	private object _value;

	public bool IsStatic => false;

	public object Value
	{
		get
		{
			return _value;
		}
		private set
		{
			_value = value;
		}
	}

	public IndexedNode(object value)
	{
		_value = value;
	}

	public abstract void AppendTo(StringBuilder output);

	public override string ToString()
	{
		return "IndexedNode:" + ((_value == null) ? "null" : _value.ToString());
	}
}
[Serializable]
public abstract class IndexedNode<T> : IndexedNode, IPathNode
{
	public new T Value => (T)base.Value;

	public IndexedNode(T value)
		: base(value)
	{
	}
}
