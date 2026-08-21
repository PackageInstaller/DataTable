using System;
using System.Collections.Generic;
using Cinemachine;
using Cinemachine.Utility;
using Config;
using UnityEngine;

public class LockTargetCinemachine : MonoBehaviour
{
	[NonSerialized]
	[HideInInspector]
	public bool hasManualLock;

	public Transform lookAt;

	[Tooltip("锁定时间")]
	public float lockTime;

	[NonSerialized]
	[HideInInspector]
	public float lockFineshTime;

	[NonSerialized]
	[HideInInspector]
	public bool isLockAPoint;

	[NonSerialized]
	[HideInInspector]
	public Vector3 targetPoint;

	private GameObject targetPointGo;

	private float runningLockTimeCount;

	private CinemachineBrain brain;

	public float softZoneDefault = 0.1463052f;

	public float deadZoneDefault = 0.07126439f;

	public float softYZoneDefault;

	public float deadYZoneDefault;

	public float screenYDefault = 0.55f;

	public float radiusDefault = 8f;

	public float heightDefault = 3f;

	public float biasXDefault;

	public float biasYDefault;

	public float horizontalDamping = 12f;

	public float verticalDamping = 10f;

	[NonSerialized]
	[HideInInspector]
	public float curHeight = 3f;

	public float minHeightDefault = 1f;

	public float maxHeightDefault = 6f;

	[NonSerialized]
	[HideInInspector]
	public float curRadius = 8f;

	public float minRadiusDefault = 13f;

	public float maxRadiusDefault = 19f;

	public float softZoneLock = 0.016f;

	public float deadZoneLock = 0.016f;

	public float softYZoneLock;

	public float deadYZoneLock;

	public float radiusLock = 10f;

	public float heightLock = 3.6f;

	public float screenYLock = 0.45f;

	public float biasXLock;

	public float biasYLock;

	public float horizontalDampingLock = 12f;

	public float verticalDampingLock = 10f;

	public float followCameraLock = 3.6f;

	private Camera mainCamera;

	private CameraParamComponent paramComponent;

	public Action<int> OnLockTargetUpdate;

	[NonSerialized]
	[HideInInspector]
	public int agentID;

	public Transform target;

	public float changeDistance = 8f;

	public float farMaxAngle = 20f;

	public float nearMaxAngle = 150f;

	public float damping = 1.5f;

	public float startHeight = 5f;

	public float minHeight = 0.5f;

	public float lookatDisWithFollow = 5f;

	public float lookatDamping = 0.4f;

	public bool dirty;

	public bool banCameraCtrlUI;

	public bool useNewSmooth;

	public Dictionary<int, List<CameraDampingClip>> runningCameraDampingClip = new Dictionary<int, List<CameraDampingClip>>(new IntComparer());

	private Stack<CameraDampingClip> cameraDampingClipPool = new Stack<CameraDampingClip>();

	public float originDamping = 1.5f;

	public float originLookatDamping = 0.4f;

	public float originLookatDisWithFollow = 5f;

	[NonSerialized]
	[HideInInspector]
	public List<int> playerList;

	private void Awake()
	{
		if (lookAt != null)
		{
			lookAt.parent = null;
			lookAt.rotation = Quaternion.identity;
		}
	}

	private void OnDestroy()
	{
		if (lookAt != null)
		{
			UnityEngine.Object.Destroy(lookAt.gameObject);
		}
	}

	private void OnEnable()
	{
		if (paramComponent == null)
		{
			paramComponent = base.gameObject.GetComponent<CameraParamComponent>();
		}
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		brain = mainCamera.GetComponent<CinemachineBrain>();
	}

	private void OnDisable()
	{
	}

