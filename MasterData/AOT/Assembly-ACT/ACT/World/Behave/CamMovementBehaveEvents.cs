using System;
using System.Threading;
using ACT.Battle;
using ACT.Drama;
using ACT.Event;
using ACT.UI;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

public class CamMovementBehaveEvents : MonoBehaviour
{
	public StateObjectBase interactObject;

	private float m_DefaultTime;

	public CamMovementBehaveData behaveData;

	private CinemachineBrain m_Brain;

	public CinemachineVirtualCamera m_VirtualCamera;

	public CinemachineDollyCart cart;

	public CinemachinePath path;

	public string[] abilities;

	private int aimIndex;

	private float timeFlag;

	private bool waitTime;

	private bool wait;

	private CancellationTokenSource m_MovementCTS;

	private bool m_MovementStarted;

	private bool m_MovementEnding;

	private bool m_CameraMovingTagAdded;

	private bool m_AbilitiesAdded;

	private bool m_PauseInputPushed;

	private void Awake()
	{
		if (interactObject != null)
		{
			CamMovementData camMovementData = interactObject.entity.GetCompStateObject().StateWorldAssetData as CamMovementData;
			behaveData = camMovementData.behaveData;
			path.m_Waypoints = behaveData.Waypoints;
		}
		m_Brain = MonoECS.instance.entityLocal.compCamera.mainCamera.GetComponent<CinemachineBrain>();
		cart.m_UpdateMethod = CinemachineDollyCart.UpdateMethod.FixedUpdate;
		cart.m_PositionUnits = CinemachinePathBase.PositionUnits.PathUnits;
	}

	private async void OnEnable()
	{
		CancelMovement();
		m_MovementCTS = new CancellationTokenSource();
		CancellationToken token = m_MovementCTS.Token;
		m_MovementStarted = false;
		m_MovementEnding = false;
		try
		{
			if ((CanStartMovement() || !(await UniTask.WaitUntil(CanStartMovement, PlayerLoopTiming.Update, token).SuppressCancellationThrow())) && !token.IsCancellationRequested && isActiveAndEnabled)
			{
				StartMovement();
			}
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			CancelMovement();
			RestoreMovementState();
		}
	}

	private static bool CanStartMovement()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null || !instance.isStartWorld || Singleton<GameState>.instance.WorldState != WorldState.Normal || Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal)
		{
			return false;
		}
		if (Singleton<ConversationManager>.HasInstance() && Singleton<ConversationManager>.instance.IsPlaying)
		{
			return false;
		}
		if (Singleton<TimelineConversationManager>.HasInstance() && (Singleton<TimelineConversationManager>.instance.Playing || Singleton<TimelineConversationManager>.instance.DialogPlaying))
		{
			return false;
		}
		return Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.CameraMoving);
	}

	private void StartMovement()
	{
		SetCameraMovingTag();
		m_MovementStarted = true;
		cart.enabled = true;
		MonoECS.instance.mainEntity.GetCompAbility().AddAbilities(abilities, AbilitySource.Ability);
		m_AbilitiesAdded = true;
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_BATTLEMAIN);
		MonoECS.instance.PushPauseInput();
		m_PauseInputPushed = true;
		m_DefaultTime = m_Brain.m_DefaultBlend.BlendTime;
		waitTime = true;
		aimIndex = 0;
		timeFlag = Time.time;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ResetZoom, null);
	}

	private void OnDisable()
	{
		if (!m_MovementEnding)
		{
			CancelMovement();
			RestoreMovementState();
		}
	}

	private void FixedUpdate()
	{
		if (!m_MovementStarted)
		{
			return;
		}
		if (waitTime)
		{
			if (!(Time.time - timeFlag > behaveData.waitTime))
			{
				return;
			}
			m_Brain.m_DefaultBlend.m_Time = behaveData.startTime;
			m_VirtualCamera.Priority = behaveData.priority;
			waitTime = false;
		}
		if (m_Brain.IsBlending)
		{
			return;
		}
		if (wait)
		{
			if (Time.time - timeFlag > behaveData.pathPointTime[aimIndex])
			{
				wait = false;
				if (aimIndex == path.m_Waypoints.Length - 1)
				{
					MovementEnd();
					return;
				}
				cart.m_Speed = behaveData.pathSpeed[aimIndex];
				aimIndex++;
			}
			return;
		}
		if (behaveData.pathPointRotation != null && behaveData.pathPointRotation.Length != 0 && aimIndex != 0 && aimIndex < behaveData.pathPointRotation.Length)
		{
			m_VirtualCamera.transform.rotation = Quaternion.Slerp(behaveData.pathPointRotation[aimIndex - 1], behaveData.pathPointRotation[aimIndex], cart.m_Position + 1f - (float)aimIndex);
		}
		if ((double)(cart.m_Position - (float)aimIndex) > 0.001 || (double)cart.m_Position < 0.001 || (double)cart.m_Position > (double)path.m_Waypoints.Length - 1.001)
		{
			if (behaveData.pathPointRotation != null && behaveData.pathPointRotation.Length != 0 && aimIndex == 0)
			{
				m_VirtualCamera.transform.rotation = behaveData.pathPointRotation[0];
			}
			timeFlag = Time.time;
			cart.m_Speed = 0f;
			wait = true;
		}
	}

	public async void MovementEnd()
	{
		if (m_MovementEnding)
		{
			return;
		}
		m_MovementEnding = true;
		CancellationToken token = m_MovementCTS?.Token ?? CancellationToken.None;
		m_Brain.m_DefaultBlend.m_Time = behaveData.endTime;
		m_VirtualCamera.Priority = 0;
		gameObject.SetActive(value: false);
		cart.enabled = false;
		cart.m_Speed = 0f;
		cart.m_Position = 0f;
		aimIndex = 0;
		try
		{
			await UniTask.Delay(TimeSpan.FromSeconds(behaveData.endTime), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			token.ThrowIfCancellationRequested();
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN).AttachExternalCancellation(token);
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		finally
		{
			RestoreMovementState();
			m_MovementEnding = false;
			m_MovementCTS?.Dispose();
			m_MovementCTS = null;
		}
	}

	private void OnDestroy()
	{
		CancelMovement();
		RestoreMovementState();
	}

	private void CancelMovement()
	{
		m_MovementCTS?.Cancel();
		m_MovementCTS?.Dispose();
		m_MovementCTS = null;
	}

	private void SetCameraMovingTag()
	{
		if (!m_CameraMovingTagAdded && !(MonoECS.instance == null))
		{
			MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.CameraMoving);
			m_CameraMovingTagAdded = true;
		}
	}

	private void RestoreMovementState()
	{
		MonoECS instance = MonoECS.instance;
		if (m_AbilitiesAdded)
		{
			if (instance != null && instance.mainEntity != null && instance.mainEntity.TryGetCompAbility(out CompAbility component))
			{
				string[] array = abilities;
				foreach (string text in array)
				{
					component.RemoveAbility(text);
				}
			}
			m_AbilitiesAdded = false;
		}
		if (m_Brain != null)
		{
			m_Brain.m_DefaultBlend.m_Time = m_DefaultTime;
		}
		if (m_PauseInputPushed)
		{
			instance?.PopPauseInput();
			m_PauseInputPushed = false;
		}
		RemoveCameraMovingTag();
		m_MovementStarted = false;
	}

	private void RemoveCameraMovingTag()
	{
		if (m_CameraMovingTagAdded)
		{
			MonoECS.instance?.RemovePlayerTag(MonoECS.PlayerTag.CameraMoving);
			m_CameraMovingTagAdded = false;
		}
	}
}
