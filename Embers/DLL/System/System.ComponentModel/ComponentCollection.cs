using System.Collections;

namespace System.ComponentModel;

public class ComponentCollection : ReadOnlyCollectionBase
{
	public virtual IComponent this[string name]
	{
		get
		{
			if (name != null)
			{
				foreach (IComponent item in (IEnumerable)base.InnerList)
				{
					if (item != null && item.Site != null && item.Site.Name != null && string.Equals(item.Site.Name, name, StringComparison.OrdinalIgnoreCase))
					{
						return item;
					}
				}
			}
			return null;
		}
	}
}
