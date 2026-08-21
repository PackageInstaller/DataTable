using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取坐标带偏移量坐标", 0)]
[Description("根据给定的坐标、偏移距离和偏移角度计算带偏移量的新坐标。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class GetOffsetPosByOffsetPosDegAction : ActionTaskBase
{
	[Name("坐标", 0)]
	[Description("要进行偏移的目标坐标。")]
	public BBParameter<Vector3> TargetPosition;

	[Name("偏移距离", 0)]
	[Description("偏移的距离。")]
	public BBParameter<float> OffSet;

	[Name("偏移角度", 0)]
	[Description("偏移的角度。")]
	public BBParameter<float> OffSetAngle;

	[Name("返回的偏移角度", 0)]
	[Description("计算得到的带偏移量的新坐标。")]
	public BBParameter<Vector3> OffsetPos;

	protected override void OnExecute()
	{
		base.OnExecute();
		OffsetPos.value = TSUtil.MoveForward2D(TargetPosition.value, OffSetAngle.value, OffSet.value);
		EndAction();
	}
}
