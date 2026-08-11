using Ase;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Utility")]
public class Wait : ActionTaskBase
{
	public BBParameter<float> waitTime = 1f;

	private float waitFrameTime;

	public CompactStatus finishStatus = CompactStatus.Success;

	private bool frozenFramePause;

	protected override string info => $"Wait {waitTime} sec.";

	protected override void OnExecute()
	{
		base.OnExecute();
		waitFrameTime = waitTime.value * 30f * 0.033f;
		if (base.ownerSystem != null && base.ownerSystem != null)
		{
			frozenFramePause = base.ownerSystem.FrozenFrameIsPauseTree;
		}
	}

	protected override void OnUpdate()
	{
		if (ownerEntity == null)
		{
			EndAction();
			return;
		}
		float num = (frozenFramePause ? ownerEntity.FrozenSpeed : 1f);
		float num2 = ownerEntity.FinalDeltaTime * num;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"等待时间 _tick ： {waitFrameTime}  Tick : {waitTime.value} ，计算公式：{waitFrameTime} -{ownerEntity.FinalDeltaTime} * {num}={waitFrameTime - num2} ，frozenFramePause：{frozenFramePause}，EntityFrozenSpeed：{ownerEntity.FrozenSpeed}", ownerEntity);
		}
		waitFrameTime -= ownerEntity.FinalDeltaTime * (frozenFramePause ? ownerEntity.FrozenSpeed : 1f);
		if (waitFrameTime < 0f)
		{
			waitFrameTime = 0f;
			EndAction(finishStatus == CompactStatus.Success);
		}
	}
}
