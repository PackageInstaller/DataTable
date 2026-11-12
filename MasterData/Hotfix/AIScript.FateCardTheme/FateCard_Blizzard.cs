#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_Blizzard : BaseFateCardTheme
{
	private readonly string fireBullet = "FateCard_Blizzard";

	private readonly int damageId = 986251;

	private readonly FP cd = 2;

	private readonly FP circleRadius = 8;

	private const string triggerFxPath = "FX/Perk/fx_perk_base_ice_trigger_s";

	private readonly string bulletPath_11 = "FateCard_Blizzard_11";

	private readonly FP interl_11 = 0.3;

	private readonly FP innerRadius_11 = 1;

	private readonly FP radius_11 = 2;

	private readonly int num_11 = 2;

	private readonly FP delayTime_14 = 0.5;

	private readonly string areaPath_14 = "FateCard_Blizzard_Area_14";

	private readonly FP duration_14 = 5;

	private readonly FP inter_14 = 1;

	private readonly int dicHitID_14 = 986253;

	private AdventureTimeBomb bullutObj;

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private int buffNum;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_Blizzard OnEnable");
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		foreach (CoroutineNode cor in corList)
		{
			StopLogicCoroutine(cor);
		}
		corList.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_Blizzard OnTrigger");
		if (CheckTimeout(cd))
		{
			Shoot(fireBullet, _actor.attackTarget, damageId);
			TriggerTheme();
		}
	}

	private void Shoot(string bullet, LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_ice_trigger_s");
			AdventureActor actor = _actor;
			TSVector2 position = target.tsTransform.Position;
			TSVector2 position2 = target.tsTransform.Position;
			bullutObj = ILRuntimeAPI.Shoot(bullet, actor, default, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureTimeBomb;
			bullutObj.hitBox.hitDamageId = hitDamageId;
			bullutObj.useOwnerActorInfo = true;
			if (CanExcuteA)
			{
				CoroutineNode item = StartLogicCoroutine(perk11_Shoot(bulletPath_11, target.tsTransform.Position, 0));
				corList.Add(item);
			}
			if (CanExcuteB)
			{
				CoroutineNode item2 = StartLogicCoroutine(DelayEffect(target, 0));
				corList.Add(item2);
			}
		}
	}

	private IEnumerator perk11_Shoot(string bullut, TSVector2 startPos, int level)
	{
		for (int i = 0; i < num_11; i++)
		{
			yield return StartLogicCoroutine(_actor.WaitForSeconds(interl_11));
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(startPos, innerRadius_11, radius_11);
			ILRuntimeAPI.Shoot(bullut, _actor, default, tSVector, _actor.tsTransform.PositionY, tSVector, null, AimType.Position, BulletDirectionType.BulletToTarget);
		}
	}

	private IEnumerator DelayEffect(LogicEntity target, int level_14)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delayTime_14));
		ILRuntimeAPI.PlayAreaEffect(_actor, areaPath_14, target.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			entity.duration = duration_14;
			AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent != null)
			{
				logicComponent.hitInterval = inter_14;
				logicComponent.hitDamageId = dicHitID_14;
			}
		});
	}
}
