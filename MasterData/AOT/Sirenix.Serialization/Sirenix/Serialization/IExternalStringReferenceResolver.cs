namespace Sirenix.Serialization;

public interface IExternalStringReferenceResolver
{
	IExternalStringReferenceResolver NextResolver { get; set; }

	bool TryResolveReference(string id, out object value);

	bool CanReference(object value, out string id);
}
