using System;
using System.Collections.Generic;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Drama;
using ACT.Event;
using ACT.NPC;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cinemachine;
using Fundamental;
using RootMotion.FinalIK;
using Runtime.AnimatorSnap;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.Battle;

public class CompNpc : EcsComponent
{
	private readonly List<Vector3> _patrolPoints = new List<Vector3>();

	private Animator _animator;

	private bool _hasDialogueCharacterOriginalRotation;

	private AnimatorSnap _animatorSnap;

	private bool _hasAnimatorSnap;

	private Looper _focusLooper;

	public const int NPC_GENERICVCAMERA_PRIORITY = 250;

	private readonly List<NpcInteractEntryRuntime> _interactEntryRuntimes = new List<NpcInteractEntryRuntime>();

	public IReadOnlyList<Vector3> PatrolPoints => _patrolPoints;

	public Vector3 DeparturePoint { get; private set; }

	public Vector3 DestinationPoint { get; private set; }

	public int CurrentPatrolPointIndex { get; private set; } = -1;

	public NpcBehaviorState BehaviorState { get; private set; }

	public Animator Animator
	{
		get
		{
			return _animator;
		}
		set
		{
			if (!(_animator == value))
			{
				_animator = value;
				if ((bool)_animator)
				{
					_animator.enabled = true;
				}
			}
		}
	}

	public bool IsInDialogue { get; private set; }

	public int NpcTableID => NpcConfigUid / 10000;

	public int NpcConfigUid => NpcDataConfig.npcConfigUid;

	public bool IsFocusing { get; private set; }

	public Vector3 FocusPosition { get; private set; }

	public NPCBehaviour NpcBehaviour { get; set; }

	public NpcDataConfig NpcDataConfig { get; set; }

	public Entity NpcEntity { get; set; }

	public LookAtIK OnlyNeckLookAtIK { get; set; }

	public CinemachineVirtualCamera VirtualCamera => Fundamental.Singleton<CameraManager>.instance.NPCVCamera;

	private GameObject _dialogueCharacterModel => Fundamental.Singleton<RuntimeNpcManager>.instance.CurrentDialogueCharacterModel;

	public NpcInteractEntryRuntime ActiveInteractEntryRuntime { get; private set; }

	public NpcInteractEntryConfig CurrentActiveInteractEntryConfig => ActiveInteractEntryRuntime?.Config;

	public void SetPatrolPoints(IReadOnlyList<Vector3> patrolPoints)
	{
		_patrolPoints.Clear();
		if (patrolPoints != null)
		{
			for (int i = 0; i < patrolPoints.Count; i++)
			{
				_patrolPoints.Add(patrolPoints[i]);
			}
		}
	}

	public void BeginMove(Vector3 departurePoint, Vector3 destinationPoint)
	{
		DeparturePoint = departurePoint;
		DestinationPoint = destinationPoint;
		UpdateCurrentPatrolPointIndex(destinationPoint);
		SetBehaviorState(NpcBehaviorState.Moving);
	}

	public void ReachDestination(Vector3 destinationPoint)
	{
		DestinationPoint = destinationPoint;
		UpdateCurrentPatrolPointIndex(destinationPoint);
		SetBehaviorState(NpcBehaviorState.ReachedDestination);
	}

	public void SetCurrentPatrolPointIndex(int patrolPointIndex)
	{
		CurrentPatrolPointIndex = ((patrolPointIndex >= 0 && patrolPointIndex < _patrolPoints.Count) ? patrolPointIndex : (-1));
	}

	private void EnterBehaviorDialogue()
	{
		SetBehaviorState(NpcBehaviorState.InDialogue);
	}

	private void ExitBehaviorDialogue()
	{
		SetBehaviorState(NpcBehaviorState.ReachedDestination);
	}

