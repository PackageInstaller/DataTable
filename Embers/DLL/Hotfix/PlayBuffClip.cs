using Ase;
using Ase.ECS;
using UnityEngine;

[ClipName("创建Buff")]
public class PlayBuffClip : TaskClip
{
	[VariableName("BuffID")]
	public ClipVariableInt buffId;

	[VariableName("TestEnum")]
	public ClipVariableEnum<HeroSkillTypeEnum> testEnum;

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
	}

	public override void EditorEnter(GameObject context, int fps, int currentFrameID)
	{
		base.EditorEnter(context, fps, currentFrameID);
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
	}
}
