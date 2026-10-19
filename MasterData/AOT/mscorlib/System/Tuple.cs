using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Text;

namespace System;

public static class Tuple
{
	public static Tuple<T1, T2> Create<T1, T2>(T1 item1, T2 item2)
	{
		return new Tuple<T1, T2>(item1, item2);
	}

	public static Tuple<T1, T2, T3> Create<T1, T2, T3>(T1 item1, T2 item2, T3 item3)
	{
		return new Tuple<T1, T2, T3>(item1, item2, item3);
	}

	internal static int CombineHashCodes(int h1, int h2)
	{
		return ((h1 << 5) + h1) ^ h2;
	}

	internal static int CombineHashCodes(int h1, int h2, int h3)
	{
		return CombineHashCodes(CombineHashCodes(h1, h2), h3);
	}

	internal static int CombineHashCodes(int h1, int h2, int h3, int h4)
	{
		return CombineHashCodes(CombineHashCodes(h1, h2), CombineHashCodes(h3, h4));
	}
}
[Serializable]
public class Tuple<T1, T2> : IStructuralEquatable, IStructuralComparable, IComparable, ITupleInternal, ITuple
{
	private readonly T1 m_Item1;

	private readonly T2 m_Item2;

	public T1 Item1 => m_Item1;

	public T2 Item2 => m_Item2;

	int ITuple.Length => 2;

	object ITuple.this[int index] => index switch
	{
		0 => (object)Item1, 
		1 => Item2, 
		_ => throw new IndexOutOfRangeException(), 
	};

	public Tuple(T1 item1, T2 item2)
	{
		m_Item1 = item1;
		m_Item2 = item2;
	}

	public override bool Equals(object obj)
	{
		return ((IStructuralEquatable)this).Equals(obj, (IEqualityComparer)EqualityComparer<object>.Default);
	}

	bool IStructuralEquatable.Equals(object other, IEqualityComparer comparer)
	{
		if (other == null)
		{
			return false;
		}
		if (!(other is Tuple<T1, T2> tuple))
		{
			return false;
		}
		if (comparer.Equals(m_Item1, tuple.m_Item1))
		{
			return comparer.Equals(m_Item2, tuple.m_Item2);
		}
		return false;
	}

	int IComparable.CompareTo(object obj)
	{
		return ((IStructuralComparable)this).CompareTo(obj, (IComparer)Comparer<object>.Default);
	}

	int IStructuralComparable.CompareTo(object other, IComparer comparer)
	{
		if (other == null)
		{
			return 1;
		}
		if (!(other is Tuple<T1, T2> tuple))
		{
			throw new ArgumentException(SR.Format("Argument must be of type {0}.", GetType().ToString()), "other");
		}
		int num = 0;
		num = comparer.Compare(m_Item1, tuple.m_Item1);
		if (num != 0)
		{
			return num;
		}
		return comparer.Compare(m_Item2, tuple.m_Item2);
	}

	public override int GetHashCode()
	{
		return ((IStructuralEquatable)this).GetHashCode((IEqualityComparer)EqualityComparer<object>.Default);
	}

	int IStructuralEquatable.GetHashCode(IEqualityComparer comparer)
	{
		return Tuple.CombineHashCodes(comparer.GetHashCode(m_Item1), comparer.GetHashCode(m_Item2));
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append('(');
		return ((ITupleInternal)this).ToString(stringBuilder);
	}

	string ITupleInternal.ToString(StringBuilder sb)
	{
		sb.Append(m_Item1);
		sb.Append(", ");
		sb.Append(m_Item2);
		sb.Append(')');
		return sb.ToString();
	}
}
[Serializable]
public class Tuple<T1, T2, T3> : IStructuralEquatable, IStructuralComparable, IComparable, ITupleInternal, ITuple
{
	private readonly T1 m_Item1;

	private readonly T2 m_Item2;

	private readonly T3 m_Item3;

	public T1 Item1 => m_Item1;

	public T2 Item2 => m_Item2;

	public T3 Item3 => m_Item3;

	int ITuple.Length => 3;

	object ITuple.this[int index] => index switch
	{
		0 => (object)Item1, 
		1 => Item2, 
		2 => Item3, 
		_ => throw new IndexOutOfRangeException(), 
	};

	public Tuple(T1 item1, T2 item2, T3 item3)
	{
		m_Item1 = item1;
		m_Item2 = item2;
		m_Item3 = item3;
	}

	public override bool Equals(object obj)
	{
		return ((IStructuralEquatable)this).Equals(obj, (IEqualityComparer)EqualityComparer<object>.Default);
	}

	bool IStructuralEquatable.Equals(object other, IEqualityComparer comparer)
	{
		if (other == null)
		{
			return false;
		}
		if (!(other is Tuple<T1, T2, T3> tuple))
		{
			return false;
		}
		if (comparer.Equals(m_Item1, tuple.m_Item1) && comparer.Equals(m_Item2, tuple.m_Item2))
		{
			return comparer.Equals(m_Item3, tuple.m_Item3);
		}
		return false;
	}

