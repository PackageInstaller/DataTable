using System;
using System.Collections.Generic;
using System.ComponentModel;
using ACT.Battle;
using ACT.MissionSystem;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Condition;
using ACT.World.StateObject.EntryProcessors;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Serialization;

namespace ACT.World.StateObject;

[Serializable]
public class InteractEntry : IButtonEntrySetting, ICommonInteractEntrySetting, IAttackEntrySetting, IExposeEntrySetting, IShowInteractTip
{
	private static Dictionary<InteractType, BaseEntryProcessor> _entryDict = new Dictionary<InteractType, BaseEntryProcessor>();

	[SerializeField]
	[FormerlySerializedAs("interactType")]
	private InteractType _interactType;

	private StateObjectBase _stateObjectBase;

	private Entity _entityReference;

	[SerializeField]
	[FormerlySerializedAs("interactOnce")]
	private bool _interactOnce;

	[SerializeReference]
	[FormerlySerializedAs("conditions")]
	private List<BaseCondition> _conditions = new List<BaseCondition>();

	[SerializeField]
	[FormerlySerializedAs("interactActionList")]
	private InteractActionList _interactActionList = new InteractActionList();

	[SerializeField]
	[Tooltip("逻辑执行的终端，根据所包含的InteractAction决定")]
	[FormerlySerializedAs("terminal")]
	private InteractTerminal _terminal = InteractTerminal.Both;

	[SerializeField]
	[FormerlySerializedAs("openBoxAni")]
	private bool _openBoxAni;

	[SerializeField]
	[FormerlySerializedAs("motionLimitButtonInteract")]
	private bool _motionLimitButtonInteract;

	[SerializeField]
	[FormerlySerializedAs("localizedString")]
	private LocalizedString _localizedString = new LocalizedString();

	[SerializeField]
	[FormerlySerializedAs("weight")]
	private int _weight;

	[SerializeField]
	[DefaultValue(-1)]
	[FormerlySerializedAs("iconId")]
	private int _iconId = -1;

	[SerializeField]
	[DefaultValue(-1)]
	[FormerlySerializedAs("tipIcon")]
	private int _tipIcon = -1;

	[SerializeField]
	[FormerlySerializedAs("tipTransform")]
	private Transform _tipTransform;

	[SerializeField]
	private ShowType _conditionFailShowType = ShowType.Hide;

	[SerializeField]
	private int _lockIconId;

	[SerializeField]
	private int _lockTipIconId = -1;

	[SerializeField]
	[Tooltip("在entityNeutralData表中的Id")]
	[FormerlySerializedAs("attackableId")]
	private int _attackableId;

	[SerializeField]
	[FormerlySerializedAs("abilities")]
	private string[] _abilities;

	[SerializeField]
	[FormerlySerializedAs("alliance")]
	private Alliance _alliance;

	[SerializeField]
	[FormerlySerializedAs("size")]
	private Vector3 _size = Vector3.one;

	[SerializeField]
	[FormerlySerializedAs("posOffset")]
	private Vector3 _posOffset = Vector3.zero;

	[SerializeField]
	[FormerlySerializedAs("syncAttackablePosition")]
	private bool _syncAttackablePosition;

	[SerializeField]
	[FormerlySerializedAs("onHitedActionList")]
	private InteractActionList _onHitedActionList = new InteractActionList();

	[SerializeField]
	private bool _isAttachCollider;

	[SerializeField]
	private Collider _attachCollider;

	[SerializeField]
	[FormerlySerializedAs("ChallengeInteractType")]
	private ChallangeType _challengeInteractType;

	[SerializeField]
	[FormerlySerializedAs("ComboCountNeed")]
	private int _comboCountNeed;

	[SerializeField]
	[FormerlySerializedAs("TimeNeed")]
	private int _timeNeed;

	[SerializeField]
	[FormerlySerializedAs("comboStateParam1")]
	private ComboStateParam _comboStateParam1;

	[SerializeField]
	[FormerlySerializedAs("comboStateParam2")]
	private ComboStateParam _comboStateParam2;

	[SerializeField]
	[FormerlySerializedAs("comboStateParam3")]
	private ComboStateParam _comboStateParam3;

	[SerializeField]
	[FormerlySerializedAs("needLog")]
	private bool _needLog;

	[SerializeField]
	[FormerlySerializedAs("exposeTime")]
	private float _exposeTime;

	[SerializeField]
	[FormerlySerializedAs("onExposeActionList")]
	private InteractActionList _onExposeActionList = new InteractActionList();

	public InteractType InteractType => _interactType;

	public Entity EntityReference
	{
		get
		{
			if (!_entityReference.IsValid)
			{
				return _stateObjectBase?.entity ?? default(Entity);
			}
			return _entityReference;
		}
		set
		{
			if (!(_entityReference == value))
			{
				_entityReference = value;
				if (_entityReference.IsValid && _entityReference.TryGetCompStateObject(out CompStateObject component))
				{
					BindInteractObjectBase(component.StateObjectBase);
				}
			}
		}
	}

