using System.Threading;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractPoisonousFog : StateObjectBase
{
	private Entity _attackEntity;

	private CancellationTokenSource _tokenSource;

	private PoisonousFogData _data;

	private const string WeaponPart = "attackField";

	private static readonly int STATEID = Animator.StringToHash("state");

	private AssetLoadHandle _backHandle;

	private AssetLoadHandle _frontHandle;

	private Animator _backAnimator;

	private Animator _frontAnimator;

	private bool _backAnimatorInit;

	private bool _frontAnimatorInit;

	private bool _attackEntityInit;

	private const float PlaneSize = 2.7f;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is PoisonousFogData data)
		{
			_data = data;
			_tokenSource = new CancellationTokenSource();
			_backHandle = AssetStationManager.BattleStation.InstantiateAsync(_data.PlaneBackPrefabAssetID, transform);
			_frontHandle = AssetStationManager.BattleStation.InstantiateAsync(_data.PlaneFrontPrefabAssetID, transform);
			_backHandle.Completed += BackCompleted;
			_frontHandle.Completed += FrontCompleted;
			CoSpawnAttackEntity().Forget();
			base.InitStateObject(stateId);
		}
	}

	private void BackCompleted(AssetLoadHandle obj)
	{
		GameObject gameObject = obj.AsGameObject();
		Transform transform = gameObject.transform;
		Vector3 center = _data.Field.center;
		Vector3 size = _data.Field.size;
		center.z += size.z / 2f;
		float x = size.x / 2.7f;
		float y = size.y / 2.7f;
		Vector3 localScale = new Vector3(x, y, 1f);
		transform.position = center + base.transform.position;
		transform.localScale = localScale;
		_backAnimator = gameObject.transform.GetComponentInChildren<Animator>();
		if (_backAnimator != null)
		{
			_backAnimator.SetInteger(STATEID, currentStateId);
		}
		_backAnimatorInit = true;
	}

	private void FrontCompleted(AssetLoadHandle obj)
	{
		GameObject gameObject = obj.AsGameObject();
		Transform transform = gameObject.transform;
		Vector3 center = _data.Field.center;
		Vector3 size = _data.Field.size;
		center.z -= size.z / 2f;
		float x = size.x / 2.7f;
		float y = size.y / 2.7f;
		Vector3 localScale = new Vector3(x, y, 1f);
		transform.position = center + base.transform.position;
		transform.localScale = localScale;
		_frontAnimator = gameObject.transform.GetComponentInChildren<Animator>();
		if (_frontAnimator != null)
		{
			_frontAnimator.SetInteger(STATEID, currentStateId);
		}
		_frontAnimatorInit = true;
	}

	private async UniTaskVoid CoSpawnAttackEntity()
	{
		Entity eb = (_attackEntity = GameManager.entities.factory.CreateMechanismTrapEntity());
		eb.GetCompStateObject().StateWorldAssetData = _data;
		await MonoECS.instance.CoServerSpawnTrapAttack(eb, _data.AttackId, _data.trapType, _data.defenceTowerType, _data.Alliance, transform.position, transform.rotation, Vector3.one, _data.AttackEntityWrapAssetID);
		if (!_tokenSource.IsCancellationRequested)
		{
			MonoWeaponPart[] monoWeaponParts = eb.GetMono().GetWeaponPart("attackField").monoWeaponParts;
			foreach (MonoWeaponPart monoWeaponPart in monoWeaponParts)
			{
				_data.Field.CopyTo(monoWeaponPart.myCollider as BoxCollider);
			}
			if (currentStateId == 0)
			{
				eb.GetCompAbility().AddAbilities(_data.Abilities, AbilitySource.Ability);
			}
			_attackEntityInit = true;
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (_backAnimator != null && _backAnimatorInit)
		{
			_backAnimator.SetInteger(STATEID, stateId);
		}
		if (_frontAnimator != null && _frontAnimatorInit)
		{
			_frontAnimator.SetInteger(STATEID, stateId);
		}
		CompAbility compAbility = _attackEntity.GetCompAbility();
		if (stateId == 0 && _attackEntityInit)
		{
			compAbility.AddAbilities(_data.Abilities, AbilitySource.Ability);
		}
		if (stateId == 1 && _attackEntityInit)
		{
			for (int i = 0; i < _data.Abilities.Length; i++)
			{
				compAbility.RemoveAbility(_data.Abilities[i]);
			}
		}
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!_attackEntity.IsValid)
		{
			return;
		}
		if (_attackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(_attackEntity);
			return;
		}
		await UniTask.WaitUntil(() => _attackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(_attackEntity);
	}

	public override void ReleaseStateObject()
	{
		_tokenSource.Cancel();
		_tokenSource.Dispose();
		if (AssetLoadHandleExtensions.IsValid(_backHandle))
		{
			_backHandle.Completed -= BackCompleted;
			AssetStationManager.BattleStation.ReleaseInstance(_backHandle);
		}
		if (AssetLoadHandleExtensions.IsValid(_frontHandle))
		{
			_frontHandle.Completed -= FrontCompleted;
			AssetStationManager.BattleStation.ReleaseInstance(_frontHandle);
		}
		ReleaseAttackEntity().Forget();
		base.ReleaseStateObject();
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
