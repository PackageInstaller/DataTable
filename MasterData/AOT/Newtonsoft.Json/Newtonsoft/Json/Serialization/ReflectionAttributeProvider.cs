using Newtonsoft.Json.Utilities;

namespace Newtonsoft.Json.Serialization;

public class ReflectionAttributeProvider : IAttributeProvider
{
	private readonly object _attributeProvider;

	public ReflectionAttributeProvider(object attributeProvider)
	{
		ValidationUtils.ArgumentNotNull(attributeProvider, "attributeProvider");
		_attributeProvider = attributeProvider;
	}
}
