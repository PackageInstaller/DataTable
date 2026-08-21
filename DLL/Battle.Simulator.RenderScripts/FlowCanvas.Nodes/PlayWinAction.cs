using System;
using System.Collections.Generic;
using Cinemachine;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("播放胜利", 0)]
[Category("Render/Timeline")]
[Description("播放胜利, 会隐藏主角之外的agent")]
public class PlayWinAction : FlowNode, IUpdatable
{
	private FlowOutput output;

	private bool start;

	private float currrentTime;

	private float maxTime;

	private Flow flow;

	public string uitposePathFormat = "StoryTimeline/Win/{0}_win_uitpose";

	public string battletposePathFormat = "StoryTimeline/Win/{0}_win_battletpose";

	public string cameraPathFormat = "StoryTimeline/Win/MultiplePlayerGameModeWinCamera";

	public string pos1Name = "pos1";

	public string pos2Name = "pos2";

	public string animationTrackTypeName = "AnimationTrack";

	public string animationTrackName = "Animation Track";

	public string timelineName = "timeline";

	public float hideTime = 1.83f;

	private List<GameObject> gameObjectsToHide = new List<GameObject>();

	private CameraExtension cameraExtension;

	private PlayableDirector playableDirector;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(uitposePathFormat);
		writer.Write(battletposePathFormat);
		writer.Write(cameraPathFormat);
		writer.Write(pos1Name);
		writer.Write(pos2Name);
		writer.Write(animationTrackTypeName);
		writer.Write(animationTrackName);
		writer.Write(timelineName);
		writer.Write(hideTime);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		uitposePathFormat = reader.ReadString();
		battletposePathFormat = reader.ReadString();
		cameraPathFormat = reader.ReadString();
		pos1Name = reader.ReadString();
		pos2Name = reader.ReadString();
		animationTrackTypeName = reader.ReadString();
		animationTrackName = reader.ReadString();
		timelineName = reader.ReadString();
		hideTime = (float)reader.ReadDouble();
	}

	public void Update()
	{
		if (!start)
		{
			return;
		}
		currrentTime += Time.deltaTime;
		if (currrentTime > maxTime)
		{
			if (cameraExtension != null)
			{
				cameraExtension.shadowRotationImmediately = false;
			}
			flow.Call(output);
			start = false;
			playableDirector?.Stop();
		}
		if (currrentTime >= hideTime)
		{
			for (int i = 0; i < gameObjectsToHide.Count; i++)
			{
				gameObjectsToHide[i].SetActive(value: false);
			}
		}
	}

	public Transform PlayMultiModeCamera(string path, Vector3 position, Vector3 forward)
	{
		GameObject gameObject = Asset.Instantiate(path);
		playableDirector = gameObject.transform.Find(timelineName).GetComponent<PlayableDirector>();
		gameObject.transform.position = position;
		gameObject.transform.forward = forward;
		maxTime = (float)playableDirector.duration;
		return gameObject.transform;
	}

	public Transform PlayMultiModePose(int agentConfigID, out CharacterEffect characterEffect)
	{
		GameObject gameObject = Asset.Instantiate(string.Format(battletposePathFormat, agentConfigID));
		CharacterEffect componentInChildren = gameObject.GetComponentInChildren<CharacterEffect>();
		if (componentInChildren != null)
		{
			DynamicBone[] components = componentInChildren.gameObject.GetComponents<DynamicBone>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].enabled = false;
			}
			componentInChildren.shadowHeight = componentInChildren.transform.position.y;
		}
		characterEffect = componentInChildren;
		return gameObject.transform;
	}

	public Transform PlayWin(int agentConfigID, Vector3 position, Vector3 forward, bool localPlayer, out CharacterEffect characterEffect)
	{
		string format = battletposePathFormat;
		if (localPlayer)
		{
			format = uitposePathFormat;
		}
		GameObject gameObject = Asset.Instantiate(string.Format(format, agentConfigID));
		PlayableDirector component = gameObject.transform.Find(timelineName).GetComponent<PlayableDirector>();
		gameObject.SetActive(value: true);
		CharacterEffect componentInChildren = gameObject.GetComponentInChildren<CharacterEffect>();
		if (componentInChildren != null)
		{
			DynamicBone[] components = componentInChildren.gameObject.GetComponents<DynamicBone>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].enabled = false;
			}
			Animator component2 = componentInChildren.gameObject.GetComponent<Animator>();
			IEnumerator<PlayableBinding> enumerator = component.playableAsset.outputs.GetEnumerator();
			while (enumerator.MoveNext())
			{
				PlayableBinding current = enumerator.Current;
				if (current.sourceObject.GetType().Name.Equals(animationTrackTypeName) && current.streamName == animationTrackName && component.GetGenericBinding(current.sourceObject) == null)
				{
					component.SetGenericBinding(current.sourceObject, component2);
				}
			}
		}
		if (gameObject != null)
		{
			gameObject.transform.position = position;
			gameObject.transform.forward = forward;
			if (localPlayer)
			{
				playableDirector = component;
			}
			else
			{
				gameObjectsToHide.Add(gameObject);
			}
		}
		characterEffect = componentInChildren;
		if (componentInChildren != null)
		{
			componentInChildren.shadowHeight = componentInChildren.transform.position.y;
		}
		return gameObject.transform;
	}

	public float GetFOVScale()
	{
		int num = 1080;
		return Convert.ToSingle((float)Mathf.RoundToInt(Convert.ToSingle(1920) / (float)Screen.width * (float)Screen.height) * 1f / (float)num);
	}

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (!start)
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene == null || battleScene.mapConfig == null || (battleScene.mapConfig.SkipWinAction & 1) != 0)
				{
					f.Call(output);
				}
				else
				{
					gameObjectsToHide.Clear();
					flow = f;
					AgentManager agentManager = battleScene.GetAgentManager();
					List<NAgent> entities = agentManager.Entities;
					for (int i = 0; i < entities.Count; i++)
					{
						DespawnGhost.RecyclePendant(entities[i]);
						ComponentTimeline componentTimeline = entities[i].ComponentTimeline;
						componentTimeline.TimelinePlayer.Stop();
						componentTimeline.DisableRenders();
					}
					battleScene.GetBattleSimulatorSystem().ThrownManager.DestoryAllThrown();
					CinemachineBrain component = Camera.main.GetComponent<CinemachineBrain>();
					if (component.IsBlending)
					{
						component.enabled = false;
						component.enabled = true;
					}
					component.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
					int num = battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count - 1;
					Transform transform = null;
					for (int j = 0; j < num + 1; j++)
					{
						bool flag = agentManager.mPlayerAgentID == agentManager.GetAgentIDByMemberPosition((MemberPosition)j);
						Transform transform2 = PlayWin(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(j).ID, (Vector3)positionInput.value, (Vector3)forwardInput.value, flag, out var characterEffect);
						if (characterEffect != null)
						{
							characterEffect.shadowHeight = ((Vector3)positionInput.value).y;
						}
						if (flag)
						{
							transform = transform2;
						}
					}
					for (int k = 0; k < gameObjectsToHide.Count; k++)
					{
						string n = pos1Name;
						if (k == 1)
						{
							n = pos2Name;
						}
						gameObjectsToHide[k].transform.parent = transform.Find(n);
						gameObjectsToHide[k].transform.localPosition = Vector3.zero;
						gameObjectsToHide[k].transform.localRotation = Quaternion.identity;
					}
					if (playableDirector != null)
					{
						playableDirector.time = Mathf.Max(0f, 1f - (float)num * 0.5f);
						maxTime = (float)playableDirector.duration + (float)num * 0.5f - 1f;
						hideTime = hideTime + (float)num * 0.5f - 1f;
					}
					cameraExtension = Camera.main.GetComponent<CameraExtension>();
					if (cameraExtension != null)
					{
						cameraExtension.shadowRotationImmediately = true;
						cameraExtension.abberationIntensity = 0f;
						cameraExtension.radialBlurScale = 0f;
						cameraExtension.radialBlurGradient = 1f;
						cameraExtension.radialBlurIntensity = 1f;
						cameraExtension.radialBlurTarget = null;
					}
					currrentTime = 0f;
					start = true;
				}
			}
		});
	}

	public override void OnGraphStoped()
	{
		cameraExtension = null;
		playableDirector = null;
		gameObjectsToHide.Clear();
		start = false;
	}
}
