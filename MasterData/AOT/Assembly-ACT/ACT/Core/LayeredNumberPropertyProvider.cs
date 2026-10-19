using System;
using Fundamental;

namespace ACT.Core;

public class LayeredNumberPropertyProvider : IPropertyProvider
{
	public float constValue;

	public int layer;

	public PropertyDescriptor propertyDescriptor;

	public static ObjectPool<LayeredNumberPropertyProvider> s_Pool = new ObjectPool<LayeredNumberPropertyProvider>(null, (LayeredNumberPropertyProvider p) =>
	{
		p.OnRelease();
	});

	public event Action<IPropertyProvider> onValueChange;

	private void OnRelease()
	{
		onValueChange = null;
	}

	public float value()
	{
		return constValue * (float)layer;
	}

	public void Release()
	{
		s_Pool.Release(this);
	}

	public PropertyDescriptor GetDescriptor()
	{
		return propertyDescriptor;
	}

	public void SetLayer(int stack)
	{
		layer = stack;
		onValueChange?.Invoke(this);
	}

	public void SetConstValue(float newValue)
	{
		if (constValue != newValue)
		{
			constValue = newValue;
			onValueChange?.Invoke(this);
		}
	}
}
