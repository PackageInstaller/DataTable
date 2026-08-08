using Entitas;

[Sim]
public class EntitySkillEffect : IComponent
{
	public int mSkillEffectCreator;

	public int mSkillConfigID;

	public int mSkillCastCount;

	public int mSkillSingleTargetID;

	public Int3 mEffectStartPosition;

	public Int3 mEffectPosition;

	public int mEffectReadyTime;

	public int mEffectDuring;

	public int mEffectTick;
}
