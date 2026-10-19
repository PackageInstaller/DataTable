using System;

namespace ACT.Core;

public interface IPropertyProvider
{
	event Action<IPropertyProvider> onValueChange;

	float value();

	void Release();

	PropertyDescriptor GetDescriptor();
}
