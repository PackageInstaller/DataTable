using System;
using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("激活剧情预制体", 0)]
[Category("Render/Asset")]
[Description("激活已经路径对应的剧情预制体,路径使用Prefab之后的路径,例如：ABResources/StoryTimeline/Camera_2020，则填写路径为 StoryTimeline/Camera_2020")]
public class ActiveStoryPrefab : FlowControlNode
{
	private EffectController _effectController;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		_effectController = null;
	}

	protected override void RegisterPorts()
	{
		FlowOutput successOut = AddFlowOutput("成功");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<string> prefabPathVar = AddValueInput<string>("路径", "ActiveStoryPrefab_StoryPrefabPathVar");
		ValueInput<CinemachineBlendDefinition> beforePlayVar = AddValueInput<CinemachineBlendDefinition>("播放前相机切换", "ActiveStoryPrefab_beforePlayVar");
		ValueInput<CinemachineBlendDefinition> afterPlayVar = AddValueInput<CinemachineBlendDefinition>("播放后相机切换", "ActiveStoryPrefab_afterPlayVar");
		AddFlowInput("In", delegate(Flow f)
		{
			GameObject gameObject = Asset.InstantiateWithoutCache(prefabPathVar.GetValue());
			if (gameObject == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				PlayStoryPrefabPrepare(beforePlayVar.GetValue(), battleUIActive: false, isPause: true);
				_effectController = gameObject.GetComponent<EffectController>();
				if (_effectController != null)
				{
					_effectController.EnableVirtualCameras();
					PlayableDirector componentInChildren = gameObject.GetComponentInChildren<PlayableDirector>();
					_effectController.Initialize(isLoop: false, (float)componentInChildren.duration, 1f, EEffectQuality.Fantastic, delegate
					{
						PlayStoryPrefabPrepare(afterPlayVar.GetValue(), battleUIActive: true, isPause: false);
						UIHelper.SetUIActive("UICamera/Canvas/UIMain/MovieBlackBorder/JumpBtn", value: false);
						successOut.Call(f);
						Asset.Unload(prefabPathVar.GetValue());
						GC.Collect();
					});
					UIHelper.SetOnClickJumpMovie(delegate
					{
						_effectController.Stop();
					});
				}
				else
				{
					CinemachineBlendDefinition defaultBlend = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject).m_DefaultBlend;
					PlayStoryPrefabPrepare(defaultBlend, battleUIActive: true, isPause: false);
					abnormalOut.Call(f);
				}
			}
		});
	}

	public void PlayStoryPrefabPrepare(CinemachineBlendDefinition cameraBlend, bool battleUIActive, bool isPause)
	{
		CinemachineBrain cinemachineBrain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		if (cinemachineBrain.IsBlending)
		{
			cinemachineBrain.enabled = false;
			cinemachineBrain.enabled = true;
		}
		cinemachineBrain.m_DefaultBlend = cameraBlend;
		BattleUI.BattleUIActive(battleUIActive);
		if (!CommonProcessor.IsSinglePlayerGameMode(ClientSimulator.Instance.mGameMode))
		{
			return;
		}
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
		if (isPause)
		{
			if (playerAgent != null)
			{
				CameraParamComponent virtualCameraParam = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
				if (virtualCameraParam != null && virtualCameraParam.lockTargetCinemachine != null)
				{
					virtualCameraParam.lockTargetCinemachine.SetLoseTarget();
				}
				ComponentTimeline componentTimeline = playerAgent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.DisableRenders();
				}
				else
				{
					playerAgent.gameObject.SetActive(value: false);
				}
			}
			ClientSimulator.Instance.StopSim();
			return;
		}
		if (playerAgent != null)
		{
			ComponentTimeline componentTimeline2 = playerAgent.ComponentTimeline;
			if (componentTimeline2 != null)
			{
				componentTimeline2.EnableRenders();
			}
			else
			{
				playerAgent.gameObject.SetActive(value: true);
			}
		}
		ClientSimulator.Instance.StartSim();
	}
}
