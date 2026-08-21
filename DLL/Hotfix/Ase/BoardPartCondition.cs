using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class BoardPartCondition
{
	public BoardPartConditionType Type;

	[Tooltip("点击次数: 需要达到的点击次数阈值")]
	public int RequiredCount;

	[Tooltip("点击部位顺序: 需要匹配的点击顺序(部位名列表)\n全局动画顺序或当前部位动画播放顺序: 需要匹配的动画顺序(动画名列表)\n点击次数: 需要检查点击次数的部位名列表")]
	public List<string> Sequence;
}