	private void Update()
	{
		if (paramComponent.virtualCamera == null || paramComponent.virtualCamera.Follow == null || paramComponent.targetGroup == null || lookAt == null)
		{
			return;
		}
		CinemachineTargetGroup targetGroup = paramComponent.targetGroup;
		int num = -1;
		for (int num2 = targetGroup.m_Targets.Length - 1; num2 > 0; num2--)
		{
			if (targetGroup.m_Targets[num2].target == target && target != null)
			{
				targetGroup.m_Targets[num2].target = target;
				num = num2;
			}
			else
			{
				targetGroup.m_Targets[num2].weight = Mathf.Lerp(targetGroup.m_Targets[num2].weight, 0f, lookatDamping);
				if (targetGroup.m_Targets[num2].weight <= 0.0001f)
				{
					targetGroup.RemoveMember(targetGroup.m_Targets[num2].target);
					num--;
				}
			}
		}
		if (target != null && (targetPointGo == null || target != targetPointGo.transform))
		{
			if (num < 0)
			{
				targetGroup.AddMember(target, 0f, 0f);
				num = targetGroup.m_Targets.Length - 1;
			}
			float initial = 1f - targetGroup.m_Targets[num].weight;
			targetGroup.m_Targets[num].weight += Damper.Damp(initial, damping, Time.deltaTime);
		}
		targetGroup.m_Targets[0].weight = 1f;
		if (isLockAPoint)
		{
			if (targetPointGo == null)
			{
				targetPointGo = new GameObject();
			}
			targetPointGo.transform.position = targetPoint;
			target = targetPointGo.transform;
			Vector3 initial2 = targetGroup.m_Targets[0].target.position - lookAt.position;
			lookAt.position += Damper.Damp(initial2, lookatDamping, Time.deltaTime);
			return;
		}
		if (targetPointGo != null && target == targetPointGo.transform)
		{
			target = null;
		}
		Vector3 vector = targetGroup.transform.position;
		Vector3 vector2 = vector - targetGroup.m_Targets[0].target.position;
		if (vector2.magnitude > lookatDisWithFollow)
		{
			vector2 = vector2.normalized * lookatDisWithFollow;
			vector = targetGroup.m_Targets[0].target.position + vector2;
		}
		Vector3 initial3 = vector - lookAt.position;
		if (useNewSmooth)
		{
			if (initial3.magnitude > lookatDisWithFollow)
			{
				Debug.Log("===>>> " + initial3.magnitude + ", " + lookatDisWithFollow);
				initial3 = initial3.normalized * lookatDisWithFollow;
				lookAt.position = vector - initial3;
			}
			else
			{
				lookAt.position += Damper.Damp(initial3, lookatDamping, Time.deltaTime);
			}
		}
		else
		{
			lookAt.position += Damper.Damp(initial3, lookatDamping, Time.deltaTime);
		}
	}

	public void LateUpdate()
	{
		if (brain == null)
		{
			brain = mainCamera.gameObject.GetComponent<CinemachineBrain>();
		}
		if ((!(brain != null) || brain.ActiveVirtualCamera == paramComponent.virtualCamera) && !(target == null))
		{
			if (!hasManualLock)
			{
				runningLockTimeCount += Time.deltaTime;
			}
			if (runningLockTimeCount > lockTime || (isLockAPoint && runningLockTimeCount > damping))
			{
				SetLoseTarget();
			}
			else
			{
				Roate();
			}
		}
	}

	public bool SetLoseTarget()
	{
		target = null;
		agentID = 0;
		hasManualLock = false;
		runningLockTimeCount = lockTime + 1f;
		OnResetClipData();
		isLockAPoint = false;
		ApplyCameraParam();
		banCameraCtrlUI = false;
		if (OnLockTargetUpdate != null)
		{
			OnLockTargetUpdate(0);
		}
		return true;
	}

	public bool ResetLockTime()
	{
		runningLockTimeCount = 0f;
		return true;
	}

