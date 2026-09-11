using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建游戏角色对象", 0)]
[Category("Render/Agent")]
[Description("创建游戏对象")]
[ExposeAsDefinition]
public class SpawnAgentHuman : CallableFunctionNode<NAgent, EntitySpawnedEvent, string>
{
	public GameObject HPPanel;

	public GameObject GetAgentGameObject(EntitySpawnedEvent ev, string modelPath)
	{
		Dictionary<int, GameObject> renderCharactor = (NScene.GetCurrentScene() as BattleScene).GetRenderCharactor();
		if (!renderCharactor.TryGetValue((int)ev.mRolePosition, out var value))
		{
			return Asset.Instantiate(modelPath);
		}
		renderCharactor.Remove((int)ev.mRolePosition);
		return value;
	}

	public override NAgent Invoke(EntitySpawnedEvent ev, string modelPath)
	{
		Skin config = ConfigHelper.GetInstance().GetConfig<Skin>(ev.mSkinID);
		if (string.IsNullOrEmpty(modelPath))
		{
			modelPath = config.BattleModelPath;
		}
		GameObject agentGameObject = GetAgentGameObject(ev, modelPath);
		NAgent nAgent = U3DUtil.Get<AgentHuman>(agentGameObject);
		if (nAgent == null)
		{
			return null;
		}
		nAgent.AgentID = ev.NewEntity;
		nAgent.Camp = ev.mAgentCamp;
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		battleScene.GetAgentManager().JoinAgent(nAgent, ev);
		if (ev.mIsPlayer)
		{
			CameraParamComponent virtualCameraParam = battleScene.virtualCameraParam;
			if (ConfigHelper.GetInstance().TryGetConfig<FollowCameraParam>(config.BattleCameraParam, out var config2))
			{
				virtualCameraParam.lockTargetCinemachine.heightLock = config2.LockHeight;
				virtualCameraParam.lockTargetCinemachine.heightDefault = config2.FollowHeight;
				virtualCameraParam.lockTargetCinemachine.curHeight = config2.FollowHeight;
				virtualCameraParam.lockTargetCinemachine.radiusLock = config2.LockRadius;
				virtualCameraParam.lockTargetCinemachine.radiusDefault = config2.FollowRadius;
				virtualCameraParam.lockTargetCinemachine.curRadius = config2.FollowRadius;
				virtualCameraParam.lockTargetCinemachine.followCameraLock = config2.LockHeight;
				U3DUtil.Get<CinemachineCameraOffset>(virtualCameraParam.gameObject).m_Offset = new Vector3(config2.OffsetX, config2.OffsetY, config2.OffsetZ);
			}
			virtualCameraParam.virtualCamera.Follow = agentGameObject.transform;
			virtualCameraParam.targetGroup.m_Targets[0].target = agentGameObject.transform;
		}
		return nAgent;
	}
}
