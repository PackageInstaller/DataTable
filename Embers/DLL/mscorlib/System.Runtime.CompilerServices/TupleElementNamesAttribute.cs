using System.Collections.Generic;

namespace System.Runtime.CompilerServices;

[CLSCompliant(false)]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Event | AttributeTargets.Parameter | AttributeTargets.ReturnValue)]
public sealed class TupleElementNamesAttribute : Attribute
{
	private readonly string[] _transformNames;

	public IList<string> TransformNames => _transformNames;

	public TupleElementNamesAttribute(string[] transformNames)
	{
		if (transformNames == null)
		{
			throw new ArgumentNullException("transformNames");
		}
		_transformNames = transformNames;
	}
}
