using System;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Obsolete]
[Name("获取拖拽技能的位置和方向", 0)]
[Category("✫ DragonLost/Skill")]
[Description("获取拖拽技能的位置和方向")]
public class GetDragSkillPositionAction : ActionTaskBase
{
	[Name("SkillUV", 0)]
	[Description("技能UV坐标")]
	public BBParameter<Vector2> SkillUv;

	[Name("MoveUv", 0)]
	[Description("移动UV坐标")]
	public BBParameter<Vector2> MoveUv;

	[Name("技能ID", 0)]
	[Description("要获取位置和方向的技能类型")]
	public BBParameter<int> SkillId;

	[Name("技能方向", 0)]
	[Description("技能的方向")]
	public BBParameter<float> SkillDeg;

	[Name("位移方向", 0)]
	[Description("位移的方向")]
	public BBParameter<float> MoveDeg;

	[Name("位置", 0)]
	[Description("技能的位置")]
	public BBParameter<Vector3> SkillPosition;

	protected override void OnExecute()
	{
		base.OnExecute();
		float deg = 0f;
		Vector3 position = Vector3.zero;
		ownerEntity.GetComponent<SkillComponent>().GetDragSkillDegAndPosition(SkillId.value, SkillUv.value, MoveUv.value, ref deg, ref position);
		SkillDeg.value = deg;
		if (MoveDeg != null)
		{
			MoveDeg.value = TSUtil.Vector2Angle(MoveUv.value);
		}
		SkillPosition.value = position;
		EndAction();
	}
}
