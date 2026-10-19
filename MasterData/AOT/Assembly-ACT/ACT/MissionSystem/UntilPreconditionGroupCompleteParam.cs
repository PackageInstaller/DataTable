using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class UntilPreconditionGroupCompleteParam
{
	[Header("任务组")]
	public int preconditionGroup;
}
