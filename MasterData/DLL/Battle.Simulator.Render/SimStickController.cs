using System;
using System.Collections.Generic;
using NetProcol;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class SimStickController : MonoBehaviour
{
	public int PressFinger = -1;

	public EStickType StickType;

	public bool keyBoard = true;

	public RectTransform thumbPosition;

	public RectTransform areaRect;

	public RectTransform touchAreaRect;

	public Camera mainCamera;

	public int JoystickIndex = 1;

	private PointerEventData eventData;

	private List<RaycastResult> listRaycastResult = new List<RaycastResult>();

	private GraphicRaycaster graphicRaycaster;

	private int mLastSimTimeSacle = 1;

	private int mPauseTime;

	private Action<Vector3, int> updateFunc;

	public Func<Vector3, bool> validPosFunc;

	protected float _followRange;

	protected Vector3 _firstPos = Vector3.zero;

	public int preMoveDirection = int.MaxValue;

	public int preCameraDirection = int.MaxValue;

	private int preCameraViewDirection;

	public bool PreControlEnable = true;

	public int ConfirmDirSndFrame;

	public int FixtimeDirSndFrame;

	private Vector3 lastInputDirection = Vector3.zero;

	private NAgent player;

	private Vector3 worldForward = Vector3.forward;

	private void Start()
	{
		SetStickModule(UpdateThumb, InArea);
		mainCamera = CanvasManager.Instance.uiCamera;
		eventData = new PointerEventData(EventSystem.current);
		graphicRaycaster = GameObject.Find("UICamera/Canvas").GetComponent<GraphicRaycaster>();
	}

	private void Update()
	{
		if (updateFunc != null)
		{
			UpdateTouchPos(updateFunc);
		}
	}

	protected Vector3 TransformPos(Vector3 pressPos)
	{
		Vector2 localPoint = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(areaRect, new Vector2(pressPos.x, pressPos.y), mainCamera, out localPoint);
		return new Vector3(localPoint.x, localPoint.y);
	}

	protected virtual bool InArea(Vector3 pos)
	{
		if (null == touchAreaRect)
		{
			return false;
		}
		listRaycastResult.Clear();
		eventData.pressPosition = pos;
		eventData.position = pos;
		graphicRaycaster.Raycast(eventData, listRaycastResult);
		if (listRaycastResult.Count > 0)
		{
			return false;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(touchAreaRect, pos, mainCamera, out var localPoint);
		if (localPoint.x > -1f * touchAreaRect.sizeDelta.x / 2f && localPoint.x < touchAreaRect.sizeDelta.x / 2f && localPoint.y > -1f * touchAreaRect.sizeDelta.y / 2f)
		{
			return localPoint.y < touchAreaRect.sizeDelta.y / 2f;
		}
		return false;
	}

	protected virtual void UpdateTouchPos(Action<Vector3, int> updateFunc)
	{
		bool flag = false;
		float x = 0f;
		float y = 0f;
		if (keyBoard)
		{
			if (Input.GetKeyDown(KeyCode.P))
			{
				if (mPauseTime % 2 == 0)
				{
					mLastSimTimeSacle = ClientSimulator.Instance.SimTimeScale;
					ClientSimulator.Instance.SimTimeScale = 0;
				}
				else
				{
					ClientSimulator.Instance.SimTimeScale = mLastSimTimeSacle;
				}
				mPauseTime++;
			}
			if (Input.GetKey(KeyCode.A))
			{
				flag = true;
				x = -1f;
			}
			else if (Input.GetKey(KeyCode.D))
			{
				flag = true;
				x = 1f;
			}
			if (Input.GetKey(KeyCode.W))
			{
				flag = true;
				y = 1f;
			}
			else if (Input.GetKey(KeyCode.S))
			{
				flag = true;
				y = -1f;
			}
			if (Input.GetAxis("LeftJoystickX") == -1f)
			{
				flag = true;
				x = -1f;
			}
			else if (Input.GetAxis("LeftJoystickX") == 1f)
			{
				flag = true;
				x = 1f;
			}
			if (Input.GetAxis("LeftJoystickY") == 1f)
			{
				flag = true;
				y = -1f;
			}
			else if (Input.GetAxis("LeftJoystickY") == -1f)
			{
				flag = true;
				y = 1f;
			}
		}
		if (flag)
		{
			Vector3 normalized = new Vector3(x, y, 0f).normalized;
			updateFunc?.Invoke(normalized, -2);
			return;
		}
		if (!Input.GetMouseButton(0))
		{
			updateFunc?.Invoke(Vector3.zero, -1);
			return;
		}
		Vector3 mousePosition = Input.mousePosition;
		if (updateFunc != null)
		{
			if (PressFinger < 0 && CheckFingerValid(base.gameObject, JoystickIndex) && validPosFunc != null && validPosFunc(mousePosition))
			{
				updateFunc(TransformPos(mousePosition), JoystickIndex);
			}
			else if (PressFinger >= 0 && CheckFingerValid(base.gameObject, JoystickIndex))
			{
				updateFunc(TransformPos(mousePosition), JoystickIndex);
			}
			else
			{
				updateFunc(Vector3.zero, -1);
			}
		}
	}

	protected static bool CheckFingerValid(GameObject self, int fingerID)
	{
		GameObject value = null;
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (worldSatetManager != null)
			{
				if (worldSatetManager.PressingFingers.TryGetValue(fingerID, out value) && value != self)
				{
					return false;
				}
				return true;
			}
		}
		return false;
	}

	protected static void SetPressingFinger(GameObject self, int current, int fingerID)
	{
		if (current == fingerID)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene != null))
		{
			return;
		}
		WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
		if (worldSatetManager != null)
		{
			if (worldSatetManager.PressingFingers.ContainsKey(current))
			{
				worldSatetManager.PressingFingers.Remove(current);
			}
			if (-1 != fingerID)
			{
				worldSatetManager.PressingFingers[fingerID] = self;
			}
		}
	}

	public virtual void UpdateThumb(Vector3 pressPos, int fingerId)
	{
		SetPressingFinger(base.gameObject, PressFinger, fingerId);
		PressFinger = fingerId;
		switch (fingerId)
		{
		case -2:
			SetOutput(pressPos.x, pressPos.y, 0);
			return;
		case -1:
			SetOutput(0f, 0f, fingerId);
			return;
		}
		Vector3 vector = pressPos - areaRect.localPosition;
		vector.z = 0f;
		float magnitude = vector.magnitude;
		if (magnitude > 50f)
		{
			Vector3 vector2 = vector.normalized * 50f;
			Vector3 vector3 = pressPos - vector2;
			Vector3 vector4 = vector3 - _firstPos;
			if (vector4.magnitude > 0f)
			{
				vector3 = _firstPos + vector4 * (_followRange / vector4.magnitude);
			}
			areaRect.localPosition = vector3;
			thumbPosition.localPosition = vector2;
			SetOutput(vector.x / magnitude, vector.y / magnitude, fingerId);
		}
		else
		{
			thumbPosition.localPosition = pressPos - areaRect.localPosition;
			SetOutput(vector.x / 50f, vector.y / 50f, fingerId);
		}
	}

	public void SendStopMove(NAgent player, bool force = false)
	{
		if ((preMoveDirection != int.MaxValue) | force)
		{
			preMoveDirection = int.MaxValue;
			ConfirmDirSndFrame = Time.frameCount;
			FixtimeDirSndFrame = 0;
			MoveDirectionStopCommand moveDirectionStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdStopMoveDir) as MoveDirectionStopCommand;
			moveDirectionStopCommand.SetData(player.AgentID);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionStopCommand);
		}
		lastInputDirection = Vector3.zero;
	}

	public void SendMoveDirection(NAgent player, Int3 lhs)
	{
		FixtimeDirSndFrame++;
		if (lhs != Int3.zero)
		{
			int i = IntMath.AngleOfVector(lhs).i;
			int num = i - preMoveDirection;
			bool flag = (!PreControlEnable && PreControlEnable != player.IsCanControl) || player.IsNeedForceControl;
			PreControlEnable = player.IsCanControl;
			if ((num > 1 || num < -1 || FixtimeDirSndFrame > 30) | flag)
			{
				SendMoveDirection(player, i);
			}
		}
	}

	private void SendMoveDirection(NAgent player, int moveDegree)
	{
		preMoveDirection = moveDegree;
		ConfirmDirSndFrame = Time.frameCount;
		FixtimeDirSndFrame = 0;
		if (StickType == EStickType.Movement)
		{
			MoveDirectionCommand moveDirectionCommand = CommandFactory.Create(NetprotoOperationCode.CmdMoveDir) as MoveDirectionCommand;
			moveDirectionCommand.SetData(player.AgentID, moveDegree, EMoveDirectionMode.Lookat);
			ClientSimulator.Instance.SendLocalCommand(moveDirectionCommand);
		}
		else if (EStickType.Direction == StickType)
		{
			AbilityDirectionCommand abilityDirectionCommand = CommandFactory.Create(NetprotoOperationCode.CmdAbilityDirection) as AbilityDirectionCommand;
			abilityDirectionCommand.SetData(player.AgentID, moveDegree);
			ClientSimulator.Instance.SendLocalCommand(abilityDirectionCommand);
		}
	}

	private void SetOutput(float hrz, float vtc, int fingerId)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene)
		{
			return;
		}
		NAgent playerAgent = battleScene.GetAgentManager().GetPlayerAgent();
		if (playerAgent == null)
		{
			return;
		}
		PressFinger = fingerId;
		Vector3 vector = new Vector3(hrz, 0f, vtc);
		if (vector.sqrMagnitude <= Mathf.Epsilon)
		{
			areaRect.localPosition = Vector3.zero;
			thumbPosition.localPosition = Vector3.zero;
			SendStopMove(playerAgent);
			return;
		}
		Vector3 forward = Camera.main.transform.forward;
		forward.y = 0f;
		Vector3 vector2 = Quaternion.LookRotation(forward.normalized) * vector;
		if (fingerId >= 0)
		{
			Int3 @int = (Int3)vector2;
			if (@int == Int3.zero)
			{
				SendStopMove(playerAgent);
			}
			else
			{
				SendMoveDirection(playerAgent, @int);
			}
		}
		else
		{
			areaRect.localPosition = Vector3.zero;
			thumbPosition.localPosition = Vector3.zero;
			SendStopMove(playerAgent);
		}
	}

	public void SetStickModule(Action<Vector3, int> updateFunc, Func<Vector3, bool> validPosFunc)
	{
		this.updateFunc = updateFunc;
		this.validPosFunc = validPosFunc;
	}

	public void ClearStickFunc()
	{
		updateFunc = null;
		validPosFunc = null;
	}

	private void OnDestroy()
	{
		ClearStickFunc();
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && battleScene.GetBattleSimulatorSystem() != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (worldSatetManager != null && worldSatetManager.PressingFingers.ContainsKey(PressFinger))
			{
				worldSatetManager.PressingFingers.Remove(PressFinger);
			}
		}
	}

	private void OnDisable()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene || battleScene.GetBattleSimulatorSystem() == null)
		{
			return;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager != null)
		{
			NAgent playerAgent = agentManager.GetPlayerAgent();
			if (!(playerAgent == null))
			{
				SendStopMove(playerAgent);
			}
		}
	}
}
