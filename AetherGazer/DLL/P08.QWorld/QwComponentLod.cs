using System;
using System.Runtime.CompilerServices;
using UnityEngine;

public class QwComponentLod : QwLodBase
{
	public static float[] dynamicBoneLodRate;

	public static float[] dynamicBoneLodDistance;

	public static float stopAnimatorDistance;

	public override void Init()
	{
		//IL_000c: Field data (rva=0x490) could not be found in any section!
		//IL_000c: Field data (rva=0x490) could not be found in any section!
		float[] array = new float[4];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		dynamicBoneLodRate = array;
		dynamicBoneLodDistance = new float[3] { 1.8980848E+28f, 7.0071633E+22f, 2.789106E+29f };
		stopAnimatorDistance = 15f;
	}

	public override void Shutdown()
	{
		dynamicBoneLodRate = null;
		dynamicBoneLodDistance = null;
	}

	public static void Update()
	{
		if (!QwLodMgr.inited)
		{
			return;
		}
		foreach (IQwLodObject lodObject in QwLodMgr.lodObjects)
		{
			ref QwLodData lodData = ref lodObject.GetLodData();
			if (lodObject is QWorldMapEntity entity)
			{
				UpdateEntityLod(entity, ref lodData);
			}
		}
	}

	private static int GetLod(float[] lodDistances, float distance)
	{
		for (int num = lodDistances.Length - 1; num >= 0; num--)
		{
			if (distance > lodDistances[num])
			{
				return num + 1;
			}
		}
		return 0;
	}

	private static void UpdateEntityLod(QWorldMapEntity entity, ref QwLodData lodData)
	{
		if (lodData.dynamicBones != null && lodData.dynamicBones.Count > 0)
		{
			bool visible = lodData.visible;
			if (lodData.visibilityDirty)
			{
				foreach (DynamicBone dynamicBone in lodData.dynamicBones)
				{
					dynamicBone.enabled = visible;
				}
			}
			if (lodData.distanceDirty)
			{
				bool isInSeeking = entity.BlackBoard.IsInSeeking;
				int lod = GetLod(dynamicBoneLodDistance, lodData.distance);
				float num = dynamicBoneLodRate[lod];
				bool enabled = lodData.dynamicBones[0].enabled;
				visible = (isInSeeking && num > 0f) || num >= 30f;
				if (visible != enabled || lod != GetLod(dynamicBoneLodDistance, lodData.lastDistance))
				{
					foreach (DynamicBone dynamicBone2 in lodData.dynamicBones)
					{
						dynamicBone2.enabled = visible;
						dynamicBone2.m_UpdateRate = num;
						dynamicBone2.m_DistantDisable = num == 0f;
					}
				}
			}
		}
		if (lodData.particleSystems == null || !lodData.visibilityDirty)
		{
			return;
		}
		foreach (ParticleSystem particleSystem in lodData.particleSystems)
		{
			_ = particleSystem;
		}
	}
}
