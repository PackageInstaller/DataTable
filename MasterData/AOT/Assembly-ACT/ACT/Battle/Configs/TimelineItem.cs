using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class TimelineItem
{
	public bool mustDo;

	[Tooltip("表示在归一化时间中，什么时候trigger ability\n取值范围是(0,1)\n填写小于0的数字表示在动作第一帧执行这件事，只执行一次")]
	public float time;

	[Tooltip("只在一段时间内做什么事情有效 目前是攻击盒和攻击补偿才有用, 当end=0 或者time跟end相等表示只判定一帧，0表示只判定一帧 ,负值表示一直持续到动作结束")]
	public float end;

	public ConfigMotionFrameRange frameRange;

	public virtual void Precache(List<YooAssetReference> list)
	{
	}

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility ability)
	{
	}

	public abstract bool CanDoPeriod();
}
