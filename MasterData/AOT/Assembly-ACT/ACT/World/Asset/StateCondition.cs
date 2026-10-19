using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class StateCondition : IDataToBake
{
	[Tooltip("配置该槽位对应的管道节点。不填表示该位置没有管道")]
	public StateWorldUid targetInteractSwid;

	[Tooltip("从0开始依次从12点钟方向顺时针增加：0=上, 1=右, 2=下, 3=左")]
	public int index;
}
