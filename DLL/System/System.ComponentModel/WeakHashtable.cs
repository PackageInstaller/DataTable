using System.Collections;

namespace System.ComponentModel;

internal sealed class WeakHashtable : Hashtable
{
	private class WeakKeyComparer : IEqualityComparer
	{
		bool IEqualityComparer.Equals(object x, object y)
		{
			if (x == null)
			{
				return y == null;
			}
			if (y != null && x.GetHashCode() == y.GetHashCode())
			{
				WeakReference weakReference = x as WeakReference;
				WeakReference weakReference2 = y as WeakReference;
				if (weakReference != null)
				{
					if (!weakReference.IsAlive)
					{
						return false;
					}
					x = weakReference.Target;
				}
				if (weakReference2 != null)
				{
					if (!weakReference2.IsAlive)
					{
						return false;
					}
					y = weakReference2.Target;
				}
				return x == y;
			}
			return false;
		}

		int IEqualityComparer.GetHashCode(object obj)
		{
			return obj.GetHashCode();
		}
	}

	private static IEqualityComparer _comparer = new WeakKeyComparer();

	internal WeakHashtable()
		: base(_comparer)
	{
	}

	public override void Clear()
	{
		base.Clear();
	}

	public override void Remove(object key)
	{
		base.Remove(key);
	}
}
