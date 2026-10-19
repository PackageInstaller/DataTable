using System.Threading;
using ACT.Battle;
using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/interactWalkureDamageArea")]
public class InteractWalkureDamageArea : StateObjectBase
{
	[SerializeField]
	private string[] _abilities;

	[SerializeField]
	private AudioEventReference _stallSoundEvent;

	[SerializeField]
	private AudioEventReference _warningSoundEvent;

	[SerializeField]
	private AudioEventReference _fireSoundEvent;

	private const int _neutralId = 1;

	private const int _activeId = 0;

	private const int _deActiveId = -1;

	private const int _stall = 0;

	private const int _warning = 1;

	private const int _fire = 2;

	private WalkureDamageAreaData _data;

	private AssetLoadHandle _handle;

	private static readonly int StateId = Animator.StringToHash("state");

	private static readonly int BehaveStateId = Animator.StringToHash("behaveState");

	private Entity _attackEntity;

	private Animator _animator;

	private int _index;

	private bool _init;

	private bool _animatorInit;

	private int _behaveId;

	private CancellationTokenSource _tokenSource;

	private bool _abilitiesAdded;

	private const float _warningRunTime = 3f;

	private const float _eruptionRunTime = 2f;

	private const string _attackField = "attackField";

	private float _runTimer;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		_data = entity.GetCompStateObject()?.StateWorldAssetData as WalkureDamageAreaData;
		_tokenSource = new CancellationTokenSource();
		if (_data.EffectPrefabAssetID != null && _data.EffectPrefabAssetID.RuntimeKeyIsValid())
		{
			_handle = AssetStationManager.BattleStation.Instantiate(_data.EffectPrefabAssetID, transform);
			GameObject gameObject = _handle.AsGameObject();
			gameObject.transform.position = _data.EffectPosition;
			_animator = gameObject.transform.GetComponentInChildren<Animator>();
			_animator.SetInteger(StateId, stateId);
			_animator.SetInteger(BehaveStateId, _behaveId);
			_animatorInit = true;
		}
		CoSpawnAttackEntity().Forget();
		base.InitStateObject(stateId);
	}

	private async UniTaskVoid CoSpawnAttackEntity()
	{
		_attackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = _attackEntity;
		eb.GetCompStateObject().StateWorldAssetData = _data;
		await MonoECS.instance.CoServerSpawnTrapAttack(eb, 1, _data.trapType, _data.defenceTowerType, Alliance.Netural, transform.position, transform.rotation, Vector3.one, _data.AttackEntityWrapAssetID);
		if (!_tokenSource.IsCancellationRequested)
		{
			InitWeaponParts(eb);
			_init = true;
			UpdateAbilities();
		}
	}

	private void InitWeaponParts(Entity eb)
	{
		if (_data.Fields == null || _data.Fields.Length == 0)
		{
			return;
		}
		int num = -1;
		MonoEntity mono = eb.GetMono();
		WeaponPart[] array = eb.GetMono()?.weaponParts;
		if (!(mono != null) || array == null)
		{
			return;
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].name == "attackField")
			{
				num = i;
				break;
			}
		}
		if (num < 0)
		{
			Debug.LogWarning("WalkureDamageArea未找到名为attackField的WeaponPart配置", this);
			return;
		}
		WeaponPart weaponPart = mono.weaponParts[num];
		Transform parent = mono.transform;
		if (weaponPart.monoWeaponParts != null)
		{
			MonoWeaponPart[] monoWeaponParts = weaponPart.monoWeaponParts;
			foreach (MonoWeaponPart monoWeaponPart in monoWeaponParts)
			{
				if (monoWeaponPart != null)
				{
					Object.Destroy(monoWeaponPart.gameObject);
				}
			}
		}
		MonoWeaponPart[] array2 = new MonoWeaponPart[_data.Fields.Length];
		for (int k = 0; k < _data.Fields.Length; k++)
		{
			MixedBox mixedBox = _data.Fields[k];
			GameObject gameObject = new GameObject("Area:" + mixedBox.name);
			int num2 = LayerMask.NameToLayer("AttackBox");
			if (num2 >= 0)
			{
				gameObject.layer = num2;
			}
			gameObject.transform.SetParent(parent, worldPositionStays: false);
			BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
			boxCollider.isTrigger = true;
			mixedBox.CopyTo(boxCollider, gameObject.transform);
			MonoWeaponPart monoWeaponPart2 = gameObject.AddComponent<MonoWeaponPart>();
			monoWeaponPart2.myCollider = boxCollider;
			array2[k] = monoWeaponPart2;
		}
		weaponPart.monoWeaponParts = array2;
		mono.weaponParts[num] = weaponPart;
	}

	public override void ReleaseStateObject()
	{
		_tokenSource.Cancel();
		_tokenSource.Dispose();
		if (AssetLoadHandleExtensions.IsValid(_handle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_handle);
		}
		ReleaseAttackEntity().Forget();
		base.ReleaseStateObject();
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

	protected override void HandleInitState(int stateId)
	{
		_animator.SetInteger(StateId, stateId);
		if (stateId == -1)
		{
			RemoveAbilities();
			_runTimer = 0f;
		}
		else
		{
			_index = _data.InitIndex;
			_behaveId = _data.States[_index].StateId;
			SetState(_behaveId);
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

	private void FixedUpdate()
	{
		if (_init && _data.States.Length != 0 && currentStateId != -1 && _runTimer > 0f)
		{
			CompTime compTime = entity.GetCompTime();
			if (compTime != null)
			{
				_runTimer -= compTime.fixedDeltaTime;
			}
			if (_runTimer < 0f)
			{
				MoveToNextAreaState();
			}
		}
	}

	private void MoveToNextAreaState()
	{
		_index++;
		if (_index > _data.States.Length - 1)
		{
			_index = 0;
		}
		int stateId = _data.States[_index].StateId;
		ChangeBehaveState(stateId);
	}

	private void ChangeBehaveState(int targetState)
	{
		if (targetState != _behaveId)
		{
			_behaveId = targetState;
			SetState(_behaveId);
		}
	}

	private void SetState(int targetState)
	{
		RunState(targetState);
		if (_animator != null && _animatorInit)
		{
			_animator.SetInteger(BehaveStateId, targetState);
		}
		AudioEventReference eventRef = targetState switch
		{
			0 => _stallSoundEvent, 
			1 => _warningSoundEvent, 
			2 => _fireSoundEvent, 
			_ => default, 
		};
		Singleton<GameManager>.instance.audioManager?.PlaySound(eventRef, new AudioPlayOptions
		{
			attachTarget = _handle.AsGameObject().transform
		});
		UpdateAbilities();
	}

	private void RunState(int stateId)
	{
		WalkureAreaState[] states = _data.States;
		foreach (WalkureAreaState walkureAreaState in states)
		{
			if (walkureAreaState.StateId == stateId)
			{
				_runTimer = walkureAreaState.StateId switch
				{
					0 => walkureAreaState.RunTime, 
					1 => 3f, 
					2 => 2f, 
					_ => 0f, 
				};
				break;
			}
		}
	}

	private void UpdateAbilities()
	{
		if (_attackEntity.IsValid)
		{
			if (_behaveId == 2 && currentStateId == 0)
			{
				AddAbilities();
			}
			else
			{
				RemoveAbilities();
			}
		}
	}

	private void AddAbilities()
	{
		if (!_abilitiesAdded)
		{
			_attackEntity.GetCompAbility()?.AddAbilities(_abilities, AbilitySource.Ability);
			_abilitiesAdded = true;
		}
	}

	private void RemoveAbilities()
	{
		if (_abilitiesAdded && _attackEntity.IsValid)
		{
			for (int i = 0; i < _abilities.Length; i++)
			{
				_attackEntity.GetCompAbility()?.RemoveAbility(_abilities[i]);
			}
			_abilitiesAdded = false;
		}
	}
}
