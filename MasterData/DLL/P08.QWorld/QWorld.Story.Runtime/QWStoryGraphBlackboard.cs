using System;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

namespace QWorld.Story.Runtime;

public class QWStoryGraphBlackboard : MonoBehaviour
{
	public const string charPath = "QWWorld/Chars/StoryActor/{0}";

	public const string thingPath = "QWWorld/Item/{0}";

	public const int DeActiveCameraPriority = 1;

	public const int ActiveCameraPriority = 20;

	public string GraphIdentify;

	[NonSerialized]
	private QWStoryGraphBlackboardData data;

	[SerializeField]
	public List<CharContext> charContext;

	[SerializeField]
	public List<CameraContext> cameraContext;

	[SerializeField]
	public List<PointContext> pointContext;

	[SerializeField]
	public List<TimelineContext> timelineContext;

	private Dictionary<string, int> charDict;

	private Dictionary<string, int> cameraDict;

	private Dictionary<string, int> pointDict;

	private Transform CharRoot;

	private Transform ThingRoot;

	private bool isDefaultLookAt;

	public void Awake()
	{
		Init();
	}

	private void Init()
	{
		CharRoot = base.transform.Find("Char");
		ThingRoot = base.transform.Find("Thing");
		charDict = new Dictionary<string, int>();
		cameraDict = new Dictionary<string, int>();
		pointDict = new Dictionary<string, int>();
		if (charContext != null)
		{
			for (int i = 0; i < charContext.Count; i++)
			{
				charDict.Add(charContext[i].tag, i);
			}
		}
		if (cameraContext != null)
		{
			for (int j = 0; j < cameraContext.Count; j++)
			{
				cameraDict.Add(cameraContext[j].tag, j);
			}
		}
		if (pointContext != null)
		{
			for (int k = 0; k < pointContext.Count; k++)
			{
				pointDict.Add(pointContext[k].tag, k);
			}
		}
		data.lastCameraTag = "";
		data.actors = new Dictionary<int, QWStoryGraphActor>();
		data.things = new Dictionary<int, QWStoryItem>();
		if (data.brain == null)
		{
			data.brain = U3DUtil.Get<CinemachineBrain>(QWorldCameraManager.Instance.MainCamera.gameObject);
		}
		data.oldBlend = data.brain.m_DefaultBlend;
		data.oldBlend.m_Time = 0.6f;
		data.cameraTweenId = -1;
		data.hasStoryTeleport = false;
	}

	private CinemachineBlendDefinition.Style GetBlendStyle(int style)
	{
		return style switch
		{
			1 => CinemachineBlendDefinition.Style.Cut, 
			2 => CinemachineBlendDefinition.Style.EaseInOut, 
			3 => CinemachineBlendDefinition.Style.EaseIn, 
			4 => CinemachineBlendDefinition.Style.EaseOut, 
			5 => CinemachineBlendDefinition.Style.HardIn, 
			6 => CinemachineBlendDefinition.Style.HardOut, 
			7 => CinemachineBlendDefinition.Style.Linear, 
			_ => CinemachineBlendDefinition.Style.EaseIn, 
		};
	}

	public void EnableCameraByTag(string tag, int style, float time)
	{
		CinemachineBlendDefinition defaultBlend = default(CinemachineBlendDefinition);
		if (tag == "")
		{
			defaultBlend.m_Style = GetBlendStyle(style);
			defaultBlend.m_Time = time;
			if (data.brain.IsBlending)
			{
				data.brain.enabled = false;
				data.brain.enabled = true;
			}
			data.brain.m_DefaultBlend = defaultBlend;
			if (cameraDict.TryGetValue(data.lastCameraTag, out var value))
			{
				cameraContext[value].camera.Priority = 1;
			}
			QWorldScene.Scene.cameraManager.ChangeStoryCameraActive(active: false);
			data.lastCameraTag = "";
			return;
		}
		QWorldScene.Scene.cameraManager.ChangeStoryCameraActive(active: true);
		defaultBlend.m_Style = GetBlendStyle(style);
		defaultBlend.m_Time = time;
		if (data.brain.IsBlending)
		{
			data.brain.enabled = false;
			data.brain.enabled = true;
		}
		data.brain.m_DefaultBlend = defaultBlend;
		if (!(data.lastCameraTag != tag))
		{
			return;
		}
		if (cameraDict.TryGetValue(data.lastCameraTag, out var value2))
		{
			cameraContext[value2].camera.Priority = 1;
			if (cameraContext[value2].cameraTimeline != null)
			{
				cameraContext[value2].cameraTimeline.gameObject.SetActive(value: false);
			}
		}
		if (cameraDict.TryGetValue(tag, out value2))
		{
			cameraContext[value2].camera.Priority = 20;
			if (cameraContext[value2].cameraTimeline != null)
			{
				cameraContext[value2].cameraTimeline.gameObject.SetActive(value: true);
			}
		}
		data.lastCameraTag = tag;
	}