	private void SetBehaviorState(NpcBehaviorState behaviorState)
	{
		if (BehaviorState != behaviorState)
		{
			BehaviorState = behaviorState;
			NpcEvent evt = Fundamental.Singleton<EventManager>.instance.GetEvt<NpcEvent>();
			evt.NpcID = NpcConfigUid;
			evt.BehaviorState = behaviorState;
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_State_Changed, evt);
			Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void ResetAiState()
	{
		_patrolPoints.Clear();
		DeparturePoint = Vector3.zero;
		DestinationPoint = Vector3.zero;
		CurrentPatrolPointIndex = -1;
		BehaviorState = NpcBehaviorState.ReachedDestination;
	}

	private void UpdateCurrentPatrolPointIndex(Vector3 destinationPoint)
	{
		if (CurrentPatrolPointIndex < 0 || CurrentPatrolPointIndex >= _patrolPoints.Count || !(_patrolPoints[CurrentPatrolPointIndex] == destinationPoint))
		{
			CurrentPatrolPointIndex = _patrolPoints.IndexOf(destinationPoint);
		}
	}

	protected override void OnGet()
	{
		ResetInteractEntryRuntimes();
	}

	protected override void OnRelease()
	{
		ResetInteractEntryRuntimes();
		ReleaseModelReferences();
		NpcBehaviour = null;
		NpcDataConfig = null;
		ResetAiState();
		_hasDialogueCharacterOriginalRotation = false;
	}

	public void ReleaseModelReferences(bool preserveAnimatorSnap = false)
	{
		if (IsInDialogue)
		{
			ExitDialogueMode();
		}
		if (preserveAnimatorSnap)
		{
			SnapAnimator();
		}
		else
		{
			ClearSnap();
		}
		_focusLooper.Cancel();
		IsFocusing = false;
		FocusPosition = Vector3.zero;
		if (OnlyNeckLookAtIK?.solver?.target != null)
		{
			UnityEngine.Object.Destroy(OnlyNeckLookAtIK.solver.target.gameObject);
		}
		OnlyNeckLookAtIK = null;
		if (!preserveAnimatorSnap)
		{
			_animatorSnap = default;
			_hasAnimatorSnap = false;
		}
		ActiveInteractEntryRuntime?.UnbindAnimator();
		Animator = null;
	}

	public void EnterDialogueMode(bool controlCamera = true, bool rotateDialogueCharacter = true)
	{
		try
		{
			if (IsInDialogue)
			{
				if (rotateDialogueCharacter)
				{
					RotateDialogueCharacterTowardNpc();
				}
				return;
			}
			IsInDialogue = true;
			EnterBehaviorDialogue();
			if (rotateDialogueCharacter)
			{
				RotateDialogueCharacterTowardNpc();
			}
			NpcInteractEntryRuntime activeInteractEntryRuntime = ActiveInteractEntryRuntime;
			if (activeInteractEntryRuntime == null || activeInteractEntryRuntime.ShouldUseAnimationSnap())
			{
				SnapAnimator();
			}
			else
			{
				ClearSnap();
			}
			if (controlCamera)
			{
				SetVirtualCamera();
			}
			SetFocus();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public void ExitDialogueMode(bool controlCamera = true)
	{
		try
		{
			if (IsInDialogue)
			{
				IsInDialogue = false;
				ExitBehaviorDialogue();
				RestoreDialogueCharacterRotation();
				ApplyAnimatorSnap();
				if (controlCamera)
				{
					ResetVirtualCamera();
				}
				ClearFocus();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public void RotateDialogueCharacterTowardNpc()
	{
		GameObject dialogueCharacterModel = _dialogueCharacterModel;
		if (dialogueCharacterModel == null || !NpcEntity.IsValid)
		{
			return;
		}
		Transform modelTrans = NpcEntity.GetModelTrans();
		if (!(modelTrans == null))
		{
			Vector3 forward = modelTrans.position - dialogueCharacterModel.transform.position;
			forward.y = 0f;
			if (!(forward.sqrMagnitude <= 0.0001f))
			{
				dialogueCharacterModel.transform.rotation = Quaternion.LookRotation(forward, Vector3.up);
			}
		}
	}

	private void RestoreDialogueCharacterRotation()
	{
		if (_hasDialogueCharacterOriginalRotation)
		{
			_ = _dialogueCharacterModel == null;
		}
		_hasDialogueCharacterOriginalRotation = false;
	}

	private void SetFocus()
	{
		if (!OnlyNeckLookAtIK || _dialogueCharacterModel == null)
		{
			return;
		}
		IsFocusing = true;
		FocusPosition = _dialogueCharacterModel.transform.position + Vector3.up * 1.6f;
		GameObject gameObject = new GameObject($"{NpcConfigUid}_VirtualLookAtTarget");
		gameObject.transform.position = FocusPosition;
		OnlyNeckLookAtIK.solver.target = gameObject.transform;
		if (_focusLooper.IsValid())
		{
			_focusLooper.Cancel();
		}
		float timer = 0f;
		_focusLooper = UpdateTimer.Default.LoopFrame(1, () =>
		{
			timer += NpcEntity.GetCompTime().fixedSpeed * Time.deltaTime;
			OnlyNeckLookAtIK.solver.IKPositionWeight = Mathf.Lerp(0f, 1f, timer);
			if (OnlyNeckLookAtIK.solver.IKPositionWeight >= 1f)
			{
				_focusLooper.Cancel();
			}
		});
	}

	private void ClearFocus()
	{
		if (!OnlyNeckLookAtIK)
		{
			return;
		}
		if (_focusLooper.IsValid())
		{
			_focusLooper.Cancel();
		}
		float timer = 0f;
		_focusLooper = UpdateTimer.Default.LoopFrame(1, () =>
		{
			timer += NpcEntity.GetCompTime().fixedSpeed * Time.deltaTime;
			OnlyNeckLookAtIK.solver.IKPositionWeight = Mathf.Lerp(1f, 0f, timer);
			if (OnlyNeckLookAtIK.solver.IKPositionWeight <= 0f)
			{
				_focusLooper.Cancel();
				FocusPosition = Vector3.zero;
				Transform target = OnlyNeckLookAtIK.solver.target;
				OnlyNeckLookAtIK.solver.target = null;
				if ((bool)target)
				{
					UnityEngine.Object.Destroy(target.gameObject);
				}
				IsFocusing = false;
			}
		});
	}

	public void SnapAnimator()
	{
		if ((bool)_animator)
		{
			_animatorSnap = new AnimatorSnap(_animator);
			_hasAnimatorSnap = true;
		}
	}

	public void ClearSnap()
	{
		_animatorSnap = default;
		_hasAnimatorSnap = false;
	}

	public void ApplyAnimatorSnap()
	{
		if (_hasAnimatorSnap && (bool)_animator)
		{
			_animatorSnap.Apply(_animator);
		}
	}

	public void RestartAnimatorFromEntry()
	{
		if ((bool)_animator)
		{
			RestoreAnimatorParametersToDefault();
			if (_hasAnimatorSnap)
			{
				_animatorSnap.ApplyLayerStatesInFixedTime(_animator, 0.5f);
				ClearSnap();
			}
			else
			{
				_animator.Rebind();
				_animator.Update(0f);
				ClearSnap();
			}
		}
	}

	private void RestoreAnimatorParametersToDefault()
	{
		AnimatorControllerParameter[] parameters = _animator.parameters;
		foreach (AnimatorControllerParameter animatorControllerParameter in parameters)
		{
			switch (animatorControllerParameter.type)
			{
			case AnimatorControllerParameterType.Float:
				_animator.SetFloat(animatorControllerParameter.name, animatorControllerParameter.defaultFloat);
				break;
			case AnimatorControllerParameterType.Int:
				_animator.SetInteger(animatorControllerParameter.name, animatorControllerParameter.defaultInt);
				break;
			case AnimatorControllerParameterType.Bool:
				_animator.SetBool(animatorControllerParameter.name, animatorControllerParameter.defaultBool);
				break;
			case AnimatorControllerParameterType.Trigger:
				_animator.ResetTrigger(animatorControllerParameter.name);
				break;
			}
		}
	}

	public void RestoreModelAnimatorState()
	{
		if ((bool)_animator)
		{
			NpcInteractEntryRuntime activeInteractEntryRuntime = ActiveInteractEntryRuntime;
			activeInteractEntryRuntime?.RestoreAnimatorState(_animator);
			if (activeInteractEntryRuntime == null || activeInteractEntryRuntime.ShouldUseAnimationSnap())
			{
				ApplyAnimatorSnap();
			}
		}
	}

	private void SetVirtualCamera()
	{
		float num = 6f;
		float num2 = 0.8f;
		GameObject model = NpcEntity.GetModel();
		GameObject dialogueCharacterModel = _dialogueCharacterModel;
		if (!(model == null) && !(dialogueCharacterModel == null))
		{
			VirtualCamera.Priority = 250;
			CinemachineVirtualCamera virtualCamera = VirtualCamera;
			Transform follow = (VirtualCamera.LookAt = model.transform);
			virtualCamera.Follow = follow;
			VirtualCamera.m_Lens.FieldOfView = 35f;
			VirtualCamera.UseCustomFovScaler(value: false);
			CinemachineBasicMultiChannelPerlin cinemachineBasicMultiChannelPerlin = VirtualCamera.AddCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			cinemachineBasicMultiChannelPerlin.m_NoiseProfile = UnityEngine.Object.Instantiate(GameLoader.meta.npcCameraNoise);
			cinemachineBasicMultiChannelPerlin.m_PivotOffset = new Vector3(0f, 0.2f, 0f);
			cinemachineBasicMultiChannelPerlin.m_AmplitudeGain = 0.2f;
			cinemachineBasicMultiChannelPerlin.m_FrequencyGain = 0.3f;
			CinemachineGroupComposer cinemachineGroupComposer = VirtualCamera.AddCinemachineComponent<CinemachineGroupComposer>();
			cinemachineGroupComposer.m_TrackedObjectOffset = VirtualCamera.LookAt.InverseTransformVector(Vector3.back * (VirtualCamera.Follow.position - VirtualCamera.LookAt.position).magnitude * 0.3f + Vector3.up * NpcDataConfig.npcHeight);
			cinemachineGroupComposer.m_ScreenY = 0.3f;
			CinemachineTransposerACT cinemachineTransposerACT = VirtualCamera.AddCinemachineComponent<CinemachineTransposerACT>();
			cinemachineTransposerACT.m_BindingMode = CinemachineTransposerACT.BindingMode.WorldSpace;
			bool flag = model.transform.position.x < dialogueCharacterModel.transform.position.x;
			cinemachineTransposerACT.m_FollowOffset = Vector3.back * num + (flag ? Vector3.left : Vector3.right) * num2 + Vector3.up * NpcDataConfig.npcHeight;
			CinemachineTargetGroup orAddComponent = VirtualCamera.transform.GetOrAddComponent<CinemachineTargetGroup>();
			orAddComponent.m_PositionMode = CinemachineTargetGroup.PositionMode.GroupAverage;
			orAddComponent.m_RotationMode = CinemachineTargetGroup.RotationMode.Manual;
			orAddComponent.m_Targets = new CinemachineTargetGroup.Target[2];
			orAddComponent.m_Targets[0].target = dialogueCharacterModel.transform;
			orAddComponent.m_Targets[0].weight = 1f;
			orAddComponent.m_Targets[0].radius = 3f;
			orAddComponent.m_Targets[1].target = model.transform;
			orAddComponent.m_Targets[1].weight = 1f;
			orAddComponent.m_Targets[1].radius = 3f;
			VirtualCamera.gameObject.SetActive(value: true);
		}
	}

	private void ResetVirtualCamera()
	{
		VirtualCamera.Priority = 0;
		VirtualCamera.gameObject.SetActive(value: false);
		CinemachineBasicMultiChannelPerlin cinemachineComponent = VirtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		if ((bool)cinemachineComponent)
		{
			UnityEngine.Object.Destroy(cinemachineComponent.m_NoiseProfile);
		}
	}

	public NpcInteractEntryRuntime GetOrCreateInteractEntryRuntime(NpcInteractEntryConfig config)
	{
		if (config == null)
		{
			return null;
		}
		for (int i = 0; i < _interactEntryRuntimes.Count; i++)
		{
			if (_interactEntryRuntimes[i].Config == config)
			{
				return _interactEntryRuntimes[i];
			}
		}
		NpcInteractEntryRuntime npcInteractEntryRuntime = new NpcInteractEntryRuntime(config);
		_interactEntryRuntimes.Add(npcInteractEntryRuntime);
		return npcInteractEntryRuntime;
	}

	public void SetActiveInteractEntryRuntime(NpcInteractEntryRuntime interactEntryRuntime)
	{
		ActiveInteractEntryRuntime = interactEntryRuntime;
	}

	public void UnbindInteractEntryConditions()
	{
		for (int i = 0; i < _interactEntryRuntimes.Count; i++)
		{
			_interactEntryRuntimes[i].UnbindCondition();
		}
	}

	public void ResetInteractEntryRuntimes()
	{
		for (int i = 0; i < _interactEntryRuntimes.Count; i++)
		{
			NpcInteractEntryRuntime npcInteractEntryRuntime = _interactEntryRuntimes[i];
			npcInteractEntryRuntime.UnbindAnimator();
			npcInteractEntryRuntime.UnbindCondition();
		}
		_interactEntryRuntimes.Clear();
		ActiveInteractEntryRuntime = null;
	}
}
