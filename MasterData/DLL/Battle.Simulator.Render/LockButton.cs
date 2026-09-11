using System.Collections.Generic;
using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class LockButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerExitHandler, IBattleUIElement
{
	public float pressTime;

	public float maxPressTime = 1f;

	public float resetLockHistoryTime = 5f;

	public Image bgImage;

	private bool isValid;

	private bool isPressing;

	private LockTargetCinemachine targetCinemachine;

	private WorldStateManager worldStateManager;

	private LockLimitParam m_config;

	private float maxDistance = 400000f;

	private Camera mainCamera;

	private static List<int> hasLockedTargets = new List<int>();

	private static float clearLockedTargetsFrameCount = 0f;

	public P08UISwitch uiSwitch { get; set; }

	public void SetActive(bool isActive, BattleUIElementActiveChangeReason reason)
	{
		uiSwitch.SetActive(isActive, reason);
	}

	private void SwitchLogicOnAwake()
	{
		if (uiSwitch == null)
		{
			uiSwitch = new P08UISwitch();
			uiSwitch.gameObject = base.gameObject;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		pressTime = 0f;
		isPressing = true;
		isValid = true;
	}

	private void Awake()
	{
		if (bgImage == null)
		{
			bgImage = GetComponent<Image>();
		}
		SwitchLogicOnAwake();
	}

	private void Update()
	{
		if (worldStateManager == null)
		{
			worldStateManager = WorldStateManager.GetWorldStateManager();
			return;
		}
		if (worldStateManager.lockType == LockType.lockNearest)
		{
			SetActive(isActive: false, BattleUIElementActiveChangeReason.SystemSetting);
			if (targetCinemachine != null && targetCinemachine.hasManualLock)
			{
				targetCinemachine.SetLoseTarget();
			}
			if (worldStateManager.hasManualLock)
			{
				worldStateManager.hasManualLock = false;
				worldStateManager.lockedAgentID = 0;
			}
			return;
		}
		if (isPressing)
		{
			pressTime += Time.deltaTime;
			if (pressTime > maxPressTime)
			{
				isPressing = false;
				PointerUp();
			}
		}
		if (worldStateManager != null && bgImage != null)
		{
			if (worldStateManager.hasManualLock && !bgImage.enabled)
			{
				bgImage.enabled = true;
			}
			else if (!worldStateManager.hasManualLock && bgImage.enabled)
			{
				bgImage.enabled = false;
			}
		}
		else if (bgImage != null && bgImage.enabled)
		{
			bgImage.enabled = false;
		}
		if (worldStateManager == null || !worldStateManager.hasManualLock)
		{
			return;
		}
		clearLockedTargetsFrameCount += Time.deltaTime;
		if (clearLockedTargetsFrameCount >= resetLockHistoryTime)
		{
			clearLockedTargetsFrameCount = 0f;
			if (hasLockedTargets.Count > 1)
			{
				int item = hasLockedTargets[hasLockedTargets.Count - 1];
				hasLockedTargets.Clear();
				hasLockedTargets.Add(item);
			}
		}
	}

	public static void LockAgent(NAgent playerAgent, int targetAgentID, LockTargetCinemachine targetCinemachine, int shapeID)
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager == null || worldStateManager.lockType == LockType.lockNearest)
		{
			return;
		}
		ChooseTargetCommand chooseTargetCommand = CommandFactory.Create(NetprotoOperationCode.CmdChooseTarget) as ChooseTargetCommand;
		chooseTargetCommand.SetData(playerAgent.AgentID, shapeID, -1);
		targetCinemachine.lockFineshTime = 0.4f;
		ClientSimulator.Instance.SendLocalCommand(chooseTargetCommand);
		targetCinemachine.hasManualLock = true;
		targetCinemachine.ResetLockTime();
		targetCinemachine.SetTargetAgent(targetAgentID);
		NAgent agent = AgentManager.GetAgentManager().GetAgent(targetAgentID);
		if (agent == null)
		{
			return;
		}
		BBHumanoid obj = agent.Blackboard as BBHumanoid;
		int lockedAgentPart = 0;
		foreach (ShapeState mShapeState in obj.m_NextSimFrameData.mShapeStates)
		{
			if (mShapeState.mShapeEntityID == shapeID)
			{
				lockedAgentPart = (int)mShapeState.mPartType;
			}
		}
		worldStateManager.hasManualLock = true;
		worldStateManager.lockedAgentID = targetAgentID;
		worldStateManager.lockedAgentPart = lockedAgentPart;
		worldStateManager.lockedTime = 0f;
		hasLockedTargets.Add(shapeID);
		clearLockedTargetsFrameCount = 0f;
		if (worldStateManager.lockTargetEvent != null)
		{
			worldStateManager.lockTargetEvent(targetAgentID);
		}
	}

	private int LockNext(NAgent playerAgent, out int shapeID)
	{
		shapeID = 0;
		if (playerAgent == null)
		{
			return 0;
		}
		int num = 0;
		int num2 = 0;
		AIProcessor.E_Direction e_Direction = AIProcessor.E_Direction.Backward;
		float num3 = float.MaxValue;
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return 0;
		}
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager == null)
		{
			return 0;
		}
		Dictionary<int, NAgent>.Enumerator enumerator = agentManager.mAgentsCreatedThisFrame.GetEnumerator();
		uint interestCamp = RoleCampProcessor.GetInterestCamp(playerAgent.Camp);
		while (enumerator.MoveNext())
		{
			BBHumanoid bBHumanoid = enumerator.Current.Value.Blackboard as BBHumanoid;
			if (bBHumanoid == null || bBHumanoid.m_NextSimFrameData.mCantBeLocked || bBHumanoid.HP <= 0 || bBHumanoid.m_NextSimFrameData.mIsHide != E_EntityHideType.None || (interestCamp & enumerator.Current.Value.Camp) == 0)
			{
				continue;
			}
			int mBeLockedPriority = bBHumanoid.m_NextSimFrameData.mBeLockedPriority;
			if (mainCamera == null)
			{
				mainCamera = Camera.main;
			}
			for (int i = 0; i < bBHumanoid.m_NextSimFrameData.mShapeStates.Count; i++)
			{
				ShapeState shapeState = bBHumanoid.m_NextSimFrameData.mShapeStates[i];
				if ((enumerator.Current.Key == worldStateManager.lockedAgentID && shapeState.mPartType == (ShapePartType)worldStateManager.lockedAgentPart) || hasLockedTargets.Contains(shapeState.mShapeEntityID))
				{
					continue;
				}
				AIProcessor.E_Direction e_Direction2 = ((!(Vector3.Dot(mainCamera.transform.forward, (Vector3)shapeState.mWorldPos - mainCamera.transform.position) > 0f)) ? AIProcessor.E_Direction.Backward : AIProcessor.E_Direction.Forward);
				float sqrMagnitude = ((Vector3)shapeState.mWorldPos - playerAgent.transform.position).sqrMagnitude;
				if (sqrMagnitude > maxDistance)
				{
					continue;
				}
				if (num2 < mBeLockedPriority)
				{
					num = enumerator.Current.Key;
					num2 = mBeLockedPriority;
					e_Direction = e_Direction2;
					num3 = sqrMagnitude;
					shapeID = shapeState.mShapeEntityID;
				}
				else if (num2 == mBeLockedPriority)
				{
					if (e_Direction2 == AIProcessor.E_Direction.Forward && e_Direction == AIProcessor.E_Direction.Backward)
					{
						num = enumerator.Current.Key;
						num2 = mBeLockedPriority;
						e_Direction = e_Direction2;
						num3 = sqrMagnitude;
						shapeID = shapeState.mShapeEntityID;
					}
					else if (e_Direction2 == e_Direction && sqrMagnitude < num3)
					{
						num = enumerator.Current.Key;
						num2 = mBeLockedPriority;
						e_Direction = e_Direction2;
						num3 = sqrMagnitude;
						shapeID = shapeState.mShapeEntityID;
					}
				}
			}
		}
		if (num == 0 && hasLockedTargets.Count > 0)
		{
			hasLockedTargets.Clear();
			num = LockNext(playerAgent, out shapeID);
		}
		return num;
	}

	private void PointerUp()
	{
		if (targetCinemachine == null)
		{
			targetCinemachine = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.gameObject.GetComponent<LockTargetCinemachine>();
		}
		if (this.worldStateManager == null)
		{
			this.worldStateManager = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager();
		}
		if (targetCinemachine == null || this.worldStateManager == null)
		{
			return;
		}
		if (m_config == null)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager == null)
			{
				return;
			}
			if (!ConfigHelper.GetInstance().TryGetConfig<LockLimitParam>(agentManager.GetPlayerAgent().AgentConfigID, out var config))
			{
				config = ConfigHelper.GetInstance().GetConfig<LockLimitParam>(0);
			}
			m_config = config;
			maxDistance = (float)m_config.LockFarestDistance * (float)m_config.LockFarestDistance / 1000000f;
		}
		if (pressTime > maxPressTime)
		{
			if (targetCinemachine.hasManualLock)
			{
				targetCinemachine.SetLoseTarget();
			}
			if (this.worldStateManager.hasManualLock)
			{
				this.worldStateManager.hasManualLock = false;
				this.worldStateManager.lockedAgentID = 0;
			}
			return;
		}
		int lockedAgentID = this.worldStateManager.lockedAgentID;
		if (lockedAgentID == 0)
		{
			hasLockedTargets.Clear();
		}
		AgentManager agentManager2 = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager2 == null)
		{
			return;
		}
		NAgent playerAgent = agentManager2.GetPlayerAgent();
		if (playerAgent == null)
		{
			return;
		}
		NAgent agent = agentManager2.GetAgent(lockedAgentID);
		if (agent != null && (agent.Blackboard as BBHumanoid).HP > 0 && !targetCinemachine.hasManualLock)
		{
			hasLockedTargets.Clear();
			int shapeID = lockedAgentID;
			BBHumanoid obj = agent.Blackboard as BBHumanoid;
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			foreach (ShapeState mShapeState in obj.m_NextSimFrameData.mShapeStates)
			{
				if (mShapeState.mPartType == (ShapePartType)worldStateManager.lockedAgentPart && ((Vector3)mShapeState.mWorldPos - playerAgent.transform.position).sqrMagnitude <= maxDistance)
				{
					shapeID = mShapeState.mShapeEntityID;
				}
			}
			LockAgent(playerAgent, lockedAgentID, targetCinemachine, shapeID);
		}
		else
		{
			lockedAgentID = LockNext(playerAgent, out var shapeID2);
			if (lockedAgentID != 0)
			{
				LockAgent(playerAgent, lockedAgentID, targetCinemachine, shapeID2);
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (isValid)
		{
			PointerUp();
			isPressing = false;
			isValid = false;
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		isPressing = false;
		isValid = false;
	}
}
