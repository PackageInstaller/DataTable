using System;
using System.Threading;
using ACT.Battle;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractPathSwitch : StateObjectBase
{
	[SerializeField]
	private Transform _interactTipTransform;

	private InteractEntry _entry;

	private PathSwitchInteractData _data;

	private CancellationTokenSource _cts;

	private bool _isSwitching;

	private bool _pauseInteractPushed;

	private bool _pauseAllInputPushed;

	private bool _battleMainClosed;

	private bool _movingPathTagAdded;

	private bool _preparePositionLogicEnabled;

	private bool _forcedRunActive;

	private bool _pathSwitchMoveTagAdded;

	private Entity _forcedRunBehave;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is PathSwitchInteractData data)
		{
			_data = data;
			InitializeCollider();
			InitializeInteractTipTransform();
			_entry = InteractEntry.CreateConfiguredEntry((_data.InteractType == PathSwitchInteractEntryType.TriggerEnter) ? InteractType.TriggerEnter : InteractType.Button, _data.ButtonConfig.LocalizedString, _data.ButtonConfig.Weight, _data.ButtonConfig.IconId, _data.InteractConfig.TipIcon);
			InteractEntry entry = _entry;
			entry.onInteract = (Action<Entity>)Delegate.Combine(entry.onInteract, new Action<Entity>(OnInteract));
			_entry.BindInteractObjectBase(this);
			_entry.BindData(compStateObject.StateWorldAssetData);
			base.InitStateObject(stateId);
		}
	}

	private void InitializeCollider()
	{
		BoxCollider component = GetComponent<BoxCollider>();
		if (!(component == null))
		{
			component.center = _data.Trigger.center;
			component.size = _data.Trigger.size;
			component.isTrigger = true;
		}
	}

	private void InitializeInteractTipTransform()
	{
		if (_interactTipTransform != null)
		{
			_interactTipTransform.position = _data.InteractConfig.InteractTipPos.value;
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == 0)
		{
			_entry.HandleInit();
		}
		base.HandleInitState(stateId);
	}

	private void OnInteract(Entity behave)
	{
		if (!_isSwitching && behave.IsValid && Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.MovingPath))
		{
			_isSwitching = true;
			_entry.HandleExit();
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = new CancellationTokenSource();
			ExecuteSwitchAsync(behave, _cts.Token).Forget();
		}
	}

	private async UniTask ExecuteSwitchAsync(Entity behave, CancellationToken token)
	{
		_ = 2;
		try
		{
			switch (_data.SwitchMode)
			{
			case PathSwitchInteractMode.BlackScreenTeleport:
				EnterTransitionState();
				await TeleportWithBlackScreenAsync(token);
				break;
			case PathSwitchInteractMode.MoveWithoutBlackScreen:
				EnterTransitionState();
				await MoveWithoutBlackScreenAsync(behave, token);
				break;
			case PathSwitchInteractMode.ForcedRun:
				EnterTransitionState();
				await ForceRunAsync(behave, token);
				break;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception, this);
		}
		finally
		{
			CleanupTransitionState();
			_isSwitching = false;
			_cts?.Dispose();
			_cts = null;
		}
	}

	private void EnterTransitionState()
	{
		MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.MovingPath);
		_movingPathTagAdded = true;
		MonoECS.instance.PushPauseInteract();
		_pauseInteractPushed = true;
		MonoECS.instance.PushPauseAllInput();
		_pauseAllInputPushed = true;
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_BATTLEMAIN);
		_battleMainClosed = true;
		Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: true);
		_preparePositionLogicEnabled = true;
	}

	private async UniTask TeleportWithBlackScreenAsync(CancellationToken token)
	{
		token.ThrowIfCancellationRequested();
		int chunkId = ((_data.ChunkId == -1) ? Singleton<GameManager>.instance.worldManager.ActiveChunkId : _data.ChunkId);
		FaceDir faceDir = ((_data.ExitFaceDir == FaceDir.None) ? FaceDir.Right : _data.ExitFaceDir);
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = _data.TargetPosition,
			faceLeft = (faceDir == FaceDir.Left)
		};
		await TeleportUtility.TeleportWithPureBlackScreen(chunkId, teleportParams, _data.BlackFadeDuration);
		token.ThrowIfCancellationRequested();
	}

	private async UniTask MoveWithoutBlackScreenAsync(Entity behave, CancellationToken token)
	{
		CompTransform compTransform = behave.GetCompTransform();
		CompPhysics compPhysics = behave.GetCompPhysics();
		AniPartControl weaponAniPart = behave.GetMono()?.aniControl;
		FaceDir dir = ((_data.EnterFaceDir == FaceDir.None) ? FaceDir.Right : _data.EnterFaceDir);
		behave.SetFaceDir(dir);
		await UniTask.Delay(TimeSpan.FromSeconds(_data.RotateDuration), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		MonoECS.instance.EntityDissolve(behave, _data.DissolveDuration, isShow: false, isChangeRoot: false);
		weaponAniPart?.PlayHidden(AniPartControl.PartType.WeaponDissolve, _data.DissolveDuration, behave);
		await UniTask.Delay(TimeSpan.FromSeconds(_data.DissolveDuration), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		compTransform.UpdatePosition(_data.TargetPosition);
		compPhysics.SetConstZ(_data.TargetPosition.value.z);
		MonoECS.instance.EntityDissolve(behave, _data.DissolveDuration, isShow: true, isChangeRoot: false);
		weaponAniPart?.PlayVisible(AniPartControl.PartType.WeaponDissolve, _data.DissolveDuration, behave);
		await UniTask.Delay(TimeSpan.FromSeconds(_data.DissolveDuration), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		FaceDir faceDir = ((_data.ExitFaceDir == FaceDir.None) ? FaceDir.Right : _data.ExitFaceDir);
		SetFaceDirectionImmediately(behave, faceDir);
	}

	private async UniTask ForceRunAsync(Entity behave, CancellationToken token)
	{
		token.ThrowIfCancellationRequested();
		CompTransform compTransform = behave.GetCompTransform();
		CompPhysics compPhysics = behave.GetCompPhysics();
		Vector3 targetPosition = _data.TargetPosition.value;
		compTransform.UpdatePosition(_data.initPos);
		compPhysics.SetConstZ(_data.initPos.z);
		_forcedRunBehave = behave;
		_forcedRunActive = true;
		MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.PathSwitchMove);
		_pathSwitchMoveTagAdded = true;
		compPhysics.StartPathSwitchRootMotion(targetPosition, _data.EnterFaceDir);
		while (!compPhysics.IsPathSwitchRootMotionFinished)
		{
			await UniTask.DelayFrame(1, PlayerLoopTiming.LastFixedUpdate, token);
		}
		compTransform.UpdatePosition(_data.TargetPosition);
		compPhysics.SetConstZ(targetPosition.z);
		StopForcedRun();
	}

	private void StopForcedRun()
	{
		if (_forcedRunActive)
		{
			_forcedRunBehave.GetCompPhysics().SetMovementMode(ACTMovementMode.Walking);
			_forcedRunActive = false;
			FaceDir faceDir = ((_data.ExitFaceDir == FaceDir.None) ? FaceDir.Right : _data.ExitFaceDir);
			SetFaceDirectionImmediately(_forcedRunBehave, faceDir);
		}
	}

	private void SetFaceDirectionImmediately(Entity behave, FaceDir faceDir)
	{
		CompPhysics? compPhysics = behave.GetCompPhysics();
		behave.SetFaceDir(faceDir);
		compPhysics.SetDirImmediately();
	}

	private void CleanupTransitionState()
	{
		if (_preparePositionLogicEnabled)
		{
			Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: false);
			_preparePositionLogicEnabled = false;
		}
		if (_battleMainClosed)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			_battleMainClosed = false;
		}
		if (_pauseAllInputPushed)
		{
			MonoECS.instance.PopPauseAllInput();
			_pauseAllInputPushed = false;
		}
		if (_pauseInteractPushed)
		{
			MonoECS.instance.PopPauseInteract();
			_pauseInteractPushed = false;
		}
		if (_pathSwitchMoveTagAdded)
		{
			MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.PathSwitchMove);
			_pathSwitchMoveTagAdded = false;
		}
		if (_movingPathTagAdded)
		{
			MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.MovingPath);
			_movingPathTagAdded = false;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0 && !_isSwitching)
		{
			_entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0 && !_isSwitching)
		{
			_entry.HandleExit();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0 && !_isSwitching)
		{
			_entry.HandleInteract(eb, interactSource);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 0)
		{
			_entry.HandleUninit();
		}
	}

	protected override bool NeedInteractTip()
	{
		if (_entry == null || _entry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _entry;
	}

	public override Transform GetInteractTipTransform()
	{
		if (!(_interactTipTransform != null))
		{
			return transform;
		}
		return _interactTipTransform;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (_entry != null)
		{
			return ShowType.Show;
		}
		return ShowType.Hide;
	}

	public override bool ShowInteractTip()
	{
		return _entry != null;
	}

	public override bool CanInteract()
	{
		if (base.CanInteract())
		{
			return _entry != null;
		}
		return false;
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		_cts?.Cancel();
		StopForcedRun();
		CleanupTransitionState();
		_cts?.Dispose();
		_cts = null;
	}
}
