namespace System;

internal interface TypeName : IEquatable<TypeName>
{
	string DisplayName { get; }
}
