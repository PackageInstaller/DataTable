using UnityEngine;

public class P08CameraCtrlGameLogic : ICameraCtrlGameLogic
{
	private CameraParamComponent cameraParam;

	public void UpdateLogic(float dragDelta, float deltaHeight, float scroll)
	{
		if (cameraParam == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				cameraParam = battleScene.virtualCameraParam;
			}
		}
		else if (!BattleScene.isPause && !cameraParam.lockTargetCinemachine.banCameraCtrlUI)
		{
			if (Mathf.Abs(dragDelta) < 0.01f)
			{
				cameraParam.transposer.m_XAxis.m_InputAxisValue = 0f;
			}
			else
			{
				cameraParam.transposer.m_XAxis.m_InputAxisValue = dragDelta;
				cameraParam.lockTargetCinemachine.SetLoseTarget();
			}
			if (Mathf.Abs(deltaHeight) > 0.01f)
			{
				cameraParam.lockTargetCinemachine.curHeight += deltaHeight;
				cameraParam.lockTargetCinemachine.curHeight = Mathf.Clamp(cameraParam.lockTargetCinemachine.curHeight, cameraParam.lockTargetCinemachine.minHeightDefault, cameraParam.lockTargetCinemachine.maxHeightDefault);
				Vector3 followOffset = cameraParam.transposer.m_FollowOffset;
				followOffset.y = cameraParam.lockTargetCinemachine.curHeight;
				cameraParam.transposer.m_FollowOffset = followOffset;
				cameraParam.lockTargetCinemachine.SetLoseTarget();
			}
			if (Mathf.Abs(scroll) > 0.01f)
			{
				cameraParam.lockTargetCinemachine.curRadius += scroll;
				cameraParam.lockTargetCinemachine.curRadius = Mathf.Clamp(cameraParam.lockTargetCinemachine.curRadius, cameraParam.lockTargetCinemachine.minRadiusDefault, cameraParam.lockTargetCinemachine.maxRadiusDefault);
				Vector3 followOffset2 = cameraParam.transposer.m_FollowOffset;
				followOffset2.z = 0f - cameraParam.lockTargetCinemachine.curRadius;
				cameraParam.transposer.m_FollowOffset = followOffset2;
				cameraParam.lockTargetCinemachine.SetLoseTarget();
			}
		}
	}
}