	bool ICommonInteractEntrySetting.InteractOnce => _interactOnce;

	InteractTerminal ICommonInteractEntrySetting.Terminal => _terminal;

	public InteractActionList InteractActionList => _interactActionList;

	List<BaseCondition> ICommonInteractEntrySetting.Conditions => _conditions;

	public StateWorldAssetData Data { get; private set; }

	public Action<Entity> onInteract { get; set; }

	public Func<Entity, UniTask> onInteractAsync { get; set; }

	public int StateId { get; private set; }

	public int EntryIndex { get; private set; }

	public bool ConditionPassed => ((ICommonInteractEntrySetting)this).ConditionPassed;

	public int InteractTipId => ((ICommonInteractEntrySetting)this).EntityReference.GetCompStateObject()?.StateObjectBase.GetInteractId() ?? _tipIcon;

	public bool ShowInteractTip
	{
		get
		{
			if ((bool)_stateObjectBase)
			{
				if (_stateObjectBase.IsBelongWorld())
				{
					return _stateObjectBase.ShowInteractTip();
				}
				return false;
			}
			return ((ICommonInteractEntrySetting)this).EntityReference.GetCompStateObject()?.StateObjectBase.ShowInteractTip() ?? true;
		}
	}

	public bool TipConditionPassed => ((ICommonInteractEntrySetting)this).TipConditionPassed;

	public ShowType ShowType
	{
		get
		{
			if ((bool)_stateObjectBase)
			{
				if (!_stateObjectBase.IsBelongWorld())
				{
					return ShowType.Hide;
				}
				return _stateObjectBase.GetInteractBtnShowType();
			}
			return ((ICommonInteractEntrySetting)this).EntityReference.GetCompStateObject()?.StateObjectBase.GetInteractBtnShowType() ?? ShowType.Show;
		}
	}

	public bool Interactable
	{
		get
		{
			try
			{
				int result;
				if (((ICommonInteractEntrySetting)this).InteractCount == 0)
				{
					CompStateObject? compStateObject = ((ICommonInteractEntrySetting)this).EntityReference.GetCompStateObject();
					if ((compStateObject == null || compStateObject.StateObjectBase.CanInteract()) && (!((ICommonInteractEntrySetting)this).InteractOnce || ((ICommonInteractEntrySetting)this).StateInteractCount < 1))
					{
						result = ((onInteract != null || onInteractAsync != null || ((ICommonInteractEntrySetting)this).InteractActionList.interactActions.Count != 0) ? 1 : 0);
						goto IL_0062;
					}
				}
				result = 0;
				goto IL_0062;
				IL_0062:
				return (byte)result != 0;
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return false;
			}
		}
	}

	IDisposable ICommonInteractEntrySetting.TriggerStatDisposable { get; set; }

	bool ICommonInteractEntrySetting.TriggerExiting { get; set; }

	int ICommonInteractEntrySetting.StateInteractCount { get; set; }

	int ICommonInteractEntrySetting.InteractCount { get; set; }

	bool ICommonInteractEntrySetting.EnterState { get; set; }

	ShowType ICommonInteractEntrySetting.ShowType { get; set; }

	bool ICommonInteractEntrySetting.ConditionPassed { get; set; }

	bool ICommonInteractEntrySetting.TipConditionPassed { get; set; }

	public ShowType ConditionFailShowType => _conditionFailShowType;

	bool IButtonEntrySetting.MotionLimitButtonInteract => _motionLimitButtonInteract;

	public int Weight => _weight;

	public bool OpenBoxAni
	{
		get
		{
			return _openBoxAni;
		}
		set
		{
			_openBoxAni = value;
		}
	}

	public Transform TipTransform => _tipTransform;

	public int TipIcon => _tipIcon;

	public int IconId => _iconId;

	public int LockIconId => _lockIconId;

	public int LockTipIconId => _lockTipIconId;

	public LocalizedString LocalizedString => _localizedString;

	bool IButtonEntrySetting.ButtonShow { get; set; }

	private bool IsAttackEntrySetting
	{
		get
		{
			if (_interactType != InteractType.Attack)
			{
				return _interactType == InteractType.AttackWithOneEntity;
			}
			return true;
		}
	}

	public int AttackableId => _attackableId;

	string[] IAttackEntrySetting.Abilities => _abilities;

	Alliance IAttackEntrySetting.Alliance => _alliance;

	Vector3 IAttackEntrySetting.Size => _size;

	Vector3 IAttackEntrySetting.PosOffset => _posOffset;

	bool IAttackEntrySetting.SyncAttackablePosition => _syncAttackablePosition;

