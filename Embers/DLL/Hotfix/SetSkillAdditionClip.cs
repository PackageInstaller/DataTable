using Ase;
using Ase.ECS;
using UnityEngine;

[ClipName("设置技能加成")]
public class SetSkillAdditionClip : TaskClip
{
	[VariableName("是否是全局加成")]
	public bool isGlobalAddition;

	[VariableName("技能加成类型")]
	public SkillAdditionType additionType;

	[VariableName("技能id")]
	public int skillId;

	[VariableName("指令类型")]
	public HeroSkillTypeEnum heroSkillTypeEnum;

	[VariableName("加成种类")]
	public AdditionKind additionKind;

	[VariableName("加成")]
	public float addition;

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
	}
}
