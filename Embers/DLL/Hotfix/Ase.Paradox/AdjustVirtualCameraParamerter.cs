using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改虚拟相机功能参数 （弃用）", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的功能参数，包括相机的广角、优先级、移动速度等。")]
public class AdjustVirtualCameraParamerter : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}

	public static Vector3 CalculatePosition(float distance, float angle, float heightOffset)
	{
		float f = angle * (MathF.PI / 180f);
		float x = Mathf.Cos(f) * distance;
		float z = Mathf.Sin(f) * distance;
		return new Vector3(x, heightOffset, z);
	}
}
