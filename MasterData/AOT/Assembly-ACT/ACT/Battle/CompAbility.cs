using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Sound;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using Bamboo.Precache;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model;
using Sirenix.Utilities;
using UnityEngine;

namespace ACT.Battle;

public class CompAbility : EcsComponent
{
	public enum AssistChangeReason
	{
		Gm,
		Hit,
		PerfectDodge,
		Ability,
		Assist,
		Reborn
	}

	private struct HitedInfo
	{
		public FindTargetResult hited;

		public float hitCD;

		public int currentHitCount;

		public int maxHitCount;

		public AttackPattern attack;
	}

	private struct HitRecoveryEnergyInfo : IEquatable<HitRecoveryEnergyInfo>
	{
		public ActionDamage hit;

		public AttackPattern attack;

		public int hitOrdinal;

		public bool Equals(HitRecoveryEnergyInfo other)
		{
			if (hit == other.hit && attack == other.attack)
			{
				return hitOrdinal == other.hitOrdinal;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is HitRecoveryEnergyInfo other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return HashCode.Combine(hit, attack, hitOrdinal);
		}
	}

	private int m_Level;

	private bool m_LevelOverride;

	private bool m_Alive;

	public float dieStartTime = float.MaxValue;

	public bool feignedDie;

	public bool zeroHpFeignedDie;

	private CancellationTokenSource aliveTokenSource;

	public ActionList<Entity> onDie = new ActionList<Entity>();

	public ActionList<Entity> onRelase = new ActionList<Entity>();

	public CharacterDamageType characterDamageType;

	public FilterCharacterFrequencyType characterFrequencyType;

	public MannerType mannerType;

	public BMap<int, int> abilityTagCounter;

	public BMap<int, Ability> dummyAbilities;

	public BSet<Ability> abilities;

	public BSet<Ability> bagAbilities;

	public BSet<Ability> toRemove;

	public Action<Ability> onAddAbilty;

	public Action<Ability> onRemoveAbility;

	public Action onAbilityChange;

	private float m_AssistValue;

	private BSet<HitedInfo> hited;

	internal BSet<Entity> carryed;

	public int maxTenacity;

	public float reviveTenacityProgress = 1f;

	public ActionList<int, int> onTenChange = new ActionList<int, int>();

	private int _tenacityValue;

	public AnomalyData anomalyData;

	public ActionList<int, int, int?> OnAnomalyChanged = new ActionList<int, int, int?>();

	private int m_AnomalyValue;

	private int m_AnomalyLimit;

	public BMap<int, ModifiedSkill> modifiedSkills;

	private BSet<HitRecoveryEnergyInfo> cacheHitRecoveryEnergy;

	private AttackPattern hitRecoveryAttack;

	private int hitRecoveryOrdinal;

	public Action<Entity, int> onCharacterDamageHit;

	private readonly List<IDamageModifier> m_AttackerDamageModifiers = new List<IDamageModifier>();

	private readonly List<IDamageModifier> m_AttackeeDamageModifiers = new List<IDamageModifier>();

	private float _ultimateSkillValue;

	private float _energyValue;

	private float _specialEnergyValue;

	private BMap<string, EntityId> entityVars;

	public BMap<string, DynamicValue> vars;

	public BMap<int, string> dynamicNames;

	private Dictionary<Type, List<BaseAbilityMixin>> m_EvtListens;

	private Dictionary<Type, Action<BaseEvt>> m_BaseEvtListens;

	private int _posture;

	private bool _activePosture;

	private bool _postureBurst;

	private float _revivePostureProgress;

	public Action<Entity, int, int> onPostureChange;

	public Action<Entity, float, float> onRevivePostureProgressChange;

	public Action<Entity, bool> onActivePostureChange;

	public Action<Entity, bool> onPostureBurstChange;

	private float m_WeakCoefficient;

	public ITableKey propertiesKey;

	private Dictionary<uint, ACT.Core.Property> properties;

	public List<string> abilitiesNeedReset = new List<string>();

	private int m_HP;

	public ActionList<int, int> onHPChange = new ActionList<int, int>();

	public ActionList<int, int, Entity> onEntityHpChange = new ActionList<int, int, Entity>();

	public Action<Entity> damageableHited;

	public Action<Entity, Entity> comboDamageable;

	private int m_Shield;

	public ActionList<int, int> onShieldChange = new ActionList<int, int>();

	public ActionList<int, int, Entity> onEntityShieldChange = new ActionList<int, int, Entity>();

	private float m_MoveSpeed;

	private int m_MotionEndureLevel;

	private int m_EndureLevel;

	public BMap<int, int> suitChip;

	private readonly VisualChannel<AbilityMaterial> _materialChannel = new VisualChannel<AbilityMaterial>();

	private readonly VisualChannel<EffectRuntimeItem> _effectChannel = new VisualChannel<EffectRuntimeItem>();

	public int level
	{
		get
		{
			CompCharacter compCharacter = owner.GetCompCharacter();
			if (compCharacter != null)
			{
				ICharacterSource characterSource = compCharacter.characterSource;
				if (characterSource != null)
				{
					return characterSource.Level();
				}
			}
			CompProduct compProduct = owner.GetCompProduct();
			if (compProduct == null)
			{
				return m_Level;
			}
			if (!m_LevelOverride)
			{
				return compProduct.caster.GetCompAbility()?.level ?? m_Level;
			}
			return m_Level;
		}
	}

	public bool alive
	{
		get
		{
			return m_Alive;
		}
		set
		{
			if (m_Alive == value)
			{
				return;
			}
			m_Alive = value;
			if (value)
			{
				if (aliveTokenSource != null)
				{
					if (!aliveTokenSource.IsCancellationRequested)
					{
						aliveTokenSource.Cancel();
					}
					aliveTokenSource.Dispose();
				}
				aliveTokenSource = new CancellationTokenSource();
			}
			else
			{
				aliveTokenSource.Cancel();
			}
		}
	}

	public EntityBlackboard EntityBlackboard { get; private set; }

	public float MaxAssistValue
	{
		get
		{
			if (properties.TryGetValue(55u, out var value))
			{
				return value.value;
			}
			return 0f;
		}
	}

	public float AssistValue => m_AssistValue;

	public float AssistPercent
	{
		get
		{
			if (MaxAssistValue == 0f)
			{
				return 0f;
			}
			return m_AssistValue / MaxAssistValue;
		}
	}

	public float AssistCost
	{
		get
		{
			if (properties.TryGetValue(65u, out var value))
			{
				return value.value;
			}
			return 0f;
		}
	}

	public float BeHitRecoverAssistValue => owner.GetConfig().beHitAssistValue;

	public float PerfectDodgeRecoverAssistValue => owner.GetConfig().perfectDodgeAssistRecover;

	public float HitRecoveryAssistCD => owner.GetConfig().beHitAssistCD;

	public int tenacityValue => _tenacityValue;

	public int anomalyValue
	{
		get
		{
			if (anomalyData != null)
			{
				return anomalyData.anomalyValue[(int)(anomalyData.currAnomaly - 1)];
			}
			return m_AnomalyValue;
		}
		set
		{
			OnAnomalyChanged?.Invoke(m_AnomalyValue, value, m_AnomalyLimit);
			m_AnomalyValue = value;
		}
	}

	public int anomalyLimit
	{
		get
		{
			return m_AnomalyLimit;
		}
		set
		{
			m_AnomalyLimit = value;
		}
	}

	public bool AttackedInMotion { get; set; }

