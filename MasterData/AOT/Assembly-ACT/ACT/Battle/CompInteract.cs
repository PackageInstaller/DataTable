using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Linq;
using ACT.Model;
using ACT.UI;
using ACT.World.StateObject;
using Bamboo.ECS;
using Bamboo.Precache;
using Fundamental;
using Runtime.Battle.ECS.System.SystemInteract;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.Battle;

public class CompInteract : EcsComponent
{
	public const string INTERACTUI1 = "InteractUI";

	public const string INTERACTUI2 = "IconPosition";

	private static ObjectPool<ObservableCollection<InteractEntry>> _objectPool = new ObjectPool<ObservableCollection<InteractEntry>>((ObservableCollection<InteractEntry> x) =>
	{
		x.Clear();
	}, null);

	private Entity _entityBehave;

	private MonoTriggerInteract _monoTriggerInteract;

	private CommonInteractUI _commonInteractTip;

	private Dictionary<InteractEntry, Action<Entity>> _cachedEntryActions;

	private bool _inTrigger;

	private bool _isCommonInteractTipEntered;

	public Entity EntityBehave
	{
		get
		{
			return _entityBehave;
		}
		set
		{
			if ((bool)_monoTriggerInteract)
			{
				MonoTriggerInteract monoTriggerInteract = _monoTriggerInteract;
				monoTriggerInteract.OnTriggerEnterCallback = (UnityAction<Collider>)Delegate.Remove(monoTriggerInteract.OnTriggerEnterCallback, new UnityAction<Collider>(InvokeOnTriggerEnter));
				MonoTriggerInteract monoTriggerInteract2 = _monoTriggerInteract;
				monoTriggerInteract2.OnTriggerExitCallback = (UnityAction<Collider>)Delegate.Remove(monoTriggerInteract2.OnTriggerExitCallback, new UnityAction<Collider>(InvokeOnTriggerExit));
				MonoTriggerInteract monoTriggerInteract3 = _monoTriggerInteract;
				monoTriggerInteract3.OnTriggerStayCallback = (UnityAction<Collider>)Delegate.Remove(monoTriggerInteract3.OnTriggerStayCallback, new UnityAction<Collider>(InvokeOnTriggerStay));
				_monoTriggerInteract = null;
			}
			TipSyncTransform = null;
			_entityBehave = value;
			GameObject gameObject = (TriggerRoot ? TriggerRoot : value.GetModel());
			_monoTriggerInteract = (TriggerRoot ? gameObject.GetComponent<MonoTriggerInteract>() : gameObject?.GetComponentInChildren<MonoTriggerInteract>());
			if ((bool)gameObject && !_monoTriggerInteract)
			{
				_monoTriggerInteract = gameObject.AddComponent<MonoTriggerInteract>();
				MonoTriggerInteract monoTriggerInteract4 = _monoTriggerInteract;
				monoTriggerInteract4.OnTriggerEnterCallback = (UnityAction<Collider>)Delegate.Combine(monoTriggerInteract4.OnTriggerEnterCallback, new UnityAction<Collider>(InvokeOnTriggerEnter));
				MonoTriggerInteract monoTriggerInteract5 = _monoTriggerInteract;
				monoTriggerInteract5.OnTriggerExitCallback = (UnityAction<Collider>)Delegate.Combine(monoTriggerInteract5.OnTriggerExitCallback, new UnityAction<Collider>(InvokeOnTriggerExit));
				MonoTriggerInteract monoTriggerInteract6 = _monoTriggerInteract;
				monoTriggerInteract6.OnTriggerStayCallback = (UnityAction<Collider>)Delegate.Combine(monoTriggerInteract6.OnTriggerStayCallback, new UnityAction<Collider>(InvokeOnTriggerStay));
			}
			TipSyncTransform = GetTipSyncTransform();
			TryLoadInteractTip();
		}
	}

	public MonoTriggerInteract MonoTriggerInteract => _monoTriggerInteract;

	public GameObject TriggerRoot { get; set; }

	public ObservableCollection<InteractEntry> Entries { get; private set; }

	public Action<Entity, InteractEntry> OnEntryInteract { get; set; }

	public InstanceHandle InteractLoader
	{
		get
		{
			if (!Model<CommonInteractUIModel>.HasInstance())
			{
				return null;
			}
			return Model<CommonInteractUIModel>.Interface.GetInstanceHandle(this);
		}
	}

	public CommonInteractUI CommonInteractTip => _commonInteractTip;

	public Transform TipSyncTransform { get; private set; }

