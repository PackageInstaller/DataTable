using System.Threading;
using ACT.Battle;
using ACT.Sound;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBlackViscousSwamp : StateObjectBase
{
	private static readonly int State = Animator.StringToHash("state");

	private const int SwampActive = 0;

	private const int SwampDeActive = 1;

	private const int SwampHide = -1;

	private const int NeutralId = 1;

	private const string AuraFiled = "auraField";

	private const float SinkDuration = 2f;

	private const float SinkDistance = 1f;

	private Vector3 _initBoundsOffset;

	private BlackViscousSwampData _data;

	[SerializeField]
	private string[] _abilities;

	[SerializeField]
	private GameObject _mesh;

	private AssetLoadHandle _rippleHandle;

	private GameObject _rippleInstance;

	private Entity _auraFieldEntity;

	private CancellationTokenSource _tokenSource;

	private bool _addAbilities;

	private Bounds _swampBounds;

	private bool _rippleLoaded;

	private bool _isSinking;

	private float _sinkTimer;

	private float _sinkStartLocalY;

	private Vector3 _runTimeBoundsOffset;

	private uint _sinkingLoopSoundId;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BlackViscousSwampData data)
		{
			_data = data;
			_tokenSource = new CancellationTokenSource();
			_runTimeBoundsOffset = Vector3.zero;
			_isSinking = false;
			if (_data.RippleAssetID != null && _data.RippleAssetID.RuntimeKeyIsValid())
			{
				GameObject root = MonoECS.instance.GetRoot(SceneRootType.Effect);
				_rippleHandle = AssetStationManager.BattleStation.InstantiateAsync(_data.RippleAssetID, root.transform);
				_rippleHandle.Completed += OnRippleLoaded;
			}
			CoSpawnAttackEntity(stateId).Forget();
			base.InitStateObject(stateId);
		}
	}

	private void OnRippleLoaded(AssetLoadHandle handle)
	{
		_rippleInstance = handle.AsGameObject();
		_rippleInstance.SetActive(value: false);
		_rippleLoaded = true;
	}

	private async UniTaskVoid CoSpawnAttackEntity(int stateId)
	{
		_auraFieldEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		_auraFieldEntity.GetCompStateObject().StateWorldAssetData = _data;
		await MonoECS.instance.CoServerSpawnTrapAttack(_auraFieldEntity, 1, _data.trapType, _data.defenceTowerType, Alliance.Netural, transform.position, transform.rotation, Vector3.one, _data.AbilityEntityAssetID);
		if (_tokenSource.IsCancellationRequested)
		{
			return;
		}
		CompAbility compAbility = _auraFieldEntity.GetCompAbility();
		_auraFieldEntity.GetCompStateObject();
		MonoEntity mono = _auraFieldEntity.GetMono();
		if (stateId == 0)
		{
			for (int i = 0; i < _abilities.Length; i++)
			{
				compAbility.AddAbilities(_abilities, AbilitySource.Ability);
			}
		}
		_addAbilities = stateId == 0;
		MonoWeaponPart[] monoWeaponParts = mono.GetWeaponPart("auraField").monoWeaponParts;
		MonoWeaponPart[] array = monoWeaponParts;
		foreach (MonoWeaponPart obj in array)
		{
			float x = ((BoxCollider)obj.myCollider).size.x * _data.initScale.x;
			float y = ((BoxCollider)obj.myCollider).size.y * _data.initScale.y;
			float z = ((BoxCollider)obj.myCollider).size.z * _data.initScale.z;
			((BoxCollider)obj.myCollider).size = new Vector3(x, y, z);
		}
		BoxCollider boxCollider = (BoxCollider)monoWeaponParts[0].myCollider;
		_initBoundsOffset = boxCollider.center;
		_swampBounds = new Bounds(transform.position + _initBoundsOffset, boxCollider.size);
	}

	protected override void HandleInitState(int stateId)
	{
		if (!_isSinking && _mesh != null)
		{
			_mesh.SetActive(stateId == 0);
		}
		CompAbility compAbility = _auraFieldEntity.GetCompAbility();
		if (stateId != 0)
		{
			for (int i = 0; i < _abilities.Length; i++)
			{
				compAbility.RemoveAbility(_abilities[i]);
			}
			_addAbilities = false;
		}
		else if (!_addAbilities)
		{
			for (int j = 0; j < _abilities.Length; j++)
			{
				compAbility.AddAbilities(_abilities, AbilitySource.Ability);
			}
		}
	}

	private void FixedUpdate()
	{
		if (_data != null)
		{
			if (_isSinking)
			{
				UpdateSinking();
			}
			if (currentStateId == 0 || _isSinking)
			{
				UpdateRippleEffect();
			}
		}
	}

	private void UpdateRippleEffect()
	{
		if (!_rippleLoaded || _rippleInstance == null)
		{
			return;
		}
		Entity battleEntity = MonoECS.instance.localPlayer.battleEntity;
		if (!battleEntity.IsValid)
		{
			_rippleInstance.SetActive(value: false);
			return;
		}
		Vector3 position = battleEntity.GetRootTransform().position;
		_swampBounds.center = transform.position + _runTimeBoundsOffset + _initBoundsOffset;
		if (_swampBounds.Contains(position))
		{
			float y = _swampBounds.center.y + _swampBounds.extents.y;
			_rippleInstance.transform.position = new Vector3(position.x, y, position.z);
			_rippleInstance.SetActive(value: true);
		}
		else
		{
			_rippleInstance.SetActive(value: false);
		}
	}

	private void UpdateSinking()
	{
		_sinkTimer += Time.fixedDeltaTime;
		float num = Mathf.Clamp01(_sinkTimer / 2f);
		float num2 = Mathf.Lerp(0f, -1f, num);
		if (_mesh != null)
		{
			Vector3 localPosition = _mesh.transform.localPosition;
			localPosition.y = _sinkStartLocalY + num2;
			_mesh.transform.localPosition = localPosition;
		}
		_runTimeBoundsOffset = new Vector3(0f, num2, 0f);
		_swampBounds.center = transform.position + _runTimeBoundsOffset + _initBoundsOffset;
		if (num >= 1f)
		{
			StopSinkingLoopSound();
			_isSinking = false;
			if (_mesh != null)
			{
				_mesh.SetActive(value: false);
			}
			if (_rippleInstance != null)
			{
				_rippleInstance.SetActive(value: false);
			}
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId == 0 && toStateId == 1)
		{
			_isSinking = true;
			_sinkTimer = 0f;
			_sinkStartLocalY = ((_mesh != null) ? _mesh.transform.localPosition.y : 0f);
			PlaySinkingLoopSound();
		}
	}

	private void StopSinkingLoopSound()
	{
		if (_sinkingLoopSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_sinkingLoopSoundId);
		}
	}

	private void PlaySinkingLoopSound()
	{
		StopSinkingLoopSound();
		_sinkingLoopSoundId = Singleton<GameManager>.instance.audioManager.PlaySound(_data.SinkingSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private async UniTaskVoid ReleaseAuraEntity()
	{
		if (!_auraFieldEntity.IsValid)
		{
			return;
		}
		if (_auraFieldEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(_auraFieldEntity);
			return;
		}
		await UniTask.WaitUntil(() => _auraFieldEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(_auraFieldEntity);
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		StopSinkingLoopSound();
		_tokenSource.Cancel();
		_tokenSource.Dispose();
		if (AssetLoadHandleExtensions.IsValid(_rippleHandle))
		{
			_rippleHandle.Completed -= OnRippleLoaded;
			AssetStationManager.BattleStation.ReleaseInstance(_rippleHandle);
		}
		_rippleInstance = null;
		_rippleLoaded = false;
		ReleaseAuraEntity().Forget();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
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
