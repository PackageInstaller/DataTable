using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class ExitMissionWorldConditionParam
{
	[Header("离开立即满足，不勾选则重新回来任务世界才算完成")]
	public bool immediate;
}
