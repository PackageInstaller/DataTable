using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Rendering;

[MovedFrom("UnityEngine.Experimental.Rendering")]
public enum RenderingThreadingMode
{
	Direct,
	SingleThreaded,
	MultiThreaded,
	LegacyJobified,
	NativeGraphicsJobs,
	NativeGraphicsJobsWithoutRenderThread
}
