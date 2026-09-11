using MessagePack.Resolvers;
using MessagePack.Unity;

namespace MessagePack.Internal;

internal static class StandardResolverHelper
{
	public static readonly IFormatterResolver[] DefaultResolvers = new IFormatterResolver[4]
	{
		BuiltinResolver.Instance,
		AttributeFormatterResolver.Instance,
		UnityResolver.Instance,
		DynamicGenericResolver.Instance
	};
}
