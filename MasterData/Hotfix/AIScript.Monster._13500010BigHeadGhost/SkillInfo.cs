using TrueSync;

namespace AIScript.Monster._13500010BigHeadGhost;

public class SkillInfo
{
	public int skillId;

	public FP skillCd;

	public FP trace_StopDis;

	public FP trace_CancleDis;

	public FP trace_Duration;

	public FP lastCastTime;

	public SkillInfo(int skillId, FP skillCd, FP trace_StopDis, FP trace_CancleDis, FP trace_Duration)
	{
		this.skillId = skillId;
		this.skillCd = skillCd;
		this.trace_StopDis = trace_StopDis;
		this.trace_CancleDis = trace_CancleDis;
		this.trace_Duration = trace_Duration;
	}

	public void Reset()
	{
		lastCastTime = 0;
	}
}
