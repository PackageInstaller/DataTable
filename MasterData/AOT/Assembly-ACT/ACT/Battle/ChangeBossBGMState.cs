using BehaviorDesigner.Runtime.Tasks;
using Fundamental;

namespace ACT.Battle;

[TaskDescription("改变Boss状态")]
public class ChangeBossBGMState : Conditional
{
	public int state;

	public override TaskStatus OnUpdate()
	{
		Singleton<GameManager>.instance.audioManager.SetGlobalParameter("Boss_Music_Change", state);
		return TaskStatus.Success;
	}
}
