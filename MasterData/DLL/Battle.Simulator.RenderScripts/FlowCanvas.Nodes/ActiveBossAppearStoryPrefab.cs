using System;
using Cinemachine;
using Config;
using MessagePack;
using NetProcol;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("Boss出场", 0)]
[Category("Render/Asset")]
[Description("激活已经路径对应的剧情预制体,路径使用Prefab之后的路径,例如：ABResources/StoryTimeline/Camera_2020，则填写路径为 StoryTimeline/Camera_2020")]
public class ActiveBossAppearStoryPrefab : FlowNode, IUpdatable
{
	public const int FOV_IN_EDITOR = 55;

	private GameObject panel;

	public string mainNamePath = "content/move/name_text";

	public string typeNamePath = "content/move/1/type_text";

	public string factionPath = "Words/content/text";

	public string factionFormat = "所属势力: {0}";

	public string featuresPath = "Words/content/text (1)";

	public string featuresFormat = "特性: {0}";

	public string attack_typePath = "Words/content/text (2)";

	public string attack_typeFormat = "攻击方式: {0}";

	public string timelineName = "timeline";

	public string animationTrackTypeName = "AnimationTrack";

	public string animationTrackName = "Animation Track";

	public Vector3 secondCameraPosition;

	public Vector3 secondCameraRotation;

	private bool startUpdate;

	private float runningTime;

	private float secondCameraAppearTime;

	private string secondCameraPath = "";

	private GameObject secondCamera;

	private GameObject appearUI;

	private bool firstFrame = true;

	private bool isSkip;

	private EventSystem currentEventSystem;

	private BattleUI battleUI;

	private EffectController _effectController;

	private CinemachineBlendDefinition blendDefinition;

	private int bossId;

	private float uiAppearTime;

	private string uiPath;

	private float battlepanelAppearTime;

	private float uiDisappearTime;

	private int bossAgentID;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(mainNamePath);
		writer.Write(typeNamePath);
		writer.Write(factionPath);
		writer.Write(factionFormat);
		writer.Write(featuresPath);
		writer.Write(featuresFormat);
		writer.Write(attack_typePath);
		writer.Write(attack_typeFormat);
		writer.Write(timelineName);
		writer.Write(animationTrackTypeName);
		writer.Write(animationTrackName);
		options.Resolver.GetFormatter<Vector3>().Serialize(ref writer, secondCameraPosition, options);
		options.Resolver.GetFormatter<Vector3>().Serialize(ref writer, secondCameraRotation, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		mainNamePath = reader.ReadString();
		typeNamePath = reader.ReadString();
		factionPath = reader.ReadString();
		factionFormat = reader.ReadString();
		featuresPath = reader.ReadString();
		featuresFormat = reader.ReadString();
		attack_typePath = reader.ReadString();
		attack_typeFormat = reader.ReadString();
		timelineName = reader.ReadString();
		animationTrackTypeName = reader.ReadString();
		animationTrackName = reader.ReadString();
		secondCameraPosition = options.Resolver.GetFormatter<Vector3>().Deserialize(ref reader, options);
		secondCameraRotation = options.Resolver.GetFormatter<Vector3>().Deserialize(ref reader, options);
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
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			storyCommand.storyType = StoryType.BossAppear;
			storyCommand.enterState = isPause;
			storyCommand.mOwner = playerAgent.AgentID;
			storyCommand.param = bossAgentID;
			ClientSimulator.Instance.SendLocalCommand(storyCommand);
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		startUpdate = false;
		runningTime = 0f;
		secondCameraAppearTime = 0f;
		secondCameraPath = "";
		if (secondCamera != null)
		{
			UnityEngine.Object.Destroy(secondCamera);
			secondCamera = null;
		}
		appearUI = null;
		firstFrame = true;
		isSkip = false;
		currentEventSystem = null;
		battleUI = null;
		_effectController = null;
		bossId = 0;
		uiAppearTime = 0f;
		uiPath = "";
		battlepanelAppearTime = 0f;
		uiDisappearTime = 0f;
	}