	int IComparable.CompareTo(object obj)
	{
		return ((IStructuralComparable)this).CompareTo(obj, (IComparer)Comparer<object>.Default);
	}

	int IStructuralComparable.CompareTo(object other, IComparer comparer)
	{
		if (other == null)
		{
			return 1;
		}
		if (!(other is Tuple<T1, T2, T3> tuple))
		{
			throw new ArgumentException(SR.Format("Argument must be of type {0}.", GetType().ToString()), "other");
		}
		int num = 0;
		num = comparer.Compare(m_Item1, tuple.m_Item1);
		if (num != 0)
		{
			return num;
		}
		num = comparer.Compare(m_Item2, tuple.m_Item2);
		if (num != 0)
		{
			return num;
		}
		return comparer.Compare(m_Item3, tuple.m_Item3);
	}

	public override int GetHashCode()
	{
		return ((IStructuralEquatable)this).GetHashCode((IEqualityComparer)EqualityComparer<object>.Default);
	}

	int IStructuralEquatable.GetHashCode(IEqualityComparer comparer)
	{
		return Tuple.CombineHashCodes(comparer.GetHashCode(m_Item1), comparer.GetHashCode(m_Item2), comparer.GetHashCode(m_Item3));
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append('(');
		return ((ITupleInternal)this).ToString(stringBuilder);
	}

	string ITupleInternal.ToString(StringBuilder sb)
	{
		sb.Append(m_Item1);
		sb.Append(", ");
		sb.Append(m_Item2);
		sb.Append(", ");
		sb.Append(m_Item3);
		sb.Append(')');
		return sb.ToString();
	}
}
[Serializable]
public class Tuple<T1, T2, T3, T4> : IStructuralEquatable, IStructuralComparable, IComparable, ITupleInternal, ITuple
{
	private readonly T1 m_Item1;

	private readonly T2 m_Item2;

	private readonly T3 m_Item3;

	private readonly T4 m_Item4;

	public T1 Item1 => m_Item1;

	public T2 Item2 => m_Item2;

	public T3 Item3 => m_Item3;

	public T4 Item4 => m_Item4;

	int ITuple.Length => 4;

	object ITuple.this[int index] => index switch
	{
		0 => (object)Item1, 
		1 => Item2, 
		2 => Item3, 
		3 => Item4, 
		_ => throw new IndexOutOfRangeException(), 
	};

	public Tuple(T1 item1, T2 item2, T3 item3, T4 item4)
	{
		m_Item1 = item1;
		m_Item2 = item2;
		m_Item3 = item3;
		m_Item4 = item4;
	}

	public override bool Equals(object obj)
	{
		return ((IStructuralEquatable)this).Equals(obj, (IEqualityComparer)EqualityComparer<object>.Default);
	}

	bool IStructuralEquatable.Equals(object other, IEqualityComparer comparer)
	{
		if (other == null)
		{
			return false;
		}
		if (!(other is Tuple<T1, T2, T3, T4> tuple))
		{
			return false;
		}
		if (comparer.Equals(m_Item1, tuple.m_Item1) && comparer.Equals(m_Item2, tuple.m_Item2) && comparer.Equals(m_Item3, tuple.m_Item3))
		{
			return comparer.Equals(m_Item4, tuple.m_Item4);
		}
		return false;
	}

	int IComparable.CompareTo(object obj)
	{
		return ((IStructuralComparable)this).CompareTo(obj, (IComparer)Comparer<object>.Default);
	}

	int IStructuralComparable.CompareTo(object other, IComparer comparer)
	{
		if (other == null)
		{
			return 1;
		}
		if (!(other is Tuple<T1, T2, T3, T4> tuple))
		{
			throw new ArgumentException(SR.Format("Argument must be of type {0}.", GetType().ToString()), "other");
		}
		int num = 0;
		num = comparer.Compare(m_Item1, tuple.m_Item1);
		if (num != 0)
		{
			return num;
		}
		num = comparer.Compare(m_Item2, tuple.m_Item2);
		if (num != 0)
		{
			return num;
		}
		num = comparer.Compare(m_Item3, tuple.m_Item3);
		if (num != 0)
		{
			return num;
		}
		return comparer.Compare(m_Item4, tuple.m_Item4);
	}

	public override int GetHashCode()
	{
		return ((IStructuralEquatable)this).GetHashCode((IEqualityComparer)EqualityComparer<object>.Default);
	}

	int IStructuralEquatable.GetHashCode(IEqualityComparer comparer)
	{
		return Tuple.CombineHashCodes(comparer.GetHashCode(m_Item1), comparer.GetHashCode(m_Item2), comparer.GetHashCode(m_Item3), comparer.GetHashCode(m_Item4));
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append('(');
		return ((ITupleInternal)this).ToString(stringBuilder);
	}

	string ITupleInternal.ToString(StringBuilder sb)
	{
		sb.Append(m_Item1);
		sb.Append(", ");
		sb.Append(m_Item2);
		sb.Append(", ");
		sb.Append(m_Item3);
		sb.Append(", ");
		sb.Append(m_Item4);
		sb.Append(')');
		return sb.ToString();
	}
}