	InteractActionList IAttackEntrySetting.OnHitedActionList => _onHitedActionList;

	public bool IsAttachCollider => _isAttachCollider;

	public Collider AttachCollider => _attachCollider;

	public Action<Entity> onSpawnAttackable { get; set; }

	ChallangeType IAttackEntrySetting.ChallengeInteractType => _challengeInteractType;

	int IAttackEntrySetting.ComboCountNeed => _comboCountNeed;

	int IAttackEntrySetting.TimeNeed => _timeNeed;

	public ComboStateParam ComboStateParam1 => _comboStateParam1;

	public ComboStateParam ComboStateParam2 => _comboStateParam2;

	public ComboStateParam ComboStateParam3 => _comboStateParam3;

	bool IAttackEntrySetting.NeedLog => _needLog;

	Tweener IAttackEntrySetting.Timer { get; set; }

	int IAttackEntrySetting.ComboCount { get; set; }

	int IAttackEntrySetting.TimeNow { get; set; }

	Entity IAttackEntrySetting.AttackableER { get; set; }

	IDisposable IAttackEntrySetting.SyncAttackablePositionDisposable { get; set; }

	public Action<Entity> onHitInteract { get; set; }

	public Action<int> onComboChallengeInteract { get; set; }

	public Action<int, int> onHPChangeInteract { get; set; }

	float IExposeEntrySetting.ExposeTime => _exposeTime;

	float IExposeEntrySetting.Timer { get; set; }

	InteractActionList IExposeEntrySetting.OnExposeActionList => _onExposeActionList;

	public static InteractEntry CreateButtonEntry(LocalizedString buttonName, int weight, int iconId, int tipIcon, InteractEntry copyFrom = null)
	{
		InteractEntry interactEntry = new InteractEntry();
		ResetButtonEntry(interactEntry, buttonName, weight, iconId, tipIcon, copyFrom);
		return interactEntry;
	}

	public static InteractEntry CreateConfiguredEntry(InteractType interactType, LocalizedString buttonName, int weight, int iconId, int tipIcon)
	{
		InteractEntry interactEntry = new InteractEntry();
		interactEntry.ResetInteractType(interactType);
		interactEntry._localizedString = buttonName;
		interactEntry._weight = weight;
		interactEntry._iconId = iconId;
		interactEntry._tipIcon = tipIcon;
		return interactEntry;
	}

	private static void ResetButtonEntry(InteractEntry entry, LocalizedString buttonName, int weight, int iconId, int tipIcon, InteractEntry copyFrom)
	{
		entry.ResetInteractType(InteractType.Button);
		entry._localizedString = buttonName;
		entry._weight = weight;
		entry._iconId = iconId;
		entry._tipIcon = tipIcon;
		if (copyFrom != null)
		{
			entry._conditions = copyFrom._conditions;
			entry._openBoxAni = copyFrom._openBoxAni;
			entry._motionLimitButtonInteract = copyFrom._motionLimitButtonInteract;
			entry._tipTransform = copyFrom._tipTransform;
		}
	}

	public static InteractEntry CreateAttackEntry(in int attackableId, in string[] abilities, in Alliance alliance, in Vector3 size, in Vector3 posOffset)
	{
		InteractEntry interactEntry = new InteractEntry();
		ResetAttackEntry(interactEntry, in attackableId, in abilities, in alliance, in size, in posOffset);
		return interactEntry;
	}

	public static void ResetAttackEntry(InteractEntry entry, in int attackableId, in string[] abilities, in Alliance alliance, in Vector3 size, in Vector3 posOffset)
	{
		entry.ResetInteractType(InteractType.Attack);
		entry._attackableId = attackableId;
		entry._abilities = abilities;
		entry._alliance = alliance;
		entry._size = size;
		entry._posOffset = posOffset;
	}

	private static BaseEntryProcessor GetEntryProcessor(InteractType type)
	{
		if (!_entryDict.TryGetValue(type, out var value))
		{
			value = CreateEntryProcessor(type);
			_entryDict[type] = value;
		}
		return value;
	}

	private static BaseEntryProcessor CreateEntryProcessor(InteractType type)
	{
		return type switch
		{
			InteractType.None => (BaseEntryProcessor)new NoneEntryProcessor(), 
			InteractType.Button => new ButtonEntryProcessor(), 
			InteractType.Attack => new AttackEntryProcessor(), 
			InteractType.AttackWithOneEntity => new AttackWithOneEntityEntryProcessor(), 
			InteractType.TriggerEnter => new TriggerEnterEntryProcessor(), 
			InteractType.TriggerStay => new TriggerStayEntryProcessor(), 
			InteractType.TriggerExit => new TriggerExitEntryProcessor(), 
			InteractType.Expose => new ExposeEntryProcessor(), 
			_ => new CommonEntryProcessor(), 
		};
	}

