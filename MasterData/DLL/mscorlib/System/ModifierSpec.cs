using System.Text;

namespace System;

internal interface ModifierSpec
{
	Type Resolve(Type type);

	StringBuilder Append(StringBuilder sb);
}
