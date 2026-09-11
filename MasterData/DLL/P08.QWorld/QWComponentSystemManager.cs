using Qworld.Runtime.SceneDither;
using Unity.Profiling;

public class QWComponentSystemManager
{
	private ProfilerMarker SphereAreaTriggerProfiler = new ProfilerMarker("sphereAreaTriggerProfiler");

	public QWBodyDitherSystem ditherSystem;

	public QWLookAtCompMgr lookAtMgr;

	public QWSceneDitherSystem sceneDitherSystem;

	public QWTriggerSystem triggerSystem;

	public void Init()
	{
		ditherSystem = new QWBodyDitherSystem();
		ditherSystem.Init();
		lookAtMgr = new QWLookAtCompMgr();
		lookAtMgr.Init();
		sceneDitherSystem = new QWSceneDitherSystem();
		sceneDitherSystem.Init();
		triggerSystem = new QWTriggerSystem();
		triggerSystem.Init();
	}

	public void Tick()
	{
		ditherSystem?.Tick();
		triggerSystem?.Tick();
	}

	public void LateTick()
	{
		lookAtMgr?.LateUpdate();
		sceneDitherSystem?.LateTick();
	}

	public void Dispose()
	{
		ditherSystem.Dispose();
		lookAtMgr.Dispose();
		sceneDitherSystem.Dispose();
		triggerSystem.Dispose();
	}
}