	public void EnableCameraCut(bool cut)
	{
		if (data.brain != null)
		{
			if (data.brain.IsBlending)
			{
				data.brain.enabled = false;
				data.brain.enabled = true;
			}
			if (cut)
			{
				CinemachineBlendDefinition defaultBlend = data.brain.m_DefaultBlend;
				defaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
				data.brain.m_DefaultBlend = defaultBlend;
			}
			else
			{
				data.brain.m_DefaultBlend = data.oldBlend;
			}
		}
	}

	public void StartCameraShake(string cfgPath, float amplitude, float frequency)
	{
		if (data.cameraShakeComp == null)
		{
			data.cameraShakeComp = new QWStoryCameraShakeComponent();
		}
		data.cameraShakeComp.StartShake(cfgPath, amplitude, frequency);
	}

	public void StopCameraShake()
	{
		if (data.cameraShakeComp == null)
		{
			data.cameraShakeComp = new QWStoryCameraShakeComponent();
		}
		data.cameraShakeComp.StopShake();
	}

	public void CameraMove(string tag, int tweenType, int direction, float time, float distance)
	{
		if (cameraDict.TryGetValue(tag, out var value))
		{
			CinemachineVirtualCamera camera = cameraContext[value].camera;
			Vector3 position = camera.transform.position;
			switch (direction)
			{
			case 1:
				position += camera.transform.forward * distance;
				break;
			case 2:
				position -= camera.transform.forward * distance;
				break;
			case 3:
				position -= camera.transform.right * distance;
				break;
			case 4:
				position += camera.transform.right * distance;
				break;
			case 5:
				position += camera.transform.up * distance;
				break;
			case 6:
				position -= camera.transform.up * distance;
				break;
			}
			if (data.cameraTweenId != -1)
			{
				LeanTween.cancel(data.cameraTweenId);
				data.cameraTweenId = -1;
			}
			data.cameraTweenId = LeanTween.move(camera.gameObject, position, time).setEase((LeanTweenType)tweenType).setOnComplete((Action)delegate
			{
				data.cameraTweenId = -1;
			})
				.uniqueId;
		}
	}

	public Transform GetPoint(string tag)
	{
		if (tag.IsNotNullOrEmpty())
		{
			if (pointDict.TryGetValue(tag, out var value))
			{
				return pointContext[value].point;
			}
			return null;
		}
		return null;
	}

	public QWStoryItem LoadThing(int id, string asset, bool needLoad = true)
	{
		if (data.things.TryGetValue(id, out var value))
		{
			if (value.asset == asset)
			{
				return value;
			}
			UnloadThingInternal(id, value, lateClear: false);
		}
		if (needLoad)
		{
			string text = $"QWWorld/Item/{asset}";
			GameObject obj = UnityEngine.Object.Instantiate(Asset.Load<GameObject>(text));
			QWStoryItem qWStoryItem = U3DUtil.Get<QWStoryItem>(obj);
			qWStoryItem.asset = text;
			obj.transform.SetParent(base.transform, worldPositionStays: false);
			qWStoryItem.Init();
			data.things[id] = qWStoryItem;
			return qWStoryItem;
		}
		return null;
	}

	internal void UnloadThingInternal(int id, QWStoryItem actor, bool lateClear)
	{
		actor.OnClear();
		actor.Dispose();
		UnityEngine.Object.Destroy(actor.gameObject);
		Asset.Unload(actor.asset);
		if (!lateClear)
		{
			data.things.Remove(id);
		}
	}

	public void UnloadThing(int id, bool lateClear = false)
	{
		if (data.things.TryGetValue(id, out var value))
		{
			UnloadThingInternal(id, value, lateClear);
		}
	}

