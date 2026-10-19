using System;
using System.Threading;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBreakableByBloodThunderPlatform : StateObjectBase
{
	private static readonly int State = Animator.StringToHash("state");

	private const int PlatformHide = -1;

	private const int PlatformActive = 0;

	private const int PlatformBroken = 1;

	private const int AnimReshape = 2;

	private BreakableByBloodThunderPlatformData _data;

	private InteractEntry _interactEntry;

	private CancellationTokenSource _tokenSource;

	private CancellationTokenSource _reshapeTokenSource;

	private bool _isReshaping;

	[SerializeField]
	private string[] _abilities;

	[SerializeField]
	private Animator _animator;

	[SerializeField]
	private BoxCollider _collider;

	private const int AttackableId = 11;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is BreakableByBloodThunderPlatformData data)
		{
			_data = data;
			_tokenSource = new CancellationTokenSource();
			_interactEntry = InteractEntry.CreateAttackEntry(11, in _abilities, Alliance.Character, _collider.size, new Vector3(0f, 0.4f, 0f));
			_interactEntry.BindInteractObjectBase(this);
			_interactEntry.BindData(compStateObject.StateWorldAssetData);
			_interactEntry.BindInteractState(0, 0);
			InteractEntry interactEntry = _interactEntry;
			interactEntry.onHPChangeInteract = (Action<int, int>)Delegate.Combine(interactEntry.onHPChangeInteract, new Action<int, int>(OnHpChangeInteract));
			base.InitStateObject(stateId);
		}
	}

	private void OnHpChangeInteract(int from, int to)
	{
		if (to == 0 && currentStateId == 0)
		{
			if (_data.CanRecover)
			{
				PlayReshapeAsync().Forget();
				return;
			}
			CancelReshape();
			NetEnterState(1).Forget();
		}
	}

	private async UniTaskVoid PlayReshapeAsync()
	{
		CancelReshape();
		_isReshaping = true;
		_reshapeTokenSource = CancellationTokenSource.CreateLinkedTokenSource(_tokenSource.Token);
		SetAnimatorState(2);
		await UniTask.Delay(TimeSpan.FromSeconds(_data.RecoverTime), ignoreTimeScale: false, PlayerLoopTiming.Update, _reshapeTokenSource.Token);
		SetAnimatorState(0);
		_interactEntry.HandleInit();
		_isReshaping = false;
	}

	private void CancelReshape()
	{
		if (_reshapeTokenSource != null)
		{
			_reshapeTokenSource.Cancel();
			_reshapeTokenSource.Dispose();
			_reshapeTokenSource = null;
			_isReshaping = false;
		}
	}

	private void SetAnimatorState(int animatorState)
	{
		if (_animator != null)
		{
			_animator.SetInteger(State, animatorState);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		SetAnimatorState(stateId);
		if (stateId == 0)
		{
			_interactEntry.HandleInit();
		}
		else
		{
			_interactEntry.HandleUninit();
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

	public override void ReleaseStateObject()
	{
		_tokenSource.Cancel();
		_tokenSource.Dispose();
		CancelReshape();
		base.ReleaseStateObject();
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == -1;
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
