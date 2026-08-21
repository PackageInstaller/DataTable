using System;

namespace Ase.ECS;

public abstract class DataNodeBase
{
	public abstract Type ValueType { get; }
}
public abstract class DataNodeBase<T> : DataNodeBase, IDataNodeValue<T>
{
	protected T value;

	public T GetValue()
	{
		return value;
	}

	public void SetValue(IDataNodeValue<T> dnValue)
	{
		value = dnValue.GetValue();
	}

	public void SetValue(T dValue)
	{
		value = dValue;
	}
}
