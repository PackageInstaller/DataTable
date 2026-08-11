using System.Collections.Generic;

namespace Sirenix.OdinInspector;

public class ValueDropdownList<T> : List<ValueDropdownItem<T>>
{
	public void Add(string text, T value)
	{
		Add(new ValueDropdownItem<T>(text, value));
	}

	public void Add(T value)
	{
		Add(new ValueDropdownItem<T>(value.ToString(), value));
	}
}
