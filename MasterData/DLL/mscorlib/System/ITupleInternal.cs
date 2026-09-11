using System.Collections;
using System.Runtime.CompilerServices;
using System.Text;

namespace System;

internal interface ITupleInternal : ITuple
{
	string ToString(StringBuilder sb);

	int GetHashCode(IEqualityComparer comparer);
}
