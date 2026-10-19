using System.Runtime.CompilerServices;
using System.Text;

namespace System;

internal interface ITupleInternal : ITuple
{
	string ToString(StringBuilder sb);
}
