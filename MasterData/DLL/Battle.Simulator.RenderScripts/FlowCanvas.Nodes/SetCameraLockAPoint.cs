using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置相机锁定某个点", 0)]
[Category("Render/Camera")]
[Description("设置相机锁定某个点")]
public class SetCameraLockAPoint : FlowNode
{
	private LockTargetCinemachine lockTargetCinemachine;

	protected override void RegisterPorts()
	{
		ValueInput<Int3> pointInput = AddValueInput<Int3>("要锁定的位置");
		ValueInput<float> timeInput = AddValueInput<float>("时间");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (lockTargetCinemachine == null)
			{
				lockTargetCinemachine = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			}
			if (!(lockTargetCinemachine == null))
			{
				lockTargetCinemachine.lockFineshTime = timeInput.value;
				lockTargetCinemachine.targetPoint = (Vector3)pointInput.value;
				lockTargetCinemachine.isLockAPoint = true;
				lockTargetCinemachine.ResetLockTime();
				output.Call(f);
			}
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		lockTargetCinemachine = null;
	}
}
