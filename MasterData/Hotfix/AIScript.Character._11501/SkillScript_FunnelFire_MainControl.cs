#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11501;

public class SkillScript_FunnelFire_MainControl : SkillAdvancedBase
{
	private bool _strengthen;

	private bool _refraction;

	private List<AdventureActor> _refractionTargets;

	private List<AdventureFXPlayer> _irradiationFxs;

	private CoroutineNode _irradiationCor;

	private FP _irradiationInterval;

	private CoroutineNode _refreshIrradiationCor;

	private Dictionary<int, List<AdventureFXPlayer>> _salvoShootFxs;

	private Dictionary<int, CoroutineNode> _salvoShootCors;

	private int _salvoShootIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_irradiationInterval = 0;
		_salvoShootIndex = 0;
		_strengthen = CommonUtils.HavePersonalPerk(_actor.dataID, 511502, out var perkLevel) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P2");
		_refraction = CommonUtils.HavePersonalPerk(_actor.dataID, 511504, out perkLevel);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "115_Main_Shoot"))
		{
			int index = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
			AnimationSlotConfigComponent.SlotType slotType = Config_MainControl.allLaserSlotTypes.get_Item(index);
			SingleShoot(slotType);
		}
		else if (string.Equals(eventName, "115_Main_Sustain_Shoot"))
		{
			IrradiationShoot();
		}
		else if (string.Equals(eventName, "115_Main_Salvo_Shoot"))
		{
			OnBeginSalvoShoot();
		}
	}

	protected void SingleShoot(AnimationSlotConfigComponent.SlotType slotType)
	{
		if (_actor.attackTarget == null || slotType == AnimationSlotConfigComponent.SlotType.None)
		{
			return;
		}
		string text = (_strengthen ? "fx_11501_bullet_B1P02_Cannon_Shoot_Strengthen" : "fx_11501_bullet_B2_Attack_Cannon");
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511509, out var perkLevel))
		{
			string tag = $"{slotType}_{511509}";
			text = (_actor.logicVariable.GetLogicTagToggle(tag) ? "fx_11501_bullet_B1P02_Cannon_Shoot_Strengthen" : text);
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias(text);
		if (gameObject != null)
		{
			GameObject fxPrefab = gameObject;
			Vector3 position = _actor.transform.position;
			Quaternion identity = Quaternion.identity;
			Transform selfSlot = GetSelfSlot(slotType);
			Transform transform = _actor.attackTarget.transform;
			AdventureFXPlayer.PlayFX(fxPrefab, 1f, position, identity, 1f, selfSlot, default, transform);
		}
		else
		{
			NovaLogger.Error("资源配置文件中未找到单发激光连线特效:" + text);
		}
		int hitDamageId = Config_MainControl.hitDamageIdDic.get_Item(slotType).get_Item(0);
		ILRuntimeAPI.HitActor(_actor, _actor.attackTarget as AdventureActor, hitDamageId, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		if (_refraction)
		{
			FindRefractionTarget();
			string text2 = "fx_11501_bullet_B2_Attack_Cannon";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511509, out perkLevel))
			{
				string tag2 = $"{slotType}_{511509}";
				text2 = (_actor.logicVariable.GetLogicTagToggle(tag2) ? "fx_11501_bullet_B1P02_Cannon_Shoot_Strengthen" : text2);
			}
			gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias(text2);
			for (int i = 0; i < _refractionTargets.Count; i++)
			{
				Transform slotNode = (_actor.attackTarget as AdventureActor).slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Body);
				if (i > 0)
				{
					slotNode = _refractionTargets.get_Item(i - 1).slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Body);
				}
				AdventureActor adventureActor = _refractionTargets.get_Item(i);
				if (gameObject != null)
				{
					GameObject fxPrefab2 = gameObject;
					Vector3 position2 = _actor.transform.position;
					Quaternion identity2 = Quaternion.identity;
					Transform source = slotNode;
					Transform transform = adventureActor.transform;
					AdventureFXPlayer.PlayFX(fxPrefab2, 1f, position2, identity2, 1f, source, default, transform);
				}
				else
				{
					NovaLogger.Error("资源配置文件中未找到单发激光折射连线特效:" + text2);
				}
				hitDamageId = Config_MainControl.hitDamageIdDic.get_Item(slotType).get_Item(1);
				ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			}
		}
		OnFunnelFire(slotType);
	}

	protected void IrradiationShoot()
	{
		StopIrradiation(dontPlaySubFX: true);
		if (_actor.attackTarget == null)
		{
			return;
		}
		if (_irradiationFxs == null)
		{
			_irradiationFxs = new List<AdventureFXPlayer>();
		}
		if (_refraction)
		{
			FindRefractionTarget();
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11501_bullet_B2_Attack_Cannon_Sustain");
		foreach (AnimationSlotConfigComponent.SlotType allLaserSlotType in Config_MainControl.allLaserSlotTypes)
		{
			if (gameObject != null)
			{
				List<AdventureFXPlayer> irradiationFxs = _irradiationFxs;
				GameObject fxPrefab = gameObject;
				Vector3 position = _actor.transform.position;
				Quaternion identity = Quaternion.identity;
				Transform selfSlot = GetSelfSlot(allLaserSlotType);
				Transform transform = _actor.attackTarget.transform;
				irradiationFxs.Add(AdventureFXPlayer.PlayFX(fxPrefab, 1f, position, identity, 1f, selfSlot, default, transform));
			}
			else
			{
				NovaLogger.Error("资源配置文件中未找到照射激光连线特效:fx_11501_bullet_B2_Attack_Cannon_Sustain");
			}
			if (_strengthen)
			{
				gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11501_bullet_B2_Attack_Cannon_Sustain_Strengthen");
				if (gameObject != null)
				{
					List<AdventureFXPlayer> irradiationFxs2 = _irradiationFxs;
					GameObject fxPrefab2 = gameObject;
					Vector3 position2 = _actor.transform.position;
					Quaternion identity2 = Quaternion.identity;
					Transform selfSlot2 = GetSelfSlot(allLaserSlotType);
					Transform transform = _actor.attackTarget.transform;
					irradiationFxs2.Add(AdventureFXPlayer.PlayFX(fxPrefab2, 1f, position2, identity2, 1f, selfSlot2, default, transform));
				}
				else
				{
					NovaLogger.Error("资源配置文件中未找到照射激光连线特效:fx_11501_bullet_B2_Attack_Cannon_Sustain_Strengthen");
				}
			}
		}
		if (_refraction)
		{
			gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11501_bullet_B2_Attack_Cannon_Refraction");
			for (int i = 0; i < _refractionTargets.Count; i++)
			{
				Transform slotNode = (_actor.attackTarget as AdventureActor).slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Body);
				if (i > 0)
				{
					slotNode = _refractionTargets.get_Item(i - 1).slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Body);
				}
				AdventureActor adventureActor = _refractionTargets.get_Item(i);
				if (gameObject != null)
				{
					List<AdventureFXPlayer> irradiationFxs3 = _irradiationFxs;
					GameObject fxPrefab3 = gameObject;
					Vector3 position3 = _actor.transform.position;
					Quaternion identity3 = Quaternion.identity;
					Transform source = slotNode;
					Transform transform = adventureActor.transform;
					irradiationFxs3.Add(AdventureFXPlayer.PlayFX(fxPrefab3, 1f, position3, identity3, 1f, source, default, transform));
				}
				else
				{
					NovaLogger.Error("资源配置文件中未找到照射激光折射连线特效:fx_11501_bullet_B2_Attack_Cannon_Refraction");
				}
			}
		}
		_irradiationCor = _actor.StartLogicCoroutine(Irradiation(), runImmediately: true);
		_refreshIrradiationCor = _actor.StartLogicCoroutine(RefreshIrradiation(), runImmediately: true);
	}

	public void StopIrradiation(bool dontPlaySubFX = false)
	{
		if (_refreshIrradiationCor != null)
		{
			_actor.StopLogicCoroutine(_refreshIrradiationCor);
		}
		_refreshIrradiationCor = null;
		if (_irradiationFxs != null && _irradiationFxs.Count > 0)
		{
			foreach (AdventureFXPlayer irradiationFx in _irradiationFxs)
			{
				irradiationFx?.Stop(dontPlaySubFX);
			}
			_irradiationFxs.Clear();
		}
		if (_irradiationCor != null)
		{
			_actor.StopLogicCoroutine(_irradiationCor);
		}
		_irradiationCor = null;
	}

	private IEnumerator Irradiation()
	{
		while (true)
		{
			if (_irradiationInterval > 0)
			{
				_irradiationInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				string soundName = (_strengthen ? "char_11501_laser_impact_strengthen" : "char_11501_laser_impact");
				bool flag = false;
				foreach (AnimationSlotConfigComponent.SlotType allLaserSlotType in Config_MainControl.allLaserSlotTypes)
				{
					if (_actor.attackTarget != null)
					{
						int hitDamageId = Config_MainControl.hitDamageIdDic.get_Item(allLaserSlotType).get_Item(2);
						ILRuntimeAPI.HitActor(_actor, _actor.attackTarget as AdventureActor, hitDamageId, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
						MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(soundName);
					}
					if (_refraction && !flag)
					{
						if (_refractionTargets != null && _refractionTargets.Count > 0)
						{
							for (int i = 0; i < _refractionTargets.Count; i++)
							{
								int hitDamageId2 = Config_MainControl.hitDamageIdDic.get_Item(allLaserSlotType).get_Item(3);
								ILRuntimeAPI.HitActor(_actor, _refractionTargets.get_Item(i), hitDamageId2, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
								MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(soundName);
							}
						}
						flag = true;
					}
					OnFunnelFire(allLaserSlotType);
				}
				_irradiationInterval += GetIrradiationHitInterval();
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.actor = _actor;
				adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_Irradiation_UpdateTarget;
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
			yield return null;
		}
	}

	private FP GetIrradiationHitInterval()
	{
		FP fP = _actor.actorInfo.normalAttackSpd;
		if (fP <= 0)
		{
			fP = 0.2f;
		}
		return Config_MainControl.hitInterval_Irradiation / fP;
	}

	private IEnumerator RefreshIrradiation()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.refreshTime_IrradiationRefraction));
		IrradiationShoot();
	}

	protected virtual void OnBeginSalvoShoot()
	{
		SalvoShoot();
	}

	protected void SalvoShoot()
	{
		if (_actor.attackTarget == null)
		{
			return;
		}
		int salvoShootIndex = _salvoShootIndex;
		if (_salvoShootFxs == null)
		{
			_salvoShootFxs = new Dictionary<int, List<AdventureFXPlayer>>();
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11501_bullet_B1P03_Cannon_Shoot");
		if (gameObject != null)
		{
			foreach (AnimationSlotConfigComponent.SlotType allLaserSlotType in Config_MainControl.allLaserSlotTypes)
			{
				if (!_salvoShootFxs.ContainsKey(salvoShootIndex))
				{
					_salvoShootFxs.Add(salvoShootIndex, new List<AdventureFXPlayer>(4));
				}
				List<AdventureFXPlayer> list = _salvoShootFxs.get_Item(salvoShootIndex);
				Vector3 position = _actor.transform.position;
				Quaternion identity = Quaternion.identity;
				Transform selfSlot = GetSelfSlot(allLaserSlotType);
				Transform transform = _actor.attackTarget.transform;
				list.Add(AdventureFXPlayer.PlayFX(gameObject, 1f, position, identity, 1f, selfSlot, default, transform));
			}
		}
		else
		{
			NovaLogger.Error("资源配置文件中未找到齐射特效:fx_11501_bullet_B1P03_Cannon_Shoot");
		}
		if (_salvoShootCors == null)
		{
			_salvoShootCors = new Dictionary<int, CoroutineNode>();
		}
		CoroutineNode value = _actor.StartLogicCoroutine(SalvoShootLogic(salvoShootIndex));
		if (_salvoShootCors.ContainsKey(salvoShootIndex))
		{
			_salvoShootCors.set_Item(salvoShootIndex, value);
		}
		else
		{
			_salvoShootCors.Add(salvoShootIndex, value);
		}
		_salvoShootIndex++;
	}

	private IEnumerator SalvoShootLogic(int index)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.hitDelay_Salvo));
		if (_salvoShootFxs.TryGetValue(index, out var value) && value != null && value.Count > 0)
		{
			foreach (AdventureFXPlayer item in value)
			{
				item?.Stop();
			}
		}
		foreach (AnimationSlotConfigComponent.SlotType allLaserSlotType in Config_MainControl.allLaserSlotTypes)
		{
			OnFunnelFire(allLaserSlotType);
		}
		if (_actor.attackTarget is AdventureActor adventureActor)
		{
			for (int i = 0; i < 4; i++)
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, 115110302, "fx_11501_hit_2", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11501_Main_Skill_P03_SalvoBoom", adventureActor.tsTransform.Position);
		}
		if (_salvoShootCors.ContainsKey(index))
		{
			_salvoShootCors.set_Item(index, (CoroutineNode)null);
		}
	}

	protected void StopSalvoShoot(bool dontPlaySubFX = false)
	{
		if (_salvoShootFxs != null && _salvoShootFxs.Count > 0)
		{
			foreach (List<AdventureFXPlayer> value in _salvoShootFxs.Values)
			{
				if (value == null || value.Count <= 0)
				{
					continue;
				}
				foreach (AdventureFXPlayer item in value)
				{
					item?.Stop(dontPlaySubFX);
				}
				value.Clear();
			}
		}
		if (_salvoShootCors == null || _salvoShootCors.Count <= 0)
		{
			return;
		}
		foreach (CoroutineNode value2 in _salvoShootCors.Values)
		{
			if (value2 != null)
			{
				_actor.StopLogicCoroutine(value2);
			}
		}
		_salvoShootCors.Clear();
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if ((evt as AdventureActorCustomEvent).eventHashCode != Config_MainControl.eventHashCode_Trigger_LaserStrengthen || _strengthen)
		{
			return;
		}
		_strengthen = true;
		if (_irradiationCor == null || !(_actor.attackTarget != null))
		{
			return;
		}
		if (_irradiationFxs == null)
		{
			_irradiationFxs = new List<AdventureFXPlayer>();
		}
		foreach (AnimationSlotConfigComponent.SlotType allLaserSlotType in Config_MainControl.allLaserSlotTypes)
		{
			GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11501_bullet_B2_Attack_Cannon_Sustain_Strengthen");
			if (gameObject != null)
			{
				List<AdventureFXPlayer> irradiationFxs = _irradiationFxs;
				Vector3 position = _actor.transform.position;
				Quaternion identity = Quaternion.identity;
				Transform selfSlot = GetSelfSlot(allLaserSlotType);
				Transform transform = _actor.attackTarget.transform;
				irradiationFxs.Add(AdventureFXPlayer.PlayFX(gameObject, 1f, position, identity, 1f, selfSlot, default, transform));
			}
			else
			{
				NovaLogger.Error("资源配置文件中未找到照射激光连线特效:fx_11501_bullet_B2_Attack_Cannon_Sustain_Strengthen");
			}
		}
	}

	private void OnFunnelFire(AnimationSlotConfigComponent.SlotType slotType)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_AfterFunnelFireHit;
		if (adventureActorCustomEvent.intParamList == null)
		{
			adventureActorCustomEvent.intParamList = new List<int>();
		}
		adventureActorCustomEvent.intParamList.Clear();
		adventureActorCustomEvent.intParamList.Add((int)slotType);
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private Transform GetSelfSlot(AnimationSlotConfigComponent.SlotType slotType)
	{
		if (_actor == null || slotType == AnimationSlotConfigComponent.SlotType.None)
		{
			return null;
		}
		return _actor.slotConfig.GetSlotNode(slotType);
	}

	private void FindRefractionTarget()
	{
		if (_refractionTargets == null)
		{
			_refractionTargets = new List<AdventureActor>();
		}
		else
		{
			_refractionTargets.Clear();
		}
		LogicEntity logicEntity = _actor.attackTarget;
		for (int i = 0; i < 4; i++)
		{
			if (!(logicEntity != null))
			{
				break;
			}
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, logicEntity.tsTransform.Position, 5, FilterRefractionTarget, isConfront: true);
			if (_refractionTargets.Count > 0 && logicEntity != _refractionTargets.Last())
			{
				logicEntity = _refractionTargets.Last();
				continue;
			}
			break;
		}
	}

	private void FilterRefractionTarget(List<LogicEntity> searchEntitiesList)
	{
		List<LogicEntity> list = searchEntitiesList.Except(_refractionTargets).ToList();
		if (list.Count <= 0)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < list.Count; i++)
		{
			if (_actor.attackTarget != null && list.get_Item(i).Id == _actor.attackTarget.Id)
			{
				num = i;
				break;
			}
		}
		if (num >= 0)
		{
			list.RemoveAt(num);
		}
		if (list.Count > 0)
		{
			int index = TSRandom.Range(0, list.Count);
			_refractionTargets.Add(list.get_Item(index) as AdventureActor);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		StopIrradiation(dontPlaySubFX: true);
		_irradiationInterval = 0;
		StopSalvoShoot(dontPlaySubFX: true);
		_salvoShootIndex = 0;
		_refractionTargets?.Clear();
	}
}