	public Func<bool> CanLoadCommonInteractTip { get; set; }

	protected override void OnGet()
	{
		Entries = _objectPool.Get();
		Entries.CollectionChanged += EntriesOnCollectionChanged;
		_cachedEntryActions = DictionaryPool<InteractEntry, Action<Entity>>.Get();
		_entityBehave = default;
	}

	protected override void OnRelease()
	{
		if (_inTrigger)
		{
			foreach (InteractEntry entry in Entries)
			{
				entry.HandleExit();
			}
			_inTrigger = false;
			SyncCommonInteractTipState();
		}
		Entries.CollectionChanged -= EntriesOnCollectionChanged;
		if ((bool)_monoTriggerInteract)
		{
			MonoTriggerInteract monoTriggerInteract = _monoTriggerInteract;
			monoTriggerInteract.OnTriggerEnterCallback = (UnityAction<Collider>)Delegate.Remove(monoTriggerInteract.OnTriggerEnterCallback, new UnityAction<Collider>(InvokeOnTriggerEnter));
			MonoTriggerInteract monoTriggerInteract2 = _monoTriggerInteract;
			monoTriggerInteract2.OnTriggerExitCallback = (UnityAction<Collider>)Delegate.Remove(monoTriggerInteract2.OnTriggerExitCallback, new UnityAction<Collider>(InvokeOnTriggerExit));
			MonoTriggerInteract monoTriggerInteract3 = _monoTriggerInteract;
			monoTriggerInteract3.OnTriggerStayCallback = (UnityAction<Collider>)Delegate.Remove(monoTriggerInteract3.OnTriggerStayCallback, new UnityAction<Collider>(InvokeOnTriggerStay));
			UnityEngine.Object.Destroy(_monoTriggerInteract);
		}
		_objectPool.Release(Entries);
		Entries = null;
		_entityBehave = default;
		TriggerRoot = null;
		CanLoadCommonInteractTip = null;
		foreach (KeyValuePair<InteractEntry, Action<Entity>> cachedEntryAction in _cachedEntryActions)
		{
			if (cachedEntryAction.Key != null)
			{
				InteractEntry key = cachedEntryAction.Key;
				key.onInteract = (Action<Entity>)Delegate.Remove(key.onInteract, cachedEntryAction.Value);
			}
		}
		DictionaryPool<InteractEntry, Action<Entity>>.Release(_cachedEntryActions);
		_cachedEntryActions = null;
		OnEntryInteract = null;
		_inTrigger = false;
		_isCommonInteractTipEntered = false;
		TryReleaseInteractTip();
	}