	public void ResetInteractType(InteractType type)
	{
		_interactType = type;
	}

	public void NetInteract()
	{
		GetProcessor().NetInteract(this);
	}

	protected BaseEntryProcessor GetProcessor()
	{
		return GetEntryProcessor(_interactType);
	}

	public void BindInteractObjectBase(StateObjectBase interactObjectBase)
	{
		_stateObjectBase = interactObjectBase;
		_entityReference = interactObjectBase.entity;
		_interactActionList.BindInteractObject(interactObjectBase);
		_onHitedActionList.BindInteractObject(interactObjectBase);
		_onExposeActionList.BindInteractObject(interactObjectBase);
	}

	public Vector3 StateObjectPosition()
	{
		try
		{
			if (_entityReference.IsNPC())
			{
				return _entityReference.GetRoot()?.transform.position ?? Vector3.zero;
			}
			return _entityReference.GetCompTransform()?.physicsPosition ?? Vector3.zero;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return Vector3.zero;
		}
	}

	public void BindData(StateWorldAssetData stateObjectBaseData)
	{
		Data = stateObjectBaseData;
	}

	public void BindInteractState(int stateId, int entryIndex)
	{
		StateId = stateId;
		EntryIndex = entryIndex;
	}

	public void EvaluateConditions()
	{
		bool flag = true;
		foreach (BaseCondition condition in ((ICommonInteractEntrySetting)this).Conditions)
		{
			flag &= condition.IsPass();
		}
		((ICommonInteractEntrySetting)this).ConditionPassed = flag;
	}

	public void EvaluateTipConditions()
	{
		bool flag = true;
		foreach (BaseCondition condition in ((ICommonInteractEntrySetting)this).Conditions)
		{
			flag &= condition.IsPass();
		}
		((ICommonInteractEntrySetting)this).TipConditionPassed = flag;
	}

	public void ResetLocalizedString(LocalizedString localizedString)
	{
		_localizedString = localizedString;
	}

	public void ResetTipTransform(Transform transform)
	{
		_tipTransform = transform;
	}

	public int GetDisplayButtonIconId()
	{
		if (ShowType != ShowType.Lock)
		{
			return _iconId;
		}
		return _lockIconId;
	}

	public bool TryGetMissionInjectedButtonImage(out int iconConfigId)
	{
		iconConfigId = 0;
		if (ShowType != ShowType.Show)
		{
			return false;
		}
		MissionManager instance = Singleton<MissionManager>.instance;
		if (instance == null)
		{
			return false;
		}
		if (Data == null)
		{
			return false;
		}
		MissionManager.InteractObject interactObject = instance.GetInteractObject(Data.stateWorldAssetUid);
		if (interactObject == null)
		{
			return false;
		}
		iconConfigId = interactObject.IconConfigId;
		return true;
	}

	public void HandleInteract(Entity behave, InteractAction.InteractSource interactSource)
	{
		GetProcessor().Interact(this, behave, interactSource);
	}

	public void HandleInit()
	{
		GetProcessor().Init(this);
	}

	public void HandleEnter()
	{
		GetProcessor().Enter(this);
	}

	public void HandleExit()
	{
		GetProcessor().Leave(this);
	}

	public void HandleUninit()
	{
		GetProcessor().Deinit(this);
	}

	public void AddTimer(float deltaTime)
	{
		GetProcessor().AddTimer(this, deltaTime);
	}

	public void OnExitExpose()
	{
		GetProcessor().ExitExpose(this);
	}

	public void Clone(InteractEntry entry)
	{
		ResetInteractType(entry._interactType);
		_conditions = entry._conditions;
		_challengeInteractType = entry._challengeInteractType;
		_openBoxAni = entry._openBoxAni;
		_motionLimitButtonInteract = entry._motionLimitButtonInteract;
		_localizedString = entry._localizedString;
		_weight = entry._weight;
		_iconId = entry._iconId;
		_tipIcon = entry._tipIcon;
		_attackableId = entry._attackableId;
		_abilities = entry._abilities;
		_alliance = entry._alliance;
		_size = entry._size;
		_posOffset = entry._posOffset;
		_syncAttackablePosition = entry._syncAttackablePosition;
		_onHitedActionList = entry._onHitedActionList;
		_comboCountNeed = entry._comboCountNeed;
		_timeNeed = entry._timeNeed;
		_comboStateParam1 = entry._comboStateParam1;
		_comboStateParam2 = entry._comboStateParam2;
		_comboStateParam3 = entry._comboStateParam3;
		_needLog = entry._needLog;
		_exposeTime = entry._exposeTime;
		_onExposeActionList = entry._onExposeActionList;
		_terminal = entry._terminal;
		_interactOnce = entry._interactOnce;
		_conditionFailShowType = entry._conditionFailShowType;
	}
}
