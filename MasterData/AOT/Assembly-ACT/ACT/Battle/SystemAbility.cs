using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Collections;
using Bamboo.ECS;
using Bamboo.Precache;
using Cinemachine;
using Fundamental;
using Runtime.Utility;
using Unity.VisualScripting;
using Unity.VisualScripting.Community;
using UnityEngine;

namespace ACT.Battle;

public class SystemAbility : EntitySystem
{
	private EntityLocal m_Local;

	public List<Entity> m_Hitables;

	private bool _hasEliteHpSnapshot;

	private int _eliteHpSnapshotCharacterId;

	private int _eliteHpSnapshotLostHp;

	private bool _eliteHpSnapshotWasDead;

	private const string BpGlobalEventName = "OnGlobalDefinedEvent";

	private Filter _abilityFilter;

	private EntityAction<CompBehave, CompAbility> _lateUpdateBehaveAction;

	private EntityAction<CompBehave, CompAbility> _fixedUpdateBehaveAction;

	private EntityAction<CompBehave, CompAbility> _updateBehaveAction;

	private EntityAction _bpGlobalEventAction;

	private DefinedEventArgs _bpGlobalEventArgs;

	public Queue<TriggerAbilityRuntime> m_ABQueue = new Queue<TriggerAbilityRuntime>();

	private Dictionary<Type, ObjectPool> m_EvtsPool;

	private ObjectPool<AttackData> m_AttackDataPool;

	private ObjectPool<AbilityMaterial> m_MaterialPool;

	private ObjectPool<TriggerAbilityRuntime> m_TriggerABPool;

	private ObjectPool<AnomalyData> m_AnomalyDataPool;

	public ObjectPool<Ability> abilityPool;

	public static ObjectPool<LoadCameraNoiseAsync> s_LoadNoisePool;

	private Dictionary<string, CinemachineImpulseSource> m_Impulses;

	private Dictionary<string, Animator> m_Volumes;

	private Dictionary<Type, List<BaseAbilityMixin>> m_EvtListens;

	public List<Type> evtTypes;

	private ObjectPool<CameraRuntimeItem> m_CameraPool;

	private ObjectPool<SwitchSkillPosData> _switchSkillPosDataPool;

	public override Filter MajorFilter => _abilityFilter;

	public AbilityMixinPoolManager mixinPoolManager { get; private set; }

	protected override void OnCreate()
	{
		InitPool();
		InitGameEvents();
		_abilityFilter = World.NewFilter().All<CompAbility>().Build();
		_lateUpdateBehaveAction = LateUpdateBehave;
		_fixedUpdateBehaveAction = FixedUpdateBehave;
		_updateBehaveAction = UpdateBehave;
		_bpGlobalEventAction = FireBpGlobalEvent;
	}

	protected override void OnDestroy()
	{
		mixinPoolManager?.Clear();
		mixinPoolManager = null;
		base.OnDestroy();
	}

	public override void LateUpdate()
	{
		using (mixinPoolManager.EnterFence())
		{
			_abilityFilter.ForEach(_lateUpdateBehaveAction);
			PropertyDirtyTracker.FlushAll();
		}
	}

	public override void FixedUpdate()
	{
		using (mixinPoolManager.EnterFence())
		{
			_abilityFilter.ForEach(_fixedUpdateBehaveAction);
		}
	}

