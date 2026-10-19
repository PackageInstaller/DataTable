using System.Threading;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractOrbitTrap : StateObjectBase
{
	private Entity m_AttackEntity;

	private CancellationTokenSource m_TokenSource;

	private OrbitTrapAreaData m_Data;

	private bool _spawnCompleted;

	private int _pendingStateId = int.MinValue;

	private const int AttackId = 1;

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == -1;
		}
		return true;
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is OrbitTrapAreaData data)
		{
			m_Data = data;
			m_TokenSource = new CancellationTokenSource();
			CoSpawnAttackEntity().Forget();
			base.InitStateObject(stateId);
		}
	}

	private async UniTaskVoid CoSpawnAttackEntity()
	{
		m_AttackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = m_AttackEntity;
		eb.GetCompStateObject().StateWorldAssetData = m_Data;
		await MonoECS.instance.CoServerSpawnTrapAttack(eb, 1, m_Data.trapType, m_Data.defenceTowerType, Alliance.Enemy, transform.position, transform.rotation, Vector3.one, m_Data.attackEntityWrapAssetID);
		if (!m_TokenSource.IsCancellationRequested)
		{
			eb.GetMono().GetMixedPart("attackField").monoAttackPart.Init(m_Data.fields);
			_spawnCompleted = true;
			if (_pendingStateId != int.MinValue)
			{
				ApplyInitState(_pendingStateId);
				_pendingStateId = int.MinValue;
			}
		}
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!m_AttackEntity.IsValid)
		{
			return;
		}
		if (m_AttackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(m_AttackEntity);
			return;
		}
		await UniTask.WaitUntil(() => m_AttackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(m_AttackEntity);
	}

	public override void ReleaseStateObject()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		_spawnCompleted = false;
		_pendingStateId = int.MinValue;
		ReleaseAttackEntity().Forget();
		base.ReleaseStateObject();
	}

	protected override void HandleInitState(int stateId)
	{
		if (!_spawnCompleted)
		{
			_pendingStateId = stateId;
		}
		else
		{
			ApplyInitState(stateId);
		}
	}

	private void ApplyInitState(int stateId)
	{
		CompAbility compAbility = m_AttackEntity.GetCompAbility();
		switch (stateId)
		{
		case 0:
			compAbility.AddAbilities(m_Data.abilities, AbilitySource.Ability);
			break;
		case -1:
		{
			string[] abilities = m_Data.abilities;
			foreach (string text in abilities)
			{
				compAbility.RemoveAbility(text);
			}
			break;
		}
		}
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
