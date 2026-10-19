namespace Mono;

internal static class X509Pal
{
	public static X509PalImpl Instance => SystemDependencyProvider.Instance.X509Pal;
}
