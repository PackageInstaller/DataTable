using TrueSync;

namespace AIScript.Monster._13500020BoomGhost;

public class SkillInfo
{
	public int skillId;

	public int skillCd;

	public FP trace_StopDis;

	public FP trace_CancleDis;

	public FP trace_Duration;

	public SkillInfo(int skillId, int skillCd, FP trace_StopDis, FP trace_CancleDis, FP trace_Duration)
	{
		this.skillId = skillId;
		this.skillCd = skillCd;
		this.trace_StopDis = trace_StopDis;
		this.trace_CancleDis = trace_CancleDis;
		this.trace_Duration = trace_Duration;
	}
}
