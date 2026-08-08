using System.Collections.Generic;
using Cinemachine;
using NetProcol;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("激活连携奥义资源(渲染)", 0)]
[Category("Render/Asset")]
[Description("激活已经路径对应的剧情预制体,路径使用Prefab之后的路径,例如：ABResources/StoryTimeline/Camera_2020，则填写路径为 StoryTimeline/Camera_2020")]
public class ActiveCooperateUniqueSkillAssets : FlowControlNode
{
	private bool startUpdate;

	private FlowOutput _Out;

	private BattleUI battleUI;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		startUpdate = false;
		battleUI = null;
	}

	public static void PlayStoryPrefabPrepare(BattleUI battleUI, int agentID, CinemachineBlendDefinition cameraBlend, bool battleUIActive, bool isPause, int targetAgentID)
	{
		CinemachineBrain cinemachineBrain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		if (cinemachineBrain.IsBlending)
		{
			cinemachineBrain.enabled = false;
			cinemachineBrain.enabled = true;
		}
		cinemachineBrain.m_DefaultBlend = cameraBlend;
		if (!isPause)
		{
			cinemachineBrain.ActiveVirtualCamera.LookAt = null;
		}
		if (battleUI == null)
		{
			battleUI = BattleUI.GetBattleUI();
			if (battleUI != null)
			{
				battleUI.SetBattleUIActive(battleUIActive);
			}
		}
		else
		{
			battleUI.SetBattleUIActive(battleUIActive);
		}
		StoryCommand storyCommand = CommandFactory.Create(NetprotoOperationCode.CmdStory) as StoryCommand;
		storyCommand.storyType = StoryType.CooperateUniqueSkill;
		storyCommand.enterState = isPause;
		storyCommand.mOwner = agentID;
		storyCommand.param = targetAgentID;
		ClientSimulator.Instance.SendLocalCommand(storyCommand);
	}

	public static void SetPlayerRelaxTimerActive(bool enable)
	{
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		for (int i = 0; i < agentManager.mPlayerList.Count; i++)
		{
			NAgent agent = agentManager.GetAgent(agentManager.mPlayerList[i]);
			if (!(agent != null))
			{
				continue;
			}
			ComponentTimeline componentTimeline = agent.ComponentTimeline;
			if (componentTimeline != null)
			{
				if (enable)
				{
					componentTimeline.EnableRelaxTimer();
				}
				else
				{
					componentTimeline.DisableRelaxTimer();
				}
			}
		}
	}

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		FlowOutput abortOut = AddFlowOutput("简洁播放", "abort");
		FlowOutput successOut = AddFlowOutput("结束播放");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> agentIDInput = AddValueInput<int>("发起者实体ID", "agentID");
		ValueInput<int> targetAgentIDInput = AddValueInput<int>("目标实体ID", "targetAgentID");
		ValueInput<CinemachineBlendDefinition> beforePlayVar = AddValueInput<CinemachineBlendDefinition>("播放前相机切换", "ActiveStoryPrefab_beforePlayVar");
		ValueInput<CinemachineBlendDefinition> afterPlayVar = AddValueInput<CinemachineBlendDefinition>("播放后相机切换", "ActiveStoryPrefab_afterPlayVar");
		ValueInput<float> playShortTimeInput = AddValueInput<float>("短播放时长(秒)", "shortTime").SetDefaultAndSerializedValue(1f);
		AddFlowInput("", delegate(Flow f)
		{
			if (startUpdate)
			{
				abnormalOut.Call(f);
			}
			else
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene == null)
				{
					abnormalOut.Call(f);
				}
				else if (battleScene.m_cooperateAssetPrefabName.Count <= 0)
				{
					abnormalOut.Call(f);
				}
				else
				{
					GameObject gameObject = null;
					List<EffectController> list = new List<EffectController>();
					List<CharacterEffect> list2 = new List<CharacterEffect>();
					for (int i = 0; i < battleScene.m_cooperateAssetPrefabName.Count; i++)
					{
						GameObject gameObject2 = Asset.Instantiate(battleScene.m_cooperateAssetPrefabName[i]);
						EffectController component = gameObject2.GetComponent<EffectController>();
						CharacterEffect[] componentsInChildren = gameObject2.GetComponentsInChildren<CharacterEffect>();
						list2.AddRange(componentsInChildren);
						list.Add(component);
						if (i == 0)
						{
							gameObject = gameObject2;
						}
					}
					AgentManager agentManager = battleScene.GetAgentManager();
					int targetAgentID = targetAgentIDInput.value;
					if (targetAgentID == 0)
					{
						targetAgentID = agentManager.GetPlayerAgent().AgentID;
					}
					if (targetAgentID != 0)
					{
						NAgent agent = agentManager.GetAgent(targetAgentID);
						if (agent != null)
						{
							Vector3 position = agent.transform.position;
							if (agent.AttachPointSetup != null)
							{
								position = agent.AttachPointSetup.GetPerformPosition();
							}
							for (int j = 0; j < list.Count; j++)
							{
								list[j].transform.position = position;
								list[j].transform.rotation = agent.transform.rotation;
							}
							for (int k = 0; k < list2.Count; k++)
							{
								list2[k].shadowHeight = position.y;
							}
						}
					}
					SetPlayerRelaxTimerActive(enable: false);
					PlayStoryPrefabPrepare(battleUI, agentIDInput.GetValue(), beforePlayVar.GetValue(), battleUIActive: false, isPause: true, targetAgentID);
					startUpdate = true;
					EffectController component2 = gameObject.GetComponent<EffectController>();
					if (component2 != null)
					{
						component2.EnableVirtualCameras();
						float num = playShortTimeInput.value;
						BattleScene.FullPlay = battleScene.GetWorldSatetManager().CanFullPlayOfCooperateUniqueSkill();
						if (BattleScene.FullPlay)
						{
							num = (float)gameObject.GetComponentInChildren<PlayableDirector>().duration;
						}
						component2.Initialize(isLoop: false, num, 1f, EEffectQuality.Fantastic, delegate
						{
							CinemachineBlendDefinition value = afterPlayVar.GetValue();
							PlayStoryPrefabPrepare(battleUI, agentIDInput.GetValue(), value, battleUIActive: true, isPause: false, targetAgentID);
							startUpdate = false;
							SetPlayerRelaxTimerActive(enable: true);
							if (!BattleScene.FullPlay)
							{
								abortOut.Call(f);
							}
							successOut.Call(f);
						});
						for (int num2 = 1; num2 < list.Count; num2++)
						{
							EffectController effectController = list[num2];
							if (effectController != null)
							{
								effectController.EnableVirtualCameras();
								effectController.Initialize(isLoop: false, num, 1f, EEffectQuality.Fantastic, null);
							}
						}
					}
					_Out.Call(f);
				}
			}
		});
	}
}
