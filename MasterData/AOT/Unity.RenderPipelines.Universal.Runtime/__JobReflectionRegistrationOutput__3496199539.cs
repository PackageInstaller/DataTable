using System;
using Unity.Jobs;
using UnityEngine;
using UnityEngine.Jobs;
using UnityEngine.Rendering.Universal;

[Unity.Jobs.DOTSCompilerGenerated]
internal class __JobReflectionRegistrationOutput__3496199539
{
	public static void CreateJobReflectionData()
	{
		try
		{
			IJobExtensions.EarlyJobInit<DecalCreateDrawCallSystem.DrawCallJob>();
		}
		catch (Exception ex)
		{
			EarlyInitHelpers.JobReflectionDataCreationFailed(ex, typeof(DecalCreateDrawCallSystem.DrawCallJob));
		}
		try
		{
			IJobParallelForTransformExtensions.EarlyJobInit<DecalUpdateCachedSystem.UpdateTransformsJob>();
		}
		catch (Exception ex2)
		{
			EarlyInitHelpers.JobReflectionDataCreationFailed(ex2, typeof(DecalUpdateCachedSystem.UpdateTransformsJob));
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterAssembliesLoaded)]
	public static void EarlyInit()
	{
		CreateJobReflectionData();
	}
}
