using System;
using Unity.Jobs;
using UnityEngine;
using UnityEngine.Jobs;

[Unity.Jobs.DOTSCompilerGenerated]
internal class __JobReflectionRegistrationOutput__300417653
{
	public static void CreateJobReflectionData()
	{
		try
		{
			IJobParallelForTransformExtensions.EarlyJobInit<QwLodMgr.UpdateLodDataJob>();
		}
		catch (Exception ex)
		{
			EarlyInitHelpers.JobReflectionDataCreationFailed(ex, typeof(QwLodMgr.UpdateLodDataJob));
		}
		try
		{
			IJobParallelForTransformExtensions.EarlyJobInit<QWorldBubbleManager.CollectInteractInfoJob>();
		}
		catch (Exception ex2)
		{
			EarlyInitHelpers.JobReflectionDataCreationFailed(ex2, typeof(QWorldBubbleManager.CollectInteractInfoJob));
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterAssembliesLoaded)]
	public static void EarlyInit()
	{
		CreateJobReflectionData();
	}
}