	public QWStoryItem GetThing(int id)
	{
		if (data.things.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public QWStoryGraphActor LoadChar(int charId, bool needLoad = true)
	{
		if (data.actors.TryGetValue(charId, out var value))
		{
			return value;
		}
		if (needLoad)
		{
			GameObject obj = UnityEngine.Object.Instantiate(Asset.Load<GameObject>($"QWWorld/Chars/StoryActor/{charId}"), CharRoot);
			QWStoryGraphActor qWStoryGraphActor = U3DUtil.Get<QWStoryGraphActor>(obj);
			obj.transform.parent = base.transform;
			obj.transform.position = Vector3.zero;
			obj.transform.rotation = Quaternion.identity;
			obj.transform.localScale = Vector3.one;
			qWStoryGraphActor.InitActor();
			data.actors.Add(charId, qWStoryGraphActor);
			return qWStoryGraphActor;
		}
		return null;
	}

	public void UnloadChar(int charId, bool lateClear = false)
	{
		if (data.actors.TryGetValue(charId, out var value))
		{
			value.OnClear();
			value.Dispose();
			UnityEngine.Object.Destroy(value.gameObject);
			Asset.Unload($"QWWorld/Chars/StoryActor/{charId}");
			if (!lateClear)
			{
				data.actors.Remove(charId);
			}
		}
	}

	public void PlayTalkSheet(int actorId, string cueSheet, string cueName, bool useStream = true)
	{
		if (!cueName.IsNotNullOrEmpty() || !cueSheet.IsNotNullOrEmpty())
		{
			return;
		}
		if (actorId != -1)
		{
			QWStoryGraphActor qWStoryGraphActor = LoadChar(actorId, needLoad: false);
			if (qWStoryGraphActor != null)
			{
				qWStoryGraphActor.PlayTalkSheet(cueSheet, cueName);
			}
			else
			{
				data._Playback = AudioManager.Instance.Play("voice", cueSheet, cueName, useStream);
			}
		}
		else
		{
			data._Playback = AudioManager.Instance.Play("voice", cueSheet, cueName, useStream);
		}
	}

	public void Agent_CameraControl(string cameraTag)
	{
		if (cameraDict.TryGetValue(cameraTag, out var value))
		{
			QWorldScene.Scene.cameraManager.CopyCameraParams(cameraContext[value].camera);
		}
	}

	public void Agent_PlayerPosControl(string pointTag)
	{
		if (pointDict.TryGetValue(pointTag, out var value))
		{
			data.hasStoryTeleport = true;
			QWorldScene.Scene.teleportManager.TeleportToCachePos(pointContext[value].point.position, pointContext[value].point.rotation);
		}
	}

	private void Update()
	{
		foreach (KeyValuePair<int, QWStoryGraphActor> actor in data.actors)
		{
			actor.Value.Tick();
		}
	}

	private void LateUpdate()
	{
		foreach (KeyValuePair<int, QWStoryGraphActor> actor in data.actors)
		{
			actor.Value.LateTick();
		}
	}

	public void PreStart(QWorldMapEntity target, int stroyType = 1, bool defaultLookAt = true)
	{
		QWorldScene.GetQWorldContext().IsInStory = true;
		QWorldLuaBridge.HideBubble();
		QWorldLuaBridge.HideHud(hide: true);
		QWorldLuaBridge.StopControl();
		if (stroyType == 2)
		{
			QWorldLuaBridge.PauseSceneDither(pause: true);
		}
		data.target = target;
		isDefaultLookAt = defaultLookAt;
		data.stroyType = stroyType;
		if (defaultLookAt)
		{
			ForwardToTarget(stroyType);
		}
		if (stroyType == 1)
		{
			if ((bool)data.target)
			{
				if (data.target.GetAgent().GetAgentLayer() == QWAgentLayer.NPC)
				{
					QWorldScene.Scene.Agent.CharacterBlackboard.characterCameraBehaviour.SwitchToStroyCamera(active: true, data.target.NPCBlackBoard.GetHead());
				}
				else
				{
					QWorldScene.Scene.Agent.CharacterBlackboard.characterCameraBehaviour.SwitchToStroyCamera(active: true, data.target.transform);
				}
			}
			else
			{
				QWorldScene.Scene.Agent.CharacterBlackboard.characterCameraBehaviour.SwitchToStroyCamera(active: true);
			}
		}
		QWorldLuaBridge.CloseUI();
	}

	public void PreStop()
	{
		QWorldScene scene = QWorldScene.Scene;
		scene.Agent.CharacterBlackboard.disableMoveInput = false;
		scene.Agent.CharacterBlackboard.disablePosition = false;
		QWorldLuaBridge.CullingAllDynamic(hideAll: false);
		QWorldLuaBridge.HideBubble(active: false);
		QWorldLuaBridge.HideHud(hide: false);
		QWorldLuaBridge.HidePlayer(hide: false);
		QWorldLuaBridge.StopControl(active: false);
		QWorldLuaBridge.CloseUI(active: false);
		if (data.stroyType == 2)
		{
			QWorldLuaBridge.PauseSceneDither(pause: false);
		}
		if (isDefaultLookAt && (bool)data.target)
		{
			QWorldMapEntity target = data.target;
			if (target != null && (bool)target.NPCBlackBoard)
			{
				target.NPCBlackBoard.disablePosition = false;
				QWRotateToForwardAction qWRotateToForwardAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.RotateToForward) as QWRotateToForwardAction;
				qWRotateToForwardAction.forward = target.NPCBlackBoard.defaultForward;
				target.NPCBlackBoard.ActionAdd(qWRotateToForwardAction);
				QWLookAtAction qWLookAtAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.LookAt) as QWLookAtAction;
				qWLookAtAction.lookAtTarget = null;
				target.BlackBoard.ActionAdd(qWLookAtAction);
			}
		}
		if (!data.hasStoryTeleport)
		{
			scene.Agent.CharacterBlackboard.characterCameraBehaviour.SwitchToStroyCamera(active: false);
		}
		else
		{
			scene.Agent.CharacterBlackboard.characterCameraBehaviour.SwitchToStroyCamera(active: false);
			QWorldScene.Scene.cameraManager.ForceToPlayerCamera();
		}
		QWorldScene.GetQWorldContext().IsInStory = false;
	}

