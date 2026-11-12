using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13401;

public class ParallelScript_MainControl : ParallelScript
{
	private PlayFX _playFX_HaveAmmo_1;

	private PlayFX _playFX_HaveAmmo_2;

	private bool _haveAmmo;

	private HitBox.HitBoxFeatureData _featureData_P3;

	private CoroutineNode _perkLogicCor_P10;

	private bool HaveAmmo
	{
		get
		{
			return _haveAmmo;
		}
		set
		{
			if (_haveAmmo == value)
			{
				return;
			}
			_haveAmmo = value;
			if (_haveAmmo)
			{
				if (_playFX_HaveAmmo_1 == null)
				{
					_playFX_HaveAmmo_1 = new PlayFX();
				}
				else
				{
					_playFX_HaveAmmo_1.Stop();
				}
				_playFX_HaveAmmo_1.Play(_actor, null, "fx_13401_loop_Main_Skill_Charging_handL", default, _actor.tsTransform.Position, default);
				if (_playFX_HaveAmmo_2 == null)
				{
					_playFX_HaveAmmo_2 = new PlayFX();
				}
				else
				{
					_playFX_HaveAmmo_2.Stop();
				}
				_playFX_HaveAmmo_2.Play(_actor, null, "fx_13401_loop_Main_Skill_Charging_handR", default, _actor.tsTransform.Position, default);
			}
			else
			{
				_playFX_HaveAmmo_1?.Stop();
				_playFX_HaveAmmo_2?.Stop();
			}
			RefreshPerkLogic_4();
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		HaveAmmo = _actor.ammoInfo.GetAmmoCount(HotfixEnum.AmmoType.Special1) > 0;
		RefreshPerkLogic_4();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513405, out var perkLevel))
		{
			_damageTag_TriggerFireMark.Add(Config_MainControl.damageTag_TriggerFireMark_P5);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513410, out perkLevel))
		{
			if (_perkLogicCor_P10 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P10);
			}
			_perkLogicCor_P10 = _actor.StartLogicCoroutine(PerkLogic_10());
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513411, out perkLevel))
		{
			return;
		}
		bool flag = true;
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.FE)
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			_actor.buffComponent.AddBuff(13411011, _actor);
		}
	}

	protected override int GetAmmoCountMax()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513401, out var _))
		{
			return 9;
		}
		return base.GetAmmoCountMax();
	}

	private void RefreshPerkLogic_4()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513404, out var _))
		{
			if (HaveAmmo)
			{
				_actor.buffComponent.RemoveBuffByBuffId(13404011);
			}
			else
			{
				_actor.buffComponent.AddBuff(13404011, _actor);
			}
		}
	}

	public void OnUpdate()
	{
		HaveAmmo = _actor.ammoInfo.GetAmmoCount(HotfixEnum.AmmoType.Special1) > 0;
	}

	private IEnumerator PerkLogic_10()
	{
		FP interval = Config_MainControl.addBuffInterval_P10;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent?.AddBuff(13410011, _actor);
				interval = Config_MainControl.addBuffInterval_P10;
			}
			yield return null;
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513405, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config.damageTag_StrengthNormalAttack))
		{
			AdventureActor.AddFromAttr(13405001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513413, out perkLevel))
		{
			FDP fDP = (FDP)CommonUtils.GetScriptValue(_actor, 13413011) / (FDP)100L;
			if (monsterAdventureActor.actorHealthInfo.hpPercentage < fDP)
			{
				AdventureActor.AddFromAttr(13413001, _actor);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513403, out var perkLevel))
		{
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Skill))
			{
				monsterAdventureActor.buffComponent.AddBuff(13403011, _actor);
			}
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_NormalAttack) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(13403011))
			{
				if (_featureData_P3 == null)
				{
					_featureData_P3 = new HitBox.HitBoxFeatureData
					{
						StiffDuration = Config_MainControl.stiffDuration_P3,
						hitStrenth = Config_MainControl.hitStrenth_P3
					};
				}
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 134503001, "fx_13401_hit_Main_Skill_P03_Hurt", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.Stiff, _featureData_P3, -1);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513409, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P9) && monsterAdventureActor.actorHealthInfo.isAlive)
		{
			int count = Config_MainControl.buffIdList_P9.Count;
			int num = Config_MainControl.buffIdList_P9.get_Item(count - 1);
			bool flag = true;
			for (int i = 0; i < count - 1; i++)
			{
				int buffID = Config_MainControl.buffIdList_P9.get_Item(i);
				if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(buffID))
				{
					int num2 = Config_MainControl.buffIdList_P9.get_Item(i + 1);
					monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffID);
					monsterAdventureActor.buffComponent.AddBuff(num2, _actor);
					if (num2 == num)
					{
						_actor.StartLogicCoroutine(PerkLogic_9(monsterAdventureActor, num), runImmediately: true);
					}
					flag = false;
					break;
				}
			}
			if (flag && !monsterAdventureActor.buffComponent.CheckBuffByBuffID(num))
			{
				monsterAdventureActor.buffComponent.AddBuff(Config_MainControl.buffIdList_P9.get_Item(0), _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513412, out perkLevel) && damageEvent.isCrit && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
		{
			_actor.buffComponent.AddBuff(13412011, _actor);
		}
	}

	private IEnumerator PerkLogic_9(MonsterAdventureActor monster, int lastBuffId)
	{
		long monsterId = monster.Id;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.hitDelay_P9));
		if (CommonUtils.CheckTargetIsValid(monster, monsterId, ingoreSearchedImmunity: true))
		{
			long areaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13401_Main_Skill_P09_Boom", monster.tsTransform.Position);
			while (ILRuntimeAPI.CheckAreaEffectAlive(areaEffectId))
			{
				yield return null;
			}
			monster.buffComponent.RemoveBuffByBuffId(lastBuffId);
		}
	}

	private void Clear()
	{
		HaveAmmo = false;
		if (_perkLogicCor_P10 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P10);
		}
		_perkLogicCor_P10 = null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		Clear();
	}
}
