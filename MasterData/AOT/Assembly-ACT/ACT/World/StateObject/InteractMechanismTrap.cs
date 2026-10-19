using System.Threading;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractMechanismTrap : StateObjectBase
{
	private MechanismTrapData data;

	private Entity _trapEntity;

	private Animator _animator;

	private bool _animationInitOver;

	private CancellationTokenSource _tokenSource;

	public override bool serviceSave => true;

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
	}

	protected override void HandleExitInteract()
	{
	}

	public override void InitStateObject(int stateId)
	{
		data = entity.GetCompStateObject().StateWorldAssetData as MechanismTrapData;
		_tokenSource = new CancellationTokenSource();
		CoSpawnTrap(MonoECS.instance, data).Forget();
		base.InitStateObject(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		InitState();
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	public override async void ReleaseStateObject()
	{
		_tokenSource.Cancel();
		_tokenSource.Dispose();
		if (_trapEntity.IsValid)
		{
			if (_trapEntity.CanRemove())
			{
				MonoECS.instance.TryRemoveBehave(_trapEntity);
			}
			else
			{
				await UniTask.WaitUntil(() => _trapEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
				MonoECS.instance.TryRemoveBehave(_trapEntity);
			}
		}
		base.ReleaseStateObject();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
	}

	private async void InitState()
	{
		if (!_animationInitOver)
		{
			await UniTask.WaitUntil(() => _animationInitOver);
		}
		if (currentStateId >= 0 && data.stateStartTimes.Length > currentStateId && data.stateStartTimes[currentStateId] > 0f)
		{
			_tokenSource.Cancel();
			_tokenSource.Dispose();
			_tokenSource = new CancellationTokenSource();
		}
		StartAnimationState(_trapEntity, data, _tokenSource.Token).SuppressCancellationThrow().Forget();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	private void FixedUpdate()
	{
		if (_animator != null && _trapEntity.IsValid)
		{
			_animator.speed = _trapEntity.GetCompTime().fixedSpeed;
		}
	}

	private void InitAnimation()
	{
		_animator = _trapEntity.GetMono().GetComponent<Animator>();
		_animationInitOver = true;
	}

	private async UniTask CoSpawnTrap(MonoECS m_ECS, MechanismTrapData data)
	{
		_trapEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		_trapEntity.GetCompStateObject().StateWorldAssetData = data;
		await MonoECS.instance.CoServerSpawnTrapAttack(_trapEntity, data.entityNeutralId, data.trapType, data.defenceTowerType, data.alliance, transform.position, transform.rotation, data.scale, data.MechanismEntityAssetID, transform);
		InitAnimation();
	}

	private async UniTask StartAnimationState(Entity eb, MechanismTrapData data, CancellationToken token)
	{
		if (currentStateId >= 0 && data.stateStartTimes.Length > currentStateId && data.stateStartTimes[currentStateId] > 0f)
		{
			float time = data.stateStartTimes[currentStateId];
			CompTime compTime = entity.GetCompTime();
			await UniTask.WaitUntil(() =>
			{
				time -= compTime.motionFixedDeltaTime;
				return time < 0f;
			}, PlayerLoopTiming.FixedUpdate, token);
		}
		if (!token.IsCancellationRequested)
		{
			_animator.SetInteger(data.stateParameter, currentStateId);
		}
	}

	public void SetState()
	{
		MonoECS.instance.ruleManager.SharedChangeState(entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, (currentStateId == 0) ? 1 : 0);
	}
}
