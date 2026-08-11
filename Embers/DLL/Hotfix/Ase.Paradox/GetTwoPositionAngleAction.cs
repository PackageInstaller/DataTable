using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取俩位置之间的角度", 0)]
[Description("计算给定两个位置之间的角度。")]
[Category("✫ DragonLost/Transform")]
public class GetTwoPositionAngleAction : ActionTaskBase
{
	[Name("转向", 0)]
	[Description("用于计算角度的方向（度数）。")]
	public BBParameter<float> deg;

	[Name("目标位置", 0)]
	[Description("要计算角度的目标位置。")]
	public BBParameter<Vector3> targetPos;

	[Name("基准位置", 0)]
	[Description("用作参考点的基准位置。")]
	public BBParameter<Vector3> standardPos;

	[Name("获取的角度", 0)]
	[Description("用于存储计算得到的角度的变量。")]
	public BBParameter<float> angleResult;

	protected override void OnExecute()
	{
		base.OnExecute();
		angleResult.value = TSUtil.TargetFwdAngleToSelf(standardPos.value, deg.value, targetPos.value);
		EndAction();
	}
}
