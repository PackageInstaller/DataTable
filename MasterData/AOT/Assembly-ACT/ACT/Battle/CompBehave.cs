using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Rendering;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using RootMotion.FinalIK;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class CompBehave : EcsComponent
{
	private CancellationTokenSource _releaseTokenSource;

	public DecalProjector shadowCaster;

	public const int ADD_RELEASE_TRANS = 1;

	public int releaseFlag;

	private EntityBehaveState _state;

	private AssetLoadHandle _configHandle;

	private AssetLoadHandle _battleMappingHandle;

	private AssetLoadHandle _weaponLoadHandle;

	private byte _tickCounter;

	private byte _tickPhase;

	private int _fullTickReferenceCount;

	private float _wakeUntil;

	private string _rootPoolKey;

	private string _effectPrewarmOwnerKey;

	private bool _effectPrewarmBound;

	private readonly ActionList<Entity> _onInactive = new ActionList<Entity>();

	private string _rootName;

	private float m_ChangeCD;

	private float m_ChangeCDBase;

	private bool m_HasChangeCDOverride;

	public ActionList onChangCD = new ActionList();

	public FilterEntityType BeHitFilter = GameUtility.defaultFilterEntityType;

	private readonly ActionList<Entity> _onLogicAvailable = new ActionList<Entity>();

	private readonly ActionList<Entity> _onBehaveAvailable = new ActionList<Entity>();

	private readonly ActionList _onRelase = new ActionList();

	private HitMaterial m_OverrideHitMaterial;

	public readonly Dictionary<string, float> ChangeCDModifiers = new Dictionary<string, float>();

	private const string NoRootMark = "(NoRoot)";

	public EntityType EntityType { get; private set; }

	public AssetLoadHandle behaveHandle { get; private set; }

	public ConfigCharacter Config { get; private set; }

	public ConfigSkinBattleMapping ConfigSkinBattleMapping { get; private set; }

	public EntityTags EntityTags { get; private set; }

	public GameObject Root { get; private set; }

	public MonoEntity MonoEntity { get; private set; }

	public Animator Animator { get; private set; }

	public GameObject Model { get; private set; }

	public FullBodyBipedIK IK { get; private set; }

	public Transform Bip001 { get; private set; }

	public int rogueTrigger { get; set; } = -1;

	public bool IsActive { get; private set; }

	public EntityTickLod TickLod { get; private set; }

	public bool IsTickDue { get; private set; } = true;

	public float TickDeltaScale { get; private set; } = 1f;

	public int FullTickReferenceCount => _fullTickReferenceCount;

	public float WakeRemainingSeconds => Mathf.Max(0f, _wakeUntil - Time.time);

	public string ConfigPath { get; set; }

	internal EntityBehaveState State
	{
		get
		{
			return _state;
		}
		private set
		{
			SetState(value);
		}
	}

	public float ChangeCD
	{
		get
		{
			return m_ChangeCD;
		}
		set
		{
			m_ChangeCD = Mathf.Max(0f, value);
			onChangCD?.Invoke();
		}
	}

	public float ChangeCDTotal { get; private set; }

	public HitMaterial HitMaterial
	{
		get
		{
			if (m_OverrideHitMaterial == HitMaterial.None)
			{
				return owner.GetConfig()?.hitMaterial ?? HitMaterial.None;
			}
			return m_OverrideHitMaterial;
		}
	}

	public override bool NeedPrint => true;

	public event Action<Entity> OnInactive
	{
		add
		{
			_onInactive.Add(value);
		}
		remove
		{
			_onInactive.Remove(value);
		}
	}

	public event Action<Entity> OnLogicAvailable
	{
		add
		{
			_onLogicAvailable.Add(value);
		}
		remove
		{
			_onLogicAvailable.Remove(value);
		}
	}

	public event Action<Entity> OnBehaveAvailable
	{
		add
		{
			_onBehaveAvailable.Add(value);
		}
		remove
		{
			_onBehaveAvailable.Remove(value);
		}
	}

	public event Action OnRelase
	{
		add
		{
			_onRelase.Add(value);
		}
		remove
		{
			_onRelase.Remove(value);
		}
	}

	public CancellationToken GetCancellationTokenOnRelease()
	{
		if (_state == EntityBehaveState.Released)
		{
			throw new InvalidOperationException("不能获取一个已被释放实体的'CancellationTokenOnRelease'!");
		}
		return _releaseTokenSource.Token;
	}

	public bool IsTickAvailable()
	{
		if (IsLogicAvailable())
		{
			return IsTickDue;
		}
		return false;
	}

	internal bool HasForcedFullTick(float now)
	{
		if (_fullTickReferenceCount <= 0)
		{
			return now < _wakeUntil;
		}
		return true;
	}

	internal void SetTickPhase(byte phase)
	{
		_tickPhase = (byte)(phase & 3);
		if (TickLod == EntityTickLod.Quarter)
		{
			_tickCounter = _tickPhase;
		}
	}

	internal void SetTickLod(EntityTickLod lod, bool due, float deltaScale)
	{
		EntityTickLod tickLod = TickLod;
		TickLod = lod;
		IsTickDue = due;
		TickDeltaScale = deltaScale;
		if (lod != EntityTickLod.Quarter)
		{
			_tickCounter = 0;
		}
		else if (tickLod != EntityTickLod.Quarter)
		{
			_tickCounter = _tickPhase;
		}
	}

	internal void PrepareTickFrame()
	{
		switch (TickLod)
		{
		case EntityTickLod.Full:
			SetTickLod(EntityTickLod.Full, due: true, 1f);
			break;
		case EntityTickLod.Quarter:
			_tickCounter = (byte)((_tickCounter + 1) & 3);
			SetTickLod(EntityTickLod.Quarter, _tickCounter == 0, (_tickCounter == 0) ? 4f : 0f);
			break;
		default:
			SetTickLod(EntityTickLod.Sleep, due: false, 0f);
			break;
		}
	}

	internal void WakeForSeconds(float seconds)
	{
		_wakeUntil = Mathf.Max(_wakeUntil, Time.time + Mathf.Max(0f, seconds));
		_tickCounter = 0;
		SetTickLod(EntityTickLod.Full, due: true, 1f);
	}

	internal void PushFullTick()
	{
		_fullTickReferenceCount++;
	}

	internal void PopFullTick()
	{
		_fullTickReferenceCount = Mathf.Max(0, _fullTickReferenceCount - 1);
	}

	internal void ResetTickLod()
	{
		TickLod = EntityTickLod.Full;
		IsTickDue = true;
		TickDeltaScale = 1f;
		_tickCounter = 0;
		_fullTickReferenceCount = 0;
		_wakeUntil = 0f;
	}

	public void SetActive(bool value)
	{
		IsActive = value;
	}

	public void SetRootPoolKey(string poolKey)
	{
		_rootPoolKey = poolKey;
	}

	public async UniTask<ConfigCharacter> LoadConfigCharacter(string configPath)
	{
		if (_configHandle.IsValid)
		{
			return _configHandle.As<ConfigCharacter>();
		}
		_configHandle = AssetStationManager.BattleStation.LoadAsync<ConfigCharacter>(configPath);
		await UniTask.WaitUntil(() => !_configHandle.IsValid || _configHandle.IsDone);
		AssetLoadHandle configHandle = _configHandle;
		if (configHandle.IsDone)
		{
			object result = configHandle.Result;
			if (result is ConfigCharacter config)
			{
				Config = config;
				return config;
			}
		}
		return null;
	}

	public async UniTask LoadBattleMapping()
	{
		if (_configHandle.IsValid)
		{
			GameObject sceneRoot = MonoECS.instance.GetRoot(SceneRootType.Entity);
			int characterId = owner.GetCompCharacter()?.characterSource?.Id() ?? owner.GetTableId();
			int skinId = ((owner.GetCompCharacter()?.characterSource != null) ? CharacterSkinRuntimeUtility.ResolveSkinId(characterId, owner.GetCompCharacter().characterSource) : 0);
			string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterId, skinId, CharacterModelUsage.Battle);
			AssetLoadHandle modelHandle = ((!string.IsNullOrEmpty(modelPath)) ? AssetStationManager.BattleStation.InstantiateAsync(modelPath, sceneRoot.transform) : default(AssetLoadHandle));
			if (modelHandle.IsValid)
			{
				await modelHandle;
			}
			GameObject gameObject = (modelHandle.IsValid ? modelHandle.AsGameObject() : null);
			if (gameObject == null)
			{
				gameObject = UnityEngine.Object.Instantiate(_configHandle.As<ConfigCharacter>().prefab, sceneRoot.transform);
				behaveHandle = default;
			}
			else
			{
				behaveHandle = modelHandle;
			}
			Root = gameObject;
			string battleMappingAssetId = CharacterSkinRuntimeUtility.GetBattleMappingAssetId(skinId);
			if (!string.IsNullOrEmpty(battleMappingAssetId))
			{
				_battleMappingHandle = AssetStationManager.BattleStation.LoadAsync<ConfigSkinBattleMapping>(battleMappingAssetId);
				await _battleMappingHandle;
				ConfigSkinBattleMapping = _battleMappingHandle.As<ConfigSkinBattleMapping>();
			}
			else
			{
				_battleMappingHandle = default;
				ConfigSkinBattleMapping = null;
			}
		}
	}

	public async UniTask InitCharacter(string configPath, bool active = true)
	{
		await LoadConfigCharacter(configPath);
		if (Config != null)
		{
			PrecacheUtility.Preload<YooAssetReference>(Config.Precache);
			await LoadBattleMapping();
			if (EffectPrewarmManager.Enabled)
			{
				_effectPrewarmOwnerKey = $"Character:{owner.Id.Index}:{owner.Id.Version}";
				_effectPrewarmBound = await EffectPrewarmManager.Instance.PrewarmCharacterAsync(_effectPrewarmOwnerKey, Config, ConfigSkinBattleMapping, GetCancellationTokenOnRelease());
			}
			SetupRoot(Root);
			CharacterHDShadow component = Root.GetComponent<CharacterHDShadow>();
			if (component != null)
			{
				component.SetObjectType(CharacterHDShadowObjectType.Battle);
			}
			UpdateMonoRef();
			GameObject gameObject = Root.transform.GetChild(0).gameObject;
			SetupModel(gameObject);
			SetupAnimator(gameObject);
			Root.SetActive(active);
		}
	}

	public void InvokeOnInactive()
	{
		_onInactive.Invoke(owner);
	}

	public void ClearOnInteract()
	{
		_onInactive.Clear();
	}

	public void HideRoot()
	{
		Root.SetActive(value: false);
		_onInactive.Invoke(owner);
	}

	public void ShowRoot()
	{
		Root.SetActive(value: true);
	}

	public void SetupModel(GameObject modelGo)
	{
		Model = modelGo;
	}

	public void SetupAnimator(GameObject node, bool initIK = true)
	{
		Animator = node.GetComponent<Animator>();
		if (initIK)
		{
			InitIK(node);
		}
	}

	public void InitIK(GameObject node)
	{
		Bip001 = node.transform.Find("Bip001");
		IK = node.GetComponent<FullBodyBipedIK>();
		if (owner.TryGetCompAim(out CompAim component))
		{
			component.aimIK = node.GetComponent<AimIK>();
			if (component.aimIK == null)
			{
				component.aimIK = node.GetComponentInChildren<AimIK>(includeInactive: true);
			}
			if (component.aimIK != null)
			{
				component.aimIK.solver.executedInEditor = false;
				component.aimIK.solver.IKPositionWeight = 0f;
				component.ikOriginTrans = component.aimIK.solver.transform;
			}
			else
			{
				component.ikOriginTrans = null;
			}
		}
	}

	public void SetupRoot(GameObject go)
	{
		Root = go;
		_rootName = go.name ?? "";
		go.name = $"{owner.Id} {go.name}";
	}

	internal void UpdateMonoRef()
	{
		MonoEntity = EntityPrefabRuntimeUtility.EnsureMonoEntity(Root);
		if (owner.HasComponent<CompPhysics>())
		{
			EntityPrefabRuntimeUtility.EnsureCharacterMovement(Root);
		}
		MonoEntity?.SetEB(owner);
	}

	internal void SetState(EntityBehaveState value)
	{
		if (_state != value)
		{
			_state = value;
			switch (value)
			{
			case EntityBehaveState.Got:
				_releaseTokenSource = new CancellationTokenSource();
				break;
			case EntityBehaveState.Released:
				_releaseTokenSource.Cancel();
				break;
			}
		}
	}

	public bool IsLogicAvailable()
	{
		return ContainsState(ref _state, EntityBehaveState.LogicAvailable);
	}

	public bool IsBehaveAvailable()
	{
		return ContainsState(ref _state, EntityBehaveState.BehaveAvailable);
	}

	public bool IsAINavAvailable()
	{
		return ContainsState(ref _state, EntityBehaveState.AINavAvailable);
	}

	public bool IsGot()
	{
		return ContainsState(ref _state, EntityBehaveState.Got);
	}

	public bool IsToRemove()
	{
		return ContainsState(ref _state, EntityBehaveState.ToRemove);
	}

	public bool CanRemove()
	{
		return ContainsState(ref _state, EntityBehaveState.CanRemove);
	}

	public bool IsOnRemove()
	{
		return ContainsState(ref _state, EntityBehaveState.OnRemove);
	}

	public bool IsReleased()
	{
		return _state == EntityBehaveState.Released;
	}

	public void SetLogicAvailable()
	{
		State |= EntityBehaveState.LogicAvailable;
		_onLogicAvailable?.Invoke(owner);
	}

	public void SetBehaveAvailable()
	{
		State |= EntityBehaveState.BehaveAvailable;
		_onBehaveAvailable?.Invoke(owner);
	}

	public void SetAINavAvailable()
	{
		State |= EntityBehaveState.AINavAvailable;
		owner.GetCompAI()?.CheckIfAINavAvailable();
	}

	private static bool ContainsState(ref EntityBehaveState state, EntityBehaveState target)
	{
		return (state & target) > EntityBehaveState.Released;
	}

	public void SetEntityType(EntityType type)
	{
		EntityType = type;
	}

	public EntityType SetEntityType(int id)
	{
		SetEntityType(RuntimeConfigs.data.entityDatas[id].type switch
		{
			1 => EntityType.Character, 
			2 => EntityType.Monster, 
			3 => EntityType.Boss, 
			4 => EntityType.Robot, 
			5 => EntityType.Npc, 
			6 => EntityType.Elite, 
			7 => EntityType.AssistNpc, 
			_ => EntityType.Null, 
		});
		return EntityType;
	}

	protected override void OnGet()
	{
		releaseFlag = 0;
		behaveHandle = default;
		IsActive = true;
		ResetTickLod();
		EntityTags = new EntityTags();
		_rootPoolKey = null;
		SetState(EntityBehaveState.Got);
	}

	public void ReleaseInstance()
	{
		ReleaseEffectPrewarm();
		AssetLoadHandle handle = behaveHandle;
		GameObject gameObject = (AssetLoadHandleExtensions.IsValid(handle) ? handle.AsGameObject() : null);
		GameObject model = Model;
		if (AssetLoadHandleExtensions.IsValid(handle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(handle);
		}
		behaveHandle = default;
		if ((releaseFlag & 1) > 0 && model != null && model != gameObject)
		{
			AssetStationManager.BattleStation.ReleaseInstance(model);
		}
		GameObject root = Root;
		if ((object)root != null && (string.IsNullOrEmpty(_rootPoolKey) || !BattleGameObjectPoolService.Instance.Release(_rootPoolKey, root)))
		{
			UnityEngine.Object.Destroy(root);
		}
		MonoEntity = null;
		Root = null;
		_rootPoolKey = null;
		if (Config != null)
		{
			PrecacheUtility.ReleasePreload<YooAssetReference>(Config.Precache);
		}
		if (AssetLoadHandleExtensions.IsValid(_configHandle))
		{
			AssetStationManager.BattleStation.Release(_configHandle);
		}
		Config = null;
		if (AssetLoadHandleExtensions.IsValid(_battleMappingHandle))
		{
			AssetStationManager.BattleStation.Release(_battleMappingHandle);
		}
		_battleMappingHandle = default;
		ConfigSkinBattleMapping = null;
		ReleaseWeapon();
		if (shadowCaster != null)
		{
			UnityEngine.Object.Destroy(shadowCaster.gameObject);
		}
		State = EntityBehaveState.Got;
		_onRelase.Invoke();
		_onRelase.Clear();
		_onLogicAvailable.Clear();
		_onBehaveAvailable.Clear();
		_onInactive.Clear();
		ChangeCDModifiers.Clear();
		onChangCD.Clear();
		EntityTags.Reset();
		Model = null;
		IK = null;
		Bip001 = null;
		IsActive = false;
		BeHitFilter = GameUtility.defaultFilterEntityType;
		rogueTrigger = -1;
		ResetChangeCD();
		m_OverrideHitMaterial = HitMaterial.None;
		releaseFlag = 0;
		ResetTickLod();
	}

	protected override void OnRelease()
	{
		_rootName = "(NoRoot)";
		ReleaseInstance();
	}

	public void ToRemove()
	{
		WakeForSeconds(1f);
		State |= EntityBehaveState.ToRemove;
	}

	public void SetCanRemove()
	{
		State |= EntityBehaveState.CanRemove;
	}

	public void SetOnRemove()
	{
		WakeForSeconds(1f);
		State |= EntityBehaveState.OnRemove;
	}

	public void SetMaxChangeCD(float value)
	{
		m_ChangeCDBase = Mathf.Max(0f, value) - GetChangeCDModifierTotal();
		m_HasChangeCDOverride = true;
		RefreshChangeCDTotal();
		onChangCD?.Invoke();
	}

	public void StartChangeCD(float defaultDuration)
	{
		if (!m_HasChangeCDOverride)
		{
			m_ChangeCDBase = defaultDuration;
		}
		RefreshChangeCDTotal();
		ChangeCD = ChangeCDTotal;
	}

	private float GetChangeCDModifierTotal()
	{
		float num = 0f;
		foreach (float value in ChangeCDModifiers.Values)
		{
			num += value;
		}
		return num;
	}

	private void RefreshChangeCDTotal()
	{
		ChangeCDTotal = Mathf.Max(0f, m_ChangeCDBase + GetChangeCDModifierTotal());
	}

	private void ResetChangeCD()
	{
		m_ChangeCD = 0f;
		m_ChangeCDBase = 0f;
		m_HasChangeCDOverride = false;
		ChangeCDTotal = 0f;
	}

	private void RemoveBattleComp()
	{
		ReleaseEffectPrewarm();
		ConfigPath = null;
		if ((releaseFlag & 1) > 0 && Model != null)
		{
			AssetStationManager.BattleStation.ReleaseInstance(Model);
		}
		if (Root != null && (string.IsNullOrEmpty(_rootPoolKey) || !BattleGameObjectPoolService.Instance.Release(_rootPoolKey, Root)))
		{
			UnityEngine.Object.Destroy(Root);
		}
		Root = null;
		_rootPoolKey = null;
		MonoEntity = null;
		Model = null;
		IK = null;
		Bip001 = null;
		IsActive = false;
		_onInactive.Clear();
		if (Config != null)
		{
			PrecacheUtility.ReleasePreload<YooAssetReference>(Config.Precache);
			Config = null;
		}
		if (AssetLoadHandleExtensions.IsValid(_configHandle))
		{
			AssetStationManager.BattleStation.Release(_configHandle);
		}
		if (shadowCaster != null)
		{
			UnityEngine.Object.Destroy(shadowCaster.gameObject);
		}
		State = EntityBehaveState.Got;
		_onLogicAvailable.Clear();
		_onBehaveAvailable.Clear();
		ResetChangeCD();
		ChangeCDModifiers?.Clear();
		onChangCD.Clear();
	}

	private void ReleaseEffectPrewarm()
	{
		if (!_effectPrewarmBound)
		{
			_effectPrewarmOwnerKey = null;
			return;
		}
		EffectPrewarmManager.Instance.Release(_effectPrewarmOwnerKey);
		_effectPrewarmBound = false;
		_effectPrewarmOwnerKey = null;
	}

	public void SetOverrideHitMaterial(HitMaterial value)
	{
		m_OverrideHitMaterial = value;
	}

	public void ResetOverrideHitMaterial()
	{
		m_OverrideHitMaterial = HitMaterial.None;
	}

	public void AddChangeCDModifier(string key, float addCD)
	{
		ChangeCDModifiers[key] = addCD;
		RefreshChangeCDTotal();
		onChangCD?.Invoke();
	}

	public void RemoveChangeCDModifier(string key)
	{
		if (ChangeCDModifiers.Remove(key))
		{
			RefreshChangeCDTotal();
			onChangCD?.Invoke();
		}
	}

	public async UniTask<AssetLoadHandle?> LoadBehaveAsset(YooAssetReference assetReference, Action<AssetLoadHandle> onComplete = null)
	{
		if (!assetReference.RuntimeKeyIsValid())
		{
			await UniTask.CompletedTask;
			return null;
		}
		behaveHandle = AssetStationManager.BattleStation.InstantiateAsync(assetReference, Root?.transform, instantiateInWorldSpace: false, (AssetLoadHandle handle) =>
		{
			if (owner.IsValid)
			{
				if (Model != null)
				{
					AssetStationManager.BattleStation.ReleaseInstance(Model);
				}
				SetupModel(handle.AsGameObject());
				onComplete?.Invoke(handle);
			}
		});
		await behaveHandle;
		return behaveHandle;
	}

	public void ReleaseWeapon()
	{
		if (AssetLoadHandleExtensions.IsValid(_weaponLoadHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_weaponLoadHandle);
			if (MonoEntity != null)
			{
				MonoEntity.weaponModel = null;
				MonoEntity.aniControls.Clear();
			}
		}
	}

	public async UniTask LoadWeapon(YooAssetReference asset, Transform parent)
	{
		ReleaseWeapon();
		if (owner.IsValid)
		{
			_weaponLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(asset, parent);
			await _weaponLoadHandle;
			GameObject weaponModel = _weaponLoadHandle.AsGameObject();
			if (!owner.IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(_weaponLoadHandle);
			}
			else
			{
				MonoEntity.weaponModel = weaponModel;
			}
		}
	}

	public override string GetPrintLog()
	{
		if (!string.IsNullOrEmpty(_rootName))
		{
			return _rootName;
		}
		return "(NoRoot)";
	}
}
