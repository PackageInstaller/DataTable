using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace AOT.Animation;

public static class YCurveScaleJobAOTWarmup
{
	[Preserve]
	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void Warmup()
	{
		PlayableGraph graph = PlayableGraph.Create("AOT_YCurveScaleJob_Warmup");
		try
		{
			AnimationScriptPlayable playable = AnimationScriptPlayable.Create<YCurveScaleJob>(graph, default, 1);
			playable.GetJobData<YCurveScaleJob>();
			playable.Destroy();
		}
		finally
		{
			graph.Destroy();
		}
	}
}
