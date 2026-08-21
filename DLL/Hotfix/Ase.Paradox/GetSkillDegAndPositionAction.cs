using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取技能位置和方向", 0)]
[Category("✫ DragonLost/Skill")]
[Description("获取指定技能类型的位置和方向，并检测是否检测到怪物。\n新增 \"选择目标受击盒位置\" \n默认不填锁最近受击盒中心 填写后锁受击盒")]
public class GetSkillDegAndPositionAction : ActionTaskBase
{
	[Name("SkillUV", 0)]
	[Description("技能UV坐标")]
	public BBParameter<Vector2> SkillUv;

	[Name("MoveUv", 0)]
	[Description("移动UV坐标")]
	public BBParameter<Vector2> MoveUv;

	[Name("是否检测到怪物", 0)]
	[Description("指示是否检测到怪物")]
	public BBParameter<bool> IsCheckMonster;

	[Name("检测到的怪物实体ID", 0)]
	[Description("检测到的怪物实体ID(变量描述)")]
	public BBParameter<int> MonsterEntityId;

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

	[Name("选择目标碰撞盒位置", 0)]
	public string boneKey;

	protected override void OnExecute()
	{
		base.OnExecute();
		float deg = 0f;
		Vector3 position = Vector3.zero;
		int monsterId = 0;
		IsCheckMonster.value = ownerEntity.GetComponent<SkillComponent>().GetSkillDegAndPosition(SkillId.value, SkillUv.value, MoveUv.value, ref deg, ref position, ref monsterId, boneKey);
		if (!IsCheckMonster.value)
		{
			ownerEntity.GetComponent<SkillComponent>().GetInteractiveSkillDegAndPosition(SkillId.value, SkillUv.value, MoveUv.value, ref deg, ref position, boneKey);
		}
		deg = Utility.Math.Round(deg);
		SkillDeg.value = deg;
		if (MoveDeg != null)
		{
			MoveDeg.value = TSUtil.Vector2Angle(MoveUv.value);
		}
		SkillPosition.value = position;
		MonsterEntityId.value = monsterId;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取技能位置和方向 ：SkillUv {SkillUv.value} MoveUv : {MoveUv.value} SkillDeg {SkillDeg.value}" + $"SkillPosition {SkillPosition.value}", ownerEntity);
		}
		EndAction();
	}
}