	public void ClearOnNext()
	{
		if (data._Playback.status != CriAtomExPlayback.Status.Removed)
		{
			data._Playback.Stop();
			data._Playback = new CriAtomExPlayback(uint.MaxValue);
		}
		foreach (KeyValuePair<int, QWStoryGraphActor> actor in data.actors)
		{
			actor.Value.ClearOnNext();
		}
	}

	private void ForwardToTarget(int stroyType)
	{
		if ((bool)data.target)
		{
			QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
			Vector3 vector = (data.target.GetPosition() + qWorldScene.Agent.Position) / 2f - qWorldScene.Agent.Position;
			Vector3 normalized = new Vector3(vector.x, 0f, vector.z).normalized;
			qWorldScene.Agent.CharacterBlackboard.disableMoveInput = true;
			qWorldScene.Agent.CharacterBlackboard.disablePosition = true;
			if (Vector3.Angle(qWorldScene.Agent.transform.forward.normalized, normalized.normalized) > 5f)
			{
				QWRotateToForwardAction qWRotateToForwardAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.RotateToForward) as QWRotateToForwardAction;
				qWRotateToForwardAction.forward = normalized;
				qWorldScene.Agent.CharacterBlackboard.ActionAdd(qWRotateToForwardAction);
			}
			QWorldMapEntity target = data.target;
			if (target != null && (bool)target.NPCBlackBoard && Vector3.Angle(target.transform.forward.normalized, (-normalized).normalized) > 5f)
			{
				target.NPCBlackBoard.disablePosition = true;
				QWRotateToForwardAction qWRotateToForwardAction2 = QWAgentActionFactory.Create(QWAgentAction.E_Type.RotateToForward) as QWRotateToForwardAction;
				qWRotateToForwardAction2.forward = -normalized;
				target.NPCBlackBoard.ActionAdd(qWRotateToForwardAction2);
				QWLookAtAction qWLookAtAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.LookAt) as QWLookAtAction;
				qWLookAtAction.lookAtTarget = qWorldScene.Agent.CharacterBlackboard.characterCameraBehaviour.LookAtPoint;
				target.BlackBoard.ActionAdd(qWLookAtAction);
			}
		}
	}

	private void OnCameraValueChange()
	{
		for (int i = 0; i < cameraContext.Count; i++)
		{
			CameraContext value = cameraContext[i];
			value.parent = this;
			cameraContext[i] = value;
		}
	}

	public void Dispose()
	{
		if (data.cameraTweenId != -1)
		{
			LeanTween.cancel(data.cameraTweenId);
			data.cameraTweenId = -1;
		}
		if (data.brain != null)
		{
			data.brain.m_DefaultBlend = data.oldBlend;
		}
		foreach (KeyValuePair<int, QWStoryGraphActor> actor in data.actors)
		{
			UnloadChar(actor.Key, lateClear: true);
		}
		data.actors.Clear();
		data.cameraShakeComp?.Dispose();
		data.cameraShakeComp = null;
	}
}