	public void Update()
	{
		if (!startUpdate)
		{
			return;
		}
		runningTime += Time.deltaTime;
		CameraParamComponent virtualCameraParam = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
		if (virtualCameraParam != null && virtualCameraParam.lockTargetCinemachine != null && virtualCameraParam.lockTargetCinemachine.IsLocking())
		{
			virtualCameraParam.lockTargetCinemachine.SetLoseTarget();
			firstFrame = true;
		}
		if (firstFrame)
		{
			firstFrame = false;
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			int mPlayerAgentID = agentManager.mPlayerAgentID;
			NAgent agent = agentManager.GetAgent(mPlayerAgentID);
			(NScene.GetCurrentScene() as BattleScene).virtualCameraParam.RotateCameraToRoleaBack(agent.transform);
		}
		if (runningTime >= secondCameraAppearTime && !string.IsNullOrEmpty(secondCameraPath) && secondCamera == null)
		{
			CinemachineBrain cinemachineBrain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
			if (cinemachineBrain.IsBlending)
			{
				cinemachineBrain.enabled = false;
				cinemachineBrain.enabled = true;
			}
			cinemachineBrain.m_DefaultBlend = blendDefinition;
			AgentManager agentManager2 = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager2 != null)
			{
				NAgent agent2 = agentManager2.GetAgent(agentManager2.mPlayerAgentID);
				if (agent2 == null)
				{
					return;
				}
				Transform transform = agent2.transform;
				secondCamera = Asset.InstantiateAutoUnloadWhileDestroy(secondCameraPath);
				secondCamera.transform.parent = transform;
				secondCamera.transform.localPosition = secondCameraPosition;
				secondCamera.transform.localRotation = Quaternion.Euler(secondCameraRotation);
				secondCamera.transform.parent = null;
			}
		}
		if (runningTime >= uiAppearTime && appearUI == null && bossId != 0 && !string.IsNullOrEmpty(uiPath))
		{
			if (panel == null)
			{
				panel = GameObject.Find("UICamera/Canvas/UIMain/BattleUIEffectPanel");
			}
			appearUI = Asset.InstantiateWithoutCache(uiPath, panel.transform);
			boss_appear_UI_text config = ConfigHelper.GetInstance().GetConfig<boss_appear_UI_text>(bossId);
			appearUI.transform.Find(mainNamePath).GetComponent<Text>().text = WorldStateManager.GetSystemTableI18N(config.MainName);
			appearUI.transform.Find(typeNamePath).GetComponent<Text>().text = WorldStateManager.GetSystemTableI18N(config.SubName);
		}
		if (battlepanelAppearTime != 0f && runningTime >= battlepanelAppearTime)
		{
			if (battleUI == null)
			{
				battleUI = BattleUI.GetBattleUI();
				if (battleUI != null)
				{
					battleUI.SetBattleUIActive(flag: true);
				}
			}
			else
			{
				battleUI.SetBattleUIActive(flag: true);
			}
			UIHelper.SetUIActive("UICamera/Canvas/UIMain/MovieBlackBorder/JumpBtn", value: false);
			battlepanelAppearTime = 0f;
			currentEventSystem = EventSystem.current;
			if (currentEventSystem != null)
			{
				currentEventSystem.enabled = false;
			}
		}
		if (runningTime < secondCameraAppearTime)
		{
			if (battleUI == null)
			{
				battleUI = BattleUI.GetBattleUI();
				if (battleUI != null)
				{
					battleUI.SetBattleUIActive(flag: false);
				}
			}
			else
			{
				battleUI.SetBattleUIActive(flag: false);
			}
		}
		if (runningTime >= uiDisappearTime && appearUI != null)
		{
			UnityEngine.Object.Destroy(appearUI);
			Asset.Unload(uiPath);
			appearUI = null;
		}
	}

	protected override void RegisterPorts()
	{
		FlowOutput successOut = AddFlowOutput("结束播放");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> bossAgentIDInput = AddValueInput<int>("创建出来的AgentID");
		ValueInput<string> prefabPathVar = AddValueInput<string>("路径", "ActiveStoryPrefab_StoryPrefabPathVar");
		ValueInput<Int3> positionIntput = AddValueInput<Int3>("位置", "position").SetDefaultAndSerializedValue(Int3.up);
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向", "forward").SetDefaultAndSerializedValue(Int3.up);
		ValueInput<CinemachineBlendDefinition> beforePlayVar = AddValueInput<CinemachineBlendDefinition>("播放前相机切换", "ActiveStoryPrefab_beforePlayVar");
		ValueInput<CinemachineBlendDefinition> secondCameraChangeInput = AddValueInput<CinemachineBlendDefinition>("对峙前相机切换");
		ValueInput<CinemachineBlendDefinition> afterPlayVar = AddValueInput<CinemachineBlendDefinition>("播放后相机切换", "ActiveStoryPrefab_afterPlayVar");
		ValueInput<CinemachineBlendDefinition> skipCameraChangeInput = AddValueInput<CinemachineBlendDefinition>("跳过相机切换");
		ValueInput<string> blackEffectPathInput = AddValueInput<string>("黑屏特效路径");
		ValueInput<float> blackEffectTimeInput = AddValueInput<float>("黑屏特效时长");
		ValueInput<string> secondCameraPathInput = AddValueInput<string>("对峙相机路径");
		ValueInput<float> secondCameraAppearTimeInput = AddValueInput<float>("对峙相机出现时间");
		ValueInput<int> idInput = AddValueInput<int>("Boss编号ID");
		ValueInput<float> uiTimeInput = AddValueInput<float>("UI出现时间");
		ValueInput<string> uiPathInput = AddValueInput<string>("UI资源路径");
		ValueInput<float> battlepanelAppearTimeInput = AddValueInput<float>("战斗UI出现时间");
		ValueInput<float> uiDisappearTimeInput = AddValueInput<float>("BossUI消失时间");
		ValueInput<bool> canSkipStoryInput = AddValueInput<bool>("能否跳过");
		AddFlowInput("", delegate(Flow f)
		{
			if (!startUpdate)
			{
				string value = prefabPathVar.GetValue();
				GameObject gameObject = Asset.InstantiateAutoUnloadWhileDestroy(value);
				if (gameObject == null)
				{
					Debug.LogError("没有缓存boss出场剧情: " + value);
					abnormalOut.Call(f);
				}
				else
				{
					if (positionIntput.GetValue() != Int3.up)
					{
						gameObject.transform.position = (Vector3)positionIntput.GetValue();
					}
					if (forwardInput.GetValue() != Int3.up)
					{
						gameObject.transform.forward = (Vector3)forwardInput.GetValue();
					}
					Transform transIn = null;
					bossAgentID = bossAgentIDInput.value;
					if (bossAgentID != 0)
					{
						transIn = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(bossAgentID).transform;
						gameObject.transform.position = transIn.position;
						gameObject.transform.rotation = transIn.rotation;
					}
					CharacterEffect[] componentsInChildren = gameObject.GetComponentsInChildren<CharacterEffect>();
					for (int i = 0; i < componentsInChildren.Length; i++)
					{
						componentsInChildren[i].shadowHeight = gameObject.transform.position.y;
					}
					ComponentTimeline ct = null;
					if (transIn != null)
					{
						ct = transIn.gameObject.GetComponent<ComponentTimeline>();
						if (ct != null)
						{
							ct.DisableRenders();
						}
						else
						{
							transIn.gameObject.SetActive(value: false);
						}
					}
					SetPlayerRelaxTimerActive(enable: false);
					PlayStoryPrefabPrepare(beforePlayVar.GetValue(), battleUIActive: false, isPause: true);
					if (canSkipStoryInput.value)
					{
						UIHelper.SetOnClickJumpMovie(delegate
						{
							panel = GameObject.Find("UICamera/Canvas/UIMain");
							string p = blackEffectPathInput.value;
							GameObject gameObject2 = Asset.InstantiateWithoutCache(p, panel.transform);
							Animator component = gameObject2.GetComponent<Animator>();
							component.Play("out");
							component.speed = 0.1f;
							float value2 = blackEffectTimeInput.value;
							UnityEngine.Object.Destroy(gameObject2, value2);
							LeanTween.delayedCall(value2, (Action)delegate
							{
								Asset.Unload(p);
							});
							isSkip = true;
							if (_effectController != null)
							{
								_effectController.Stop();
							}
						});
					}
					startUpdate = true;
					runningTime = 0f;
					firstFrame = true;
					secondCameraAppearTime = secondCameraAppearTimeInput.value;
					secondCameraPath = secondCameraPathInput.value;
					blendDefinition = secondCameraChangeInput.value;
					bossId = idInput.value;
					uiAppearTime = uiTimeInput.value;
					uiPath = uiPathInput.value;
					battlepanelAppearTime = battlepanelAppearTimeInput.value;
					uiDisappearTime = uiDisappearTimeInput.value;
					isSkip = false;
					_effectController = gameObject.GetComponent<EffectController>();
					if (_effectController != null)
					{
						_effectController.EnableVirtualCameras();
						PlayableDirector componentInChildren = gameObject.GetComponentInChildren<PlayableDirector>();
						_effectController.Initialize(isLoop: false, (float)componentInChildren.duration, 1f, EEffectQuality.Fantastic, delegate(EffectController effctCtrl)
						{
							CinemachineBlendDefinition value2 = afterPlayVar.GetValue();
							if (isSkip)
							{
								value2 = skipCameraChangeInput.value;
							}
							AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
							int mPlayerAgentID = agentManager.mPlayerAgentID;
							NAgent agent = agentManager.GetAgent(mPlayerAgentID);
							if (agent != null)
							{
								(NScene.GetCurrentScene() as BattleScene).virtualCameraParam.RotateCameraToRoleaBack(agent.transform);
							}
							PlayStoryPrefabPrepare(value2, battleUIActive: true, isPause: false);
							if (appearUI != null)
							{
								UnityEngine.Object.Destroy(appearUI);
								Asset.Unload(uiPath);
								appearUI = null;
							}
							if (secondCamera != null)
							{
								secondCamera.SetActive(value: false);
								UnityEngine.Object.Destroy(secondCamera, 2f);
								secondCamera = null;
							}
							UIHelper.SetUIActive("UICamera/Canvas/UIMain/MovieBlackBorder/JumpBtn", value: false);
							if (transIn != null)
							{
								if (ct != null)
								{
									ct.EnableRenders();
								}
								else
								{
									transIn.gameObject.SetActive(value: true);
								}
							}
							startUpdate = false;
							SetPlayerRelaxTimerActive(enable: true);
							if (currentEventSystem != null)
							{
								currentEventSystem.enabled = true;
							}
							UnityEngine.Object.Destroy(effctCtrl.gameObject);
							GC.Collect();
							successOut.Call(f);
						});
					}
					else
					{
						CinemachineBlendDefinition defaultBlend = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject).m_DefaultBlend;
						PlayStoryPrefabPrepare(defaultBlend, battleUIActive: true, isPause: false);
						SetPlayerRelaxTimerActive(enable: true);
						abnormalOut.Call(f);
					}
				}
			}
		});
	}

	public void SetPlayerRelaxTimerActive(bool enable)
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
}
