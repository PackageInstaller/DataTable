using System;
using ACT.Battle;
using ACT.Event;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBlackViscousCore : StateObjectBase
{
	private static readonly int State = Animator.StringToHash("state");

	private static readonly int InAttackField = Animator.StringToHash("inAttackField");

	private static readonly int SystemUnLock = Animator.StringToHash("systemUnLock");

	private const string UnAttackHit = "unAttackHit";

	private BlackViscousCoreData _data;

	private InteractEntry _interactEntry;

	private const int CoreActive = 0;

	private const int CoreDeActive = 1;

	private const int CoreHide = -1;

	private const int SwampActive = 0;

	private const int SwampDeActive = 1;

	private const int NeutralId = 11;

	[SerializeField]
	private string[] abilities;

	[SerializeField]
	private Vector3 _size;

	[SerializeField]
	private Vector3 _posOffset;

	[SerializeField]
	private Animator _animator;

	private bool _inAttackFiled;

	private GameObject _attackField;

	private bool _systemUnLock;

	private const int SystemId = 103108;

	private AssetLoadHandle[] _pointToLinkHandles;

	private static readonly Vector3 LineRenderEnd = new Vector3(0f, 0f, 9f);

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is BlackViscousCoreData data)
		{
			_data = data;
			_interactEntry = InteractEntry.CreateAttackEntry(11, in abilities, Alliance.Netural, in _size, in _posOffset);
			_interactEntry.BindInteractObjectBase(this);
			_interactEntry.BindData(compStateObject.StateWorldAssetData);
			_interactEntry.BindInteractState(0, 0);
			InteractEntry interactEntry = _interactEntry;
			interactEntry.onHPChangeInteract = (Action<int, int>)Delegate.Combine(interactEntry.onHPChangeInteract, new Action<int, int>(OnHpChangeInteract));
			InteractEntry interactEntry2 = _interactEntry;
			interactEntry2.onSpawnAttackable = (Action<Entity>)Delegate.Combine(interactEntry2.onSpawnAttackable, new Action<Entity>(OnAttackableSpawn));
			InteractEntry interactEntry3 = _interactEntry;
			interactEntry3.onHitInteract = (Action<Entity>)Delegate.Combine(interactEntry3.onHitInteract, new Action<Entity>(OnHitInteract));
			GameObject gameObject = new GameObject();
			gameObject.transform.SetParent(transform, worldPositionStays: false);
			_attackField = gameObject;
			gameObject.AddComponent<TemporaryArea>().Init(new MixedBox[1] { _data.MixedBox }, OnEnterField, OnExitField);
			_systemUnLock = Singleton<SystemUnlockManager>.instance.IsUnlock(103108);
			_animator.SetBool(SystemUnLock, _systemUnLock);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
			SpawnPointToLinks();
			base.InitStateObject(stateId);
		}
	}

	private void SpawnPointToLinks()
	{
		Pos[] pointToLinks = _data.PointToLinks;
		StateWorldUid[] linkObjects = _data.LinkObjects;
		if (pointToLinks == null || linkObjects == null || !_data.PointToLinkAssetId.RuntimeKeyIsValid())
		{
			return;
		}
		int num = Mathf.Min(pointToLinks.Length, linkObjects.Length);
		if (num == 0)
		{
			return;
		}
		_pointToLinkHandles = new AssetLoadHandle[num];
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		for (int i = 0; i < num; i++)
		{
			if (worldManager.GetWorldStateAssetDataBySGOID(linkObjects[i].value) != null)
			{
				Vector3 value = pointToLinks[i].value;
				Quaternion rotate = pointToLinks[i].rotate;
				_pointToLinkHandles[i] = AssetStationManager.BattleStation.Instantiate(_data.PointToLinkAssetId, transform);
				GameObject gameObject = _pointToLinkHandles[i].AsGameObject();
				gameObject.transform.position = value;
				gameObject.transform.rotation = rotate;
				MonoLineEffect component = gameObject.GetComponent<MonoLineEffect>();
				component.start = value;
				component.end = value + rotate * LineRenderEnd;
				gameObject.SetActive(currentStateId == 0);
			}
		}
	}

	private void OnSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 103108 } systemOpenEvt)
		{
			_systemUnLock = systemOpenEvt.unLock;
			_animator.SetBool(SystemUnLock, _systemUnLock);
		}
	}

	private void OnExitField()
	{
		_inAttackFiled = false;
		_animator.SetBool(InAttackField, _inAttackFiled);
	}

	private void OnEnterField()
	{
		_inAttackFiled = true;
		_animator.SetBool(InAttackField, _inAttackFiled);
	}

	private void OnHpChangeInteract(int from, int to)
	{
		if (to != 0)
		{
			return;
		}
		NetEnterState(1).Forget();
		if (_animator != null)
		{
			_animator.SetInteger(State, 1);
		}
		int num = _data.LinkObjects.Length;
		if (num > 0)
		{
			StateChangeInfo[] array = new StateChangeInfo[num];
			for (int i = 0; i < num; i++)
			{
				StateWorldUid stateWorldUid = _data.LinkObjects[i];
				array[i] = new StateChangeInfo
				{
					uid = stateWorldUid.value,
					stateId = 1
				};
			}
			MonoECS.instance.ruleManager.SharedChangeStates(array);
		}
	}

	private void OnHitInteract(Entity entityBehave)
	{
		if (entityBehave.IsCharacter() && (!_systemUnLock || !_inAttackFiled) && _animator != null)
		{
			_animator.CrossFadeInFixedTime("unAttackHit", 0f);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (_animator != null)
		{
			_animator.SetInteger(State, stateId);
		}
		if (stateId == 0)
		{
			_interactEntry.HandleInit();
		}
		_attackField.SetActive(stateId == 0);
		ActivePointLinks(stateId == 0);
	}

	protected override void HandleUninitState(int stateId)
	{
		if (stateId == 0)
		{
			_interactEntry.HandleUninit();
		}
	}

	private void OnAttackableSpawn(Entity entityBehave)
	{
		entityBehave.GetCompAbility().AddAbilities(abilities, AbilitySource.Ability);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		if (_pointToLinkHandles == null)
		{
			return;
		}
		for (int i = 0; i < _pointToLinkHandles.Length; i++)
		{
			AssetLoadHandle handle = _pointToLinkHandles[i];
			if (handle.IsValid)
			{
				AssetStationManager.BattleStation.Release(handle);
			}
		}
		_pointToLinkHandles = null;
	}

	private void ActivePointLinks(bool active)
	{
		if (_pointToLinkHandles == null)
		{
			return;
		}
		for (int i = 0; i < _pointToLinkHandles.Length; i++)
		{
			AssetLoadHandle assetLoadHandle = _pointToLinkHandles[i];
			if (assetLoadHandle.IsValid)
			{
				assetLoadHandle.AsGameObject().SetActive(active);
			}
		}
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
