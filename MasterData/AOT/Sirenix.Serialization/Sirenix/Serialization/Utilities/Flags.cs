using System.Reflection;

namespace Sirenix.Serialization.Utilities;

internal static class Flags
{
	public const BindingFlags AnyVisibility = BindingFlags.Public | BindingFlags.NonPublic;

	public const BindingFlags InstancePublic = BindingFlags.Instance | BindingFlags.Public;

	public const BindingFlags InstancePrivate = BindingFlags.Instance | BindingFlags.NonPublic;

	public const BindingFlags InstanceAnyVisibility = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

	public const BindingFlags StaticPublic = BindingFlags.Static | BindingFlags.Public;

	public const BindingFlags StaticPrivate = BindingFlags.Static | BindingFlags.NonPublic;

	public const BindingFlags StaticAnyVisibility = BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

	public const BindingFlags InstancePublicDeclaredOnly = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;

	public const BindingFlags InstancePrivateDeclaredOnly = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.NonPublic;

	public const BindingFlags InstanceAnyDeclaredOnly = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

	public const BindingFlags StaticPublicDeclaredOnly = BindingFlags.DeclaredOnly | BindingFlags.Static | BindingFlags.Public;

	public const BindingFlags StaticPrivateDeclaredOnly = BindingFlags.DeclaredOnly | BindingFlags.Static | BindingFlags.NonPublic;

	public const BindingFlags StaticAnyDeclaredOnly = BindingFlags.DeclaredOnly | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

	public const BindingFlags StaticInstanceAnyVisibility = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

	public const BindingFlags AllMembers = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy;
}
