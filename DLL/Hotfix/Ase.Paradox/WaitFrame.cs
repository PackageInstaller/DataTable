using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("等待(帧)", 0)]
[Category("✫ DragonLost/Operation")]
[Description("等待指定数量的帧数后结束任务")]
public class WaitFrame : ActionTaskBase
{
	[Name("帧数", 0)]
	[Description("等待的帧数")]
	public BBParameter<int> tick;

	private float _waitTime;

	private bool frozenFramePause;

	protected override string info => $"等待 {tick.value} 帧.";

	protected override void OnExecute()
	{
		base.OnExecute();
		_waitTime = (float)tick.value * 0.033f;
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
			LockstepData.Instance.WriteAuthorityEntityId($"等待帧 _tick ： {_waitTime}  Tick : {tick.value}，计算公式：{_waitTime} -{ownerEntity.FinalDeltaTime} * {num}={_waitTime - num2} ，frozenFramePause：{frozenFramePause}，EntityFrozenSpeed：{ownerEntity.FrozenSpeed}", ownerEntity);
		}
		_waitTime -= num2;
		if (_waitTime < 0f)
		{
			_waitTime = 0f;
			EndAction();
		}
	}
}
