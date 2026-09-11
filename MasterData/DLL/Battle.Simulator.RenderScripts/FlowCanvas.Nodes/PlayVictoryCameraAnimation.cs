using Cinemachine;
using Config;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("播放相机胜利动画", 0)]
[Category("Render/Camera")]
[Description("播放相机出场动画")]
public class PlayVictoryCameraAnimation : FlowNode
{
	private GameObject m_go;

	private PlayableDirector director;

	private const string BIND_PLAYER_AGENT_TPOSE = "$BIND_PLAYER_AGENT_TPOSE";

	protected override void RegisterPorts()
	{
		ValueInput<string> assetNameInput = AddValueInput<string>("资源名");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			string.IsNullOrEmpty(assetNameInput.GetValue());
			m_go = Asset.Instantiate(GetAssetPath());
			if (m_go != null)
			{
				if (!m_go.TryGetComponent<PlayableDirector>(out director))
				{
					director = null;
				}
				else
				{
					PrepareTimelineParamsForPlayableDirector(director);
				}
			}
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				AgentManager agentManager = battleScene.GetAgentManager();
				if (agentManager != null)
				{
					NAgent playerAgent = agentManager.GetPlayerAgent();
					if (playerAgent != null)
					{
						m_go.transform.position = playerAgent.transform.position;
						m_go.transform.rotation = playerAgent.transform.rotation;
					}
				}
			}
			Camera main = Camera.main;
			if (main != null)
			{
				CinemachineBrain component = main.gameObject.GetComponent<CinemachineBrain>();
				if (component != null)
				{
					component.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
				}
			}
			output.Call(f);
		});
		AddValueOutput("实例", "go", () => m_go);
	}

	private string GetAssetPath()
	{
		NAgent nAgent = (NScene.GetCurrentScene() as BattleScene)?.GetAgentManager()?.GetPlayerAgent();
		string text = "Effect/EndBattle/DollyTrackCamera_battle_end_tongyong";
		if (ConfigHelper.GetInstance().TryGetConfig<charactor_param>(nAgent?.AgentConfigID ?? 0, out var config))
		{
			text = (RaceType)config.RaceID switch
			{
				RaceType.RaceGreece => "Effect/EndBattle/DollyTrackCamera_battle_end_aoshan", 
				RaceType.RaceEgypt => "Effect/EndBattle/DollyTrackCamera_battle_end_niluo", 
				RaceType.RaceJapan => "Effect/EndBattle/DollyTrackCamera_battle_end_zhenying", 
				RaceType.RaceNorthernEurope => "Effect/EndBattle/DollyTrackCamera_battle_end_shengshu", 
				RaceType.Other => "Effect/EndBattle/DollyTrackCamera_battle_end_zhongxing", 
				RaceType.RaceChina => "Effect/EndBattle/DollyTrackCamera_battle_end_tianyuan", 
				_ => "Effect/EndBattle/DollyTrackCamera_battle_end_tongyong", 
			};
		}
		if (AssetManager.TryGetAssetNameAndBundleName(text, out var _, out var _))
		{
			return text;
		}
		return "Camera/DollyTrackCamera_battle_end_tongyong";
	}

	private void PrepareTimelineParamsForPlayableDirector(PlayableDirector director)
	{
		foreach (PlayableBinding output in director.playableAsset.outputs)
		{
			if (output.streamName == "$BIND_PLAYER_AGENT_TPOSE")
			{
				Transform attachPoint = ((NScene.GetCurrentScene() as BattleScene)?.GetAgentManager()?.GetPlayerAgent()).AttachPointSetup.GetAttachPoint("Bip001");
				director.SetGenericBinding(output.sourceObject, attachPoint);
			}
		}
	}
}
