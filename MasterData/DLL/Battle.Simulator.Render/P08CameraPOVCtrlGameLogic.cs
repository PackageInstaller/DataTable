using Cinemachine;
using UnityEngine;

public class P08CameraPOVCtrlGameLogic : ICameraCtrlGameLogic
{
	public CinemachinePOV composer;

	private Camera mainCamera;

	public float rotateY;

	public void UpdateLogic(float dragDelta, float deltaHeight, float scroll)
	{
		composer.m_VerticalAxis.m_InputAxisValue = deltaHeight;
		rotateY += dragDelta;
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent == null)
		{
			return;
		}
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		if (!(mainCamera == null))
		{
			playerAgent.Blackboard.OverrideWithDeltaRotate = true;
			playerAgent.Blackboard.DeltaRotate = new Vector3(0f, rotateY, 0f);
			_ = playerAgent.transform.rotation.eulerAngles;
			composer.m_HorizontalAxis.Value = rotateY;
			BBHumanoid bBHumanoid = playerAgent.Blackboard as BBHumanoid;
			if (bBHumanoid != null && bBHumanoid.m_LastSimFrameData != null)
			{
				bBHumanoid.LastFrameFaceDirection = Quaternion.Euler(0f, rotateY, 0f) * Vector3.forward;
			}
			if (bBHumanoid != null && bBHumanoid.m_NextSimFrameData != null)
			{
				bBHumanoid.NextFrameFaceDirection = Quaternion.Euler(0f, rotateY, 0f) * Vector3.forward;
			}
		}
	}
}
