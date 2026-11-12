using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Soldier._162;

public class Parallel : AIBase
{
	private const string bulletKey_Potential2 = "Bullet_LeiDian_P1";

	private const string areaTag_Potential2 = "Soldier_162_ZhongJianCharu";

	private static readonly FP bulletRange_Potential2 = 0;

	public int hitTag_Normal = CommonHelper.StringToHash("162Normal");

	private const int triggerPercent_Potential2 = 50;

	private const string areaEffectKey_Potential2 = "Area_MainSkill_Soldier";

	private const string areaEffectTag_ZhongJianCharu_Potential3 = "Soldier_162_ZhongJianCharu";

	private static readonly FP absorbRange_Potential3 = 30;

	private const string fxKey_Potential3 = "fx_16201_bullet_ZhongJianLoop_XiShou";

	private static readonly FP fxMoveDuration_Potential3 = (FP)3 / (FP)10;

	private const int buffId_Potential3 = 250105601;

	private int _potentialLv;

	private readonly List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

	private readonly List<AreaEffectEntity> _absorbBuffer_Potential3 = new List<AreaEffectEntity>(8);

	public void OnEnable()
	{
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		_enemyBuffer.Clear();
		_absorbBuffer_Potential3.Clear();
	}

	public void OnUpdate()
	{
		if (_potentialLv >= 3 && !(_actor == null) && !_actor.IsDead())
		{
			AbsorbNearbyZhongJian_Potential3();
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (_potentialLv >= 2 && evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent && !(_actor == null) && !_actor.IsDead() && !(adventureAreaEffectFinishEvent.owner == null) && adventureAreaEffectFinishEvent.owner.Id == _actor.Id && adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag("Soldier_162_ZhongJianCharu"))
		{
			TSVector2 position = areaEffectEntity.tsTransform.Position;
			TSVector2 position2 = _actor.tsTransform.Position;
			if (!((position2 - position).LengthSquared() <= FP.Epsilon))
			{
				AdventureActor actor = _actor;
				FP range = bulletRange_Potential2;
				TSVector2 targetPosition = position2;
				ILRuntimeAPI.Shoot("Bullet_LeiDian_P1", actor, range, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private void OnReceiveHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeSettlementEvent.from is SoldierActor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag, hitTag_Normal) && _potentialLv >= 2 && TSRandom.Range(0, 100) < 50)
		{
			TSVector2 position = PickRandomEnemyPos();
			ILRuntimeAPI.PlayAreaEffect(_actor, "Area_MainSkill_Soldier", position);
		}
	}

	private TSVector2 PickRandomEnemyPos()
	{
		_enemyBuffer.Clear();
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController { enemyMainControlActor: var enemyMainControlActor } soldierLevelController && enemyMainControlActor != null)
		{
			soldierLevelController.GetBattleActors(enemyMainControlActor, _enemyBuffer);
			for (int num = _enemyBuffer.Count - 1; num >= 0; num--)
			{
				if (_enemyBuffer.get_Item(num) == null || _enemyBuffer.get_Item(num).IsSearchedImmunity())
				{
					_enemyBuffer.RemoveAt(num);
				}
			}
		}
		if (_enemyBuffer.Count == 0)
		{
			return _actor.tsTransform.Position;
		}
		return _enemyBuffer.get_Item(TSRandom.Range(0, _enemyBuffer.Count)).tsTransform.Position;
	}

	private void AbsorbNearbyZhongJian_Potential3()
	{
		_absorbBuffer_Potential3.Clear();
		List<AreaEffectEntity> areaEffectByTag = ILRuntimeAPI.GetAreaEffectByTag("Soldier_162_ZhongJianCharu");
		if (areaEffectByTag == null || areaEffectByTag.Count == 0)
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position;
		FP fP = absorbRange_Potential3 * absorbRange_Potential3;
		for (int i = 0; i < areaEffectByTag.Count; i++)
		{
			AreaEffectEntity areaEffectEntity = areaEffectByTag.get_Item(i);
			if (!(areaEffectEntity == null) && !areaEffectEntity.Finished && areaEffectEntity.ActiveSelf && !((areaEffectEntity.tsTransform.Position - position).LengthSquared() > fP))
			{
				_absorbBuffer_Potential3.Add(areaEffectEntity);
			}
		}
		if (_absorbBuffer_Potential3.Count != 0)
		{
			Vector3 position2 = _actor.transform.position;
			for (int j = 0; j < _absorbBuffer_Potential3.Count; j++)
			{
				AreaEffectEntity areaEffectEntity2 = _absorbBuffer_Potential3.get_Item(j);
				Vector3 position3 = areaEffectEntity2.transform.position;
				float speed = Vector3.Distance(position3, position2) / fxMoveDuration_Potential3.AsFloat();
				_actor.PlayMovableFx("fx_16201_bullet_ZhongJianLoop_XiShou", position3, position2, speed);
				_actor.StartLogicCoroutine(AbsorbAddBuff_Potential3(fxMoveDuration_Potential3), runImmediately: true);
				ILRuntimeAPI.StopAreaEffect(areaEffectEntity2.Id);
			}
			_absorbBuffer_Potential3.Clear();
		}
	}

	private IEnumerator AbsorbAddBuff_Potential3(FP delay)
	{
		yield return _actor.WaitTime(delay);
		_actor.buffComponent.AddBuff(250105601, _actor);
	}
}
