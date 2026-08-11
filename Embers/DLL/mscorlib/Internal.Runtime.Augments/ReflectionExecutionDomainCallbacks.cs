using System;
using System.Reflection;

namespace Internal.Runtime.Augments;

internal class ReflectionExecutionDomainCallbacks
{
	internal Exception CreateMissingMetadataException(Type attributeType)
	{
		return new MissingMetadataException();
	}
}
