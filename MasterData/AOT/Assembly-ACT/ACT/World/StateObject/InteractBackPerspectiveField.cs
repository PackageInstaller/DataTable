using System;
using System.Threading;
using ACT.Battle;
using ACT.Battle.ECS.System;
using ACT.Model;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBackPerspectiveField : StateObjectBase
{
	[SerializeField]
	private CinemachineVirtualCamera _vcam;

	private BackPerspectiveFieldData _data;

	private GameObject _enterFieldRoot;

	private GameObject _exitFieldRoot;

	private bool _isInEnterArea;

	private bool _isWaitingGuideEnd;

	private const int ENTER = 0;

	private const int EXIT = 1;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BackPerspectiveFieldData data)
		{
			_data = data;
			_enterFieldRoot = new GameObject();
			_enterFieldRoot.transform.SetParent(transform, worldPositionStays: false);
			_enterFieldRoot.AddComponent<TemporaryArea>().Init(_data.EnterFields, OnEnterAreaEnter, OnEnterAreaExit);
			_exitFieldRoot = new GameObject();
			_exitFieldRoot.transform.SetParent(transform, worldPositionStays: false);
			_exitFieldRoot.AddComponent<TemporaryArea>().Init(_data.ExitField, null, OnExitAreaExit);
			_vcam.enabled = false;
			SystemCamera cameraSystem = GameManager.cameraSystem;
			_vcam.Follow = cameraSystem.CameraPlayerWrapper.transform;
			_vcam.LookAt = cameraSystem.CameraPlayerWrapper.transform;
			base.InitStateObject(stateId);
		}
	}

	private void OnEnterAreaEnter()
	{
		if (currentStateId == 0)
		{
			_isInEnterArea = true;
			if (Model<GuideModel>.Interface != null && Model<GuideModel>.Interface.IsInStrongGuide())
			{
				WaitForStrongGuideEnd().Forget();
			}
			else if (currentStateId == 0)
			{
				_vcam.enabled = true;
				Model<BattleMainModel>.Interface.SetPlayerPerspective(PlayerPerspectiveState.Back);
			}
		}
	}

	private async UniTaskVoid WaitForStrongGuideEnd()
	{
		if (_isWaitingGuideEnd)
		{
			return;
		}
		_isWaitingGuideEnd = true;
		CancellationToken cancellationToken = this.GetCancellationTokenOnDestroy();
		try
		{
			await UniTask.WaitUntil(() => Model<GuideModel>.Interface == null || !Model<GuideModel>.Interface.IsInStrongGuide(), PlayerLoopTiming.Update, cancellationToken);
		}
		catch (OperationCanceledException arg)
		{
			Debug.LogWarning($"[InteractBackPerspectiveField] 强引导等待被取消。{arg}");
			return;
		}
		finally
		{
			_isWaitingGuideEnd = false;
		}
		if (!cancellationToken.IsCancellationRequested && _isInEnterArea)
		{
			OnEnterAreaEnter();
		}
	}

	private void OnExit()
	{
		_isInEnterArea = false;
		_vcam.enabled = false;
		Model<BattleMainModel>.Interface.SetPlayerPerspective(PlayerPerspectiveState.Normal);
	}

	private void OnEnterAreaExit()
	{
		if (currentStateId == 0)
		{
			OnExit();
		}
	}

	private void OnExitAreaExit()
	{
		if (currentStateId == 0)
		{
			OnExit();
			NetEnterState(1).Forget();
		}
	}

	public override void ReleaseStateObject()
	{
		_isInEnterArea = false;
		base.ReleaseStateObject();
		if (Model<BattleMainModel>.Interface.IsBack)
		{
			Model<BattleMainModel>.Interface.SetPlayerPerspective(PlayerPerspectiveState.Normal);
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
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
