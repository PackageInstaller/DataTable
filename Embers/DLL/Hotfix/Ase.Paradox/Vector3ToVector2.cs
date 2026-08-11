using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("Vector3坐标转换为Vector2坐标", 0)]
[Description("将 Vector3 类型的坐标转换为 Vector2 类型的坐标，并将结果存储到指定的变量中。")]
[Category("✫ DragonLost/Operation")]
public class Vector3ToVector2 : ActionTaskBase
{
	[Name("Vector3坐标", 0)]
	[Description("要转换的 Vector3 类型的坐标。")]
	public BBParameter<Vector3> v3;

	[Name("值", 0)]
	[Description("用于存储转换后的 Vector2 类型的坐标的变量。")]
	public BBParameter<Vector2> v2;

	protected override void OnExecute()
	{
		base.OnExecute();
		v2.value = new Vector2(v3.value.x, v3.value.z);
		EndAction();
	}
}
