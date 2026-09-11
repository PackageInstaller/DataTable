using System.Collections.Generic;
using Cinemachine;
using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

public class MasterSkillRenderHigh : MonoBehaviour
{
	public const string DynamicalCanvasPath = "UICamera/DynamicalCanvas";

	public CinemachineBlendDefinition cameraBlend;

	public string cameraEffectPath = "Effect/lianxie_combo/fx_comboskill_cam_1";

	public EffectController effectController;

	public PlayableDirector playableDirector;

	public float playShortTime = 1f;

	public string endAudioSheetName = "ui_battle";

	public string endAudioCueName = "ui_battle_stopcooperate";

	public bool endAudioUseStream;

	public Transform pos1;

	private EffectController _effectControllerPlayer;

	private EffectController _effectControllerCamera;

	private int _delayTime = -1;

	private List<int> _agentHide = new List<int>();

	private GameObject _dynamicalCanvas;

	private BattleUI _battleUI;

	private CinemachineBrain _cameraBrain;

	public void SetEffectControllerPlayer(EffectController e)
	{
		_effectControllerPlayer = e;
		CharacterEffect componentInChildren = e.GetComponentInChildren<CharacterEffect>();
		if (componentInChildren != null)
		{
			DynamicBone[] components = componentInChildren.gameObject.GetComponents<DynamicBone>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].enabled = false;
			}
			componentInChildren.shadowHeight = componentInChildren.transform.position.y;
		}
		if (pos1 != null)
		{
			e.transform.parent = pos1;
		}
		else
		{
			e.transform.parent = base.transform.FindChildDeep("pos1");
		}
		e.transform.localPosition = Vector3.zero;
		e.transform.localRotation = Quaternion.identity;
	}

	public void PlayFunction()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && battleScene.CameraExtension != null)
		{
			battleScene.CameraExtension.CaptureSnapshot();
		}
		if (battleScene != null)
		{
			battleScene.PauseEnvironmentEffect(pCleanEffect: true);
		}
		_delayTime = 1;
	}

	public void Update()
	{
		if (_delayTime < 0)
		{
			return;
		}
		if (_delayTime > 0)
		{
			_delayTime = 0;
			return;
		}
		_delayTime = -1;
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return;
		}
		if (battleScene.sceneSetting != null && battleScene.GetWorldSatetManager().m_breakEntityID == 0 && battleScene.sceneSetting.gameObject.activeSelf)
		{
			battleScene.sceneSetting.gameObject.SetActive(value: false);
		}
		_agentHide.Clear();
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		List<NAgent>.Enumerator enumerator = agentManager.Entities.GetEnumerator();
		while (enumerator.MoveNext())
		{
			NAgent current = enumerator.Current;
			if (current != null)
			{
				ComponentTimeline componentTimeline = current.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.DisableRenders();
					componentTimeline.DisableRelaxTimer();
					_agentHide.Add(current.AgentID);
				}
			}
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		PlayStoryCommand(playerAgent.AgentID, battleUIActive: false, enterState: true);
		if (!(effectController == null) && !(playableDirector == null))
		{
			effectController.EnableVirtualCameras();
			float num = (float)playableDirector.duration;
			effectController.SetActive(active: true);
			effectController.Initialize(isLoop: false, num, 1f, EEffectQuality.Fantastic, AfterPlayCallBack);
			effectController.Simulator(0f);
			if (_effectControllerPlayer != null)
			{
				_effectControllerPlayer.SetActive(active: true);
				_effectControllerPlayer.EnableVirtualCameras();
				_effectControllerPlayer.Simulator(0f);
				_effectControllerPlayer.Initialize(isLoop: false, num, 1f, EEffectQuality.Fantastic, null);
			}
			Vector3 forward = battleScene.virtualCameraParam.virtualCamera.transform.forward;
			Transform transform = playerAgent.transform;
			Vector3 one = Vector3.one;
			_effectControllerCamera = playerAgent.ComponentTimeline.PlayCommonEffect(cameraEffectPath, "", Vector3.zero, one, Vector3.zero, transform.forward, pIsAttach: false, pIsLoop: false, pNeedManager: false, 0f, 9999f, pUsePosition: false, Vector3.zero);
			_effectControllerCamera.transform.forward = forward;
			_effectControllerCamera.EnableVirtualCameras();
			battleScene.GetBattleSimulatorSystem().ThrownManager.HideAll(hide: true);
			if (_dynamicalCanvas == null)
			{
				_dynamicalCanvas = GameObject.Find("UICamera/DynamicalCanvas");
			}
			if (_dynamicalCanvas != null)
			{
				_dynamicalCanvas.SetActive(value: false);
			}
		}
	}

	public void PlayStoryCommand(int agentID, bool battleUIActive, bool enterState)
	{
		if (_cameraBrain == null)
		{
			_cameraBrain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		}
		if (_cameraBrain.IsBlending)
		{
			_cameraBrain.enabled = false;
			_cameraBrain.enabled = true;
		}
		_cameraBrain.m_DefaultBlend = cameraBlend;
		if (!enterState)
		{
			_cameraBrain.ActiveVirtualCamera.LookAt = null;
		}
		if (_battleUI == null)
		{
			_battleUI = BattleUI.GetBattleUI();
		}
		if (_battleUI != null)
		{
			_battleUI.SetBattleUIActive(battleUIActive);
		}
		StoryCommand storyCommand = CommandFactory.Create(NetprotoOperationCode.CmdStory) as StoryCommand;
		storyCommand.storyType = StoryType.MasterSkill;
		storyCommand.enterState = enterState;
		storyCommand.mOwner = agentID;
		storyCommand.param = 0;
		ClientSimulator.Instance.SendLocalCommand(storyCommand);
	}

	public void AfterPlay()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		PlayStoryCommand(playerAgent.AgentID, battleUIActive: true, enterState: false);
		if (!BattleScene.FullPlay)
		{
			AudioManager.Instance.Play("effect", endAudioSheetName, endAudioCueName, endAudioUseStream);
		}
		if (battleScene != null && battleScene.CameraExtension != null)
		{
			battleScene.CameraExtension.FreeSnapshot();
		}
		for (int i = 0; i < _agentHide.Count; i++)
		{
			int agentID = _agentHide[i];
			NAgent agent = agentManager.GetAgent(agentID);
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.EnableRelaxTimer();
					componentTimeline.EnableRenders();
				}
			}
		}
		battleScene.ResumeEnvironmentEffect();
		if (battleScene.sceneSetting != null && battleScene.GetWorldSatetManager().m_breakEntityID == 0 && !battleScene.sceneSetting.gameObject.activeSelf)
		{
			battleScene.sceneSetting.gameObject.SetActive(value: true);
		}
		if (_effectControllerCamera != null)
		{
			PooledAsset.DestroyOrReturn(_effectControllerCamera.gameObject);
		}
		battleScene.GetBattleSimulatorSystem().ThrownManager.HideAll(hide: false);
		if (_dynamicalCanvas == null)
		{
			_dynamicalCanvas = GameObject.Find("UICamera/DynamicalCanvas");
		}
		if (_dynamicalCanvas != null)
		{
			_dynamicalCanvas.SetActive(value: true);
		}
		effectController.SetActive(active: false);
		if (_effectControllerPlayer != null)
		{
			_effectControllerPlayer.SetActive(active: false);
		}
	}

	public static void AfterPlayCallBack(EffectController effect)
	{
		MasterSkillRenderHigh component = effect.gameObject.GetComponent<MasterSkillRenderHigh>();
		if (!(component == null))
		{
			component.AfterPlay();
		}
	}
}
