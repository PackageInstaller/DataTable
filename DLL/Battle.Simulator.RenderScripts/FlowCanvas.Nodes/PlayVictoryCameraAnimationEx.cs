using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("播放相机胜利动画(扩展)", 0)]
[Category("Render/Camera")]
[Description("播放相机出场动画")]
public class PlayVictoryCameraAnimationEx : FlowNode
{
	private GameObject m_go;

	private PlayableDirector director;

	private string bindTPoseTrs;

	private const string DEFAULT_ASSET_PATH_PREFIX = "DollyTrackCamera_battle_end";

	private const string FALLBACK_ASSET_DIR = "Camera";

	private const string NEW_ASSET_DIR = "Effect/EndBattle";

	private const string DEFAULT_BIND_ATTACH_POINT = "Bip001";

	private const string BIND_PLAYER_AGENT_TPOSE = "$BIND_PLAYER_AGENT_TPOSE";

	protected override void RegisterPorts()
	{
		ValueInput<string> assetNameInput = AddValueInput<string>("资源前缀").SetDefaultAndSerializedValue("DollyTrackCamera_battle_end");
		ValueInput<string> bindTrs = AddValueInput<string>("绑定挂点").SetDefaultAndSerializedValue("Bip001");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			string text = assetNameInput.GetValue();
			if (string.IsNullOrEmpty(text))
			{
				text = "DollyTrackCamera_battle_end";
			}
			m_go = Asset.Instantiate(GetAssetPath(text));
			if (m_go != null)
			{
				m_go.GetComponentInChildren<CinemachineVirtualCamera>().LookAt = m_go.transform;
				if (!m_go.TryGetComponent<PlayableDirector>(out director))
				{
					director = null;
				}
				else
				{
					bindTPoseTrs = bindTrs.value;
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
		AddValueOutput("PlayableDirector(Optional)", "director", () => director);
	}

	private string GetAssetPath(string assetPrefix)
	{
		int num = ((NScene.GetCurrentScene() as BattleScene)?.GetAgentManager()?.GetPlayerAgent())?.AgentSkinID ?? 0;
		string text = string.Format("{0}/{1}_{2}", "Effect/EndBattle", assetPrefix, num);
		if (AssetManager.TryGetAssetNameAndBundleName(text, out var _, out var _))
		{
			return text;
		}
		return "Camera/" + assetPrefix;
	}

	private void PrepareTimelineParamsForPlayableDirector(PlayableDirector director)
	{
		foreach (PlayableBinding output in director.playableAsset.outputs)
		{
			if (output.streamName == "$BIND_PLAYER_AGENT_TPOSE")
			{
				Transform attachPoint = ((NScene.GetCurrentScene() as BattleScene)?.GetAgentManager()?.GetPlayerAgent()).AttachPointSetup.GetAttachPoint(bindTPoseTrs);
				director.SetGenericBinding(output.sourceObject, attachPoint);
			}
		}
	}
}
