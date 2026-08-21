using System;
using Ase;
using ParadoxNotion.Design;
using UnityEngine;

[Name("修改虚拟相机偏移 （offset）弃用", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的偏移")]
public class AdjustVirtualOffsetAction : ActionTaskBase
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
