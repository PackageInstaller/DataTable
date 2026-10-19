using System.Collections;
using System.Runtime.CompilerServices;

namespace System;

internal interface IValueTupleInternal : ITuple
{
	int GetHashCode(IEqualityComparer comparer);

	string ToStringEnd();
}
