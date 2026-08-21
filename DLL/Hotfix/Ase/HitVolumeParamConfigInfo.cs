using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class HitVolumeParamConfigInfo
{
	public int CanHitCount;

	public bool IsCanHit;

	public int ReduceHitCount;

	public Vector3 HitMoveDirects;

	public List<HitVolumeHitCountChangeInfo> HitVolumeHitCountChangeInfo;

	public static HitVolumeParamConfigInfo CopyData(HitVolumeParamConfigInfo data)
	{
		HitVolumeParamConfigInfo hitVolumeParamConfigInfo = new HitVolumeParamConfigInfo();
		hitVolumeParamConfigInfo.CanHitCount = data.CanHitCount;
		hitVolumeParamConfigInfo.IsCanHit = data.IsCanHit;
		hitVolumeParamConfigInfo.ReduceHitCount = data.ReduceHitCount;
		hitVolumeParamConfigInfo.HitMoveDirects = data.HitMoveDirects;
		hitVolumeParamConfigInfo.HitVolumeHitCountChangeInfo = new List<HitVolumeHitCountChangeInfo>(data.HitVolumeHitCountChangeInfo.Count);
		for (int i = 0; i < data.HitVolumeHitCountChangeInfo.Count; i++)
		{
			hitVolumeParamConfigInfo.HitVolumeHitCountChangeInfo.Add(new HitVolumeHitCountChangeInfo
			{
				Id = data.HitVolumeHitCountChangeInfo[i].Id,
				ReduceHitCount = data.HitVolumeHitCountChangeInfo[i].ReduceHitCount
			});
		}
		return hitVolumeParamConfigInfo;
	}

	public static void ReverData(HitVolumeParamConfigInfo originData, HitVolumeParamConfigInfo data)
	{
		data.CanHitCount = originData.CanHitCount;
		data.IsCanHit = originData.IsCanHit;
		data.ReduceHitCount = originData.ReduceHitCount;
		data.HitMoveDirects = originData.HitMoveDirects;
		for (int i = 0; i < originData.HitVolumeHitCountChangeInfo.Count; i++)
		{
			HitVolumeHitCountChangeInfo value = data.HitVolumeHitCountChangeInfo[i];
			value.Id = originData.HitVolumeHitCountChangeInfo[i].Id;
			value.ReduceHitCount = originData.HitVolumeHitCountChangeInfo[i].ReduceHitCount;
			data.HitVolumeHitCountChangeInfo[i] = value;
		}
	}
}
