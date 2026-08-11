namespace System.Reflection;

[Flags]
public enum ResourceLocation
{
	ContainedInAnotherAssembly = 2,
	ContainedInManifestFile = 4,
	Embedded = 1
}