	private void EntriesOnCollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		if (_cachedEntryActions == null)
		{
			return;
		}
		if (e.Action == NotifyCollectionChangedAction.Add)
		{
			foreach (InteractEntry newItem in e.NewItems)
			{
				InteractEntry interactEntry = newItem;
				if (interactEntry != null)
				{
					if (!_cachedEntryActions.TryGetValue(interactEntry, out var value))
					{
						value = OnInteract;
						_cachedEntryActions[interactEntry] = value;
					}
					interactEntry.EntityReference = _entityBehave;
					InteractEntry interactEntry2 = interactEntry;
					interactEntry2.onInteract = (Action<Entity>)Delegate.Remove(interactEntry2.onInteract, value);
					InteractEntry interactEntry3 = interactEntry;
					interactEntry3.onInteract = (Action<Entity>)Delegate.Combine(interactEntry3.onInteract, value);
					if (_inTrigger)
					{
						interactEntry.HandleEnter();
					}
				}
				void OnInteract(Entity eb)
				{
					OnEntryInteract?.Invoke(eb, interactEntry);
				}
			}
			SyncCommonInteractTipState();
			TryLoadInteractTip();
		}
		else
		{
			if (e.Action != NotifyCollectionChangedAction.Remove)
			{
				return;
			}
			foreach (InteractEntry oldItem in e.OldItems)
			{
				if (oldItem != null && _cachedEntryActions.TryGetValue(oldItem, out var value2))
				{
					oldItem.onInteract = (Action<Entity>)Delegate.Remove(oldItem.onInteract, value2);
					oldItem.EntityReference = default;
					if (_inTrigger)
					{
						oldItem.HandleExit();
					}
				}
			}
			SyncCommonInteractTipState();
			TryLoadInteractTip();
		}
	}

	private void SyncCommonInteractTipState()
	{
		if (_inTrigger && Entries != null && Entries.Count > 0)
		{
			if (!_isCommonInteractTipEntered && (bool)CommonInteractTip)
			{
				CommonInteractTip.OnEnterInteractObj();
				_isCommonInteractTipEntered = true;
			}
		}
		else if (_isCommonInteractTipEntered)
		{
			CommonInteractTip?.OnExitInteractObj();
			_isCommonInteractTipEntered = false;
		}
	}

	private void TryLoadInteractTip()
	{
		Func<bool> canLoadCommonInteractTip = CanLoadCommonInteractTip;
		if ((canLoadCommonInteractTip == null || canLoadCommonInteractTip()) && !(_entityBehave == null) && InteractLoader == null && Model<CommonInteractUIModel>.HasInstance())
		{
			Model<CommonInteractUIModel>.Interface.Load(this, OnInteractTipLoaded);
		}
	}

	private void OnInteractTipLoaded(CommonInteractUI commonInteractTip)
	{
		_commonInteractTip = commonInteractTip;
		_commonInteractTip.Init(_entityBehave, Entries.FirstOrDefault());
		SyncCommonInteractTipState();
	}

	public void RefreshTipSyncTransform(bool loadInteractTip = true)
	{
		TipSyncTransform = GetTipSyncTransform();
		_commonInteractTip?.RefreshNpcTipSyncTransform(TipSyncTransform);
		if (loadInteractTip)
		{
			TryLoadInteractTip();
		}
	}

	public void ReleaseInteractTip()
	{
		TryReleaseInteractTip();
	}

	public void RegenerateInteractTip()
	{
		TipSyncTransform = GetTipSyncTransform();
		TryLoadInteractTip();
	}

	private void TryReleaseInteractTip()
	{
		try
		{
			if (Model<CommonInteractUIModel>.HasInstance())
			{
				Model<CommonInteractUIModel>.Interface.Release(this);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"头顶提示卸载失败 原因 :\n {arg}");
			}
		}
		finally
		{
			_commonInteractTip = null;
			_isCommonInteractTipEntered = false;
		}
	}

	private Transform GetTipSyncTransform()
	{
		GameObject model = _entityBehave.GetModel();
		Transform transform = FindChildRecursive(model?.transform, "InteractUI");
		if ((bool)transform)
		{
			return transform;
		}
		transform = FindChildRecursive(model?.transform, "IconPosition");
		if (!transform)
		{
			return _entityBehave.GetRootTransform();
		}
		return transform;
	}

	private static Transform FindChildRecursive(Transform root, string childName)
	{
		if (!root)
		{
			return null;
		}
		for (int i = 0; i < root.childCount; i++)
		{
			Transform child = root.GetChild(i);
			if (child.name == childName)
			{
				return child;
			}
			Transform transform = FindChildRecursive(child, childName);
			if ((bool)transform)
			{
				return transform;
			}
		}
		return null;
	}

	public void InvokeOnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!component || component.entity != MonoECS.instance.mainEntity)
		{
			return;
		}
		bool inTrigger = _inTrigger;
		_inTrigger = true;
		foreach (InteractEntry entry in Entries)
		{
			if (!((entry.InteractType == InteractType.TriggerEnter) & inTrigger))
			{
				entry.HandleEnter();
			}
		}
		SyncCommonInteractTipState();
	}

	public void InvokeOnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!component || component.entity != MonoECS.instance.mainEntity)
		{
			return;
		}
		foreach (InteractEntry entry in Entries)
		{
			entry.HandleExit();
		}
		_inTrigger = false;
		SyncCommonInteractTipState();
	}

	public void InvokeOnTriggerStay(Collider other)
	{
	}

	public void TriggerCurrentOverlaps()
	{
		_monoTriggerInteract?.TriggerCurrentOverlaps(BattleConsts.entityMask);
	}

	public void InvokeOnAttack(Entity attacker)
	{
		foreach (InteractEntry entry in Entries)
		{
			InteractType interactType = entry.InteractType;
			if (interactType == InteractType.Attack || interactType == InteractType.AttackWithOneEntity)
			{
				entry.NetInteract();
			}
		}
	}

	public void InvokeOnExpose(Entity entity)
	{
		CompTime compTime = entity.GetCompTime();
		foreach (InteractEntry entry in Entries)
		{
			entry.AddTimer(compTime.fixedDeltaTime);
		}
	}

	public void InvokeOnExitExposed()
	{
		foreach (InteractEntry entry in Entries)
		{
			if (entry.InteractType == InteractType.Expose)
			{
				entry.OnExitExpose();
			}
		}
	}
}
