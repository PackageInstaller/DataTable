using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取向量各方向的标量", 0)]
[Description("从指定的向量中获取其各个方向上的标量，并将结果存储到指定的黑板浮点数变量中。")]
[Category("✫ DragonLost/Movement")]
public class GetVectorValue : ActionTaskBase
{
	[ShowIf("isVector2", false)]
	[Name("三维向量", 0)]
	[Description("要获取标量的向量变量。")]
	public BBParameter<Vector3> Vector;

	[ShowIf("isVector2", true)]
	[Name("二维向量", 0)]
	[Description("要获取标量的向量变量。")]
	public BBParameter<Vector2> Vector2;

	[Name("X", 0)]
	[Description("用于存储 X 方向标量的黑板浮点数变量。")]
	public BBParameter<float> X;

	[Name("Y", 0)]
	[Description("用于存储 Y 方向标量的黑板浮点数变量。")]
	public BBParameter<float> Y;

	[HideIf("isVector2", true)]
	[Name("Z", 0)]
	[Description("用于存储 Z 方向标量的黑板浮点数变量。")]
	public BBParameter<float> Z;

	[Name("是否是二维向量", 0)]
	public bool isVector2;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!isVector2)
		{
			X.value = Vector.value.x;
			Y.value = Vector.value.y;
			Z.value = Vector.value.z;
		}
		else
		{
			X.value = Vector2.value.x;
			Y.value = Vector2.value.y;
		}
		EndAction();
	}
}
