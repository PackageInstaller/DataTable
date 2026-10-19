using System;

namespace Unity.VisualScripting.FullSerializer;

public sealed class fsDuplicateVersionNameException : Exception
{
	public fsDuplicateVersionNameException(Type typeA, Type typeB, string version)
		: base(typeA?.ToString() + " and " + typeB?.ToString() + " have the same version string (" + version + "); please change one of them.")
	{
	}
}