	private void LateUpdateBehave(Entity entity, CompBehave compBehave, CompAbility compAbility)
	{
		if (!entity.IsTickAvailable())
		{
			return;
		}
		foreach (Ability ability in compAbility.abilities)
		{
			try
			{
				ability.LateUpdate();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("Ability - " + ability.config.name + " has something error.");
					Debug.LogException(exception);
				}
			}
		}
	}

	public Ability ProcessImmediateAbilityAdd(Entity entity, Ability toAdd)
	{
		Ability result = toAdd;
		if (toAdd.stack == 0)
		{
			abilityPool.Release(toAdd);
			return result;
		}
		if (toAdd.config.onCasterDieRemove && !toAdd.caster.IsValid)
		{
			abilityPool.Release(toAdd);
			return result;
		}
		CompAbility compAbility = entity.GetCompAbility();
		bool flag = false;
		foreach (Ability ability in compAbility.abilities)
		{
			if (ability.config == toAdd.config)
			{
				flag = true;
				if (ability.config.refreshCaster)
				{
					ability.RefreshData(toAdd.caster);
				}
				ability.Merge(toAdd.stack);
				result = ability;
				abilityPool.Release(toAdd);
				compAbility.onAbilityChange?.Invoke();
				break;
			}
		}
		if (!flag)
		{
			toAdd.InitMixins();
			toAdd.config.Precache();
			compAbility.RegisterAbility(toAdd);
			toAdd.OnAdd();
			DoActions(toAdd.caster, toAdd.owner, FindTargetResult.EntityOnly(toAdd.owner), null, toAdd, toAdd.config.OnAdd);
			compAbility.onAddAbilty?.Invoke(toAdd);
			compAbility.onAbilityChange?.Invoke();
		}
		return result;
	}

	private void FixedUpdateBehave(Entity entity, CompBehave compBehave, CompAbility compAbility)
	{
		if (!entity.IsTickAvailable())
		{
			return;
		}
		CompCharacter compCharacter = entity.GetCompCharacter();
		CompMotion compMotion = entity.GetCompMotion();
		foreach (Ability item in compAbility.toRemove)
		{
			item.OnRemove();
			DoActions(entity.GetCaster(), entity, FindTargetResult.EntityOnly(entity), null, item, item.config.OnRemove);
			item.config.RemoveCache();
			if (Model<CharacterTutorialModel>.Interface.InCharacterTutorial && compCharacter != null)
			{
				CharacterTutorialRemoveAbilityEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<CharacterTutorialRemoveAbilityEvt>();
				evt.characterId = compCharacter.characterSource.Id();
				evt.abilityName = item.config.name;
				Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_RemoveAbility, evt);
				Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			abilityPool.Release(item);
			compAbility.toRemove.Remove(item);
			compAbility.UnregisterAbility(item);
			compAbility.onRemoveAbility?.Invoke(item);
			compAbility.onAbilityChange?.Invoke();
		}
		if (!MonoECS.instance.IsLoadSubScene)
		{
			if (compMotion != null && entity.IsActive())
			{
				bool switchIn = false;
				if (compMotion.lastLayer0Peak != null)
				{
					switchIn = true;
					try
					{
						DoFrame(entity, compMotion.lastLayer0Peak, switchIn: false, switchOut: true);
					}
					finally
					{
						compMotion.suppressSwitchOutAreaAttack = false;
					}
					compAbility.ClearHited();
					compAbility.ClearHitRecoveryEnergy();
					compAbility.AttackedInMotion = false;
				}
				DoFrame(entity, compMotion.layer0Peak, switchIn, switchOut: false);
			}
			foreach (Ability ability2 in compAbility.abilities)
			{
				try
				{
					ability2.FixedUpdate();
				}
				catch (Exception exception)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(exception);
					}
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("Ability - " + ability2.config.name + " has something error.");
					}
				}
			}
		}
		foreach (Ability ability3 in compAbility.abilities)
		{
			if (ability3.stack == 0 && !compAbility.toRemove.Contains(ability3))
			{
				string name = ability3.config.name;
				Ability ability = ability3;
				ability.OnRemove();
				DoActions(entity.GetCaster(), entity, FindTargetResult.EntityOnly(entity), null, ability, ability.config.OnRemove);
				compAbility.UnregisterAbility(ability3);
				ability.config.RemoveCache();
				compAbility.ClearPendingAbilityBeforeRelease(ability);
				abilityPool.Release(ability);
				if (Model<CharacterTutorialModel>.Interface.InCharacterTutorial && compCharacter != null)
				{
					CharacterTutorialRemoveAbilityEvt evt2 = Fundamental.Singleton<EventManager>.instance.GetEvt<CharacterTutorialRemoveAbilityEvt>();
					evt2.characterId = compCharacter.characterSource.Id();
					evt2.abilityName = name;
					Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_RemoveAbility, evt2);
					Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt2);
				}
				compAbility.onRemoveAbility?.Invoke(ability);
				compAbility.onAbilityChange?.Invoke();
			}
		}
		CompTime compTime = entity.GetCompTime();
		if (compTime != null)
		{
			compAbility.FixedUpdateHited(compTime.motionFixedSpeed * compTime.fixedDeltaTime);
		}
		ServerFixed(entity, compAbility, compTime);
	}

	public void InheritAbility(string abName, Entity entity, Entity target, bool remove)
	{
		CompAbility compAbility = entity.GetCompAbility();
		CompAbility compAbility2 = target.GetCompAbility();
		if (!compAbility.TryGetAbility(abName, includeAdd: false, out var ab))
		{
			return;
		}
		bool flag = false;
		foreach (Ability ability in compAbility2.abilities)
		{
			if (ability.config == ab.config)
			{
				flag = true;
				ability.Merge(ab.stack);
				abilityPool.Release(ab);
				break;
			}
		}
		if (!flag)
		{
			compAbility2.RegisterAbility(ab);
		}
		if (remove)
		{
			compAbility.UnregisterAbility(ab);
		}
	}

	public void ChangeCharacterInheritAbility(Entity entity, Entity target)
	{
		CompAbility compAbility = entity.GetCompAbility();
		CompAbility compAbility2 = target.GetCompAbility();
		BSet<Ability> bSet = BSetPool<Ability>.Default.Get();
		foreach (Ability ability in compAbility.abilities)
		{
			if (ability.config.inheritOnChangeCharacter)
			{
				bSet.Add(ability);
			}
		}
		foreach (Ability item in bSet)
		{
			compAbility.UnregisterAbility(item);
			compAbility2.RegisterAbility(item);
			item.OnInheritAbility(target);
		}
		BSetPool<Ability>.Default.Recycle(bSet);
	}

	private void ServerFixed(Entity entity, CompAbility compAbility, CompTime compTime)
	{
		if (entity.IsBattleBehaveNotCharacter())
		{
			float revivePostureProgress = compAbility.revivePostureProgress;
			if (compAbility.IsHavePosture && revivePostureProgress < 1f && compAbility.WeakTime > 0f && compTime != null)
			{
				float value = InterpolationUtility.FixedLerp(revivePostureProgress, 1f, compTime.fixedDeltaTime / compAbility.WeakTime);
				compAbility.ServerSetRevivePostureProgress(value);
			}
		}
	}

	private void DoFrame(Entity entity, FSMRuntimeState rState, bool switchIn, bool switchOut)
	{
		if (rState == null)
		{
			return;
		}
		ConfigMotion configMotion = rState.actualMotion;
		if ((object)configMotion == null)
		{
			return;
		}
		CompMotion compMotion = entity.GetCompMotion();
		CompAbility compAbility = entity.GetCompAbility();
		CompPhysics compPhysics = entity.GetCompPhysics();
		string text = null;
		try
		{
			int index = rState.state.index;
			Ability value = null;
			if (configMotion.compensations != null)
			{
				rState.frameCompensationRate = 1f;
				for (int i = 0; i < configMotion.compensations.Length; i++)
				{
					try
					{
						CompensationPattern compensationPattern = configMotion.compensations[i];
						if (switchIn)
						{
							compensationPattern.Reset(entity);
						}
						if (rState.DoByPercentPeriod(compensationPattern.time, compensationPattern.end, switchOut && compensationPattern.mustDo, compensationPattern.CanDoPeriod()))
						{
							if (compensationPattern.end == 0f)
							{
								compensationPattern.end = compensationPattern.time;
							}
							float duration = (compensationPattern.end - compensationPattern.time) * rState.length;
							compensationPattern.CompensationHandle(this, entity, duration, rState);
						}
					}
					catch (Exception exception)
					{
						text = $"compensations[{i}]";
						if (LuminApplication.LogEnabled)
						{
							Debug.LogException(exception);
						}
						throw;
					}
				}
			}
			if (configMotion.attacks != null)
			{
				if (configMotion.attacks.Length != 0)
				{
					compAbility.dummyAbilities.TryGetValue(configMotion.skillDetailId, out value);
				}
				for (int j = 0; j < configMotion.attacks.Length; j++)
				{
					try
					{
						DoAttack(configMotion.attacks[j], rState, entity, value, index, j, temp: false, switchIn, switchOut, configMotion);
					}
					catch (Exception exception2)
					{
						text = $"attacks[{j}] ,";
						if (LuminApplication.LogEnabled)
						{
							Debug.LogException(exception2);
						}
						throw;
					}
				}
			}
			if (configMotion.performances != null)
			{
				for (int k = 0; k < configMotion.performances.Length; k++)
				{
					try
					{
						PerformanceItem performanceItem = configMotion.performances[k];
						if (rState.DoByPercentPeriod(performanceItem.time, performanceItem.end, switchOut && performanceItem.mustDo, performanceItem.CanDoPeriod()))
						{
							performanceItem.Fire(FindTargetResult.EntityOnly(entity), rState);
						}
					}
					catch (Exception exception3)
					{
						text = $"performances[{k}]的 特效播放有报错（大部分情况是prefab为空导致的报错）\t";
						if (LuminApplication.LogEnabled)
						{
							Debug.LogException(exception3);
						}
						throw;
					}
				}
			}
			if (configMotion.volumeClips != null)
			{
				for (int l = 0; l < configMotion.volumeClips.Length; l++)
				{
					try
					{
						VolumeLayerItem volumeLayerItem = configMotion.volumeClips[l];
						if (rState.DoByPercentPeriod(volumeLayerItem.time, volumeLayerItem.time, mustDo: false, volumeLayerItem.CanDoPeriod()))
						{
							if (entity.IsFaceLeft() && volumeLayerItem.needCasterFaceDirToCheckVolume)
							{
								volumeLayerItem.StartVolumeClip(entity, GetVolume(volumeLayerItem.volumeReference1AssetID));
							}
							else
							{
								volumeLayerItem.StartVolumeClip(entity, GetVolume(volumeLayerItem.volumeReferenceAssetID));
							}
							goto IL_0336;
						}
						if (!rState.DoByPercentPeriod(volumeLayerItem.time, volumeLayerItem.end, mustDo: false, volumeLayerItem.CanDoPeriod()))
						{
							goto IL_0336;
						}
						if (compMotion.volumeAnimator == null)
						{
							continue;
						}
						float num = ((rState.runtimeClip != null) ? rState.runtimeClip.length : 0f);
						if (volumeLayerItem.end > volumeLayerItem.time)
						{
							num *= volumeLayerItem.end - volumeLayerItem.time;
						}
						compMotion.volumeAnimator.speed = entity.GetCompTime().motionFixedSpeed * compMotion.volumeSpeed;
						goto IL_0336;
						IL_0336:
						if (rState.DoByPercentPeriod(volumeLayerItem.end, volumeLayerItem.end, switchOut, volumeLayerItem.CanDoPeriod()))
						{
							if (entity.IsFaceLeft() && volumeLayerItem.needCasterFaceDirToCheckVolume)
							{
								volumeLayerItem.EndVolumeClip(entity, GetVolume(volumeLayerItem.volumeReference1AssetID));
							}
							else
							{
								volumeLayerItem.EndVolumeClip(entity, GetVolume(volumeLayerItem.volumeReferenceAssetID));
							}
						}
					}
					catch (Exception)
					{
						text = $"volumeClips[{l}]";
						throw;
					}
				}
			}
			if (configMotion.triggerAbilities != null)
			{
				for (int m = 0; m < configMotion.triggerAbilities.Length; m++)
				{
					try
					{
						ConfigTriggerAbility configTriggerAbility = configMotion.triggerAbilities[m];
						if (rState.DoByPercentPeriod(configTriggerAbility.time, configTriggerAbility.end, switchOut && configTriggerAbility.mustDo, configTriggerAbility.CanDoPeriod()))
						{
							compAbility.dummyAbilities.TryGetValue(configMotion.skillDetailId, out var value2);
							configTriggerAbility.triggerAbility.CheckDo(new ActionMemory(entity, entity, FindTargetResult.EntityOnly(entity), null, value2));
						}
					}
					catch (Exception exception4)
					{
						text = $"triggerAbilities[{m}]";
						if (LuminApplication.LogEnabled)
						{
							Debug.LogException(exception4);
						}
						throw;
					}
				}
			}
			if (compPhysics != null)
			{
				compPhysics.configMotionPhysics = null;
				if (configMotion.physicsOverrides != null)
				{
					for (int n = 0; n < configMotion.physicsOverrides.Length; n++)
					{
						try
						{
							PhysicsOverride physicsOverride = configMotion.physicsOverrides[n];
							if (rState.DoByPercentPeriod(physicsOverride.time, physicsOverride.end, switchOut && physicsOverride.mustDo, physicsOverride.CanDoPeriod()))
							{
								compPhysics.configMotionPhysics = physicsOverride.configMotionPhysics;
							}
						}
						catch (Exception exception5)
						{
							text = $"physicsOverrides[{n}]";
							if (LuminApplication.LogEnabled)
							{
								Debug.LogException(exception5);
							}
							throw;
						}
					}
				}
				compPhysics.ResetParams();
				if (configMotion.ecm2Overrides != null)
				{
					for (int num2 = 0; num2 < configMotion.ecm2Overrides.Length; num2++)
					{
						try
						{
							ECM2Override eCM2Override = configMotion.ecm2Overrides[num2];
							if (rState.DoByPercentPeriod(eCM2Override.time, eCM2Override.end, switchOut && eCM2Override.mustDo, eCM2Override.CanDoPeriod()))
							{
								eCM2Override.configMotionECM2.Do(new ActionMemory(entity, entity, FindTargetResult.EntityOnly(entity)));
							}
						}
						catch (Exception exception6)
						{
							text = $"ecm2Overrides[{num2}]";
							if (LuminApplication.LogEnabled)
							{
								Debug.LogException(exception6);
							}
							throw;
						}
					}
				}
			}
			if (compMotion.lastLayer0Peak != null)
			{
				rState = compMotion.lastLayer0Peak;
				configMotion = compMotion.lastLayer0PeakConfig;
			}
		}
		catch (Exception ex2)
		{
			if (configMotion == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($" {entity} 的Config Motion 有报错:\t {text} 产生了 {ex2}");
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($" {entity} 的Config Motion {configMotion.name} 有报错:\t{text}产生了 {ex2}");
			}
		}
	}

	private void DoAttack(AttackPattern attack, FSMRuntimeState rState, Entity entity, Ability dummyAbility, int stateIndex, int attackIndex, bool temp, bool switchIn, bool switchOut, ConfigMotion configMotion)
	{
		if (switchOut)
		{
			attack.Init();
		}
		bool flag = rState.DoByPercentPeriod(attack.time, attack.end, switchOut && attack.mustDo, attack.CanDoPeriod());
		if (attack is AreaAttackPattern areaAttack)
		{
			if (flag && (!switchOut || attack.mustDo))
			{
				LocalHandleAttack(areaAttack, entity, rState, dummyAbility, stateIndex, attackIndex, temp);
			}
		}
		else if (flag)
		{
			attack.Handle(this, entity, dummyAbility, stateIndex, attackIndex);
		}
	}

	private void LocalHandleAttack(AreaAttackPattern areaAttack, Entity behave, FSMRuntimeState rState, Ability dummyAbility, int stateIndex, int attackIndex, bool temp)
	{
		if (!temp)
		{
			if (areaAttack._findTargets is ConfigFindFlexibleAreaTargets configFindFlexibleAreaTargets)
			{
				float time = areaAttack.time;
				float num = areaAttack.end;
				if (num < 0f)
				{
					num = 1f;
				}
				if (num > time)
				{
					if (rState.toLogicPercent >= time && rState.toLogicPercent <= num)
					{
						float value = (rState.toLogicPercent - time) / (num - time);
						configFindFlexibleAreaTargets.ChangeTargetRange(Mathf.Clamp01(value));
					}
				}
				else if (Mathf.Approximately(num, time) && Mathf.Approximately(rState.toLogicPercent, time))
				{
					configFindFlexibleAreaTargets.ChangeTargetRange(1f);
				}
			}
			areaAttack.Handle(this, behave, dummyAbility, stateIndex, attackIndex);
		}
		else
		{
			areaAttack.HandleTemp(this, behave, dummyAbility, stateIndex, attackIndex);
		}
	}

	internal void RemoteEntityAttack(CmdMotionAttack cmd)
	{
		Entity entity = GameManager.entities.GetEntity(cmd.attacker);
		if (!entity.IsValid)
		{
			return;
		}
		CompAbility compAbility = entity.GetCompAbility();
		State state = entity.GetState(cmd.state);
		ConfigMotion configMotion = entity.GetConfigMotion(state);
		AttackPattern attackPattern = configMotion.attacks[cmd.attackIndex];
		compAbility.dummyAbilities.TryGetValue(configMotion.skillDetailId, out var value);
		MotionAttackSourceInfo source = new MotionAttackSourceInfo(entity, configMotion, attackPattern, cmd.state, cmd.attackIndex, configMotion.skillDetailId, value?.skillLevelInfo.id ?? 0);
		MotionAttackBatchAccumulator accumulator = default;
		int num = 0;
		for (int i = 0; i < cmd.targets.Count; i++)
		{
			FindTargetResult target = cmd.targets[i];
			Entity entity2 = target.entity;
			if (!entity2.IsAlive())
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"目标不能被攻击 alive:{entity2.IsAlive()} cantBeAttack:{entity2.CantBeAttack()}");
				}
				continue;
			}
			if (entity2.IsBehaveEntity())
			{
				num++;
			}
			bool flag = cmd.hitRecoveryOrdinals != null && i < cmd.hitRecoveryOrdinals.Count;
			if (flag)
			{
				compAbility.SetHitRecoveryEnergyContext(attackPattern, cmd.hitRecoveryOrdinals[i]);
			}
			AttackResolveResult result = default;
			try
			{
				result = attackPattern.DoServerAuthActionsAndCollect(entity, target, value, configMotion.motionPrimaryTypeTag, configMotion.motionTypeTag);
			}
			finally
			{
				if (flag)
				{
					compAbility.ClearHitRecoveryEnergyContext();
				}
			}
			accumulator.Record(entity2, in result);
		}
		if (!compAbility.AttackedInMotion && entity.GetEntityType() == EntityType.Character)
		{
			AddUltimateSkillValue(entity, 0f, offsite: false, useChargeRate: false);
			compAbility.AttackedInMotion = true;
		}
		if (num > 0)
		{
			DoActions(entity, entity, FindTargetResult.EntityOnly(entity), null, value, attackPattern.onHitCharacter);
		}
		DoActions(entity, entity, FindTargetResult.EntityOnly(entity), null, value, attackPattern.onHitSelf);
		DispatchMotionAttackBatchResolved(in source, in accumulator);
	}

	internal void DispatchMotionAttackBatchResolved(in MotionAttackSourceInfo source, in MotionAttackBatchAccumulator accumulator)
	{
		if (accumulator.HasEffectiveResult)
		{
			MotionAttackPatternResolvedEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<MotionAttackPatternResolvedEvt>();
			evt.source = source;
			evt.resolvedEnemyCount = accumulator.resolvedEnemyCount;
			evt.damagedEnemyCount = accumulator.damagedEnemyCount;
			evt.killedEnemyCount = accumulator.killedEnemyCount;
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.MotionAttackPatternResolved, evt);
			Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	internal static void DoActions(Entity caster, Entity owner, FindTargetResult target, BaseEvt evt, Ability ability, ConfigAction[] actions)
	{
		DoActions(new ActionMemory(caster, owner, target, evt, ability), actions);
	}

	internal static void DoActions(ActionMemory memory, ConfigAction[] actions)
	{
		if (actions == null || actions.Length <= 0)
		{
			return;
		}
		foreach (ConfigAction configAction in actions)
		{
			try
			{
				configAction.CheckDo(memory);
			}
			catch (Exception)
			{
				_ = LuminApplication.LogEnabled;
			}
		}
	}

	internal static void DoActionsToSelf(Entity entity, ConfigAction[] actions)
	{
		DoActions(entity, entity, FindTargetResult.EntityOnly(entity), null, null, actions);
	}

	internal void FireCameraFOV(AnimationCurve curve, float time, TimeScale timeScale)
	{
		m_Local.compCamera.FireCameraFOV(curve, time, timeScale);
	}

	public void PreloadVolume()
	{
		List<YooAssetReference> volumeRefrencesAssetID = GameLoader.meta.volumeRefrencesAssetID;
		for (int i = 0; i < volumeRefrencesAssetID.Count; i++)
		{
			YooAssetReference yooAssetReference = volumeRefrencesAssetID[i];
			string guid = yooAssetReference.GUID;
			if (m_Volumes.TryGetValue(guid, out var value))
			{
				if (value != null)
				{
					continue;
				}
				m_Volumes.Remove(guid);
			}
			AssetStationManager.BattleStation.InstantiateAsync(yooAssetReference, (AssetLoadHandle result) =>
			{
				GameObject gameObject = result.AsGameObject();
				if (!(gameObject == null))
				{
					gameObject.SetActive(value: false);
					Animator component = gameObject.GetComponent<Animator>();
					if (!(component == null))
					{
						m_Volumes[guid] = component;
					}
				}
			});
		}
	}

	public Animator GetVolume(YooAssetReference reference)
	{
		m_Volumes.TryGetValue(reference.GUID, out var value);
		return value;
	}

	[Obsolete]
	internal void ChangeVCamera(string vCamera)
	{
		m_Local.compCamera.changed = true;
		m_Local.compCamera.curVirtualCamera = vCamera;
	}

	internal CameraRuntimeItem LoadVCamera(VCameraParams p)
	{
		Vector3 pos = p.caster.GetMono().transform.position;
		if (p.canUsePos)
		{
			pos = p.pos;
		}
		CameraRuntimeItem runtime = GetCameraItem();
		runtime.caster = p.caster;
		PrecacheManager.Instance.GetInstanceHandle(p.patternAssetID.GUID).Completed += (InstanceHandle l) =>
		{
			runtime.OnLoad(l, p.patternAssetID, p.config, pos);
		};
		return runtime;
	}

	[Obsolete]
	internal void SetVCamAnimatorParam(bool temp = false)
	{
		m_Local.compCamera.setAnimatorParam = true;
		if (temp)
		{
			m_Local.compCamera.setLeft = true;
		}
		else
		{
			m_Local.compCamera.setLeft = false;
		}
	}

	internal bool CanAttack(Entity behave, EntityId id, out Entity target)
	{
		if (TryGetIHitable(id, out target))
		{
			return CanAttack(behave, target);
		}
		return false;
	}

	internal bool CanAttack(Entity behave, Entity target)
	{
		if (!target.IsAlive() || target.CantBeAttack())
		{
			return false;
		}
		return behave.GetAlliance() switch
		{
			Alliance.Character => target.GetAlliance() != Alliance.Character, 
			Alliance.Enemy => target.GetAlliance() != Alliance.Enemy, 
			Alliance.Netural => target.GetAlliance() != Alliance.Netural, 
			_ => true, 
		};
	}

	internal void ServerResolveDamage(AttackData attackData, Ability ability)
	{
		CompAbility compAbility = attackData.attackee.GetCompAbility();
		attackData.actualDamage = Mathf.Min(compAbility.hp + compAbility.shield, Mathf.RoundToInt(attackData.damage));
		EvtSetActualDamage evt = GetEvt<EvtSetActualDamage>(attackData.attacker, ability);
		evt.mainEntity = attackData.attackee;
		evt.attackData = attackData;
		FireEvt(evt);
		ReleaseEvt(evt);
		CmdDamageNumber cmd = DamageNotifications.BuildDamageNumberCmd(attackData, ability);
		if (!attackData.attackee.IsCollection() && !attackData.attackee.IsTrajectory())
		{
			DamageNotifications.FireDamageNumberSpawn(in cmd);
		}
		if (attackData.attackee.GetEntityType() == EntityType.Boss)
		{
			GameManager.hatredSystem.RefreshBossBloodBar(attackData.attackee);
		}
		DamageNotifications.NotifyCharacterDamageHit(attackData);
		PostureDamageResolver.Apply(attackData, ability);
		attackData.shieldMixinRemainingDamage = Mathf.Min(compAbility.shield, attackData.actualDamage);
		EvtBeforeShieldConsume evt2 = GetEvt<EvtBeforeShieldConsume>(attackData.attacker, ability);
		evt2.mainEntity = attackData.attackee;
		evt2.attackData = attackData;
		FireEvt(evt2);
		ReleaseEvt(evt2);
		int num = ShieldConsumer.Consume(attackData);
		CompAbility? compAbility2 = attackData.attacker.GetCompAbility();
		int hp = compAbility.hp;
		if (num > 0)
		{
			compAbility.ServerSetHP(compAbility.hp - num);
		}
		DeathResolver.Resolve(attackData, ability, hp, cmd.faceLeft);
		compAbility2.ServerSetHpChange((int)(compAbility2.GetProperty(45u).value * (float)attackData.actualDamage));
	}

	public override void Update()
	{
		using (mixinPoolManager.EnterFence())
		{
			_abilityFilter.ForEach(_updateBehaveAction);
		}
	}

	private void UpdateBehave(Entity behave, CompBehave compBehave, CompAbility compAbility)
	{
		if (!behave.IsTickAvailable())
		{
			return;
		}
		foreach (Ability ability in compAbility.abilities)
		{
			try
			{
				ability.Update();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"entity {behave} Ability - " + ability.config?.name + " has something error.");
				}
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
	}

	public void FireDamageableEvt(BaseEvt evt)
	{
		if (evt.mainEntity.IsValid)
		{
			GameManager.entityTickLodSystem?.Wake(evt.mainEntity, evt.GetType().Name);
		}
		using (mixinPoolManager.EnterFence())
		{
			if (evt.mainEntity.IsValid)
			{
				List<BaseAbilityMixin> listeners = evt.mainEntity.GetCompAbility().GetListeners(evt.GetType());
				List<BaseAbilityMixin> list = Fundamental.ListPool<BaseAbilityMixin>.Get();
				list.AddRange(listeners);
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i].isActive)
					{
						list[i].OnEvt(evt);
					}
				}
				Fundamental.ListPool<BaseAbilityMixin>.Release(list);
			}
			List<BaseAbilityMixin> listeners2 = GetListeners(evt.GetType());
			List<BaseAbilityMixin> list2 = Fundamental.ListPool<BaseAbilityMixin>.Get();
			list2.AddRange(listeners2);
			for (int j = 0; j < list2.Count; j++)
			{
				if (list2[j].isActive)
				{
					list2[j].ListenEvt(evt);
				}
			}
			Fundamental.ListPool<BaseAbilityMixin>.Release(list2);
		}
	}

	public void FireEvt(BaseEvt evt)
	{
		using (mixinPoolManager.EnterFence())
		{
			if (evt.mainEntity.IsValid && (evt.mainEntity.IsBehaveEntity() || evt.mainEntity.HasCompNeutral() || evt.mainEntity.GetEntityType() == EntityType.Trajectory))
			{
				CompAbility compAbility = evt.mainEntity.GetCompAbility();
				List<BaseAbilityMixin> listeners = compAbility.GetListeners(evt.GetType());
				List<BaseAbilityMixin> list = Fundamental.ListPool<BaseAbilityMixin>.Get();
				list.AddRange(listeners);
				for (int i = 0; i < list.Count; i++)
				{
					if (!list[i].isActive)
					{
						continue;
					}
					try
					{
						list[i].OnEvt(evt);
					}
					catch (Exception exception)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogException(exception);
						}
					}
				}
				Fundamental.ListPool<BaseAbilityMixin>.Release(list);
				compAbility.GetBaseEvt(evt.GetType())?.Invoke(evt);
			}
			List<BaseAbilityMixin> listeners2 = GetListeners(evt.GetType());
			List<BaseAbilityMixin> list2 = Fundamental.ListPool<BaseAbilityMixin>.Get();
			list2.AddRange(listeners2);
			for (int j = 0; j < list2.Count; j++)
			{
				if (!list2[j].isActive)
				{
					continue;
				}
				try
				{
					list2[j].ListenEvt(evt);
				}
				catch (Exception exception2)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(exception2);
					}
				}
			}
			Fundamental.ListPool<BaseAbilityMixin>.Release(list2);
		}
	}

	public void TriggerAbility(Entity caster, Entity b, ActionTriggerAbility actionTriggerAbility)
	{
		TriggerAbilityRuntime triggerAbilityRuntime = m_TriggerABPool.Get();
		triggerAbilityRuntime.caster = caster;
		triggerAbilityRuntime.eb = b;
		triggerAbilityRuntime.action = actionTriggerAbility;
		SetTriggerAbilityRuntimeAbility(triggerAbilityRuntime, b, actionTriggerAbility.name);
		_ = LuminApplication.LogEnabled;
	}

	public void TriggerAbility(Entity caster, Entity b, string abilityName)
	{
		TriggerAbilityRuntime triggerAbilityRuntime = m_TriggerABPool.Get();
		triggerAbilityRuntime.caster = caster;
		triggerAbilityRuntime.eb = b;
		triggerAbilityRuntime.action = null;
		SetTriggerAbilityRuntimeAbility(triggerAbilityRuntime, b, abilityName);
	}

	private void SetTriggerAbilityRuntimeAbility(TriggerAbilityRuntime runtime, Entity b, string abilityName)
	{
		if (b.GetCompAbility().TryGetAbility(abilityName, includeAdd: false, out var ab))
		{
			runtime.ability = ab;
			EnqueueTriggerAbility(runtime);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
			runtime.Reset();
			m_TriggerABPool.Release(runtime);
		}
	}

	private void EnqueueTriggerAbility(TriggerAbilityRuntime runtime)
	{
		if (m_ABQueue.Count == 0)
		{
			m_ABQueue.Enqueue(runtime);
			while (m_ABQueue.Count > 0)
			{
				TriggerAbilityRuntime triggerAbilityRuntime = m_ABQueue.Peek();
				try
				{
					Ability ability = triggerAbilityRuntime.ability;
					ability.actionTriggerAbility = triggerAbilityRuntime.action;
					for (int i = 0; i < ability.mixins.Length; i++)
					{
						ability.mixins[i].TriggerAbility();
					}
					DoActions(triggerAbilityRuntime.caster, triggerAbilityRuntime.eb, FindTargetResult.EntityOnly(triggerAbilityRuntime.eb), null, ability, ability.config.onTriggerAbility);
				}
				catch (Exception ex)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"Entity{triggerAbilityRuntime.eb} 执行技能失败，{triggerAbilityRuntime.ability.config.name} 当前配置技能触发Type为{triggerAbilityRuntime.action?.type}");
					}
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError(ex.ToString());
					}
				}
				finally
				{
					m_ABQueue.Dequeue();
					triggerAbilityRuntime.Reset();
					m_TriggerABPool.Release(triggerAbilityRuntime);
				}
			}
		}
		else
		{
			m_ABQueue.Enqueue(runtime);
		}
	}

	private bool TryGetIHitable(EntityId id, out Entity entity)
	{
		for (int i = 0; i < m_Hitables.Count; i++)
		{
			if (m_Hitables[i].Id == id)
			{
				entity = m_Hitables[i];
				return true;
			}
		}
		entity = default;
		return false;
	}

	internal static void AddUltimateSkillValue(Entity entity, float value, bool offsite, bool useChargeRate)
	{
		if (entity.IsAlive())
		{
			CompAbility compAbility = entity.GetCompAbility();
			float num = (offsite ? RuntimeConfigs.data.game.offsiteChargeRate : 1f) * (useChargeRate ? compAbility.ChargeRate : 1f) * Mathf.Max(0f, value);
			compAbility.CurrentUltimateSkillValue += num;
		}
	}

	internal static void AddUltimateSkillValueForPlayer(MPPlayer player, float value, bool useOffsiteParam, bool useChargeRate)
	{
		if (player != null)
		{
			AddUltimateSkillValue(player.battleEntity, value, offsite: false, useChargeRate);
			Entity switchCharacter = MPPlayer.local.GetSwitchCharacter(0);
			Entity switchCharacter2 = MPPlayer.local.GetSwitchCharacter(1);
			AddUltimateSkillValue(switchCharacter, value, useOffsiteParam, useChargeRate);
			AddUltimateSkillValue(switchCharacter2, value, useOffsiteParam, useChargeRate);
		}
	}

	internal static void AddUltimateSkillValueForAllPlayer(float value, bool useOffsiteParam, bool useChargeRate)
	{
		AddUltimateSkillValueForPlayer(MonoECS.instance.localPlayer, value, useOffsiteParam, useChargeRate);
	}

	private void InitPool()
	{
		m_EvtsPool = new Dictionary<Type, ObjectPool>();
		m_AttackDataPool = new ObjectPool<AttackData>(null, null, 5);
		m_MaterialPool = new ObjectPool<AbilityMaterial>(null, (AbilityMaterial x) =>
		{
			x.Reset();
		}, 20);
		m_Impulses = new Dictionary<string, CinemachineImpulseSource>();
		m_Volumes = new Dictionary<string, Animator>();
		s_LoadNoisePool = new ObjectPool<LoadCameraNoiseAsync>(null, ClearLoadGoAsync);
		m_TriggerABPool = new ObjectPool<TriggerAbilityRuntime>();
		m_EvtListens = new Dictionary<Type, List<BaseAbilityMixin>>();
		abilityPool = new ObjectPool<Ability>(null, (Ability p) =>
		{
			p.Reset();
		}, 100);
		mixinPoolManager = new AbilityMixinPoolManager();
		m_AnomalyDataPool = new ObjectPool<AnomalyData>(null, null, 5);
		evtTypes = new List<Type>();
		m_CameraPool = new ObjectPool<CameraRuntimeItem>();
		_switchSkillPosDataPool = new ObjectPool<SwitchSkillPosData>((SwitchSkillPosData x) =>
		{
			x.Reset();
		}, (SwitchSkillPosData x) =>
		{
			x.Reset();
		}, 5);
		Type typeFromHandle = typeof(BaseEvt);
		Type[] types = typeFromHandle.Assembly.GetTypes();
		Type typeFromHandle2 = typeof(ObjectPool<>);
		Type[] array = types;
		foreach (Type type in array)
		{
			if (type.IsSubclassOf(typeFromHandle))
			{
				evtTypes.Add(type);
				object obj = Activator.CreateInstance(typeFromHandle2.MakeGenericType(type));
				m_EvtsPool.Add(type, (ObjectPool)obj);
				m_EvtListens.Add(type, new List<BaseAbilityMixin>());
			}
		}
	}

	private void ClearLoadGoAsync(LoadCameraNoiseAsync arg0)
	{
		arg0.name = string.Empty;
		arg0.Completed = null;
	}

	public List<BaseAbilityMixin> GetListeners(Type t)
	{
		return m_EvtListens[t];
	}

	public void AddListener(Type t, BaseAbilityMixin mixin)
	{
		m_EvtListens[t].Add(mixin);
	}

	public void RemoveListener(Type t, BaseAbilityMixin mixin)
	{
		m_EvtListens[t].Remove(mixin);
	}

	public T GetEvt<T>(Entity owner, Ability ability) where T : BaseEvt, new()
	{
		T val = ((ObjectPool<T>)m_EvtsPool[typeof(T)]).Get();
		val.ownerEntity = owner;
		val.ability = ability;
		return val;
	}

	public void ReleaseEvt<T>(T ret) where T : BaseEvt, new()
	{
		ret.BaseReset();
		((ObjectPool<T>)m_EvtsPool[typeof(T)]).Release(ret);
	}

	public AttackData GetAttackData()
	{
		return m_AttackDataPool.Get();
	}

	public AnomalyData GetAnomalyData()
	{
		return m_AnomalyDataPool.Get();
	}

	public void ReleaseAttackData(AttackData d)
	{
		d.Reset();
		m_AttackDataPool.Release(d);
	}

	public void ReleaseAnomalyData(AnomalyData d)
	{
		d.Reset();
		m_AnomalyDataPool.Release(d);
	}

	public AbilityMaterial GetMaterialItem()
	{
		return m_MaterialPool.Get();
	}

	public void ReleaseMaterialItem(AbilityMaterial d)
	{
		m_MaterialPool.Release(d);
	}

	public CameraRuntimeItem GetCameraItem()
	{
		return m_CameraPool.Get();
	}

	public void ReleaseCameraItem(CameraRuntimeItem c)
	{
		c.Reset();
		m_CameraPool.Release(c);
	}

	public SwitchSkillPosData GetSwitchSkillPosData()
	{
		return _switchSkillPosDataPool.Get();
	}

	public void ReleaseSwitchSkillPosData(SwitchSkillPosData d)
	{
		_switchSkillPosDataPool.Release(d);
	}

	private void InitGameEvents()
	{
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_Change, OnSkillLevelUp);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_ChangeEquip, OnCharacterChangeEquip);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_ChangeGem, OnCharacterChangeGem);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_EliteLevelChange, OnElitePointLevelChange);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, OnWorldChange);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.SyncSystemPropertiesChangeToBattle, SyncSystemPropertiesToBattle);
		EventBus.Register<DefinedEventArgs>(new EventHook("BpGlobalEventName"), BpGlobalEventHandle);
	}

	private void BpGlobalEventHandle(DefinedEventArgs obj)
	{
		_bpGlobalEventArgs = obj;
		_abilityFilter.ForEach(_bpGlobalEventAction);
		_bpGlobalEventArgs = default;
	}

	private void FireBpGlobalEvent(Entity entity)
	{
		EvtBpGlobal evt = GetEvt<EvtBpGlobal>(entity, null);
		evt.eventData = _bpGlobalEventArgs.eventData;
		FireEvt(evt);
		ReleaseEvt(evt);
	}

	private void OnCharacterLevelUp(BaseEventContent obj)
	{
	}

	public void BagCharacterChipChange(Entity m_Entity, int nowChip, int preChip, BSet<int> lastChip = null)
	{
	}

	private void OnCharacterChangeEquip(BaseEventContent obj)
	{
		CharacterChangeEquipEvt evt;
		if (MonoECS.instance.isStartWorld)
		{
			evt = (CharacterChangeEquipEvt)obj;
			if (evt.character != null && EntityHelper.TryGetBattleEntityByCharacter(evt.character, out var entity))
			{
				DoChangeEquip(entity);
			}
		}
		void DoChangeEquip(Entity entityBehave)
		{
			RefreshCharacterEquipAbility(entityBehave, evt.removeEquip, evt.addEquip);
		}
	}

	private void OnCharacterChangeGem(BaseEventContent obj)
	{
		CharacterChangeGemEvt evt;
		if (MonoECS.instance.isStartWorld)
		{
			evt = (CharacterChangeGemEvt)obj;
			if (evt.Equip != null && EntityHelper.TryGetBattleEntityByCharacter(evt.character, out var entity))
			{
				DoChangeGem(entity);
			}
		}
		void DoChangeGem(Entity entityBehave)
		{
			RefreshCharacterEquipAbility(entityBehave, evt.Equip, evt.Equip);
		}
	}

	private void RefreshCharacterEquipAbility(Entity entity, Equip preEquip, Equip nowEquip)
	{
		if (!MonoECS.instance.isStartWorld || !entity.IsValid || !(entity.GetCompCharacter().characterSource is Character character))
		{
			return;
		}
		CompAbility compAbility = entity.GetCompAbility();
		List<int> list = Fundamental.ListPool<int>.Get();
		if (preEquip != null)
		{
			preEquip.GetAllFeatureIDs(list);
			foreach (int item in list)
			{
				EquipFeatureData data = CoreUtils.GetData(item, RuntimeConfigs.data.equipFeatureDatas);
				if (data == null)
				{
					continue;
				}
				SkillGroupData data2 = CoreUtils.GetData(data.skillGroupData, RuntimeConfigs.data.skillGroupDatas);
				if (data2?.skillTotalIds == null)
				{
					continue;
				}
				int featureData = character.GetFeatureData(item);
				for (int i = 0; i < data2.skillTotalIds.Length; i++)
				{
					SkillDetailData data3 = CoreUtils.GetData(data2.skillTotalIds[i], RuntimeConfigs.data.skillDetailDatas);
					if (data3 == null)
					{
						continue;
					}
					Ability abilityByName = compAbility.GetAbilityByName(data3.abilityName);
					if (abilityByName != null)
					{
						abilityByName.skillLevelInfo.level = (byte)featureData;
						if (featureData <= 0)
						{
							compAbility.RemoveAbility(data3.abilityName);
							continue;
						}
						abilityByName.RemoveProperty();
						abilityByName.AddProperty();
					}
				}
			}
		}
		if (nowEquip != null)
		{
			nowEquip.GetAllFeatureIDs(list);
			foreach (int item2 in list)
			{
				EquipFeatureData data4 = CoreUtils.GetData(item2, RuntimeConfigs.data.equipFeatureDatas);
				if (data4 == null)
				{
					continue;
				}
				SkillGroupData data5 = CoreUtils.GetData(data4.skillGroupData, RuntimeConfigs.data.skillGroupDatas);
				if (data5?.skillTotalIds == null)
				{
					continue;
				}
				int featureData2 = character.GetFeatureData(item2);
				if (featureData2 == 0)
				{
					continue;
				}
				for (int j = 0; j < data5.skillTotalIds.Length; j++)
				{
					SkillDetailData data6 = CoreUtils.GetData(data5.skillTotalIds[j], RuntimeConfigs.data.skillDetailDatas);
					if (data6 != null)
					{
						Ability abilityByName2 = compAbility.GetAbilityByName(data6.abilityName);
						if (abilityByName2 == null)
						{
							compAbility.AddAbility(entity, data6.abilityName, AbilitySource.Equip, new MPSkill
							{
								id = data6.id,
								level = (byte)featureData2
							}, 1);
						}
						else
						{
							abilityByName2.skillLevelInfo.level = (byte)featureData2;
							abilityByName2.RemoveProperty();
							abilityByName2.AddProperty();
						}
					}
				}
			}
		}
		Fundamental.ListPool<int>.Release(list);
	}

	public void OnElitePointLevelChange(BaseEventContent obj)
	{
		if (!(obj is CharacterEliteLevelChange { character: var character } characterEliteLevelChange))
		{
			return;
		}
		if (!EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			ClearEliteHpSnapshot(character);
			return;
		}
		int eliteActiveLevel = character.GetEliteActiveLevel();
		int beforeLevel = characterEliteLevelChange.beforeLevel;
		BList<int> ids = BListPool<int>.Default.Get(3);
		BList<int> ids2 = BListPool<int>.Default.Get(3);
		CompAbility compAbility = entity.GetCompAbility();
		TableRule.GetActiveEliteSkillIds(character.Id, beforeLevel, ref ids2);
		foreach (int item in ids2)
		{
			SkillDetailData data = CoreUtils.GetData(item, RuntimeConfigs.data.skillDetailDatas);
			if (data != null)
			{
				compAbility.RemoveAbility(data.abilityName);
			}
		}
		TableRule.GetActiveEliteSkillIds(character.Id, eliteActiveLevel, ref ids);
		foreach (int item2 in ids)
		{
			SkillDetailData data2 = CoreUtils.GetData(item2, RuntimeConfigs.data.skillDetailDatas);
			if (data2 != null)
			{
				compAbility.AddAbility(entity, data2.abilityName, AbilitySource.Elite, new MPSkill
				{
					id = item2,
					level = 1
				}, 1);
			}
		}
		BListPool<int>.Default.Recycle(ids);
		BListPool<int>.Default.Recycle(ids2);
		RestoreEliteHpSnapshot(character, compAbility);
	}

	private void CacheEliteHpSnapshot(Character character, CompAbility compAbility)
	{
		if (character != null && compAbility != null)
		{
			_hasEliteHpSnapshot = true;
			_eliteHpSnapshotCharacterId = character.Id;
			_eliteHpSnapshotWasDead = compAbility.hp <= 0;
			_eliteHpSnapshotLostHp = ((!_eliteHpSnapshotWasDead) ? Mathf.Max(0, compAbility.maxHP - compAbility.hp) : 0);
		}
	}

	private void RestoreEliteHpSnapshot(Character character, CompAbility compAbility)
	{
		if (_hasEliteHpSnapshot && character != null && character.Id == _eliteHpSnapshotCharacterId)
		{
			int num = ((!_eliteHpSnapshotWasDead) ? Mathf.Max(1, compAbility.maxHP - _eliteHpSnapshotLostHp) : 0);
			ClearEliteHpSnapshot(character);
			if (compAbility.hp != num)
			{
				compAbility.ServerSetHP(num);
			}
		}
	}

	private void ClearEliteHpSnapshot(Character character)
	{
		if (_hasEliteHpSnapshot && character != null && character.Id == _eliteHpSnapshotCharacterId)
		{
			_hasEliteHpSnapshot = false;
			_eliteHpSnapshotCharacterId = 0;
			_eliteHpSnapshotLostHp = 0;
			_eliteHpSnapshotWasDead = false;
		}
	}

	private void OnSkillLevelUp(BaseEventContent obj)
	{
		SkillGroupLevelUpEvt evt = (SkillGroupLevelUpEvt)obj;
		Character character = evt.character;
		if (EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			DoSkillLevelUp(entity, character);
		}
		void DoSkillLevelUp(Entity entityBehave, Character character2)
		{
			if (entityBehave.IsValid)
			{
				CompAbility compAbility = entityBehave.GetCompAbility();
				SkillGroupData data = CoreUtils.GetData(evt.skillGrouID, RuntimeConfigs.data.skillGroupDatas);
				if (data?.skillTotalIds != null)
				{
					byte skillGroupEventualLevel = character2.GetSkillGroupEventualLevel(data.id);
					int[] skillTotalIds = data.skillTotalIds;
					foreach (int num in skillTotalIds)
					{
						if (compAbility.dummyAbilities.TryGetValue(num, out var value))
						{
							value.skillLevelInfo.level = skillGroupEventualLevel;
						}
						else
						{
							SkillDetailData data2 = CoreUtils.GetData(num, RuntimeConfigs.data.skillDetailDatas);
							if (data2 == null)
							{
								continue;
							}
							MPSkill skillLevelInfo = new MPSkill
							{
								id = num,
								level = (byte)character2.SkillGroupLevels[data.id]
							};
							Ability ability = abilityPool.Get();
							ability.Init(compAbility.owner, compAbility.owner, AbilitySource.UpgradeSkill, skillLevelInfo);
							compAbility.dummyAbilities.Add(skillLevelInfo.id, ability);
							compAbility.AddAbility(entityBehave, data2.abilityName, AbilitySource.UpgradeSkill, skillLevelInfo, 1);
						}
						foreach (Ability ability2 in compAbility.abilities)
						{
							if (ability2.skillLevelInfo.id == num)
							{
								ability2.skillLevelInfo.level = skillGroupEventualLevel;
							}
						}
					}
				}
			}
		}
	}

	private void OnWorldChange(BaseEventContent obj)
	{
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter != null)
			{
				EvtOnWorldChanged evt = GetEvt<EvtOnWorldChanged>(teamCharacter, null);
				FireEvt(evt);
				ReleaseEvt(evt);
			}
		}
	}

	public void AddEnvironmentElementAbilityToAllTeamCharacter(EnvironmentElementData data)
	{
		if (data == null)
		{
			return;
		}
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = localPlayer.GetTeamCharacter(i);
			if (!teamCharacter.TryGetCompAbility(out CompAbility component))
			{
				continue;
			}
			List<string> abilityNames = data.GetAbilityNames();
			if (!data.element.HasFlag(component.GetElementBit()))
			{
				continue;
			}
			foreach (string item in abilityNames)
			{
				component.AddAbility(teamCharacter, item, AbilitySource.System, default, 1);
			}
		}
	}

	public void RemoveEnvironmentElementAbilityToAllTeamCharacter(EnvironmentElementData data)
	{
		if (data == null)
		{
			return;
		}
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		for (int i = 0; i < 3; i++)
		{
			if (!localPlayer.GetTeamCharacter(i).TryGetCompAbility(out CompAbility component))
			{
				continue;
			}
			foreach (string abilityName in data.GetAbilityNames())
			{
				if (component.HasAbility(abilityName))
				{
					component.RemoveAbility(abilityName);
				}
			}
		}
	}

	public void AddTeamResonanceBuff()
	{
		if (GameUtility.GetElementalResonance().level1)
		{
			if (GameUtility.GetElementalResonance().level2)
			{
				for (int i = 0; i < 3; i++)
				{
					Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
					if (teamCharacter != null)
					{
						GameUtility.AddResonanceAbility(teamCharacter);
					}
				}
				return;
			}
			for (int j = 0; j < 3; j++)
			{
				Entity teamCharacter2 = MonoECS.instance.localPlayer.GetTeamCharacter(j);
				if (teamCharacter2 != null)
				{
					GameUtility.AddResonanceAbility(teamCharacter2);
				}
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.Log("没有共鸣");
		}
	}

	public void RemoveTeamResonanceBuff()
	{
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter != null)
			{
				GameUtility.RemoveResonanceAbility(teamCharacter);
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("移除当前buff");
				}
			}
		}
	}

	private void SyncSystemPropertiesToBattle(BaseEventContent obj)
	{
		if (!(obj is SyncSystemPropertiesToBattle syncSystemPropertiesToBattle))
		{
			return;
		}
		if (syncSystemPropertiesToBattle.traget == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		Dictionary<int, float> properties = syncSystemPropertiesToBattle.properties;
		Entity entity;
		if (properties == null || properties.Count <= 0)
		{
			_ = LuminApplication.LogEnabled;
		}
		else if (EntityHelper.TryGetBattleEntityByCharacter(syncSystemPropertiesToBattle.traget, out entity))
		{
			CompAbility compAbility = entity.GetCompAbility();
			if (syncSystemPropertiesToBattle.isRemove && syncSystemPropertiesToBattle.propertySourceUid == 4)
			{
				CacheEliteHpSnapshot(syncSystemPropertiesToBattle.traget, compAbility);
			}
			if (syncSystemPropertiesToBattle.isRemove)
			{
				compAbility.RemoveProperties(syncSystemPropertiesToBattle.properties, needCal: true, PropertySource.System, syncSystemPropertiesToBattle.propertySourceUid);
			}
			else
			{
				compAbility.ReplaceProperties(syncSystemPropertiesToBattle.properties, PropertySource.System, syncSystemPropertiesToBattle.propertySourceUid, isNeedCal: true);
			}
		}
	}

	public void AddPostureSegment(Entity entity, int segment)
	{
		if (segment <= 0 || !entity.IsValid)
		{
			return;
		}
		ConfigCharacter config = entity.GetConfig();
		CompAbility compAbility = entity.GetCompAbility();
		if (config.postureType == PostureType.Long)
		{
			compAbility.ServerSetPosture(compAbility.maxPosture);
			return;
		}
		float num = (float)compAbility.posture / (float)compAbility.maxPosture;
		float[] posturePercent = config.posturePercent;
		int num2 = 0;
		bool flag = false;
		for (int i = 0; i < posturePercent.Length; i++)
		{
			float num3 = posturePercent[i];
			float num4 = ((i > 0) ? posturePercent[i - 1] : 0f);
			float num5;
			if (i != 0)
			{
				if (i == 1)
				{
					num5 = posturePercent[i - 1];
				}
				else
				{
					num5 = ((i > 1) ? (posturePercent[i - 1] - posturePercent[i - 2]) : 0f);
				}
			}
			else
			{
				num5 = 0f;
			}
			if (num3 > num && num4 < num)
			{
				flag = true;
				num2 = i;
			}
			if (num4 > num && num4 - num < num5 * 0.1f)
			{
				flag = true;
				num2 = i;
			}
		}
		if (flag)
		{
			int num6 = Mathf.Clamp(num2 + segment - 1, 0, posturePercent.Length - 1);
			compAbility.ServerSetPosture((int)(posturePercent[num6] * (float)compAbility.maxPosture));
		}
	}
}