	public void ApplyCameraParam()
	{
		CameraParam currentCameraParam = paramComponent.GetCurrentCameraParam();
		if (agentID == 0)
		{
			currentCameraParam.deadZoneWidth = deadZoneDefault;
			currentCameraParam.softZoneWidth = softZoneDefault;
			currentCameraParam.deadZoneHeight = deadYZoneDefault;
			currentCameraParam.softZoneHeight = softYZoneDefault;
			currentCameraParam.radius = curRadius;
			currentCameraParam.height = curHeight;
			currentCameraParam.screenY = screenYDefault;
			paramComponent.composer.m_BiasX = biasXDefault;
			paramComponent.composer.m_BiasY = biasYDefault;
			paramComponent.composer.m_HorizontalDamping = horizontalDamping;
			paramComponent.composer.m_VerticalDamping = verticalDamping;
			paramComponent.SetCameraParam(currentCameraParam, lookatDamping);
		}
		else
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentID);
			if (agent == null)
			{
				return;
			}
			if (!dirty && ConfigHelper.GetInstance().TryGetConfig<LockedCameraParam>(agent.AgentConfigID, out var config))
			{
				currentCameraParam.deadZoneWidth = deadZoneLock;
				currentCameraParam.softZoneWidth = softZoneLock;
				currentCameraParam.deadZoneHeight = deadYZoneLock;
				currentCameraParam.softZoneHeight = softYZoneLock;
				currentCameraParam.radius = config.LockRadius;
				currentCameraParam.height = config.LockHeight;
				currentCameraParam.screenY = config.ScreenY;
				heightLock = config.LockHeight;
			}
			else
			{
				heightLock = followCameraLock;
				currentCameraParam.deadZoneWidth = deadZoneLock;
				currentCameraParam.softZoneWidth = softZoneLock;
				currentCameraParam.deadZoneHeight = deadYZoneLock;
				currentCameraParam.softZoneHeight = softYZoneLock;
				currentCameraParam.radius = radiusLock;
				currentCameraParam.height = heightLock;
				currentCameraParam.screenY = screenYLock;
			}
			curRadius = radiusDefault;
			curHeight = heightDefault;
			paramComponent.composer.m_BiasX = biasXLock;
			paramComponent.composer.m_BiasY = biasYLock;
			paramComponent.composer.m_HorizontalDamping = horizontalDampingLock;
			paramComponent.composer.m_VerticalDamping = verticalDampingLock;
		}
		paramComponent.SetCameraParam(currentCameraParam, damping);
	}

	public void SetTargetAgent(int agentID)
	{
		if (this.agentID == agentID && IsLocking())
		{
			lockFineshTime = 0f;
			runningLockTimeCount = 0.001f;
			return;
		}
		this.agentID = agentID;
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null || battleScene.GetTimelineAndHitCache() == null)
		{
			return;
		}
		NAgent agent = agentManager.GetAgent(agentID);
		if (!(agent == null))
		{
			target = agent.AttachPointSetup.GetAttachPoint(En_BaseAttachPointType.HitPoint);
			isLockAPoint = false;
			ApplyCameraParam();
			runningLockTimeCount = 0.001f;
			if (OnLockTargetUpdate != null)
			{
				OnLockTargetUpdate(agentID);
			}
		}
	}

	public int GetTargetAgent()
	{
		return agentID;
	}

	public bool IsLocking()
	{
		if (!(target != null))
		{
			return isLockAPoint;
		}
		return true;
	}

	private void Roate()
	{
		if (!(paramComponent.virtualCamera == null) && !(paramComponent.virtualCamera.Follow == null) && !(paramComponent.targetGroup == null) && !(target == null))
		{
			Vector3 position = paramComponent.targetGroup.m_Targets[0].target.position;
			Vector3 position2 = target.position;
			Vector3 vector = (position - Camera.main.transform.position).NewY(0f);
			Vector3 to = (position2 - position).NewY(0f);
			float num = Vector3.SignedAngle(vector, to, Vector3.up);
			float num2 = Mathf.Abs(num);
			float num3 = Vector3.Distance(position, position2);
			float num4 = ((!(num3 >= changeDistance)) ? Mathf.Lerp(farMaxAngle, nearMaxAngle, (changeDistance - num3) / changeDistance) : farMaxAngle);
			if (isLockAPoint)
			{
				num4 = 10f;
			}
			float num5 = 0f;
			if (num2 > num4)
			{
				num5 = num2 - num4;
				num5 = ((num > 0f) ? num5 : (0f - num5));
			}
			else
			{
				num5 = 0f;
			}
			float dampTime = damping;
			if (num5 != 0f)
			{
				dampTime = Mathf.Lerp(0f, damping, num3 / changeDistance);
			}
			if (damping > 0f)
			{
				num5 = Damper.Damp(num5, dampTime, Time.deltaTime);
			}
			paramComponent.transposer.m_XAxis.Value += num5;
			if (position2.y - position.y > startHeight)
			{
				float num6 = Vector3.Distance(base.transform.position, position) / Mathf.Max(1f, num3);
				float num7 = Mathf.Clamp((position.y - position2.y + startHeight) * num6 + heightLock, minHeight, startHeight);
				Vector3 followOffset = paramComponent.transposer.m_FollowOffset;
				followOffset.y += Damper.Damp(num7 - followOffset.y, dampTime, Time.deltaTime);
				paramComponent.transposer.m_FollowOffset = followOffset;
			}
			else
			{
				Vector3 followOffset2 = paramComponent.transposer.m_FollowOffset;
				followOffset2.y += Damper.Damp(heightLock - followOffset2.y, dampTime, Time.deltaTime);
				paramComponent.transposer.m_FollowOffset = followOffset2;
			}
		}
	}

	public CameraDampingClip GetCameraDampingClip()
	{
		if (cameraDampingClipPool.Count > 0)
		{
			return cameraDampingClipPool.Pop();
		}
		return new CameraDampingClip();
	}

	public void ReturnCameraDampingClip(CameraDampingClip clip)
	{
		if (clip != null)
		{
			cameraDampingClipPool.Push(clip);
		}
	}

	public void AddCameraDampingClip(int agentID, CameraDampingClip clip)
	{
		if (!runningCameraDampingClip.ContainsKey(agentID))
		{
			runningCameraDampingClip.Add(agentID, new List<CameraDampingClip>());
		}
		runningCameraDampingClip[agentID].Add(clip);
		if (playerList == null)
		{
			playerList = AgentManager.GetAgentManager().mPlayerList;
		}
	}

	public void RemoveCameraDampingClip(int agent, CameraDampingClip clip)
	{
		if (!runningCameraDampingClip.ContainsKey(agent))
		{
			return;
		}
		List<CameraDampingClip> list = runningCameraDampingClip[agent];
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].Equals(clip))
			{
				list.RemoveAt(i);
				break;
			}
		}
		if (list.Count == 0)
		{
			runningCameraDampingClip.Remove(agent);
		}
	}

	public CameraDampingClip UpdateCameraDamping(int TargetAgent)
	{
		CameraDampingClip cameraDampingClip = null;
		if (playerList == null)
		{
			playerList = AgentManager.GetAgentManager().mPlayerList;
		}
		if ((TargetAgent != agentID && !playerList.Contains(TargetAgent)) || !runningCameraDampingClip.ContainsKey(TargetAgent))
		{
			return cameraDampingClip;
		}
		foreach (CameraDampingClip item in runningCameraDampingClip[TargetAgent])
		{
			if (cameraDampingClip == null)
			{
				cameraDampingClip = item;
			}
			else if (cameraDampingClip.priority < item.priority)
			{
				cameraDampingClip = item;
			}
		}
		return cameraDampingClip;
	}

	public void OnResetClipData()
	{
		damping = originDamping;
		lookatDamping = originLookatDamping;
		lookatDisWithFollow = originLookatDisWithFollow;
	}
}