	public float CurrentUltimateSkillValue
	{
		get
		{
			return _ultimateSkillValue;
		}
		set
		{
			CompCharacter compCharacter = owner.GetCompCharacter();
			if (compCharacter != null)
			{
				float skillEnergy = RuntimeConfigs.data.entityCharacterDatas[compCharacter.characterSource.Id()].skillEnergy;
				float num = Mathf.Clamp(value, 0f, skillEnergy);
				if (Mathf.Approximately(num, skillEnergy))
				{
					num = skillEnergy;
				}
				if (_ultimateSkillValue != num)
				{
					_ultimateSkillValue = num;
					owner.SetFloat("ultraEnergy", _ultimateSkillValue);
					CharacterUltraEnergyUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterUltraEnergyUpdateEvt>();
					evt.entity = owner;
					evt.characterId = compCharacter.characterSource.Id();
					evt.ultraEnergyVal = _ultimateSkillValue;
					evt.ultraEnergyPercent = CurUltraEnergyPercent;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CharacterEnergyChange, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
			}
		}
	}

	public float CurUltraEnergyPercent => _ultimateSkillValue / RuntimeConfigs.data.entityCharacterDatas[owner.GetCompCharacter().characterSource.Id()].skillEnergy;

	public float CurNormalEnergyPercent => _energyValue / MaxNormalEnergy;

	public float EnergyValue => _energyValue;

	public float MaxNormalEnergy => RuntimeConfigs.data.entityCharacterDatas[owner.GetCompCharacter().characterSource.Id()].normalEnergy;

	public float CurSpecialEnergyPercent => _specialEnergyValue / MaxSpecialEnergy;

	public float SpecialEnergyValue => _specialEnergyValue;

	public float MaxSpecialEnergy => RuntimeConfigs.data.entityCharacterDatas[owner.GetCompCharacter().characterSource.Id()].specialEnergy;

	public int posture => _posture;

	public float[] PosturePercent => owner.GetConfig().posturePercent;

	public bool ActivePosture => _activePosture;

	public bool IsWeak
	{
		get
		{
			if (maxPosture > 0 && ActivePosture)
			{
				return revivePostureProgress != 1f;
			}
			return false;
		}
	}

	public bool IsHavePosture
	{
		get
		{
			if (_activePosture)
			{
				return maxPosture > 0;
			}
			return false;
		}
	}

	public bool IsPostureBurst
	{
		get
		{
			if (IsHavePosture)
			{
				return _postureBurst;
			}
			return false;
		}
	}

	public int maxPosture => Mathf.CeilToInt(GetProperty(41u).value);

	public float postureDmgChar => GetProperty(42u).value;

	public float postureDmgResistance => owner.GetConfig().postureDmgResistance;

	public float revivePostureProgress => _revivePostureProgress;

	public float WeakTime => owner.GetConfig().weakTime * (1f + Mathf.Min(m_WeakCoefficient, 0.5f));

	public Dictionary<uint, ACT.Core.Property> Properties
	{
		get
		{
			if (properties == null)
			{
				properties = new Dictionary<uint, ACT.Core.Property>();
			}
			return properties;
		}
	}

	public int hp => m_HP;

	public int maxHP
	{
		get
		{
			if (properties.TryGetValue(1u, out var value))
			{
				return ToRuntimeMaxHp(value.value);
			}
			return int.MaxValue;
		}
	}

	public float HpPercent => (float)hp / (float)maxHP;

	public int shield => m_Shield;

	public int maxShield
	{
		get
		{
			if (properties.TryGetValue(205u, out var value))
			{
				return Mathf.CeilToInt(Mathf.Max(0f, value.value));
			}
			return 0;
		}
	}

	public float shieldPercent
	{
		get
		{
			if (maxShield > 0)
			{
				return (float)shield / (float)maxShield;
			}
			return 0f;
		}
	}

	public float moveSpeed => m_MoveSpeed;

	public int atk => Mathf.CeilToInt(GetProperty(2u).value);

	public float criticalChance => GetProperty(3u).value;

	public float criticalMul => GetProperty(4u).value;

	public float Def => GetProperty(8u).value;

	public float DefPenetration => GetProperty(13u).value;

	public float DamageMulAdd => GetProperty(44u).value;

	public float BurstMulAdd => GetProperty(58u).value;

	public float Vulnerable => GetProperty(67u).value;

	public float DamageReductionMulAdd => GetProperty(66u).value;

	public float WeakMul => GetProperty(43u).value;

	public float ChargeRate => GetProperty(40u).value;

	public Element element { get; protected set; }

	public int endureLevel => m_EndureLevel;

	public int motionEndureLevel
	{
		set
		{
			m_MotionEndureLevel = value;
			CalEndure();
		}
	}

	public float GetAssistStrikerBottleRecoverCd => GetProperty(222u).value;

	public int GetAssistStrikerBottleRecoverCount => (int)GetProperty(223u).value;

	public void SetLevel(int value, bool levelOverride = false)
	{
		m_Level = value;
		m_LevelOverride = levelOverride;
	}

	public CancellationToken GetCancellationTokenOnDie()
	{
		return aliveTokenSource.Token;
	}

	public EntityBlackboard GetOrCreateEntityBlackboard()
	{
		if (EntityBlackboard == null)
		{
			EntityBlackboard = new EntityBlackboard();
		}
		return EntityBlackboard;
	}

	public CompAbility()
	{
		properties = new Dictionary<uint, ACT.Core.Property>();
		alive = true;
		m_EvtListens = new Dictionary<Type, List<BaseAbilityMixin>>();
		m_BaseEvtListens = new Dictionary<Type, Action<BaseEvt>>();
		foreach (Type evtType in GameManager.abilitySystem.evtTypes)
		{
			m_EvtListens.Add(evtType, new List<BaseAbilityMixin>());
			m_BaseEvtListens.Add(evtType, null);
		}
	}

	internal void InitCommon(EntityData cData)
	{
		element = ((cData.element == 0) ? Element.Dark : ((Element)cData.element));
		if (owner.IsBattleBehaveNotCharacter())
		{
			maxTenacity = cData.MaxTenacity;
		}
	}

	internal void InitAttackEntityCommon(EntityNeutralData data)
	{
		element = (Element)data.element;
	}

	protected override void OnGet()
	{
		EntityBlackboard = null;
		abilities = BSetPool<Ability>.Default.Get();
		dummyAbilities = BMapPool<int, Ability>.Default.Get();
		toRemove = BSetPool<Ability>.Default.Get();
		hited = BSetPool<HitedInfo>.Default.Get();
		carryed = BSetPool<Entity>.Default.Get();
		vars = BMapPool<string, DynamicValue>.Default.Get();
		entityVars?.Clear();
		dynamicNames = BMapPool<int, string>.Default.Get();
		suitChip = BMapPool<int, int>.Default.Get();
		modifiedSkills = BMapPool<int, ModifiedSkill>.Default.Get();
		bagAbilities = BSetPool<Ability>.Default.Get();
		abilityTagCounter = BMapPool<int, int>.Default.Get();
		cacheHitRecoveryEnergy = BSetPool<HitRecoveryEnergyInfo>.Default.Get();
		ClearHitRecoveryEnergyContext();
		_revivePostureProgress = 1f;
		dieStartTime = float.MaxValue;
		GameManager.entityScopeSystem.OnAbilityAdd(this);
	}

	protected override void OnRelease()
	{
		GameManager.entityScopeSystem.OnAbilityRemove(this);
		EntityBlackboard?.Clear();
		EntityBlackboard = null;
		onRelase.Invoke(owner);
		alive = false;
		alive = true;
		feignedDie = false;
		zeroHpFeignedDie = false;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		ObjectPool<Ability> abilityPool = abilitySystem.abilityPool;
		foreach (Ability ability in abilities)
		{
			foreach (KeyValuePair<YooAssetReference, InstanceHandle> item in ability.abilityVolumeAssetID)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(item.Value);
			}
			ability.abilityVolumeAssetID.Clear();
			ability.config.RemoveCache();
			ability.OnSilentRemove(this);
			abilityPool.Release(ability);
		}
		abilities.Clear();
		foreach (KeyValuePair<int, Ability> dummyAbility in dummyAbilities)
		{
			dummyAbility.Value.OnSilentRemove(this);
			abilityPool.Release(dummyAbility.Value);
		}
		dummyAbilities.Clear();
		toRemove.Clear();
		hited.Clear();
		carryed.Clear();
		foreach (KeyValuePair<uint, ACT.Core.Property> property in properties)
		{
			property.Value.Reset();
		}
		m_MoveSpeed = 1f;
		vars.Clear();
		dynamicNames.Clear();
		propertiesKey = null;
		foreach (KeyValuePair<Type, List<BaseAbilityMixin>> evtListen in m_EvtListens)
		{
			evtListen.Value.Clear();
		}
		foreach (Type evtType in abilitySystem.evtTypes)
		{
			m_BaseEvtListens[evtType] = null;
		}
		m_HP = 0;
		reviveTenacityProgress = 1f;
		_posture = 0;
		m_Level = 0;
		m_LevelOverride = false;
		m_EndureLevel = 0;
		AttackedInMotion = false;
		onHPChange.Clear();
		damageableHited = null;
		comboDamageable = null;
		onEntityHpChange.Clear();
		onTenChange.Clear();
		onDie.Clear();
		onRelase.Clear();
		properties.Clear();
		suitChip.Clear();
		modifiedSkills.Clear();
		anomalyData = null;
		_ultimateSkillValue = 0f;
		_posture = 0;
		_activePosture = true;
		onPostureChange = null;
		onRevivePostureProgressChange = null;
		onActivePostureChange = null;
		onPostureBurstChange = null;
		bagAbilities.Clear();
		abilityTagCounter.Clear();
		cacheHitRecoveryEnergy.Clear();
		ClearHitRecoveryEnergyContext();
		onCharacterDamageHit = null;
		m_AssistValue = 0f;
		_energyValue = 0f;
		_specialEnergyValue = 0f;
		mannerType = MannerType.None;
		m_WeakCoefficient = 0f;
		BSetPool<Ability>.Default.Recycle(abilities);
		BMapPool<int, Ability>.Default.Recycle(dummyAbilities);
		BSetPool<Ability>.Default.Recycle(toRemove);
		BSetPool<HitedInfo>.Default.Recycle(hited);
		BSetPool<Entity>.Default.Recycle(carryed);
		BMapPool<string, DynamicValue>.Default.Recycle(vars);
		ReleaseEntityVars();
		BMapPool<int, string>.Default.Recycle(dynamicNames);
		BMapPool<int, int>.Default.Recycle(suitChip);
		BMapPool<int, ModifiedSkill>.Default.Recycle(modifiedSkills);
		BSetPool<Ability>.Default.Recycle(bagAbilities);
		BMapPool<int, int>.Default.Recycle(abilityTagCounter);
		BSetPool<HitRecoveryEnergyInfo>.Default.Recycle(cacheHitRecoveryEnergy);
		ClearVisualChannels();
		ResetDamageModifiers();
		dieStartTime = float.MaxValue;
	}

	public void BattleInit()
	{
		if (owner.IsMonster())
		{
			_activePosture = owner.GetConfig().defaultActivePosture;
			if (_activePosture)
			{
				_revivePostureProgress = 1f;
				_posture = maxPosture;
			}
		}
	}

	public void RegisterAbility(Ability ability)
	{
		abilities.Add(ability);
		RefreshAbilityTagCounter(ability.config, 1);
	}

	public void UnregisterAbility(Ability ability)
	{
		RefreshAbilityTagCounter(ability.config, -1);
		abilities.Remove(ability);
	}

	internal void ClearPendingAbilityBeforeRelease(Ability ability)
	{
		if (ability != null)
		{
			bool flag = true;
			while (flag)
			{
				flag = toRemove.Remove(ability);
			}
		}
	}

	private void RefreshAbilityTagCounter(ConfigAbility config, int delta)
	{
		if (config == null || delta == 0)
		{
			return;
		}
		int[] compiledCustomTagIds = config.GetCompiledCustomTagIds();
		foreach (int key in compiledCustomTagIds)
		{
			abilityTagCounter.TryGetValue(key, out var value);
			int num = value + delta;
			if (num <= 0)
			{
				abilityTagCounter.Remove(key);
			}
			else
			{
				abilityTagCounter[key] = num;
			}
		}
	}

	public void AddAbilities(string[] abilities, AbilitySource source)
	{
		Entity caster = owner.GetCaster();
		foreach (string abName in abilities)
		{
			AddAbility(caster, abName, source, default, 1);
		}
	}

	public void AddAbilities(string[] abilities, AbilitySource source, Ability ownerAbility)
	{
		Entity caster = owner.GetCaster();
		foreach (string abName in abilities)
		{
			AddAbility(caster, abName, source, ownerAbility.skillLevelInfo, 1);
		}
	}

	public void AddAbilitiesByBindings(IEnumerable<AbilitiyBinding> abilitiyBindings)
	{
		foreach (AbilitiyBinding abilitiyBinding in abilitiyBindings)
		{
			int skillId = abilitiyBinding.skillId;
			bool flag = dummyAbilities.TryGetValue(skillId, out var _);
			if (!abilitiyBinding.ingoreWhenNoSkill || flag)
			{
				string[] abilitiyNames = abilitiyBinding.abilitiyNames;
				foreach (string ab in abilitiyNames)
				{
					AddAbilityByBinding(abilitiyBinding.skillId, ab);
				}
			}
		}
	}

	public void AddAbilityByBinding(int skillId, string ab)
	{
		Entity caster = owner.GetCaster();
		if (owner.IsCharacter())
		{
			if (dummyAbilities.TryGetValue(skillId, out var value))
			{
				AddAbility(caster, ab, AbilitySource.UpgradeSkill, value.skillLevelInfo, 1);
				return;
			}
			MPSkill skillLevelInfo = new MPSkill
			{
				id = 0,
				level = 1
			};
			AddAbility(caster, ab, AbilitySource.UpgradeSkill, skillLevelInfo, 1);
			_ = LuminApplication.LogEnabled;
		}
		else if (owner.IsBehaveEntity())
		{
			AddAbility(caster, ab, AbilitySource.UpgradeSkill, new MPSkill
			{
				id = skillId,
				level = 1
			}, 1);
		}
	}

	public void AddAbilityByBinding(Entity entity, int skillId, string ab, AbilitySource source, int rogueTrigger = -1)
	{
		Entity entity2 = entity;
		entity = entity.GetCaster();
		if (entity2.IsCharacter())
		{
			if (entity2.GetCompAbility().dummyAbilities.TryGetValue(skillId, out var value))
			{
				AddAbility(entity, ab, source, value.skillLevelInfo, 1, rogueTrigger);
				return;
			}
			AddAbility(entity, ab, source, new MPSkill
			{
				id = skillId,
				level = 1
			}, 1, rogueTrigger);
		}
		else if (entity2.IsMonster())
		{
			AddAbility(entity, ab, source, new MPSkill
			{
				id = skillId,
				level = 1
			}, 1, rogueTrigger);
		}
	}

