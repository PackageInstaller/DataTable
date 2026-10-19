using System;

namespace Sirenix.Serialization;

public interface IExternalGuidReferenceResolver
{
	IExternalGuidReferenceResolver NextResolver { get; set; }

	bool TryResolveReference(Guid guid, out object value);

	bool CanReference(object value, out Guid guid);
}
