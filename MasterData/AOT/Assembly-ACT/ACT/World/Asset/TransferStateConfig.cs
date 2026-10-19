using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TransferStateConfig
{
	[Tooltip("该状态的唯一ID")]
	public int stateId;

	[Tooltip("该状态的最终旋转角度（绝对角度，欧拉角XYZ）。例如：(0, 0, 90) 表示Z轴旋转90度")]
	public Vector3 rotation;

	[Tooltip("用于编辑器显示的描述信息")]
	public string description;
}