	public void AddAbility(Entity caster, string abName, AbilitySource source, MPSkill skillLevelInfo, int stack, int rogueTrigger = -1)
	{
		if (string.IsNullOrEmpty(abName))
		{
			return;
		}
		try
		{
			if (stack <= 0)
			{
				return;
			}
			SystemAbility abilitySystem = GameManager.abilitySystem;
			if (EngineConfigs.ability.TryGetValue(abName, out var value))
			{
				EvtAddAbilityBeforeAdd evt = abilitySystem.GetEvt<EvtAddAbilityBeforeAdd>(owner, null);
				evt.mainEntity = owner;
				evt.name = abName;
				evt.stack = stack;
				evt.casterEntity = caster;
				evt.targetEntity = owner;
				abilitySystem.FireEvt(evt);
				abilitySystem.ReleaseEvt(evt);
				if (!owner.IsCharacter() && !owner.IsAlive())
				{
					return;
				}
				EntityType entityType = owner.GetEntityType();
				if (value.filterBlockEntityType.HasEntityType(entityType))
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning($"entity类型不符合，无法添加技能：{abName}，entityType: {entityType}");
					}
					return;
				}
				if (!value.filterBlockAbilities.IsNullOrEmpty())
				{
					string[] filterBlockAbilities = value.filterBlockAbilities;
					foreach (string text in filterBlockAbilities)
					{
						if (HasAbility(text))
						{
							if (LuminApplication.LogEnabled)
							{
								Debug.LogWarning("entity身上有被过滤的技能，无法添加技能：" + abName + "，过滤技能: " + text);
							}
							return;
						}
					}
				}
				if (value.filterBlockTags != 0)
				{
					foreach (Ability ability2 in abilities)
					{
						if ((ability2.config.buffTag & value.filterBlockTags) != 0)
						{
							if (LuminApplication.LogEnabled)
							{
								Debug.LogWarning($"entity身上有被过滤的BuffTag，无法添加技能：{abName}，匹配Tag: {ability2.config.buffTag & value.filterBlockTags}");
							}
							return;
						}
					}
				}
				int[] compiledFilterBlockCustomTagIds = value.GetCompiledFilterBlockCustomTagIds();
				if (compiledFilterBlockCustomTagIds.Length != 0 && TryGetMatchedAbilityCustomTag(compiledFilterBlockCustomTagIds, out var matchedTagId))
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning("entity身上有被过滤的CustomTag，无法添加技能：" + abName + "，匹配Tag: " + AbilityTagRegistry.GetTagDisplayName(matchedTagId));
					}
				}
				else
				{
					if (value.buffType == BuffType.ControlBuff && (owner.InTag(EntityTag.IgnoreControl) || Mathf.Abs(GetProperty(204u).value - 1f) < 0.0001f))
					{
						return;
					}
					AbilitySource abilitySource = AbilitySource.Passive | AbilitySource.UpgradeSkill | AbilitySource.Weapon | AbilitySource.Chip | AbilitySource.System | AbilitySource.RogueCard | AbilitySource.RogueArtifact | AbilitySource.RogueTrigger | AbilitySource.Equip | AbilitySource.BloodBottle | AbilitySource.Constellation;
					if (abName == "cantBeAttack")
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogError($"entity{owner}被添加无敌buff->{abName}，source是->{source}");
						}
						if (abilitySource.HasFlag(source))
						{
							if (LuminApplication.LogEnabled)
							{
								Debug.LogError($"entity{owner}被添加无敌buff->{abName}，但是source是->{source}，类型错误，无法被添加");
							}
							return;
						}
					}
					Ability ability = abilitySystem.abilityPool.Get();
					stack = Mathf.Max(stack, 1);
					ability.Init(caster, owner, value, source, skillLevelInfo, stack, rogueTrigger);
					ability = abilitySystem.ProcessImmediateAbilityAdd(owner, ability);
					EvtAddAbilityAddTo evt2 = abilitySystem.GetEvt<EvtAddAbilityAddTo>(owner, null);
					evt2.mainEntity = caster;
					evt2.name = abName;
					evt2.ability = ability;
					evt2.casterEntity = caster;
					evt2.targetEntity = owner;
					abilitySystem.FireEvt(evt2);
					abilitySystem.ReleaseEvt(evt2);
					EvtAddAbilityAdd evt3 = abilitySystem.GetEvt<EvtAddAbilityAdd>(owner, null);
					evt3.mainEntity = owner;
					evt3.name = abName;
					evt3.ability = ability;
					evt3.casterEntity = caster;
					evt3.targetEntity = owner;
					abilitySystem.FireEvt(evt3);
					abilitySystem.ReleaseEvt(evt3);
					ability.OnInit(evt3);
					_ = LuminApplication.LogEnabled;
					BuffAddEvt evt4 = EventTrackSolver.Instance.GetEvt<BuffAddEvt>();
					evt4.skillId = skillLevelInfo.id;
					evt4.caster = caster;
					evt4.owner = owner;
					evt4.buffStackNum = stack;
					evt4.buffName = abName;
					EventTrackSolver.Instance.Dispatch(evt4);
					bool num = Model<CharacterTutorialModel>.HasInstance() && Model<CharacterTutorialModel>.Interface.InCharacterTutorial;
					bool flag = Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedCharacterAddAbilityEvent;
					if ((num | flag) && caster.IsCharacter())
					{
						CharacterTutorialAddAbilityEvt evt5 = Singleton<EventManager>.instance.GetEvt<CharacterTutorialAddAbilityEvt>();
						evt5.entity = caster;
						evt5.characterId = caster.GetCompCharacter().characterSource.Id();
						evt5.abilityName = abName;
						Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_AddAbility, evt5);
						Singleton<EventManager>.instance.ReleaseEvt(evt5);
					}
				}
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public void AddAbility(MPAbility mpab)
	{
		ConfigAbility ability = GameLoader.meta.GetAbility(mpab.id);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		Ability ability2 = abilitySystem.abilityPool.Get();
		ability2.Init(ability, mpab);
		abilitySystem.ProcessImmediateAbilityAdd(owner, ability2);
	}

	public void AddAbilityPropertyOnly(Entity caster, string abName, AbilitySource source, MPSkill skillLevelInfo, int stack, int rogueTrigger = -1)
	{
		if (string.IsNullOrEmpty(abName))
		{
			return;
		}
		try
		{
			if (stack > 0)
			{
				SystemAbility abilitySystem = GameManager.abilitySystem;
				if (EngineConfigs.ability.TryGetValue(abName, out var value))
				{
					Ability ability = abilitySystem.abilityPool.Get();
					stack = Mathf.Max(stack, 1);
					ability.Init(caster, owner, value, source, skillLevelInfo, stack, rogueTrigger);
					ability.InitMixins();
					RegisterAbility(ability);
					bagAbilities.Add(ability);
					TrackAbilityEvt evt = EventTrackSolver.Instance.GetEvt<TrackAbilityEvt>();
					evt.ability = ability;
					evt.owner = owner;
					EventTrackSolver.Instance.Dispatch(evt);
					EvtAddAbilityAdd evt2 = abilitySystem.GetEvt<EvtAddAbilityAdd>(owner, null);
					evt2.mainEntity = owner;
					evt2.name = ability.config.name;
					abilitySystem.FireEvt(evt2);
					abilitySystem.ReleaseEvt(evt2);
					ability.AddProperty();
				}
				else
				{
					_ = LuminApplication.LogEnabled;
				}
			}
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public void GetAbilityFormSource(AbilitySource source, ref BList<Ability> list)
	{
		foreach (Ability ability in abilities)
		{
			if (ability.source.HasFlag(source))
			{
				list.Add(ability);
			}
		}
	}

	public void ClearTimeAbility()
	{
		BSet<Ability> bSet = BSetPool<Ability>.Default.Get();
		foreach (Ability ability in abilities)
		{
			if (ability.CanRemoveInDie)
			{
				bSet.Add(ability);
			}
		}
		ClearAbility(bSet);
		BSetPool<Ability>.Default.Recycle(bSet);
	}

	public void ClearAbility(BSet<Ability> removeAbilities)
	{
		foreach (Ability removeAbility in removeAbilities)
		{
			removeAbility.OnSilentRemove(this);
			if (removeAbility.attachEffects.Count > 0)
			{
				foreach (EffectRuntimeItem attachEffect in removeAbility.attachEffects)
				{
					attachEffect.SetToBeRemove();
					RemoveEffect(attachEffect);
				}
			}
			GameManager.effectSystem?.StopAbilityEffects(removeAbility.playEffects);
			foreach (KeyValuePair<YooAssetReference, InstanceHandle> item in removeAbility.abilityVolumeAssetID)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(item.Value);
			}
			removeAbility.abilityVolumeAssetID.Clear();
			toRemove.Add(removeAbility);
		}
	}

	public bool HasAbility(string name)
	{
		foreach (Ability ability in abilities)
		{
			if (ability.config != null && ability.config.name == name)
			{
				return true;
			}
		}
		return false;
	}

	public bool HasAbilityTag(BuffTag buffTag)
	{
		foreach (Ability ability in abilities)
		{
			if ((ability.config.buffTag & buffTag) != 0)
			{
				return true;
			}
		}
		return false;
	}

	private bool HasAbilityTagId(int tagId)
	{
		if (abilityTagCounter != null && abilityTagCounter.TryGetValue(tagId, out var value))
		{
			return value > 0;
		}
		return false;
	}

	public bool HasAbilityCustomTag(string customTag)
	{
		if (!AbilityTagRegistry.TryGetCustomTagId(customTag, out var tagId))
		{
			return false;
		}
		return HasAbilityTagId(tagId);
	}

	public bool TryGetMatchedAbilityCustomTag(int[] candidateTagIds, out int matchedTagId)
	{
		matchedTagId = 0;
		if (candidateTagIds == null)
		{
			return false;
		}
		foreach (int num in candidateTagIds)
		{
			if (HasAbilityTagId(num))
			{
				matchedTagId = num;
				return true;
			}
		}
		return false;
	}

	public Ability GetAbilityByName(string name)
	{
		foreach (Ability ability in abilities)
		{
			if (ability.config != null && ability.config.name == name)
			{
				return ability;
			}
		}
		return null;
	}

	public List<Ability> GetAbilitiesByTag(BuffTag buffTag)
	{
		List<Ability> list = new List<Ability>();
		foreach (Ability ability in abilities)
		{
			if (ability.config != null && ability.config.buffType.HasFlag(buffTag))
			{
				list.Add(ability);
			}
		}
		return list;
	}

	public Ability GetAbilityById(int Id)
	{
		foreach (KeyValuePair<int, Ability> dummyAbility in dummyAbilities)
		{
			if (dummyAbility.Key == Id)
			{
				return dummyAbility.Value;
			}
		}
		return null;
	}

	public void NetSyncUpdateAbility(MPAbility mpab)
	{
		if (TryGetAbility(mpab.id, out var ab))
		{
			if (ab.stack > mpab.stack)
			{
				ab.RemoveStackImpl(ab.stack - mpab.stack);
			}
			else
			{
				ab.Merge(mpab.stack - ab.stack);
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("buff not exist?");
		}
	}

	public void RemoveAbility(string name)
	{
		if (TryGetAbility(name, includeAdd: true, out var ab))
		{
			_ = LuminApplication.LogEnabled;
			ab.RemoveStack(ab.stack);
		}
	}

	public void RemoveToBag()
	{
		onRelase?.Invoke(owner);
		onRelase.Clear();
		onDie.Clear();
		foreach (Ability ability in abilities)
		{
			UnregisterAbility(ability);
			ability.OnRemove();
			SystemAbility.DoActions(ability.caster, owner, FindTargetResult.EntityOnly(owner), null, ability, ability.config.OnRemove);
			ability.config.RemoveCache();
			onRemoveAbility?.Invoke(ability);
			onAbilityChange?.Invoke();
		}
		vars.Clear();
		ClearEntityVars();
		dynamicNames.Clear();
	}

	public void RemoveAbilityFormSource(AbilitySource source)
	{
		foreach (Ability ability in abilities)
		{
			if (ability.source.HasFlag(source))
			{
				ability.RemoveStack(ability.stack);
			}
		}
	}

	public void RemoveAbilityFormSourceImmediate(AbilitySource source)
	{
		BList<Ability> bList = BListPool<Ability>.Default.Get();
		foreach (Ability ability in abilities)
		{
			if (ability.source.HasFlag(source))
			{
				bList.Add(ability);
			}
		}
		foreach (Ability item in bList)
		{
			RemoveAbilityImmediate(item);
		}
		BListPool<Ability>.Default.Recycle(bList);
	}

	public void RemoveAbilityImmediate(string name)
	{
		if (TryGetAbility(name, includeAdd: true, out var ab))
		{
			RemoveAbilityImmediate(ab);
		}
	}

	private void RemoveAbilityImmediate(Ability ability)
	{
		ability.OnRemove();
		SystemAbility.DoActions(ability.caster, owner, FindTargetResult.EntityOnly(owner), null, ability, ability.config.OnRemove);
		UnregisterAbility(ability);
		ability.config.RemoveCache();
		ClearPendingAbilityBeforeRelease(ability);
		GameManager.abilitySystem.abilityPool.Release(ability);
		onRemoveAbility?.Invoke(ability);
		onAbilityChange?.Invoke();
	}

	public void RemoveAbilityFormSource(int id, AbilitySource source)
	{
		SystemRogue rogueSystem = GameManager.rogueSystem;
		foreach (Ability ability in abilities)
		{
			if (ability.source.HasFlag(source) && ability.rogueTrigger == id && (ability.config == null || !ability.config.buffTag.HasFlag(BuffTag.SharedTriggerBuff) || rogueSystem.GetTriggerSuitCount(id) == 0))
			{
				ability.RemoveStack(ability.stack);
			}
		}
		_ = LuminApplication.LogEnabled;
	}

	public void DoPropertyAbilityRemove(string name)
	{
		if (TryGetAbility(name, includeAdd: true, out var ab))
		{
			ab.RemoveProperty();
			ClearPendingAbilityBeforeRelease(ab);
			GameManager.abilitySystem.abilityPool.Release(ab);
			UnregisterAbility(ab);
			bagAbilities.Remove(ab);
		}
	}

	public void NetSyncRemoveAbility(int id)
	{
		if (TryGetAbility(id, out var ab))
		{
			ab.RemoveStackImpl(ab.stack);
		}
	}

	public void RemoveAbilityStack(string name, int stack)
	{
		if (TryGetAbility(name, includeAdd: true, out var ab))
		{
			ab.RemoveStack(stack);
		}
	}

	internal bool TryGetAbility(string name, bool includeAdd, out Ability ab)
	{
		foreach (Ability ability in abilities)
		{
			if (ability.config != null && ability.config.name == name)
			{
				ab = ability;
				return true;
			}
		}
		ab = null;
		return false;
	}

	internal bool TryGetAbility(int id, out Ability ab)
	{
		foreach (Ability ability in abilities)
		{
			if (ability.config.id == id)
			{
				ab = ability;
				return true;
			}
		}
		ab = null;
		return false;
	}

	public void ChangeAssistValue(float value)
	{
		float assistValue = m_AssistValue;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBeforeModifyAssistValue evt = abilitySystem.GetEvt<EvtBeforeModifyAssistValue>(owner, null);
		evt.mainEntity = owner;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		m_AssistValue += value * (1f + GetProperty(209u).value);
		m_AssistValue = Mathf.Clamp(m_AssistValue, 0f, MaxAssistValue);
		OnAssistValChange();
		if (m_AssistValue > assistValue && Mathf.Approximately(m_AssistValue, MaxAssistValue))
		{
			AudioEventReference assistFullSoundEvent = GameLoader.meta.assistFullSoundEvent;
			if (!assistFullSoundEvent.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(assistFullSoundEvent, new AudioPlayOptions
				{
					attachTarget = owner.GetRootTransform()
				});
			}
		}
		EvtModifyAssistValue evt2 = abilitySystem.GetEvt<EvtModifyAssistValue>(owner, null);
		evt2.mainEntity = owner;
		evt2.before = assistValue;
		evt2.after = m_AssistValue;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	public void ClearAssistValue()
	{
		float assistValue = m_AssistValue;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBeforeModifyAssistValue evt = abilitySystem.GetEvt<EvtBeforeModifyAssistValue>(owner, null);
		evt.mainEntity = owner;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		m_AssistValue = 0f;
		OnAssistValChange();
		EvtModifyAssistValue evt2 = abilitySystem.GetEvt<EvtModifyAssistValue>(owner, null);
		evt2.mainEntity = owner;
		evt2.before = assistValue;
		evt2.after = m_AssistValue;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	public void SetAssistValue(float value)
	{
		float assistValue = m_AssistValue;
		m_AssistValue = Mathf.Clamp(value, 0f, MaxAssistValue);
		OnAssistValChange();
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtModifyAssistValue evt = abilitySystem.GetEvt<EvtModifyAssistValue>(owner, null);
		evt.mainEntity = owner;
		evt.before = assistValue;
		evt.after = m_AssistValue;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	public bool CanAssist(float need)
	{
		return !(need > AssistValue);
	}

	public void CostAssist()
	{
		float assistValue = m_AssistValue;
		m_AssistValue -= AssistCost;
		m_AssistValue = Mathf.Clamp(m_AssistValue, 0f, MaxAssistValue);
		OnAssistValChange();
		float assistValue2 = m_AssistValue;
		float valueChange = assistValue2 - assistValue;
		AssistValueChange evt = EventTrackSolver.Instance.GetEvt<AssistValueChange>();
		evt.valueBefore = assistValue;
		evt.valueAfter = assistValue2;
		evt.valueChange = valueChange;
		evt.reason = AssistChangeReason.Assist.ToString();
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void OnAssistValChange()
	{
		if (owner.GetCompCharacter() != null)
		{
			AssistValChangeEvt evt = Singleton<EventManager>.instance.GetEvt<AssistValChangeEvt>();
			evt.eb = owner;
			evt.assistVal = m_AssistValue;
			evt.assistMax = MaxAssistValue;
			evt.assistPercent = AssistPercent;
			evt.assistCost = AssistCost;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.AssistVal_Change, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public int SetHited(FindTargetResult target, float hitCd, AttackPattern attack, int maxHitCount = 1)
	{
		FindTargetResult other = ((target.targetSourceType == FindTargetResult.TargetSourceType.Damageable || !target.entity.IsDummy()) ? target : FindTargetResult.EntityOnly(target.entity.GetCaster()));
		foreach (HitedInfo item in hited)
		{
			FindTargetResult findTargetResult = item.hited;
			if (findTargetResult.Equals(other) && item.attack == attack)
			{
				if ((maxHitCount <= 1) ? (item.currentHitCount >= 1) : (item.currentHitCount >= maxHitCount))
				{
					return item.currentHitCount;
				}
				hited.Remove(item);
				int num = item.currentHitCount + 1;
				hited.Add(new HitedInfo
				{
					hited = other,
					hitCD = hitCd,
					currentHitCount = num,
					maxHitCount = maxHitCount,
					attack = attack
				});
				return num;
			}
		}
		hited.Add(new HitedInfo
		{
			hited = other,
			hitCD = hitCd,
			currentHitCount = 1,
			maxHitCount = maxHitCount,
			attack = attack
		});
		return 1;
	}

	public bool IsHited(FindTargetResult findTarget, AttackPattern attack)
	{
		FindTargetResult other = ((findTarget.entity.IsValid && findTarget.entity.IsDummy()) ? FindTargetResult.EntityOnly(findTarget.entity.GetCompProduct().caster) : findTarget);
		if (attack == null)
		{
			foreach (HitedInfo item in hited)
			{
				FindTargetResult findTargetResult = item.hited;
				if (findTargetResult.Equals(other))
				{
					if ((item.maxHitCount <= 1) ? (item.currentHitCount >= 1) : (item.currentHitCount >= item.maxHitCount))
					{
						return true;
					}
					if (item.hitCD > 0f)
					{
						return true;
					}
				}
			}
			return false;
		}
		foreach (HitedInfo item2 in hited)
		{
			FindTargetResult findTargetResult = item2.hited;
			if (findTargetResult.Equals(other) && item2.attack == attack)
			{
				if ((item2.maxHitCount <= 1) ? (item2.currentHitCount >= 1) : (item2.currentHitCount >= item2.maxHitCount))
				{
					return true;
				}
				if (item2.hitCD > 0f)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void FixedUpdateHited(float deltaTime)
	{
		foreach (HitedInfo item in hited)
		{
			if (!((item.maxHitCount <= 1) ? (item.currentHitCount >= 1) : (item.currentHitCount >= item.maxHitCount)) && item.hitCD >= 0f)
			{
				hited.Remove(item);
				if (item.hitCD != 0f || item.maxHitCount > 1)
				{
					float num = item.hitCD - deltaTime;
					hited.Add(new HitedInfo
					{
						hited = item.hited,
						hitCD = ((num < 0f) ? 0f : num),
						currentHitCount = item.currentHitCount,
						maxHitCount = item.maxHitCount,
						attack = item.attack
					});
				}
			}
		}
	}

	public void ClearHited()
	{
		hited.Clear();
	}

	public void AddCarryTarget(Entity target, Transform carryCenter, Vector3 carryoffset, Transform beCarryCenter)
	{
		if (!carryed.Contains(target))
		{
			carryed.Add(target);
			CompTransform compTransform = target.GetCompTransform();
			compTransform.SetCarrier(owner, carryCenter, carryoffset, beCarryCenter);
			target.GetCompPhysics().SetMovementMode(ACTMovementMode.BeCarryed);
			if (carryCenter != null && beCarryCenter != null)
			{
				Vector3 vector = carryCenter.position + carryoffset;
				compTransform.SetPositionImmediately(compTransform.physicsPosition + vector - beCarryCenter.position);
			}
			target.SetBool("BeCarryed", value: true);
		}
	}

	public void ClearCarryed()
	{
		foreach (Entity item in carryed)
		{
			item.SetBool("BeCarryed", value: false);
			CompPhysics? compPhysics = item.GetCompPhysics();
			compPhysics.ClearLastFrameVelocity();
			compPhysics.ExitBeCarryed();
		}
		carryed.Clear();
	}

	private void MaxTenacityChange(float from, float to)
	{
		if (to > from)
		{
			int num = Mathf.CeilToInt(to - from);
			int value = tenacityValue + num;
			ServerSetTenacity(value);
		}
	}

	[Obsolete("韧性机制已经被弃用")]
	public void ServerSetTenacity(int value)
	{
		int num = _tenacityValue;
		value = Mathf.Clamp(value, 0, maxTenacity);
		_tenacityValue = value;
		onTenChange.Invoke(num, value);
		if (num <= 0 && value > 0)
		{
			SyncTenacityState(isTenacityNull: false);
		}
		else if (num > 0 && value <= 0)
		{
			SyncTenacityState(isTenacityNull: true);
		}
		if (value == maxTenacity)
		{
			SystemAbility abilitySystem = GameManager.abilitySystem;
			EvtTenacitiedRecoverMax evt = abilitySystem.GetEvt<EvtTenacitiedRecoverMax>(owner, null);
			evt.mainEntity = owner;
			abilitySystem.FireEvt(evt);
			abilitySystem.ReleaseEvt(evt);
		}
	}

	private void SyncTenacityState(bool isTenacityNull)
	{
		if (isTenacityNull)
		{
			reviveTenacityProgress = 0f;
			CompMotion compMotion = owner.GetCompMotion();
			CompBehave? compBehave = owner.GetCompBehave();
			EntityType entityType = compBehave.EntityType;
			MonoEntity monoEntity = compBehave.MonoEntity;
			if ((entityType == EntityType.Boss || entityType == EntityType.Elite) && GameLoader.meta.weakRefrenceAssetID != null)
			{
				GameManager.effectSystem.FireEffect(GameLoader.meta.weakRefrenceAssetID, monoEntity.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT), Quaternion.identity);
			}
			else if (entityType == EntityType.Monster && GameLoader.meta.enemyWeakRefrenceAssetID != null)
			{
				GameManager.effectSystem.FireEffect(GameLoader.meta.enemyWeakRefrenceAssetID, monoEntity.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT), Quaternion.identity);
			}
			if (!compMotion.InTag(MotionTag_backUp.TenacityImmune))
			{
				compMotion.isChasingSuccess = true;
			}
		}
		else
		{
			owner.GetBTree().SendEvent("tenaciRecover");
		}
	}

	public int CalTenacity(float tenacityAtk)
	{
		float num;
		if (owner.InTag(MotionTag_backUp.SuperArmor) || owner.InTag(MotionTag_backUp.TenacityImmune))
		{
			num = 0f;
		}
		else
		{
			num = ((!owner.InTag(MotionTag_backUp.TenResistance)) ? 1f : BattleConsts.tenResistance);
		}
		return tenacityValue - Mathf.CeilToInt(tenacityAtk * num);
	}

	public void AddSkillModifier(ISkillModifier modifier, Ability ability)
	{
		modifier.Init(ability);
		MPSkill skill = new MPSkill
		{
			id = modifier.SkillId
		};
		int skillId = modifier.SkillId;
		string key = modifier.Key;
		int stringArrIndex = skill.GetStringArrIndex(key);
		if (!modifiedSkills.ContainsKey(skillId) && RuntimeConfigs.data.skillDetailDatas.TryGetValue(skillId, out var value))
		{
			modifiedSkills.Add(skillId, new ModifiedSkill
			{
				param = new float[value.validParam.Length + value.validParam1.Length]
			});
		}
		if (modifiedSkills.ContainsKey(skillId) && stringArrIndex >= 0)
		{
			modifiedSkills[skillId].param[stringArrIndex] += modifier.GetValue();
		}
	}

	public void AddSkillModifier(ISkillModifier[] modifiers, Ability ability)
	{
		foreach (ISkillModifier modifier in modifiers)
		{
			AddSkillModifier(modifier, ability);
		}
	}

	public void RemoveSkillModifier(ISkillModifier modifier, Ability ability)
	{
		modifier.Init(ability);
		int skillId = modifier.SkillId;
		MPSkill skill = new MPSkill
		{
			id = skillId
		};
		if (modifiedSkills.ContainsKey(skillId))
		{
			int stringArrIndex = skill.GetStringArrIndex(modifier.Key);
			if (stringArrIndex >= 0)
			{
				modifiedSkills[skillId].param[stringArrIndex] -= modifier.GetValue();
			}
		}
	}

	public void RemoveSkillModifier(ISkillModifier[] modifiers, Ability ability)
	{
		foreach (ISkillModifier modifier in modifiers)
		{
			RemoveSkillModifier(modifier, ability);
		}
	}

	public void SetHitRecoveryEnergyContext(AttackPattern attack, int ordinal)
	{
		hitRecoveryAttack = attack;
		hitRecoveryOrdinal = ordinal;
	}

	public void ClearHitRecoveryEnergyContext()
	{
		hitRecoveryAttack = null;
		hitRecoveryOrdinal = 0;
	}

	public void ServerHitRecoveryEnergy(ActionDamage hit, float energy)
	{
		if (owner.IsCharacter())
		{
			HitRecoveryEnergyInfo item = new HitRecoveryEnergyInfo
			{
				hit = hit,
				attack = hitRecoveryAttack,
				hitOrdinal = ((hitRecoveryAttack != null) ? hitRecoveryOrdinal : 0)
			};
			if (!cacheHitRecoveryEnergy.Contains(item))
			{
				cacheHitRecoveryEnergy.Add(item);
				SystemAbility.AddUltimateSkillValueForPlayer(MonoECS.instance.localPlayer, energy, useOffsiteParam: true, useChargeRate: true);
			}
		}
	}

	public void ClearHitRecoveryEnergy()
	{
		cacheHitRecoveryEnergy.Clear();
		ClearHitRecoveryEnergyContext();
	}

	public void AddDamageModifier(IDamageModifier modifier)
	{
		List<IDamageModifier> list = ((modifier.Side == DamageModifierSide.Attacker) ? m_AttackerDamageModifiers : m_AttackeeDamageModifiers);
		int index = list.Count;
		for (int i = 0; i < list.Count; i++)
		{
			if (modifier.Priority < list[i].Priority)
			{
				index = i;
				break;
			}
		}
		list.Insert(index, modifier);
	}

	public void RemoveDamageModifier(IDamageModifier modifier)
	{
		((modifier.Side == DamageModifierSide.Attacker) ? m_AttackerDamageModifiers : m_AttackeeDamageModifiers).Remove(modifier);
	}

	public void ApplyAttackerDamageModifiers(AttackData attackData, Ability sourceAbility)
	{
		for (int i = 0; i < m_AttackerDamageModifiers.Count; i++)
		{
			IDamageModifier damageModifier = m_AttackerDamageModifiers[i];
			if (damageModifier.IsValid)
			{
				damageModifier.Modify(attackData, sourceAbility);
			}
		}
	}

	public void ApplyAttackeeDamageModifiers(AttackData attackData, Ability sourceAbility)
	{
		for (int i = 0; i < m_AttackeeDamageModifiers.Count; i++)
		{
			IDamageModifier damageModifier = m_AttackeeDamageModifiers[i];
			if (damageModifier.IsValid)
			{
				damageModifier.Modify(attackData, sourceAbility);
			}
		}
	}

	private void ResetDamageModifiers()
	{
		m_AttackerDamageModifiers.Clear();
		m_AttackeeDamageModifiers.Clear();
	}

	public void SyncNormalEnergyValue(float value)
	{
		_energyValue = value;
	}

	public void ModifyNormalEnergy(float value)
	{
		float energyValue = EnergyValue;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBeforeModifyNormalEnergy evt = abilitySystem.GetEvt<EvtBeforeModifyNormalEnergy>(owner, null);
		evt.mainEntity = owner;
		evt.value = value;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		if (owner.IsCharacter())
		{
			SetNormalEnergy(value);
		}
		EvtModifyNormalEnergy evt2 = abilitySystem.GetEvt<EvtModifyNormalEnergy>(owner, null);
		evt2.mainEntity = owner;
		evt2.preValue = energyValue;
		evt2.curValue = EnergyValue;
		evt2.modifySource = ActionChangeNormalEnergy.ModifySource.None;
		evt2.state = ActionChangeNormalEnergy.State.Set;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	public void ActionModifyNormalEnergy(float value, Ability ability, ActionChangeNormalEnergy.State state, ActionChangeNormalEnergy.ModifySource modifySource = ActionChangeNormalEnergy.ModifySource.None)
	{
		float energyValue = EnergyValue;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBeforeModifyNormalEnergy evt = abilitySystem.GetEvt<EvtBeforeModifyNormalEnergy>(owner, ability);
		evt.mainEntity = owner;
		evt.value = value;
		evt.modifySource = modifySource;
		abilitySystem.FireEvt(evt);
		value = evt.value;
		abilitySystem.ReleaseEvt(evt);
		if (owner.IsCharacter())
		{
			float v;
			if (state == ActionChangeNormalEnergy.State.Normal)
			{
				float value2 = GetProperty(208u).value;
				int num = ((value >= 0f) ? 1 : 0);
				v = energyValue + value * (1f + (float)num * value2);
			}
			else
			{
				v = value;
			}
			SetNormalEnergy(Quantize(v));
			float num2 = energyValue - EnergyValue;
			if (num2 > 0f && Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedCharacterNormalEnergyEvent)
			{
				CharacterNormalEnergyConsumeEvt evt2 = Singleton<EventManager>.instance.GetEvt<CharacterNormalEnergyConsumeEvt>();
				evt2.entity = owner;
				evt2.characterId = owner.GetCompCharacter().characterSource.Id();
				evt2.consumedValue = num2;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterNormalEnergyChange, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
			}
		}
		EvtModifyNormalEnergy evt3 = abilitySystem.GetEvt<EvtModifyNormalEnergy>(owner, ability);
		evt3.mainEntity = owner;
		evt3.preValue = energyValue;
		evt3.curValue = EnergyValue;
		evt3.modifySource = modifySource;
		evt3.state = state;
		abilitySystem.FireEvt(evt3);
		abilitySystem.ReleaseEvt(evt3);
		static float Quantize(float num3)
		{
			return Mathf.Round(num3 * 1000f) / 1000f;
		}
	}

	private void SetNormalEnergy(float value)
	{
		float num = Mathf.Clamp(value, 0f, MaxNormalEnergy);
		if (!Mathf.Approximately(_energyValue, num))
		{
			_energyValue = num;
			owner.SetFloat("normalEnergy", _energyValue);
			CharacterNormalEnergyChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterNormalEnergyChangeEvt>();
			evt.entity = owner;
			evt.characterId = owner.GetCompCharacter().characterSource.Id();
			evt.value = _energyValue;
			evt.percent = _energyValue / MaxNormalEnergy;
			evt.min = 0f;
			evt.max = MaxNormalEnergy;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterNormalEnergyChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void ActionRegurgitateNormalEnergy(float value, Ability ability)
	{
		float energyValue = EnergyValue;
		if (owner.IsCharacter())
		{
			value += energyValue;
			SetNormalEnergy(value);
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtRegurgitateNormalEnergy evt = abilitySystem.GetEvt<EvtRegurgitateNormalEnergy>(owner, ability);
		evt.mainEntity = owner;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	public void ModifySpecialEnergy(float value)
	{
		float specialEnergyValue = SpecialEnergyValue;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBeforeModifySpecialEnergy evt = abilitySystem.GetEvt<EvtBeforeModifySpecialEnergy>(owner, null);
		evt.mainEntity = owner;
		evt.value = value;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		if (owner.IsCharacter())
		{
			SetSpecialEnergy(value);
		}
		EvtModifySpecialEnergy evt2 = abilitySystem.GetEvt<EvtModifySpecialEnergy>(owner, null);
		evt2.mainEntity = owner;
		evt2.preValue = specialEnergyValue;
		evt2.curValue = SpecialEnergyValue;
		evt2.state = ActionChangeSpecialEnergy.State.Set;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	public void ActionModifySpecialEnergy(float value, Ability ability, ActionChangeSpecialEnergy.State state)
	{
		float specialEnergyValue = SpecialEnergyValue;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBeforeModifySpecialEnergy evt = abilitySystem.GetEvt<EvtBeforeModifySpecialEnergy>(owner, ability);
		evt.mainEntity = owner;
		if (state == ActionChangeSpecialEnergy.State.Normal)
		{
			evt.value = specialEnergyValue + value;
		}
		else
		{
			evt.value = value;
		}
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		if (owner.IsCharacter())
		{
			float specialEnergy = ((state != ActionChangeSpecialEnergy.State.Normal) ? value : (specialEnergyValue + value));
			SetSpecialEnergy(specialEnergy);
			float num = specialEnergyValue - SpecialEnergyValue;
			if (num > 0f && Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedCharacterSpecialEnergyEvent)
			{
				CharacterSpecialEnergyConsumeEvt evt2 = Singleton<EventManager>.instance.GetEvt<CharacterSpecialEnergyConsumeEvt>();
				evt2.entity = owner;
				evt2.characterId = owner.GetCompCharacter().characterSource.Id();
				evt2.consumedValue = num;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterSpeicalEnergyChange, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
			}
			if (state == ActionChangeSpecialEnergy.State.Normal && value > 0f && Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedCharacterSpecialEnergyEvent)
			{
				CharacterSpecialEnergyGainEvt evt3 = Singleton<EventManager>.instance.GetEvt<CharacterSpecialEnergyGainEvt>();
				evt3.entity = owner;
				evt3.characterId = owner.GetCompCharacter().characterSource.Id();
				evt3.gainedValue = value;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterSpeicalEnergyChange, evt3);
				Singleton<EventManager>.instance.ReleaseEvt(evt3);
			}
		}
		EvtModifySpecialEnergy evt4 = abilitySystem.GetEvt<EvtModifySpecialEnergy>(owner, ability);
		evt4.mainEntity = owner;
		evt4.preValue = specialEnergyValue;
		evt4.curValue = SpecialEnergyValue;
		evt4.state = state;
		abilitySystem.FireEvt(evt4);
		abilitySystem.ReleaseEvt(evt4);
	}

	private void SetSpecialEnergy(float value)
	{
		float num = Mathf.Clamp(value, 0f, MaxSpecialEnergy);
		if (!Mathf.Approximately(_specialEnergyValue, num))
		{
			_specialEnergyValue = num;
			owner.SetFloat("specialEnergy", _specialEnergyValue);
			CharacterSpecialEnergyChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterSpecialEnergyChangeEvt>();
			evt.entity = owner;
			evt.characterId = owner.GetCompCharacter().characterSource.Id();
			evt.value = _specialEnergyValue;
			evt.percent = _specialEnergyValue / MaxSpecialEnergy;
			evt.min = 0f;
			evt.max = MaxSpecialEnergy;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterSpeicalEnergyChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void SetEntityVar(string name, EntityId value)
	{
		if (entityVars == null)
		{
			entityVars = BMapPool<string, EntityId>.Default.Get();
		}
		entityVars[name] = value;
	}

	public bool TryGetEntityVar(string name, out EntityId value)
	{
		if (entityVars != null && entityVars.TryGetValue(name, out value))
		{
			return true;
		}
		value = EntityId.Invalid;
		return false;
	}

	public bool HasEntityVar(string name)
	{
		if (entityVars != null)
		{
			return entityVars.ContainsKey(name);
		}
		return false;
	}

	public void ClearEntityVars()
	{
		entityVars?.Clear();
	}

	internal void ReleaseEntityVars()
	{
		if (entityVars != null)
		{
			entityVars.Clear();
			BMapPool<string, EntityId>.Default.Recycle(entityVars);
			entityVars = null;
		}
	}

	public DynamicValue GetOrCreateDynamicVar(string name)
	{
		DynamicValue value = null;
		if (!vars.TryGetValue(name, out value))
		{
			value = new DynamicValue(name);
			vars[name] = value;
			value.onValueChange += new Action<float, DynamicValue>(DynamicVarChangeEvt);
		}
		return value;
		void DynamicVarChangeEvt(float last, DynamicValue v)
		{
			SystemAbility abilitySystem = GameManager.abilitySystem;
			EvtDynamicValueChange evt = abilitySystem.GetEvt<EvtDynamicValueChange>(owner, null);
			evt.mainEntity = owner;
			evt.dynamicValue = v;
			evt.name = name;
			evt.changeValue = v.value - last;
			abilitySystem.FireEvt(evt);
			abilitySystem.ReleaseEvt(evt);
			DynamicValValChangeEvt evt2 = Singleton<EventManager>.instance.GetEvt<DynamicValValChangeEvt>();
			evt2.characterId = owner.GetCompCharacter()?.characterSource.Id() ?? (-1);
			evt2.name = v.Name;
			evt2.preVal = last;
			evt2.curVal = v.value;
			evt2.delta = v.value - last;
			evt2.min = v.min;
			evt2.max = v.max;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.DynamicVal_ValChange, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
	}

	public bool HasDynamicVar(string name)
	{
		return vars.ContainsKey(name);
	}

	public void AddDynamicValue(string name, float add)
	{
		if (vars.TryGetValue(name, out var value))
		{
			value.value += add;
		}
	}

	public void SyncDynamic(MPDynamic mpDy)
	{
		if (dynamicNames.TryGetValue(mpDy.id, out var value))
		{
			if (vars.TryGetValue(value, out var value2))
			{
				if (value2.value != mpDy.value)
				{
					value2.value = mpDy.value;
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("dyNamic not exist?" + value);
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("dyNamic has no name :" + mpDy.id);
		}
	}

	public List<BaseAbilityMixin> GetListeners(Type t)
	{
		return m_EvtListens[t];
	}

	public void AddListener(Type t, BaseAbilityMixin mixin)
	{
		List<BaseAbilityMixin> list = m_EvtListens[t];
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num] == mixin)
			{
				list.RemoveAt(num);
			}
		}
		int priority = mixin.GetPriority();
		int index = list.Count;
		for (int i = 0; i < list.Count; i++)
		{
			if (priority < list[i].GetPriority())
			{
				index = i;
				break;
			}
		}
		list.Insert(index, mixin);
	}

	public void RemoveListener(Type t, BaseAbilityMixin mixin)
	{
		List<BaseAbilityMixin> list = m_EvtListens[t];
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num] == mixin)
			{
				list.RemoveAt(num);
			}
		}
	}

	public void AddBaseEvtListener(Type t, Action<BaseEvt> eventAction)
	{
		Dictionary<Type, Action<BaseEvt>> baseEvtListens = m_BaseEvtListens;
		baseEvtListens[t] = (Action<BaseEvt>)Delegate.Combine(baseEvtListens[t], eventAction);
	}

	public void RemoveBaseEventListener(Type t, Action<BaseEvt> eventAction)
	{
		Dictionary<Type, Action<BaseEvt>> baseEvtListens = m_BaseEvtListens;
		baseEvtListens[t] = (Action<BaseEvt>)Delegate.Remove(baseEvtListens[t], eventAction);
	}

	public Action<BaseEvt> GetBaseEvt(Type t)
	{
		return m_BaseEvtListens[t];
	}

	private void MaxPostureChange(float from, float to, PropertyDescriptor descriptor)
	{
		if (to > from)
		{
			int num = Mathf.CeilToInt(to - from);
			int value = _posture + num;
			ServerSetPosture(value);
		}
	}

	public void ServerSetPosture(int value, float coefficient = 0f)
	{
		value = Mathf.Clamp(value, 0, maxPosture);
		if (value == _posture)
		{
			return;
		}
		int num = _posture;
		_posture = value;
		onPostureChange?.Invoke(owner, num, value);
		m_WeakCoefficient = coefficient;
		ConfigCharacter config = owner.GetConfig();
		if ((bool)config)
		{
			switch (config.postureType)
			{
			case PostureType.Long:
			case PostureType.Medium:
				if (value < num && value <= 0)
				{
					ServerSetRevivePostureProgress(0f);
				}
				break;
			case PostureType.Multi:
			{
				if (value >= num)
				{
					break;
				}
				if (value == 0)
				{
					ServerSetRevivePostureProgress(0f);
					break;
				}
				float[] posturePercent = config.posturePercent;
				for (int i = 0; i < posturePercent.Length; i++)
				{
					float num2 = posturePercent[i] * (float)maxPosture;
					if ((float)num > num2 && (float)value <= num2)
					{
						ServerSetRevivePostureProgress(0f);
						break;
					}
				}
				break;
			}
			}
		}
		if (value <= 0)
		{
			SetPostureBurst(value: false);
		}
	}

	public void SetPostureActive(bool value)
	{
		if (_activePosture != value)
		{
			_activePosture = value;
			onActivePostureChange?.Invoke(owner, value);
		}
	}

	[Obsolete("爆发态不需要了")]
	public void SetPostureBurst(bool value)
	{
		if (_postureBurst != value)
		{
			_postureBurst = value;
			onPostureBurstChange?.Invoke(owner, value);
		}
	}

	public void OnRevivePostureProgressChange(float pre, float value)
	{
		if (pre != value)
		{
			if (pre == 1f && value < 1f)
			{
				EnterBreak();
			}
			onRevivePostureProgressChange?.Invoke(owner, pre, value);
			if (pre < 1f && value == 1f)
			{
				ExitBreak();
			}
		}
	}

	public void ServerSetRevivePostureProgress(float value)
	{
		if (value != _revivePostureProgress)
		{
			float pre = _revivePostureProgress;
			_revivePostureProgress = value;
			OnRevivePostureProgressChange(pre, value);
		}
	}

	private void EnterBreak()
	{
		owner.SetBool("IsBreak", value: true);
		owner.SetBool("IsWeak", value: true);
		owner.SetTrigger("PostureBreak");
		owner.GetCompAI().ActBehaviorTree.SendEvent("enterWeak");
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtEnterWeak evt = abilitySystem.GetEvt<EvtEnterWeak>(owner, null);
		evt.mainEntity = owner;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		TrackWeakStart evt2 = EventTrackSolver.Instance.GetEvt<TrackWeakStart>();
		evt2.owner = owner;
		EventTrackSolver.Instance.Dispatch(evt2);
		EnterBreakAction();
	}

	private void ExitBreak()
	{
		ConfigCharacter config = owner.GetConfig();
		switch (config.postureType)
		{
		case PostureType.Long:
		case PostureType.Medium:
			if (config.weakEndMode == WeakEndMode.WeakEndToNormal)
			{
				ServerSetPosture(maxPosture);
			}
			else if (config.weakEndMode == WeakEndMode.WeakEndInactivePosture)
			{
				SetPostureActive(value: false);
			}
			break;
		case PostureType.Multi:
			if (posture == 0)
			{
				if (config.weakEndMode == WeakEndMode.WeakEndToNormal)
				{
					ServerSetPosture(maxPosture);
				}
				else if (config.weakEndMode == WeakEndMode.WeakEndInactivePosture)
				{
					SetPostureActive(value: false);
				}
			}
			break;
		}
		owner.SetBool("IsBreak", value: false);
		owner.SetBool("IsWeak", value: false);
		owner.GetCompAI().ActBehaviorTree?.SendEvent("postureRecover");
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtExitWeak evt = abilitySystem.GetEvt<EvtExitWeak>(owner, null);
		evt.mainEntity = owner;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	private void EnterBreakAction()
	{
		if (!owner.IsMonster())
		{
			return;
		}
		ConfigCharacter config = owner.GetConfig();
		if (config.enterWeakWhenBreakPosture || GameLoader.meta.breakPostureActions.allowNoWeak)
		{
			if (GameLoader.meta.breakPostureActions.breakPostureGlobalSpeeds.TryGetValue(config.monsterWeigtType, out var value))
			{
				value.CheckDo(new ActionMemory(owner, owner, owner));
			}
			if (GameLoader.meta.breakPostureActions.breakPostureCameraNoises.TryGetValue(config.monsterWeigtType, out var value2))
			{
				value2.CheckDo(new ActionMemory(owner, owner, owner));
			}
		}
	}

	private static PropertyDescriptor GetSystemPropertyDescriptor(PropertySource from, int uid)
	{
		if (from != PropertySource.System || uid != 4)
		{
			return PropertyDescriptor.None;
		}
		return PropertyDescriptor.MaxHpChangeWithNoGrow;
	}

	internal ACT.Core.Property GetOrCreateProperty(PropertyItem item)
	{
		if (properties.TryGetValue(item.id, out var value))
		{
			return value;
		}
		value = new ACT.Core.Property();
		value.rounding = item.rounding;
		value.originalCalType = item.cal;
		ACT.Core.Property property = value;
		property.formula = item.cal switch
		{
			PropertyCalculate.SimpleAdd => (IPropertyFormula)MulAddFormula.Instance, 
			PropertyCalculate.SimpleMulAdd => MulAddFormula.Instance, 
			PropertyCalculate.SimpleMax => MaxFormula.Instance, 
			PropertyCalculate.NonLinearAdd => NonLinearAddFormula.Instance, 
			_ => MulAddFormula.Instance, 
		};
		properties.Add(item.id, value);
		return value;
	}

	internal ACT.Core.Property GetProperty(uint name)
	{
		if (properties.TryGetValue(name, out var value))
		{
			return value;
		}
		return EmptyProperty.s_Default;
	}

	internal void PushProperties(Dictionary<int, float> propertyCal, bool needCal, PropertySource from, int uid)
	{
		foreach (KeyValuePair<int, float> item in propertyCal)
		{
			float value = item.Value;
			if (value != 0f)
			{
				int key = item.Key;
				if (RuntimeConfigs.data.propertyDatas.TryGetValue(key, out var value2))
				{
					ACT.Core.Property property = GetProperty((uint)value2.propertyId);
					NumberPropertyProvider numberPropertyProvider = NumberPropertyProvider.s_Pool.Get();
					numberPropertyProvider.constValue = value;
					numberPropertyProvider.from.source = from;
					numberPropertyProvider.from.uid = uid;
					numberPropertyProvider.propertyDescriptor = GetSystemPropertyDescriptor(from, uid);
					property.PushSubValue((PropertySub)value2.subType, numberPropertyProvider, needCal);
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"property {key} not exist");
				}
			}
		}
	}

	internal void RemoveProperties(Dictionary<int, float> propertyCal, bool needCal, PropertySource from, int uid)
	{
		foreach (KeyValuePair<int, float> item in propertyCal)
		{
			if (item.Value == 0f)
			{
				continue;
			}
			int key = item.Key;
			if (RuntimeConfigs.data.propertyDatas.TryGetValue(key, out var value))
			{
				ACT.Core.Property property = GetProperty((uint)value.propertyId);
				if (property.TryGetNumberProvider((PropertySub)value.subType, from, uid, out var provider))
				{
					property.PopSubValue((PropertySub)value.subType, provider, needCal);
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("移除不存在的值？");
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"移除不存在的属性 {key}？");
			}
		}
	}

	internal void ReplaceProperties(Dictionary<int, float> propertyCal, PropertySource from, int uid, bool isNeedCal)
	{
		foreach (KeyValuePair<int, float> item in propertyCal)
		{
			float value = item.Value;
			int key = item.Key;
			if (RuntimeConfigs.data.propertyDatas.TryGetValue(key, out var value2))
			{
				ACT.Core.Property property = GetProperty((uint)value2.propertyId);
				if (property.TryGetNumberProvider((PropertySub)value2.subType, from, uid, out var provider))
				{
					provider.propertyDescriptor = GetSystemPropertyDescriptor(from, uid);
					provider.SetValue(value);
					continue;
				}
				NumberPropertyProvider numberPropertyProvider = NumberPropertyProvider.s_Pool.Get();
				numberPropertyProvider.constValue = value;
				numberPropertyProvider.from.source = from;
				numberPropertyProvider.from.uid = uid;
				numberPropertyProvider.propertyDescriptor = GetSystemPropertyDescriptor(from, uid);
				property.PushSubValue((PropertySub)value2.subType, numberPropertyProvider, isNeedCal);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"property {key} not exist");
			}
		}
	}

	internal void PushProperty(int tableId, float value, bool isNeedCal, out NumberPropertyProvider pp, out uint propertId, out PropertySub subType)
	{
		if (RuntimeConfigs.data.propertyDatas.TryGetValue(tableId, out var value2))
		{
			propertId = (uint)value2.propertyId;
			ACT.Core.Property property = GetProperty(propertId);
			pp = NumberPropertyProvider.s_Pool.Get();
			pp.constValue = value;
			pp.propertyDescriptor = PropertyDescriptor.None;
			subType = (PropertySub)value2.subType;
			property.PushSubValue(subType, pp, isNeedCal);
		}
		else
		{
			pp = null;
			propertId = 0u;
			subType = PropertySub.Base;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"property {tableId} not exist");
			}
		}
	}

	internal void PushProperties(Dictionary<PropertyItem, float> propertyCal, bool needCal, PropertySource from, int uid)
	{
		foreach (KeyValuePair<PropertyItem, float> item in propertyCal)
		{
			PropertyItem key = item.Key;
			ACT.Core.Property property = GetProperty(key.id);
			if (property != EmptyProperty.s_Default)
			{
				NumberPropertyProvider numberPropertyProvider = NumberPropertyProvider.s_Pool.Get();
				numberPropertyProvider.constValue = item.Value;
				numberPropertyProvider.from.source = from;
				numberPropertyProvider.from.uid = uid;
				numberPropertyProvider.propertyDescriptor = GetSystemPropertyDescriptor(from, uid);
				property.PushSubValue(key.cal switch
				{
					PropertyCalculate.SimpleAdd => PropertySub.Add, 
					PropertyCalculate.SimpleMulAdd => PropertySub.Add, 
					PropertyCalculate.SimpleMax => PropertySub.Max, 
					_ => PropertySub.Base, 
				}, numberPropertyProvider, needCal);
			}
		}
	}

	public void CalAllProperty()
	{
		foreach (ACT.Core.Property value in properties.Values)
		{
			value.Cal(needInvoke: true);
		}
	}

	public float GetScreenProperty(int name, Func<IPropertyProvider, bool> baseScreen, Func<IPropertyProvider, bool> addScreen, Func<IPropertyProvider, bool> mulScreen)
	{
		if (properties.TryGetValue((uint)name, out var value))
		{
			return value.CalculateProviderFilter(baseScreen, addScreen, mulScreen);
		}
		return 0f;
	}

	public float GetScreenMulProperty(int name, Func<IPropertyProvider, bool> mulScreen)
	{
		if (properties.TryGetValue((uint)name, out var value))
		{
			return value.CalculateBaseProvider(mulScreen);
		}
		return 0f;
	}

	public void RefreshRogueAbility()
	{
		RefreshBuildAbility();
		RefreshRogueItemAbility();
		RefreshTalentAbility();
	}

	public void ClearRogueAbility()
	{
	}

	public void RefreshBuildAbility()
	{
		int bdCore = Model<RogueNewModel>.Interface.GetBdCore();
		AddBuildCoreAbility(bdCore);
	}

	public void AddBuildCoreAbility(int coreId)
	{
		foreach (string item in EnumerateRogueCore(coreId))
		{
			AddAbility(owner, item, AbilitySource.RogueArtifact, default, 1);
		}
	}

	public void RemoveBuildCoreAbility(int coreId)
	{
		foreach (string item in EnumerateRogueCore(coreId))
		{
			RemoveAbility(item);
		}
	}

	public void AddBuildTreeAbility(int treeId, int level)
	{
	}

	public void RemoveBuildTreeAbility(int treeId, int level)
	{
	}

	public void RefreshRogueItemAbility()
	{
		foreach (KeyValuePair<int, List<RogueBagItemData>> item in Model<RogueNewModel>.Interface.GetCurrentRogueBag())
		{
			for (int i = 0; i < item.Value.Count; i++)
			{
				ACT.Game.Data.RogueItem rogueItem = item.Value[i].RogueItem;
				AddRogueElementAbility(rogueItem.ItemId);
				RogueElement data = CoreUtils.GetData(rogueItem.ItemId, RuntimeConfigs.data.rogueElements);
				if (data != null && data.elementType == 3)
				{
					AddRogueItemAbility(rogueItem.ItemId);
				}
			}
		}
	}

	public void AddRogueElementAbility(int itemId)
	{
		foreach (string item in EnumerateRogueItemElement(itemId))
		{
			AddAbility(owner, item, AbilitySource.RogueArtifact, default, 1);
		}
	}

	public void AddRogueItemAbility(int itemId)
	{
		foreach (string item in EnumerateRogueItemInscription(itemId, add: true))
		{
			AddAbility(owner, item, AbilitySource.RogueArtifact, default, 1);
		}
	}

	public void RemoveRogueElementAbility(int itemId)
	{
		foreach (string item in EnumerateRogueItemElement(itemId))
		{
			RemoveAbility(item);
		}
	}

	public void RemoveRogueItemAbility(int itemId)
	{
		foreach (string item in EnumerateRogueItemInscription(itemId, add: false))
		{
			RemoveAbility(item);
		}
	}

	public void RefreshTalentAbility()
	{
		MapField<int, RogueTalentTreeNode> nodes = Model<RogueNewModel>.Interface.Info.TalentTree.Nodes;
		if (nodes == null)
		{
			return;
		}
		foreach (KeyValuePair<int, RogueTalentTreeNode> item in nodes)
		{
			TalentNodeLevelData talentNodeLevelDataByLevel = Model<RogueNewModel>.Interface.GetTalentNodeLevelDataByLevel(item.Value.NodeId, item.Value.Level);
			if (talentNodeLevelDataByLevel != null)
			{
				int[] combatEffectIds = talentNodeLevelDataByLevel.combatEffectIds;
				foreach (int id in combatEffectIds)
				{
					string abName = CoreUtils.GetData(id, RuntimeConfigs.data.combatEffects)?.abilityName;
					int num = item.Value.Level;
					AddAbility(owner, abName, AbilitySource.RogueArtifact, new MPSkill
					{
						id = id,
						level = (byte)num
					}, 1);
				}
			}
		}
	}

	private IEnumerable<string> EnumerateRogueCore(int coreId)
	{
		BdCore data = CoreUtils.GetData(coreId, RuntimeConfigs.data.bdCores);
		if (data == null)
		{
			yield break;
		}
		int[] combatEffectIds = data.combatEffectIds;
		for (int i = 0; i < combatEffectIds.Length; i++)
		{
			string text = CoreUtils.GetData(combatEffectIds[i], RuntimeConfigs.data.combatEffects)?.abilityName;
			if (!string.IsNullOrEmpty(text))
			{
				yield return text;
			}
		}
	}

	private IEnumerable<string> EnumerateRogueItemElement(int itemId)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		if (data == null)
		{
			yield break;
		}
		int[] combatEffectIds = data.combatEffectIds;
		for (int i = 0; i < combatEffectIds.Length; i++)
		{
			string text = CoreUtils.GetData(combatEffectIds[i], RuntimeConfigs.data.combatEffects)?.abilityName;
			if (!string.IsNullOrEmpty(text))
			{
				yield return text;
			}
		}
	}

	private IEnumerable<string> EnumerateRogueItemInscription(int itemId, bool add)
	{
		ACT.Config.RogueItem data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueItems);
		if (data == null)
		{
			yield break;
		}
		int[] inscriptionIds = data.inscriptionIds;
		for (int i = 0; i < inscriptionIds.Length; i++)
		{
			Inscription data2 = CoreUtils.GetData(inscriptionIds[i], RuntimeConfigs.data.inscriptions);
			if (data2 == null)
			{
				continue;
			}
			int inscriptionLevel = Model<RogueNewModel>.Interface.GetInscriptionById(inscriptionIds[i]);
			int[] synergyIds = data2.synergyIds;
			for (int j = 0; j < synergyIds.Length; j++)
			{
				Synergy data3 = CoreUtils.GetData(synergyIds[j], RuntimeConfigs.data.synergys);
				if (data3 == null || (add && inscriptionLevel < data3.threshold) || (!add && inscriptionLevel >= data3.threshold))
				{
					continue;
				}
				int[] combatEffectIds = data3.combatEffectIds;
				for (int k = 0; k < combatEffectIds.Length; k++)
				{
					string text = CoreUtils.GetData(combatEffectIds[k], RuntimeConfigs.data.combatEffects)?.abilityName;
					if (!string.IsNullOrEmpty(text))
					{
						yield return text;
					}
				}
			}
		}
	}

	public void InitRogueDummyAbility()
	{
		Dictionary<int, SkillGroupData> skillGroupDatas = RuntimeConfigs.data.skillGroupDatas;
		int[] rogueSkillGroup = owner.GetConfig().rogueSkillGroup;
		if (rogueSkillGroup != null && rogueSkillGroup.Length != 0)
		{
			int[] array = rogueSkillGroup;
			foreach (int num in array)
			{
				byte skillGroupLevel = owner.GetCompCharacter().characterSource.GetSkillGroupLevel(num);
				if (skillGroupLevel == 0)
				{
					continue;
				}
				SkillGroupData data = CoreUtils.GetData(num, skillGroupDatas);
				if (data != null)
				{
					int[] skillTotalIds = data.skillTotalIds;
					foreach (int id in skillTotalIds)
					{
						MPSkill skillLevelInfo = new MPSkill
						{
							id = id,
							level = skillGroupLevel
						};
						Ability ability = Singleton<GameManager>.instance.ecsManager.systemAbility.abilityPool.Get();
						ability.Init(owner, owner, AbilitySource.UpgradeSkill, skillLevelInfo);
						dummyAbilities.Add(skillLevelInfo.id, ability);
					}
				}
			}
		}
		owner.GetCompAbility().AddAbilitiesByBindings(owner.GetConfig().abilitiyBindings);
	}

	public void ServerSetHP(int value)
	{
		value = Mathf.Clamp(value, 0, maxHP);
		if (m_HP != value)
		{
			onHPChange.Invoke(m_HP, value);
			onEntityHpChange.Invoke(m_HP, value, owner);
			DispatchHpChangeEvent(owner, m_HP, value, maxHP);
		}
		m_HP = value;
	}

	public void Sacrifice(int value, Ability ability)
	{
		if (alive)
		{
			int num = hp;
			SystemAbility abilitySystem = GameManager.abilitySystem;
			EvtBeforeSacrificeHp evt = abilitySystem.GetEvt<EvtBeforeSacrificeHp>(owner, ability);
			evt.mainEntity = owner;
			abilitySystem.FireEvt(evt);
			abilitySystem.ReleaseEvt(evt);
			int num2 = Mathf.Clamp(value, 0, hp);
			int num3 = Mathf.Max(1, hp - num2);
			ServerSetHP(num3);
			EvtSacrificeHp evt2 = abilitySystem.GetEvt<EvtSacrificeHp>(owner, ability);
			evt2.mainEntity = owner;
			evt2.before = num;
			evt2.after = num3;
			abilitySystem.FireEvt(evt2);
			abilitySystem.ReleaseEvt(evt2);
			if (owner.IsActive())
			{
				CompTransform compTransform = owner.GetCompTransform();
				SendDamageNumEvent(new CmdDamageNumber
				{
					damageFeature = DamageFeature.Sacrifice,
					damage = num2,
					pos = compTransform.physicsPosition,
					entityPos = compTransform.physicsPosition,
					entitySize = compTransform.size
				});
			}
		}
	}

	public void Recover(int recover, bool checkAlive)
	{
		if (!checkAlive || owner.IsAlive())
		{
			int max = maxHP - hp;
			recover = Mathf.Clamp(recover, 0, max);
			ServerSetHP(hp + recover);
			if (owner.IsActive())
			{
				CompTransform compTransform = owner.GetCompTransform();
				SendDamageNumEvent(new CmdDamageNumber
				{
					damageFeature = DamageFeature.Heal,
					damage = recover,
					pos = compTransform.physicsPosition,
					entityPos = compTransform.physicsPosition,
					entitySize = compTransform.size
				});
			}
		}
	}

	public void ServerSetHpChange(int value)
	{
		ServerSetHP(value + hp);
	}

	public void SetHPWithoutNotify(int value)
	{
		m_HP = value;
	}

	private void MaxHPChange(float from, float to, PropertyDescriptor descriptor)
	{
		if (to == from || float.IsNaN(from) || float.IsNaN(to))
		{
			return;
		}
		int hP = m_HP;
		if (hP <= 0)
		{
			return;
		}
		int oldMax = ToRuntimeMaxHp(from);
		int num = ToRuntimeMaxHp(to);
		if (descriptor.HasFlag(PropertyDescriptor.MaxHpChangeWithNoGrow))
		{
			if (hP > num)
			{
				ServerSetHP(num);
			}
		}
		else
		{
			int num2 = MapHpByOriginalPercent(hP, oldMax, num);
			if (num2 != hP)
			{
				ServerSetHP(num2);
			}
		}
		DispatchHpChangeEvent(owner, hP, m_HP, maxHP);
	}

	private static int ToRuntimeMaxHp(float raw)
	{
		if (float.IsNaN(raw) || float.IsNegativeInfinity(raw))
		{
			return 1;
		}
		if (float.IsPositiveInfinity(raw) || raw >= 2.1474836E+09f)
		{
			return int.MaxValue;
		}
		int num = Mathf.CeilToInt(raw);
		if (num < 1)
		{
			num = 1;
		}
		return num;
	}

	private static int MapHpByOriginalPercent(int currentHp, int oldMax, int newMax)
	{
		if (newMax < 1)
		{
			return 1;
		}
		if (oldMax < 1 || currentHp >= oldMax)
		{
			return newMax;
		}
		int num = (int)(((long)currentHp * (long)newMax + (long)oldMax / 2L) / oldMax);
		if (num < 1)
		{
			return 1;
		}
		if (num > newMax)
		{
			return newMax;
		}
		return num;
	}

	private void DispatchHpChangeEvent(Entity entityBehave, int preHp, int curHp, int maxHp)
	{
		CompCharacter compCharacter = entityBehave.GetCompCharacter();
		if (compCharacter != null)
		{
			CharacterHpChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterHpChangeEvt>();
			evt.characterId = compCharacter.characterSource.Id();
			evt.preHp = preHp;
			evt.curHp = curHp;
			evt.maxHp = maxHp;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Character_HpChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			SystemAbility abilitySystem = GameManager.abilitySystem;
			EvtHpChanged evt2 = abilitySystem.GetEvt<EvtHpChanged>(entityBehave, null);
			evt2.mainEntity = entityBehave;
			evt2.preHp = preHp;
			evt2.curHp = curHp;
			evt2.maxHp = maxHp;
			abilitySystem.FireEvt(evt2);
			abilitySystem.ReleaseEvt(evt2);
			if (preHp > curHp)
			{
				HpLower hpLower = new HpLower();
				hpLower.id = compCharacter.characterSource.Id();
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Character_HpLower, hpLower);
				Singleton<EventManager>.instance.ReleaseEvt(hpLower);
			}
		}
	}

	public void ServerSetShield(int value)
	{
		value = Mathf.Clamp(value, 0, maxShield);
		if (m_Shield != value)
		{
			onShieldChange.Invoke(m_Shield, value);
			onEntityShieldChange.Invoke(m_Shield, value, owner);
		}
		DispatchShieldChangeEvent(owner, m_Shield, value, maxShield);
		m_Shield = value;
	}

	private void MaxShieldChange(float from, float to, PropertyDescriptor descriptor)
	{
		if (to > from)
		{
			int num = Mathf.CeilToInt(to - from);
			onShieldChange.Invoke(m_Shield, m_Shield + num);
			onEntityShieldChange.Invoke(m_Shield, m_Shield + num, owner);
			m_Shield += num;
		}
		ServerSetShield(m_Shield);
	}

	private void PCritMulChange(float from, float to, PropertyDescriptor descriptor)
	{
		if (!Mathf.Approximately(from, to))
		{
			RecalculateCriticalConversionChance();
		}
	}

	private void PCritConversionChange(float from, float to, PropertyDescriptor descriptor)
	{
		if (!Mathf.Approximately(from, to))
		{
			RecalculateCriticalConversionChance();
		}
	}

	private void RecalculateCriticalConversionChance()
	{
		if (owner.TryGetCompCharacter(out CompCharacter component) && component.characterSource is Character character)
		{
			float value = GetProperty(57u).value;
			float value2 = GetProperty(4u).value;
			if (CharacterModel.TryCalculateCriticalConversionChance(character, value, value2, out var value3))
			{
				Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
				dictionary[300] = value3;
				ReplaceProperties(dictionary, PropertySource.System, 8, isNeedCal: true);
				DictionaryPool<int, float>.Release(dictionary);
			}
		}
	}

	private void DispatchShieldChangeEvent(Entity entityBehave, int preShield, int curShield, int maxShield)
	{
		CompCharacter compCharacter = entityBehave.GetCompCharacter();
		if (compCharacter != null)
		{
			CharacterShieldChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterShieldChangeEvt>();
			evt.characterId = compCharacter.characterSource.Id();
			evt.preShield = preShield;
			evt.curShield = curShield;
			evt.maxShield = maxShield;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Character_ShieldChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			if (preShield > curShield)
			{
				HpLower hpLower = new HpLower();
				hpLower.id = compCharacter.characterSource.Id();
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Character_ShieldLower, hpLower);
				Singleton<EventManager>.instance.ReleaseEvt(hpLower);
			}
		}
	}

	public void SetMoveSpeedNotify(float value)
	{
		m_MoveSpeed = value;
	}

	public ElementBitmask GetElementBit()
	{
		return element switch
		{
			Element.Born => ElementBitmask.Born, 
			Element.Disturb => ElementBitmask.Disturb, 
			Element.Ash => ElementBitmask.Ash, 
			Element.Operate => ElementBitmask.Operate, 
			Element.Promote => ElementBitmask.Promote, 
			Element.Dark => ElementBitmask.Dark, 
			_ => ElementBitmask.Born, 
		};
	}

	public float GetElementDamage(Element e)
	{
		return GetProperty((uint)(e + 19)).value;
	}

	public float GetElementResist(Element e)
	{
		return GetProperty((uint)(e + 29)).value;
	}

	public float GetRealDamage(Element e)
	{
		return GetProperty((uint)(e + 49)).value;
	}

	public float GetMannerTypeDamageIncrease(MannerType mType)
	{
		if (mType == MannerType.None)
		{
			return 0f;
		}
		return GetProperty((uint)(mType + 55)).value;
	}

	public float GetCharacterDamageTypeDamageIncrease(CharacterDamageType characterDamageType)
	{
		float result = 0f;
		switch (characterDamageType)
		{
		case CharacterDamageType.Striker:
			result = GetProperty(70u).value;
			break;
		case CharacterDamageType.Breaker:
			result = GetProperty(69u).value;
			break;
		}
		return result;
	}

	private void CalEndure()
	{
		if (properties.ContainsKey(15u))
		{
			m_EndureLevel = Mathf.Max(m_MotionEndureLevel, m_MotionEndureLevel + Mathf.RoundToInt(GetProperty(15u).value));
		}
	}

	private void OnEndureChange(float before, float after, PropertyDescriptor descriptor)
	{
		m_EndureLevel = Mathf.Max(m_MotionEndureLevel, m_MotionEndureLevel + Mathf.RoundToInt(after));
	}

	private static void SendDamageNumEvent(CmdDamageNumber cmd)
	{
		DamageNumberSpawnEvt evt = Singleton<EventManager>.instance.GetEvt<DamageNumberSpawnEvt>();
		evt.cmdDamageNumber = cmd;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.DamageNumberSpawn, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnSkillCooldownReductionChange(float pre, float now, PropertyDescriptor propertyDescriptor)
	{
		CompMotion compMotion = owner.GetCompMotion();
		if (compMotion == null)
		{
			return;
		}
		foreach (Skill skill in compMotion.skills)
		{
			if (skill.AffectByCDR)
			{
				skill.SetMaxCd((1f - now) * skill.ConfigCd);
			}
		}
	}

	public void OnDestinyActive(int destinyId, Character character)
	{
		if (!RuntimeConfigs.data.characterConstellationDatas.TryGetValue(destinyId, out var value) || value.unlockSkill == 0)
		{
			return;
		}
		string[] constellationSkillName = value.constellationSkillName;
		for (int i = 0; i < constellationSkillName.Length; i++)
		{
			if (!int.TryParse(constellationSkillName[i], out var result))
			{
				continue;
			}
			SkillGroupData data = CoreUtils.GetData(result, RuntimeConfigs.data.skillGroupDatas);
			if (data != null)
			{
				int[] skillTotalIds = data.skillTotalIds;
				foreach (int id in skillTotalIds)
				{
					string abilityName = CoreUtils.GetData(id, RuntimeConfigs.data.skillDetailDatas).abilityName;
					MPSkill skillLevelInfo = new MPSkill
					{
						id = id,
						level = 1
					};
					AddAbility(owner, abilityName, AbilitySource.Constellation, skillLevelInfo, 1);
				}
			}
		}
	}

	public void OnDestinyDeActive(int destinyId, Character character)
	{
		if (!RuntimeConfigs.data.characterConstellationDatas.TryGetValue(destinyId, out var value) || value.unlockSkill == 0)
		{
			return;
		}
		string[] constellationSkillName = value.constellationSkillName;
		for (int i = 0; i < constellationSkillName.Length; i++)
		{
			if (int.TryParse(constellationSkillName[i], out var result))
			{
				string abilityName = CoreUtils.GetData(result * 10 + 1, RuntimeConfigs.data.skillDetailDatas).abilityName;
				RemoveAbility(abilityName);
			}
		}
	}

	public void OnElitePointLevelReset()
	{
		int[] array = CoreUtils.GetData(owner.GetCompCharacter().characterSource.Id(), RuntimeConfigs.data.eliteTrainingMaps)?.characterSkill;
		for (int i = 0; i < array.Length; i++)
		{
			SkillDetailData data = CoreUtils.GetData(CoreUtils.GetData(array[i], RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas);
			RemoveAbility(data.abilityName);
		}
	}

	public Guid ApplyMaterialEffect(Material overrideMaterial, int priority)
	{
		AbilityMaterial materialItem = Singleton<GameManager>.instance.ecsManager.systemAbility.GetMaterialItem();
		materialItem.Init(owner, priority, overrideMaterial);
		return _materialChannel.Add(materialItem);
	}

	public bool RemoveMaterialEffect(Guid handle)
	{
		return _materialChannel.Remove(handle);
	}

	public Guid ApplyEffect(EffectRuntimeItem effect, int priority)
	{
		effect.SetPriority(priority);
		return _effectChannel.Add(effect);
	}

	public bool RemoveEffect(EffectRuntimeItem effect)
	{
		return _effectChannel.Remove(effect.Id);
	}

	private void ClearVisualChannels()
	{
		_materialChannel.ClearAll();
		_effectChannel.ClearAll();
	}

	public void Init(ITableKey tableKey)
	{
		propertiesKey = tableKey;
		foreach (PropertyItem property2 in EngineConfigs.configProperty.properties)
		{
			GetOrCreateProperty(property2);
		}
		tableKey.InitProperties(this);
		tableKey.InitDummyAbilities(this);
		ACT.Core.Property property = GetProperty(1u);
		property.onValueChange += new Action<float, float, PropertyDescriptor>(MaxHPChange);
		GetProperty(205u).onValueChange += new Action<float, float, PropertyDescriptor>(MaxShieldChange);
		GetProperty(4u).onValueChange += new Action<float, float, PropertyDescriptor>(PCritMulChange);
		GetProperty(57u).onValueChange += new Action<float, float, PropertyDescriptor>(PCritConversionChange);
		if (owner.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			int hpSync = RuntimeConfigs.data.game.hpSync;
			int num = ((Character)component.characterSource).Status.Hp;
			float f = property.value / (float)hpSync * (float)num;
			SetHPWithoutNotify(Mathf.CeilToInt(f));
		}
		else
		{
			SetHPWithoutNotify(Mathf.CeilToInt(property.value));
		}
		alive = m_HP > 0;
		if (owner.IsCharacter())
		{
			GetProperty(15u).onValueChange += new Action<float, float, PropertyDescriptor>(OnEndureChange);
		}
		if (owner.IsBattleBehaveNotCharacter())
		{
			GetProperty(41u).onValueChange += new Action<float, float, PropertyDescriptor>(MaxPostureChange);
		}
		GetProperty(206u).onValueChange += new Action<float, float, PropertyDescriptor>(OnSkillCooldownReductionChange);
	}
}
