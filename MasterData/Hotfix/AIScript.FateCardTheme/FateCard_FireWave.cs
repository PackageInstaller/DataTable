#define LOG_DEBUG
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_FireWave : BaseFateCardTheme
{
	private const int hitDamageId = 986131;

	private readonly FP cd = 1;

	private readonly FP circleRadius = 5;

	private const string triggerFxPath = "fire_trigger_s";

	private readonly FP speed = 15;

	private const string path_FireWaveBullet = "FateCard_fireWave";

	private readonly int fireWaveDamageTag = CommonHelper.StringToHash("fireWave");

	private const string path_FireWaveBullet_Proa = "FateCard_fireWave_A";

	private static readonly int fireMarkTag = CommonHelper.StringToHash("FireTag");

	private readonly FP range_14 = 10;

	private const string path_Bullet14 = "FateCard_fireWave_14";

	private const int hitDamageId_14 = 986133;

	private readonly int triggerPercent_14 = 30;

	private readonly int num_14 = 2;

	private const string path_Bulle_ProC = "FateCard_fireWave_14_A";

	private Dictionary<string, GameObject> _fireWavePrefabDic;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_FireWave OnEnable");
		base.OnEnable();
		_fireWavePrefabDic = new Dictionary<string, GameObject>(4);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnActorRefreshBuff);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_fireWavePrefabDic?.Clear();
		_fireWavePrefabDic = null;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_GET_BUFF", OnActorRefreshBuff);
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_FireWave OnTrigger");
		if (CheckTimeout(cd))
		{
			ShootFireWave(986131);
			TriggerTheme();
		}
	}

	private void ShootFireWave(int hitDamageId)
	{
		LogicEntity attackTarget = _actor.attackTarget;
		attackTarget = ((attackTarget != null) ? attackTarget : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(attackTarget == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "fire_trigger_s");
			GameObject fireBulletPrefab = getFireBulletPrefab(CanExcuteA ? "FateCard_fireWave_A" : "FateCard_fireWave");
			TSVector2 normalized = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			AdventureBullet obj = _actor.shootBehaviour.Shoot(fireBulletPrefab, _actor.tsTransform.Position, null, normalized) as AdventureBullet;
			obj.ResetHitID(hitDamageId);
			obj.moveSpeed = speed;
			obj.velocitySpeed = speed;
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent _evt)
	{
		base.OnHitPre(_evt);
		if (_evt.from != _actor || !_evt.hitDamageTag.Contains(fireWaveDamageTag))
		{
			return;
		}
		AdventureActor target = _evt.to as AdventureActor;
		if (!CanExcuteB || (!CommonUtils.CheckElementMark(CommonDefine.Fire, target) && TSRandom.Range(0, 100) >= triggerPercent_14))
		{
			return;
		}
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, target.tsTransform.Position, range_14, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				for (int num = result.Count - 1; num > -1; num--)
				{
					if (result.get_Item(num).Id == target.Id)
					{
						result.RemoveAt(num);
						break;
					}
				}
			}
			if (result.Count > 0)
			{
				int num2 = num_14;
				num2 = ((num2 >= result.Count) ? result.Count : num2);
				for (int i = 0; i < num2; i++)
				{
					MonsterAdventureActor monsterAdventureActor = result.get_Item(i) as MonsterAdventureActor;
					if (monsterAdventureActor != null)
					{
						TSVector2 normalized = (monsterAdventureActor.tsTransform.Position - target.tsTransform.Position).normalized;
						string curPath = (CanExcuteC ? "FateCard_fireWave_14_A" : "FateCard_fireWave_14");
						_actor.shootBehaviour.Shoot(getFireBulletPrefab(curPath), target.tsTransform.Position, null, normalized).ResetHitID(986133);
					}
				}
			}
		}, isConfront: true);
	}

	private void OnActorRefreshBuff(IEvent evt)
	{
	}

	private GameObject getFireBulletPrefab(string curPath)
	{
		if (_fireWavePrefabDic.TryGetValue(curPath, out var value))
		{
			return value;
		}
		GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, curPath, forceUseCommonConfig: true);
		_fireWavePrefabDic.set_Item(curPath, bulletByAlias);
		return bulletByAlias;
	}
}
