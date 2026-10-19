using System;

namespace Unity.VisualScripting.FullSerializer;

public sealed class fsMissingVersionConstructorException : Exception
{
	public fsMissingVersionConstructorException(Type versionedType, Type constructorType)
		: base(versionedType?.ToString() + " is missing a constructor for previous model type " + constructorType)
	{
	}
}
