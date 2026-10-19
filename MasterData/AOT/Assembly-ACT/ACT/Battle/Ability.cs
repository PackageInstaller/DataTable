using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class Ability
{
	public AbilitySource source;

	public MPSkill skillLevelInfo;

	public ConfigAbility config;

	public AbilityConst abilityConst;

	private AbilityConst m_AbilityConstCache;

	public Entity caster;

	public Entity owner;

	public BaseAbilityMixin[] mixins;

	private static BaseAbilityMixin[] s_Empty = new BaseAbilityMixin[0];

	public int maxStack;

	private AbilityDuration _duration;

	private AbilityDuration m_DurationCache;

	public bool casterDieRemove;

	public List<EffectRuntimeItem> attachEffects = new List<EffectRuntimeItem>();

	public List<EffectRuntimeItem> playEffects = new List<EffectRuntimeItem>();

	public Dictionary<YooAssetReference, InstanceHandle> abilityVolumeAssetID = new Dictionary<YooAssetReference, InstanceHandle>();

	public ActionTriggerAbility actionTriggerAbility;

	private AbilityBlackboard m_BlackboardCache;

	private readonly List<LayeredNumberPropertyProvider> layered = new List<LayeredNumberPropertyProvider>(4);

	public long addTimeStamp;

	public float cooldownTimestamp;

	public int rogueTrigger = -1;

	public Entity originalOwner { get; private set; }

	public int stack { get; protected set; }

	public AbilityDuration Duration => _duration;

	public AbilityBlackboard Blackboard { get; private set; }

	public bool needSync { get; protected set; }

	public float time { get; protected set; }

	public bool CanRemoveInDie
	{
		get
		{
			AbilitySource abilitySource = AbilitySource.Passive | AbilitySource.UpgradeSkill | AbilitySource.Weapon | AbilitySource.Chip | AbilitySource.System | AbilitySource.RogueCard | AbilitySource.RogueArtifact | AbilitySource.RogueTrigger | AbilitySource.Equip | AbilitySource.Constellation;
			bool flag = false;
			bool flag2 = false;
			if (config != null)
			{
				flag = (config.buffTag & BuffTag.CantClearOnDie) != 0;
				flag2 = (config.buffTag & BuffTag.ForceClearOnDie) != 0;
			}
			if (!flag2)
			{
				if ((source & abilitySource) == 0)
				{
					return !flag;
				}
				return false;
			}
			return true;
		}
	}

	public float timePast
	{
		get
		{
			TimeScale timeScale = config.timeScale;
			if (timeScale != TimeScale.Owner && timeScale == TimeScale.NoScale)
			{
				return Time.fixedDeltaTime * owner.GetCompTime().logicScale;
			}
			return owner.GetCompTime().abilityFixedDeltaTime;
		}
	}

	public Ability()
	{
		stack = 1;
	}

	public void Init(Entity caster, Entity owner, AbilitySource source, MPSkill skillLevelInfo)
	{
		this.caster = caster;
		this.owner = owner;
		originalOwner = owner;
		this.source = source;
		this.skillLevelInfo = skillLevelInfo;
		abilityConst = null;
		addTimeStamp = TimeManager.LocalTime.NowTimestamp;
	}

	public void Init(Entity caster, Entity owner, ConfigAbility config, AbilitySource source, MPSkill skillLevelInfo, int stack, int nextRogueTrigger = -1)
	{
		this.caster = caster;
		this.owner = owner;
		originalOwner = owner;
		this.config = config;
		this.source = source;
		this.skillLevelInfo = skillLevelInfo;
		InitAbilityConst();
		addTimeStamp = TimeManager.LocalTime.NowTimestamp;
		maxStack = Mathf.Max(1, (int)config.iMaxStack.GetFloat(this));
		stack = Mathf.Clamp(stack, 1, maxStack);
		float initialDuration = ApplyControlResistance(config.fDuration.GetFloat(this));
		if (m_DurationCache == null)
		{
			m_DurationCache = new AbilityDuration();
		}
		m_DurationCache.Initialize(config.name, owner.TryGetCompCharacter(out CompCharacter component) ? component.characterSource.Id() : (-1), maxStack, stack, initialDuration, owner);
		_duration = m_DurationCache;
		CompBehave compBehave = this.caster.GetCompBehave();
		CompBehave compBehave2 = this.owner.GetCompBehave();
		this.stack = stack;
		if (compBehave.rogueTrigger != -1)
		{
			nextRogueTrigger = compBehave.rogueTrigger;
		}
		if (compBehave2.rogueTrigger != -1)
		{
			nextRogueTrigger = compBehave2.rogueTrigger;
		}
		if (nextRogueTrigger != -1)
		{
			rogueTrigger = nextRogueTrigger;
		}
		InitializeBlackboard();
		mixins = null;
	}

	internal void Init(ConfigAbility config, MPAbility mpab)
	{
		caster = mpab.caster;
		owner = GameManager.entities.GetEntity(mpab.owner);
		originalOwner = owner;
		this.config = config;
		InitAbilityConst();
		source = AbilitySource.NetSync;
		skillLevelInfo = mpab.skillLevel;
		stack = mpab.stack;
		InitializeBlackboard();
		needSync = false;
	}

	internal void Reset()
	{
		needSync = false;
		skillLevelInfo.Reset();
		config = null;
		abilityConst = null;
		m_AbilityConstCache?.Clear();
		stack = 1;
		if (mixins != null)
		{
			AbilityMixinPoolManager abilityMixinPoolManager = GameManager.abilitySystem?.mixinPoolManager;
			BaseAbilityMixin[] array = mixins;
			foreach (BaseAbilityMixin mixin in array)
			{
				abilityMixinPoolManager?.RequestReturn(mixin);
			}
		}
		mixins = null;
		_duration = null;
		m_DurationCache?.Reset();
		foreach (EffectRuntimeItem attachEffect in attachEffects)
		{
			attachEffect.SetToBeRemove();
			if (owner.IsValid)
			{
				owner.GetCompAbility()?.RemoveEffect(attachEffect);
			}
		}
		GameManager.effectSystem?.StopAbilityEffects(playEffects);
		owner = default;
		originalOwner = default;
		caster = default;
		foreach (EffectRuntimeItem attachEffect2 in attachEffects)
		{
			if (attachEffect2.attachAbility == this)
			{
				attachEffect2.attachAbility = null;
			}
		}
		attachEffects.Clear();
		playEffects.Clear();
		abilityVolumeAssetID.Clear();
		actionTriggerAbility = null;
		m_BlackboardCache?.Reset();
		Blackboard = null;
		casterDieRemove = false;
		cooldownTimestamp = 0f;
		time = 0f;
		rogueTrigger = -1;
	}

	public void OnAdd()
	{
		TrackAbilityEvt evt = EventTrackSolver.Instance.GetEvt<TrackAbilityEvt>();
		evt.ability = this;
		evt.owner = owner;
		EventTrackSolver.Instance.Dispatch(evt);
		SubscribeCasterDie();
		BaseAbilityMixin[] array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnAdd();
		}
		AddProperty();
		CompAbility compAbility = owner.GetCompAbility();
		if (config.skillModifiers != null)
		{
			compAbility.AddSkillModifier(config.skillModifiers, this);
		}
		AbilityAddEvt evt2 = Singleton<EventManager>.instance.GetEvt<AbilityAddEvt>();
		evt2.eb = owner;
		evt2.abilityName = config.name;
		evt2.curStack = stack;
		evt2.maxStack = maxStack;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Ability_Add, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	public void OnPropertAbilityAdd()
	{
		SubscribeCasterDie();
		InitMixins();
		BaseAbilityMixin[] array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnAdd();
		}
	}

	private void SubscribeCasterDie()
	{
		if (config.onCasterDieRemove && caster.IsValid)
		{
			CompAbility? compAbility = caster.GetCompAbility();
			compAbility.onDie += new Action<Entity>(OnCasterDie);
			compAbility.onRelase += new Action<Entity>(OnCasterRelease);
		}
	}

	internal void InitMixins()
	{
		if (config.mixins != null)
		{
			mixins = new BaseAbilityMixin[config.mixins.Length];
			AbilityMixinPoolManager abilityMixinPoolManager = GameManager.abilitySystem?.mixinPoolManager;
			for (byte b = 0; b < config.mixins.Length; b++)
			{
				BaseAbilityMixin baseAbilityMixin = abilityMixinPoolManager?.Rent(config.mixins[b], this, b) ?? config.mixins[b].CreateInst(this, b);
				mixins[b] = baseAbilityMixin;
			}
		}
		else
		{
			mixins = s_Empty;
		}
	}

	private void InitializeBlackboard()
	{
		if (m_BlackboardCache == null)
		{
			m_BlackboardCache = new AbilityBlackboard();
		}
		m_BlackboardCache.Initialize(config?.blackboardVariables);
		Blackboard = m_BlackboardCache;
	}

	public AbilityBlackboard GetOrCreateBlackboard()
	{
		if (Blackboard == null)
		{
			if (m_BlackboardCache == null)
			{
				m_BlackboardCache = new AbilityBlackboard();
			}
			Blackboard = m_BlackboardCache;
		}
		return Blackboard;
	}

	public void AddProperty(int value = 0)
	{
		if (config.properties == null)
		{
			return;
		}
		if (layered.Count > 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[Ability] AddProperty called with stale layered for " + config.name + ", cleaning up first");
			}
			RemoveProperty();
		}
		CompAbility compAbility = owner.GetCompAbility();
		for (int i = 0; i < config.properties.Length; i++)
		{
			ABProperty aBProperty = config.properties[i];
			LayeredNumberPropertyProvider layeredNumberPropertyProvider = LayeredNumberPropertyProvider.s_Pool.Get();
			layeredNumberPropertyProvider.propertyDescriptor = aBProperty.propertyDescriptor;
			Entity entity = (aBProperty.isCaster ? caster : owner);
			float num = 0f;
			Property property = entity.GetCompAbility().GetProperty(aBProperty.value.property);
			if (property != null)
			{
				GetCoefficientType coefficientType = aBProperty.value.coefficientType;
				num = aBProperty.value.coefficientType switch
				{
					GetCoefficientType.Mul => (aBProperty.value.property == 0) ? 0f : (property.GetPropertyCoefficient(coefficientType) - 1f), 
					_ => property.GetPropertyCoefficient(coefficientType), 
				};
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("属性来源取值为0，无意义！检查" + config.name + "的属性来源是否为空");
			}
			float num2 = aBProperty.value.mulKey.GetFloat(this);
			float num3 = (aBProperty.additivity ? aBProperty.value.constKey.GetFloatDifValue(this, value) : aBProperty.value.constKey.GetFloat(this));
			layeredNumberPropertyProvider.constValue = num * num2 + num3;
			layeredNumberPropertyProvider.layer = stack;
			compAbility.GetProperty(aBProperty.property).PushSubValue(aBProperty.sub, layeredNumberPropertyProvider, needCal: true);
			layered.Add(layeredNumberPropertyProvider);
		}
	}

	private void RefreshProperty()
	{
		if (config.properties == null || layered.Count == 0)
		{
			return;
		}
		for (int i = 0; i < layered.Count; i++)
		{
			LayeredNumberPropertyProvider layeredNumberPropertyProvider = layered[i];
			if (layeredNumberPropertyProvider != null)
			{
				ABProperty aBProperty = config.properties[i];
				Entity entity = (aBProperty.isCaster ? caster : owner);
				float num = 0f;
				Property property = entity.GetCompAbility().GetProperty(aBProperty.value.property);
				if (property != null)
				{
					GetCoefficientType coefficientType = aBProperty.value.coefficientType;
					num = coefficientType switch
					{
						GetCoefficientType.Mul => (aBProperty.value.property == 0) ? 0f : (property.GetPropertyCoefficient(coefficientType) - 1f), 
						_ => property.GetPropertyCoefficient(coefficientType), 
					};
				}
				float num2 = aBProperty.value.mulKey.GetFloat(this);
				float num3 = (aBProperty.additivity ? aBProperty.value.constKey.GetFloatDifValue(this) : aBProperty.value.constKey.GetFloat(this));
				layeredNumberPropertyProvider.SetConstValue(num * num2 + num3);
			}
		}
	}

	public void OnAddStack(int add)
	{
		if (mixins != null)
		{
			BaseAbilityMixin[] array = mixins;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].OnAddStack(add);
			}
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtAbilityStackChange evt = systemAbility.GetEvt<EvtAbilityStackChange>(owner, this);
		evt.change = add;
		SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), evt, this, config.OnAddStack);
		systemAbility.ReleaseEvt(evt);
		DispatchStackChangeEvt();
	}

	public void OnRemoveStack(int remove)
	{
		if (mixins != null)
		{
			BaseAbilityMixin[] array = mixins;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].OnRemoveStack(remove);
			}
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtAbilityStackChange evt = systemAbility.GetEvt<EvtAbilityStackChange>(owner, this);
		evt.change = -remove;
		SystemAbility.DoActions(owner.GetCaster(), owner, FindTargetResult.EntityOnly(owner), evt, this, config.OnRemoveStack);
		systemAbility.ReleaseEvt(evt);
		DispatchStackChangeEvt();
	}

	private void DispatchStackChangeEvt()
	{
		AbilityStackChangeEvt evt = Singleton<EventManager>.instance.GetEvt<AbilityStackChangeEvt>();
		evt.eb = owner;
		evt.abilityName = config.name;
		evt.curStack = stack;
		evt.maxStack = maxStack;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Ability_StackChange, evt);
	}

	public void OnInit(EvtAddAbilityAdd evt)
	{
		SystemAbility.DoActions(owner.GetCaster(), owner, FindTargetResult.EntityOnly(owner), evt, this, config.OnInit);
	}

	public void OnRemove()
	{
		if (mixins != null)
		{
			BaseAbilityMixin[] array = mixins;
			foreach (BaseAbilityMixin baseAbilityMixin in array)
			{
				if (baseAbilityMixin == null)
				{
					continue;
				}
				try
				{
					baseAbilityMixin.isActive = false;
					baseAbilityMixin.OnRemove();
				}
				catch (Exception exception)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("Ability.OnRemove Mixin 清理失败: " + (config?.name ?? "<null>") + ", " + baseAbilityMixin.GetType().Name);
						Debug.LogException(exception);
					}
				}
				finally
				{
					GameManager.abilitySystem?.mixinPoolManager?.RequestReturn(baseAbilityMixin);
				}
			}
			mixins = null;
		}
		if (config == null)
		{
			return;
		}
		foreach (KeyValuePair<YooAssetReference, InstanceHandle> item in abilityVolumeAssetID)
		{
			PrecacheManager.Instance?.ReleaseInstanceHandle(item.Value);
		}
		abilityVolumeAssetID.Clear();
		RemoveProperty();
		CompAbility compAbility = (owner.IsValid ? owner.GetCompAbility() : null);
		if (config.skillModifiers != null)
		{
			compAbility?.RemoveSkillModifier(config.skillModifiers, this);
		}
		foreach (EffectRuntimeItem attachEffect in attachEffects)
		{
			compAbility?.RemoveEffect(attachEffect);
		}
		GameManager.effectSystem?.StopAbilityEffects(playEffects);
		if (config.onCasterDieRemove && caster.IsValid)
		{
			CompAbility compAbility2 = caster.GetCompAbility();
			if (compAbility2 != null)
			{
				compAbility2.onDie -= new Action<Entity>(OnCasterDie);
				compAbility2.onRelase -= new Action<Entity>(OnCasterRelease);
			}
		}
		if (Singleton<EventManager>.instance != null)
		{
			DispatchAbilityRemoveEvt();
		}
	}

	public void RemoveProperty()
	{
		if (!owner.IsValid || config == null || config.properties == null || layered.Count <= 0)
		{
			return;
		}
		CompAbility compAbility = owner.GetCompAbility();
		for (int i = 0; i < layered.Count; i++)
		{
			LayeredNumberPropertyProvider layeredNumberPropertyProvider = layered[i];
			if (layeredNumberPropertyProvider != null)
			{
				ABProperty aBProperty = config.properties[i];
				compAbility.GetProperty(aBProperty.property).PopSubValue(aBProperty.sub, layeredNumberPropertyProvider, needCal: true);
			}
		}
		layered.Clear();
	}

	internal void OnSilentRemove(CompAbility comp)
	{
		if (mixins != null)
		{
			BaseAbilityMixin[] array = mixins;
			foreach (BaseAbilityMixin obj in array)
			{
				obj.isActive = false;
				obj.OnSilentRemove();
			}
		}
		RemoveProperty();
		if (config != null && config.onCasterDieRemove && caster.IsValid)
		{
			CompAbility? compAbility = caster.GetCompAbility();
			compAbility.onDie -= new Action<Entity>(OnCasterDie);
			compAbility.onRelase -= new Action<Entity>(OnCasterRelease);
		}
	}

	private void DispatchAbilityRemoveEvt()
	{
		AbilityRemoveEvt evt = Singleton<EventManager>.instance.GetEvt<AbilityRemoveEvt>();
		evt.characterId = (originalOwner.TryGetCompCharacter(out CompCharacter component) ? component.characterSource.Id() : 0);
		evt.abilityName = config.name;
		evt.curOwner = owner;
		evt.originalOwner = originalOwner;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Ability_Remove, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	internal void OnInheritAbility(Entity target)
	{
		Entity oldOwner = owner;
		BaseAbilityMixin[] array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnInheritRemove();
		}
		foreach (KeyValuePair<YooAssetReference, InstanceHandle> item in abilityVolumeAssetID)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(item.Value);
		}
		abilityVolumeAssetID.Clear();
		RemoveProperty();
		if (config.skillModifiers != null)
		{
			owner.GetCompAbility().RemoveSkillModifier(config.skillModifiers, this);
		}
		if (config.onCasterDieRemove && caster.IsValid)
		{
			CompAbility? compAbility = caster.GetCompAbility();
			compAbility.onDie -= new Action<Entity>(OnCasterDie);
			compAbility.onRelase -= new Action<Entity>(OnCasterRelease);
			compAbility.onDie += new Action<Entity>(OnCasterDie);
			compAbility.onRelase += new Action<Entity>(OnCasterRelease);
		}
		owner = target;
		AddProperty();
		array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnInheritAdd();
		}
		CompAbility compAbility2 = owner.GetCompAbility();
		if (config.skillModifiers != null)
		{
			compAbility2.AddSkillModifier(config.skillModifiers, this);
		}
		if (config.inheritAttachedEffect)
		{
			GameManager.effectSystem?.RebindAttachedEffects(attachEffects, oldOwner, target);
		}
	}

	private void OnCasterDie(Entity caster)
	{
		if (config != null && owner.IsValid && !casterDieRemove)
		{
			casterDieRemove = true;
			RemoveStack(stack);
		}
	}

	private void OnCasterRelease(Entity caster)
	{
		if (config != null && owner.IsValid && !casterDieRemove)
		{
			casterDieRemove = true;
			SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, this, config.OnRemove);
			RemoveStack(stack);
		}
	}

	public void RefreshData(Entity caster)
	{
		if (config.onCasterDieRemove && this.caster != caster)
		{
			CompAbility? compAbility = this.caster.GetCompAbility();
			compAbility.onDie -= new Action<Entity>(OnCasterDie);
			compAbility.onRelase -= new Action<Entity>(OnCasterRelease);
			compAbility.onDie += new Action<Entity>(OnCasterDie);
			compAbility.onRelase += new Action<Entity>(OnCasterRelease);
		}
		this.caster = caster;
	}

	private float ApplyControlResistance(float baseDuration)
	{
		if (config.buffType == BuffType.ControlBuff)
		{
			float value = owner.GetCompAbility().GetProperty(204u).value;
			return baseDuration * (1f - value);
		}
		return baseDuration;
	}

	public void Merge(int mergeStack)
	{
		int num = Mathf.Min(maxStack - stack, mergeStack);
		if (config.durationType == DurationType.Infinite)
		{
			if (num > 0)
			{
				stack += num;
				OnStackChange(num);
			}
			return;
		}
		if (num > 0)
		{
			bool flag = config.durationMergeType == DurationMergeType.Independent || config.durationMergeType == DurationMergeType.Maximum;
			for (int i = 0; i < num; i++)
			{
				float newVal = (flag ? ApplyControlResistance(config.fDuration.GetFloat(this)) : _duration.GetVal(stack + i - 1));
				_duration.SetVal(stack + i, newVal);
			}
			stack += num;
			OnStackChange(num);
		}
		switch (config.durationMergeType)
		{
		case DurationMergeType.Refresh:
		{
			float newVal2 = ApplyControlResistance(config.fDuration.GetFloat(this));
			for (int k = 0; k < stack; k++)
			{
				_duration.SetVal(k, newVal2);
			}
			break;
		}
		case DurationMergeType.Prolong:
			if (!config.prolongByStack || num > 0)
			{
				int num3 = ((!config.prolongByStack || num <= 0) ? 1 : num);
				float num4 = ApplyControlResistance(config.fProlongDuration.GetFloat(this));
				for (int l = 0; l < stack; l++)
				{
					_duration.SetVal(l, _duration.GetVal(l) + num4 * (float)num3);
				}
			}
			break;
		case DurationMergeType.Maximum:
		{
			float num2 = ApplyControlResistance(config.fDuration.GetFloat(this));
			for (int j = 0; j < stack; j++)
			{
				if (num2 > _duration.GetVal(j))
				{
					_duration.SetVal(j, num2);
				}
			}
			break;
		}
		case DurationMergeType.Independent:
			break;
		}
	}

	private void OnStackChange(int change)
	{
		if (layered.Count > 0 && stack > 0)
		{
			foreach (LayeredNumberPropertyProvider item in layered)
			{
				item?.SetLayer(stack);
			}
		}
		if (change > 0)
		{
			OnAddStack(change);
		}
		else
		{
			OnRemoveStack(-change);
		}
	}

	public void FixedUpdate()
	{
		float num = timePast;
		time += num;
		BaseAbilityMixin[] array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].FixedUpdate();
		}
		if (config.durationType != DurationType.Infinite)
		{
			for (int j = 0; j < stack; j++)
			{
				if (config.stackDurationType != StackDurationType.TopStackTick || j >= stack - 1)
				{
					_duration.SetVal(j, _duration.GetVal(j) - num);
				}
			}
			if (source != AbilitySource.NetSync)
			{
				for (int num2 = stack - 1; num2 >= 0; num2--)
				{
					if (_duration.GetVal(num2) <= 0f)
					{
						if (config.stackDurationType == StackDurationType.TopStackTick)
						{
							RemoveTopStack();
						}
						else
						{
							RemoveStack(num2 + 1);
						}
						break;
					}
				}
			}
		}
		if (config.properties == null)
		{
			return;
		}
		for (int k = 0; k < config.properties.Length; k++)
		{
			if (config.properties[k].isChanged)
			{
				RefreshProperty();
				break;
			}
		}
	}

	public void LateUpdate()
	{
		BaseAbilityMixin[] array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].LateUpdate();
		}
	}

	public void Update()
	{
		BaseAbilityMixin[] array = mixins;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].Update();
		}
	}

	public void RemoveStackImpl(int remove)
	{
		remove = Mathf.Min(remove, stack);
		for (int i = remove; i < stack; i++)
		{
			_duration.SetVal(i - remove, _duration.GetVal(i));
		}
		stack -= remove;
		OnStackChange(-remove);
	}

	public void RemoveStack(int remove)
	{
		RemoveStackImpl(remove);
	}

	public void RemoveTopStackImpl()
	{
		stack--;
		OnStackChange(-1);
	}

	public void RemoveTopStack()
	{
		RemoveTopStackImpl();
	}

	private void InitAbilityConst()
	{
		if (config?.abilityConst == null || config.abilityConst.Count == 0)
		{
			m_AbilityConstCache?.Clear();
			abilityConst = null;
			return;
		}
		if (m_AbilityConstCache == null)
		{
			m_AbilityConstCache = new AbilityConst();
		}
		m_AbilityConstCache.Clear();
		abilityConst = m_AbilityConstCache;
		foreach (KeyValuePair<string, float> item in config.abilityConst)
		{
			abilityConst[item.Key] = item.Value;
		}
	}

	public bool TryGetAbilityConst(string key, out float value)
	{
		if (string.IsNullOrEmpty(key) || abilityConst == null)
		{
			value = 0f;
			return false;
		}
		return abilityConst.TryGetValue(key, out value);
	}

	public void SetAbilityConst(string key, float value)
	{
		if (string.IsNullOrEmpty(key))
		{
			return;
		}
		if (abilityConst == null)
		{
			if (m_AbilityConstCache == null)
			{
				m_AbilityConstCache = new AbilityConst();
			}
			abilityConst = m_AbilityConstCache;
		}
		abilityConst[key] = value;
	}

	public float AddAbilityConst(string key, float delta)
	{
		if (string.IsNullOrEmpty(key))
		{
			return 0f;
		}
		if (abilityConst == null)
		{
			if (m_AbilityConstCache == null)
			{
				m_AbilityConstCache = new AbilityConst();
			}
			abilityConst = m_AbilityConstCache;
		}
		abilityConst.TryGetValue(key, out var value);
		value += delta;
		abilityConst[key] = value;
		return value;
	}

	public override string ToString()
	{
		return ((config == null) ? "<no config>" : config.name) ?? "";
	}
}
