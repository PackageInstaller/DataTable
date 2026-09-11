using System.Collections.Generic;
using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("实例化连携奥义预制(渲染)", 0)]
[Category("Render/Asset")]
[Description("激活已经路径对应的剧情预制体,路径使用Prefab之后的路径,例如：ABResources/StoryTimeline/Camera_2020，则填写路径为 StoryTimeline/Camera_2020")]
public class ActiveCooperateUniqueSkillPrefab : EffectCreateBaseNode
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

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_Out = AddFlowOutput("Out", "output");
		FlowOutput successOut = AddFlowOutput("结束播放");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> agentIDInput = AddValueInput<int>("发起者实体ID", "agentID");
		ValueInput<int> targetAgentIDInput = AddValueInput<int>("目标实体ID", "targetAgentID");
		ValueInput<CinemachineBlendDefinition> beforePlayVar = AddValueInput<CinemachineBlendDefinition>("播放前相机切换", "ActiveStoryPrefab_beforePlayVar");
		ValueInput<CinemachineBlendDefinition> afterPlayVar = AddValueInput<CinemachineBlendDefinition>("播放后相机切换", "ActiveStoryPrefab_afterPlayVar");
		AddFlowInput("", delegate(Flow f)
		{
			if (startUpdate)
			{
				abnormalOut.Call(f);
			}
			else
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				List<GameObject> list = new List<GameObject>();
				for (int i = 0; i < battleScene.m_cooperateAssetPrefabName.Count; i++)
				{
					GameObject gameObject = Asset.Instantiate(battleScene.m_cooperateAssetPrefabName[i]);
					list.Add(gameObject);
					if (i == 0)
					{
						_effectInstance = gameObject;
					}
				}
				AgentManager agentManager = battleScene.GetAgentManager();
				Transform transform = null;
				int targetAgentID = targetAgentIDInput.value;
				if (targetAgentID == 0)
				{
					targetAgentID = agentManager.GetPlayerAgent().AgentID;
				}
				if (targetAgentID != 0)
				{
					transform = agentManager.GetAgent(targetAgentID).transform;
					for (int j = 0; j < list.Count; j++)
					{
						list[j].transform.position = transform.position;
						list[j].transform.rotation = transform.rotation;
					}
				}
				ActiveCooperateUniqueSkillAssets.SetPlayerRelaxTimerActive(enable: false);
				ActiveCooperateUniqueSkillAssets.PlayStoryPrefabPrepare(battleUI, agentIDInput.GetValue(), beforePlayVar.GetValue(), battleUIActive: false, isPause: true, targetAgentID);
				startUpdate = true;
				EffectController component = _effectInstance.GetComponent<EffectController>();
				if (component != null)
				{
					component.EnableVirtualCameras();
					PlayableDirector componentInChildren = _effectInstance.GetComponentInChildren<PlayableDirector>();
					component.Initialize(isLoop: false, (float)componentInChildren.duration, 1f, EEffectQuality.Fantastic, delegate
					{
						CinemachineBlendDefinition value = afterPlayVar.GetValue();
						ActiveCooperateUniqueSkillAssets.PlayStoryPrefabPrepare(battleUI, agentIDInput.GetValue(), value, battleUIActive: true, isPause: false, targetAgentID);
						startUpdate = false;
						ActiveCooperateUniqueSkillAssets.SetPlayerRelaxTimerActive(enable: true);
						successOut.Call(f);
					});
					for (int num = 1; num < list.Count; num++)
					{
						EffectController component2 = list[num].GetComponent<EffectController>();
						if (component2 != null)
						{
							component2.EnableVirtualCameras();
							component2.Initialize(isLoop: false, (float)componentInChildren.duration, 1f, EEffectQuality.Fantastic, null);
						}
					}
				}
				_Out.Call(f);
			}
		});
	}
}
