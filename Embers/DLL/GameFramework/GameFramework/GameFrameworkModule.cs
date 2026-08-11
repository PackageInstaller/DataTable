namespace GameFramework;

internal abstract class GameFrameworkModule
{
	internal virtual int Priority => 0;

	internal abstract void Update(float elapseSeconds, float realElapseSeconds);

	internal abstract void Shutdown();
}
