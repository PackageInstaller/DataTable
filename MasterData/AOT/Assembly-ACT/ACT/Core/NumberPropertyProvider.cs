using System;
using Fundamental;

namespace ACT.Core;

public class NumberPropertyProvider : IPropertyProvider
{
	public float constValue;

	public From from;

	public PropertyDescriptor propertyDescriptor;

	public static ObjectPool<NumberPropertyProvider> s_Pool = new ObjectPool<NumberPropertyProvider>(null, (NumberPropertyProvider p) =>
	{
		p.OnRelease();
	}, 50);

	public event Action<IPropertyProvider> onValueChange;

	private void OnRelease()
	{
		from.source = PropertySource.None;
		from.uid = -1;
		propertyDescriptor = PropertyDescriptor.None;
		onValueChange = null;
	}

	public void SetValue(float v)
	{
		constValue = v;
		onValueChange?.Invoke(this);
	}

	public float value()
	{
		return constValue;
	}

	public void Release()
	{
		from.source = PropertySource.None;
		from.uid = -1;
		s_Pool.Release(this);
	}

	public PropertyDescriptor GetDescriptor()
	{
		return propertyDescriptor;
	}
}
