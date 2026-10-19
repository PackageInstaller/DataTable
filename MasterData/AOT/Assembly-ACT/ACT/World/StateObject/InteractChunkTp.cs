using System;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Sound;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.Precache;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractChunkTp : StateObjectBase
{
	private const int ShowState = 0;

	private const int LockState = 1;

	private ChunkTpData _data;

	[SerializeField]
	private InteractEntry _interactEntryConfig;

	private InteractEntry _interactEntry;

	private EffectRuntimeItem _trialEffectItem;

	[SerializeField]
	[Header("TP过渡相机（无Follow/Confiner/Extension）")]
	private CinemachineVirtualCamera _transitionCamera;

	[SerializeField]
	private float _cameraTransitionTime = 0.5f;

	[SerializeField]
	[Header("TP过渡相机优先级")]
	private int _cameraTransitionPriority = 9999;

	private CameraState _transitionStartCameraState;

	private bool _isCameraTransitioning;

	private CinemachineBrain _cameraTransitionBrain;

	[SerializeField]
	[Header("指向特效")]
	private YooAssetReference _linRenderEffectReference;

	[SerializeField]
	[Header("tp特效")]
	private YooAssetReference _tpEffectReference;

	private ChunkTpData _targetChunkTpData;

	private uint _loopSoundEvent;

	private const string LoopSoundPath = "event:/SFX/Interact/ChunkTp_Loop";

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		_data = (ChunkTpData)entity.GetCompStateObject().StateWorldAssetData;
		_interactEntry = new InteractEntry();
		_interactEntry.Clone(_interactEntryConfig);
		_interactEntry.BindInteractObjectBase(this);
		_interactEntry.BindData(_data);
		_interactEntry.BindInteractState(0, 0);
		InteractEntry interactEntry = _interactEntry;
		interactEntry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(interactEntry.onInteractAsync, new Func<Entity, UniTask>(OnInteractAsync));
		_loopSoundEvent = Singleton<GameManager>.instance.audioManager.PlaySound("event:/SFX/Interact/ChunkTp_Loop", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
		_targetChunkTpData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(_data.TargetChunkTpComp) as ChunkTpData;
		InitTransitionCamera();
		base.InitStateObject(stateId);
	}

	private async UniTask OnInteractAsync(Entity entityBehave)
	{
		SetParams();
		try
		{
			await UniTask.WaitUntil(() => entityBehave.GetCompMotion().layer0Peak.state.value.stateType != MotionState.OpenBox);
			await TeleportNew();
		}
		finally
		{
			ResetParams();
		}
	}

	private async UniTask TeleportNew()
	{
		if (_targetChunkTpData == null)
		{
			Debug.LogError("ChunkTp目标配置无效：" + name, this);
			return;
		}
		MonoECS instance = MonoECS.instance;
		Entity eb = instance.mainEntity;
		CompTransform compTransform = eb.GetCompTransform();
		Vector3 characterTargetPos = PhysicsUtility.GetGroundPoint(_targetChunkTpData.TargetPos + compTransform.center, compTransform.size) - compTransform.center;
		Vector3 lineRenderStartPos = eb.GetCompTransform().colliderPosition;
		Vector3 lineRenderEndPos = characterTargetPos + eb.GetCompTransform().center;
		Vector3 physicsPosition = eb.GetCompTransform().physicsPosition;
		eb.HideRenderer();
		SystemEffect effectSystem = GameManager.effectSystem;
		effectSystem.FireEffect(_tpEffectReference, physicsPosition, Quaternion.identity);
		_trialEffectItem = effectSystem.FireEffect(_linRenderEffectReference, lineRenderStartPos, Quaternion.identity);
		await UniTask.WaitUntil(() => _trialEffectItem.lineRenderer != null);
		_trialEffectItem.lineRenderer.start = lineRenderStartPos;
		_trialEffectItem.lineRenderer.end = lineRenderEndPos;
		await UniTask.Delay(TimeSpan.FromSeconds(_data.StartWaitTime));
		CinemachineBrain brain = GameManager.cameraSystem.Brain;
		bool cameraTransitionStarted = BeginCameraTransition(brain);
		try
		{
			TeleportCharacter(eb, characterTargetPos);
			eb.ShowRenderer();
			CleanLineRenderAfterDelay(_trialEffectItem, _data.LineRenderExistTime).Forget();
			if (!cameraTransitionStarted)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(1.0));
				return;
			}
			await UniTask.WhenAll(UniTask.Delay(TimeSpan.FromSeconds(_data.EndWaitTime)), BlendToDestinationAreaCamera(brain));
		}
		finally
		{
			if (cameraTransitionStarted)
			{
				await EndCameraTransition();
			}
		}
	}

	private void TeleportCharacter(Entity eb, Vector3 targetPos)
	{
		eb.Teleport(targetPos);
		eb.SetFaceLeft(!_targetChunkTpData.FaceRight);
		CompPhysics? compPhysics = eb.GetCompPhysics();
		compPhysics.SetConstZ(targetPos.z);
		compPhysics.SetDirImmediately();
		compPhysics.InitRotation(!_targetChunkTpData.FaceRight);
		eb.SetFloat("GroundDistance", 0f);
		MonoECS.instance.ForceToIdle(eb);
		compPhysics.SetMovementMode(ACTMovementMode.Walking);
	}

	private void InitTransitionCamera()
	{
		ValidateTransitionCamera(_transitionCamera);
		SetTransitionCameraEnabled(_transitionCamera, enabled: false);
	}

	private bool BeginCameraTransition(CinemachineBrain brain)
	{
		if (brain == null || _transitionCamera == null)
		{
			return false;
		}
		_transitionStartCameraState = brain.CurrentCameraState;
		ApplyCameraState(_transitionCamera, _transitionStartCameraState);
		_transitionCamera.Priority = _cameraTransitionPriority;
		_cameraTransitionBrain = brain;
		_isCameraTransitioning = true;
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Remove(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(GetCameraBlendOverride));
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Combine(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(GetCameraBlendOverride));
		SetTransitionCameraEnabled(_transitionCamera, enabled: true);
		return true;
	}

	private async UniTask BlendToDestinationAreaCamera(CinemachineBrain brain)
	{
		await UniTask.NextFrame();
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = await WaitForDestinationAreaCamera();
		if (!(cinemachineVirtualCameraBase == null))
		{
			await MoveTransitionCamera(cinemachineVirtualCameraBase, brain);
		}
	}

	private async UniTask<CinemachineVirtualCameraBase> WaitForDestinationAreaCamera()
	{
		for (int i = 0; i < 3; i++)
		{
			await UniTask.Yield(PlayerLoopTiming.FixedUpdate);
			CinemachineVirtualCameraBase destinationCamera = GetHighestPriorityStayedAreaCamera();
			if (!(destinationCamera == null))
			{
				await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
				return GetOutputCamera(destinationCamera);
			}
		}
		Debug.LogWarning("ChunkTp未找到目标AreaCamera：" + name, this);
		return null;
	}

	private async UniTask MoveTransitionCamera(CinemachineVirtualCameraBase destinationCamera, CinemachineBrain brain)
	{
		if (_cameraTransitionTime <= 0f)
		{
			ApplyCameraState(_transitionCamera, GetRefreshedDestinationCameraState(destinationCamera, brain));
			return;
		}
		float elapsedTime = 0f;
		do
		{
			float t = Mathf.Clamp01(elapsedTime / _cameraTransitionTime);
			CameraState refreshedDestinationCameraState = GetRefreshedDestinationCameraState(destinationCamera, brain);
			ApplyInterpolatedCameraState(_transitionCamera, _transitionStartCameraState, refreshedDestinationCameraState, Mathf.SmoothStep(0f, 1f, t));
			await UniTask.Yield(PlayerLoopTiming.Update);
			elapsedTime += Time.deltaTime;
		}
		while (elapsedTime < _cameraTransitionTime);
		ApplyCameraState(_transitionCamera, GetRefreshedDestinationCameraState(destinationCamera, brain));
	}

	private static CinemachineVirtualCameraBase GetOutputCamera(CinemachineVirtualCameraBase camera)
	{
		while (camera.ParentCamera is CinemachineVirtualCameraBase cinemachineVirtualCameraBase)
		{
			camera = cinemachineVirtualCameraBase;
		}
		return camera;
	}

	private CinemachineVirtualCameraBase GetHighestPriorityStayedAreaCamera()
	{
		CinemachineVirtualCameraBase result = null;
		int num = int.MinValue;
		AreaCamera[] array = UnityEngine.Object.FindObjectsOfType<AreaCamera>();
		foreach (AreaCamera areaCamera in array)
		{
			CinemachineVirtualCameraBase vCamera = areaCamera.conditionalCamera.vCamera;
			if (areaCamera.IsStay && areaCamera.conditionalCamera.enabled && !(vCamera == null) && vCamera.enabled && vCamera.Priority > num)
			{
				num = vCamera.Priority;
				result = vCamera;
			}
		}
		return result;
	}

	private async UniTask EndCameraTransition()
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		SetTransitionCameraEnabled(_transitionCamera, enabled: false);
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Remove(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(GetCameraBlendOverride));
		_isCameraTransitioning = false;
		_cameraTransitionBrain = null;
	}

	private CinemachineBlendDefinition GetCameraBlendOverride(ICinemachineCamera fromCamera, ICinemachineCamera toCamera, CinemachineBlendDefinition blend, MonoBehaviour owner)
	{
		if (!_isCameraTransitioning || owner != _cameraTransitionBrain)
		{
			return blend;
		}
		if (toCamera == _transitionCamera || fromCamera == _transitionCamera)
		{
			return new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		}
		return blend;
	}

	private CameraState GetRefreshedDestinationCameraState(CinemachineVirtualCameraBase destinationCamera, CinemachineBrain brain)
	{
		destinationCamera.UpdateCameraState(brain.DefaultWorldUp, Time.deltaTime);
		return destinationCamera.State;
	}

	private void ApplyInterpolatedCameraState(CinemachineVirtualCamera transitionCamera, CameraState fromState, CameraState toState, float t)
	{
		transitionCamera.m_Lens = LensSettings.Lerp(fromState.Lens, toState.Lens, t);
		transitionCamera.ForceCameraPosition(Vector3.Lerp(fromState.FinalPosition, toState.FinalPosition, t), Quaternion.Slerp(fromState.FinalOrientation, toState.FinalOrientation, t));
	}

	private void ApplyCameraState(CinemachineVirtualCamera transitionCamera, CameraState state)
	{
		transitionCamera.m_Lens = state.Lens;
		transitionCamera.ForceCameraPosition(state.FinalPosition, state.FinalOrientation);
	}

	private void ValidateTransitionCamera(CinemachineVirtualCamera transitionCamera)
	{
		if (!(transitionCamera == null) && (transitionCamera.Follow != null || transitionCamera.LookAt != null || transitionCamera.GetComponent<CinemachineExtension>() != null))
		{
			Debug.LogWarning("ChunkTp过渡相机应为纯快照相机：请移除 Follow、LookAt 与 CinemachineExtension。" + name, this);
		}
	}

	private void SetTransitionCameraEnabled(CinemachineVirtualCamera transitionCamera, bool enabled)
	{
		if (!(transitionCamera == null))
		{
			transitionCamera.gameObject.SetActive(value: true);
			transitionCamera.enabled = enabled;
		}
	}

	private async UniTaskVoid CleanLineRenderAfterDelay(EffectRuntimeItem effectItem, float delay)
	{
		if (delay > 0f)
		{
			await UniTask.Delay(TimeSpan.FromSeconds(delay));
		}
		GameManager.effectSystem.CleanEffect(effectItem);
		PrecacheManager.Instance.ReleaseInstanceHandle(effectItem.instanceHandle);
	}

	private void SetParams()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		EntityTags entityTags = mainEntity.GetCompBehave().EntityTags;
		entityTags.AddTag(EntityTag.IgnoreAttack);
		entityTags.AddTag(EntityTag.IgnoreTrap);
		entityTags.AddTag(EntityTag.UnHatable);
		entityTags.AddTag(EntityTag.SystemControl);
		Singleton<NewUIManager>.instance.CloseAllUI();
		MonoECS.instance.ClearMainEntityInput();
		CompMotion? compMotion = mainEntity.GetCompMotion();
		compMotion.ResetTrigger(compMotion.lastConflictTrigger);
	}

	private void ResetParams()
	{
		EntityTags entityTags = MonoECS.instance.mainEntity.GetCompBehave().EntityTags;
		entityTags.RemoveTag(EntityTag.IgnoreAttack);
		entityTags.RemoveTag(EntityTag.IgnoreTrap);
		entityTags.RemoveTag(EntityTag.UnHatable);
		entityTags.RemoveTag(EntityTag.SystemControl);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == 0)
		{
			_interactEntry.HandleInit();
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (stateId == 0)
		{
			_interactEntry.HandleUninit();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
		_interactEntry.HandleEnter();
	}

	protected override void HandleExitInteract()
	{
		_interactEntry.HandleExit();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0 && entryIndex == 0)
		{
			_interactEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	public override void ReleaseStateObject()
	{
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Remove(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(GetCameraBlendOverride));
		_isCameraTransitioning = false;
		_cameraTransitionBrain = null;
		SetTransitionCameraEnabled(_transitionCamera, enabled: false);
		Singleton<GameManager>.instance.audioManager.Stop(_loopSoundEvent);
		base.ReleaseStateObject();
		_interactEntry = null;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (currentStateId != 0)
		{
			return ShowType.Hide;
		}
		return ShowType.Show;
	}

	public override bool ShowInteractTip()
	{
		return currentStateId == 0;
	}
}
