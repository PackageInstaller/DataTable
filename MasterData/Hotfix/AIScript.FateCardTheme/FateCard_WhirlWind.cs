#define LOG_DEBUG
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_WhirlWind : BaseFateCardTheme
{
	private readonly string commonWindArea = "FateCard_WhirlWind";

	private readonly FP commonCenterDis = 1.5;

	private readonly int hitDamageId = 986041;

	private readonly FP cd = 1.5;

	private readonly string commonWindArea_Diffuse = "FateCard_WhirlWind_q1";

	private readonly int hitDamageId_2 = 986043;

	private readonly string smallWindArea_Arc = "FateCard_WhirlWind_small_q2";

	private readonly int samllDamageId_ProB = 986042;

	private readonly int smallWindArea_count = 5;

	private readonly int samllDamageId_ProC = 986044;

	private List<long> allWindLogicId = new List<long>();

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_WhirlWind OnEnable");
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		allWindLogicId.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_WhirlWind OnTrigger");
		if (!CheckTimeout(cd))
		{
			return;
		}
		LogicEntity logicEntity = CommonUtils.SearchNearTargetByCircle(_actor, 99);
		if (!(logicEntity == null))
		{
			int damageId = hitDamageId;
			if (CanExcuteA)
			{
				damageId = hitDamageId_2;
			}
			ChooseAreaEffect(commonWindArea, logicEntity, isMove: true, damageId, commonCenterDis);
			TriggerTheme();
		}
	}

	private void ChooseAreaEffect(string bulletPath, LogicEntity to, bool isMove = true, int damageId = 0, FP cDis = default(FP))
	{
		string areaEffect = bulletPath;
		bool isDiffuse = false;
		FP cDisMax = 0;
		FP cGrowth = 0;
		FP cInterval = 0;
		if (CanExcuteA)
		{
			isDiffuse = true;
			areaEffect = commonWindArea_Diffuse;
		}
		PlayHit(areaEffect, to, isMove, isSuper: false, damageId, isDiffuse, cDis, cDisMax, cGrowth, cInterval);
	}

	private void PlayHit(string areaEffect, LogicEntity to, bool isMove, bool isSuper, int damageId, bool isDiffuse, FP cDis, FP cDisMax, FP cGrowth, FP cInterval)
	{
		FP angle = (to.tsTransform.Position - _actor.tsTransform.Position).normalized.GetAngle();
		TSVector2 position = _actor.tsTransform.Position;
		if (!isMove)
		{
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				angle = 360,
				radius = 2,
				position = to.tsTransform.Position
			};
			position = _actor.RandomActorReachablePointInsideShape(shape);
		}
		long num = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, position, angle, (AreaEffectEntity entity) =>
		{
			entity.duration = 3;
			AreaEffect_MoveComponent logicComponent = entity.GetLogicComponent<AreaEffect_MoveComponent>();
			if (logicComponent != null)
			{
				logicComponent.speed = 5;
			}
			AreaEffect_PullComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_PullComponent>();
			if (logicComponent2 != null)
			{
				logicComponent2.strength = 0;
			}
			AreaEffect_AttackComponent logicComponent3 = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent3 != null)
			{
				logicComponent3.hitInterval = 0.5;
				if (damageId != 0)
				{
					logicComponent3.hitDamageId = damageId;
				}
			}
			if (!isMove && logicComponent != null)
			{
				logicComponent.speed = 0;
			}
		});
		if (num != 0L)
		{
			allWindLogicId.Add(num);
		}
	}

	private void PlaySmallHit(LogicEntity wind)
	{
		TSVector2 position = wind.tsTransform.Position;
		for (int i = 0; i < smallWindArea_count; i++)
		{
			FP fP = 0;
			fP = wind.tsTransform.Forward.GetAngle() + i * 90 + TSRandom.Range(-30, 30);
			ILRuntimeAPI.PlayAreaEffect(_actor, smallWindArea_Arc, position, fP, (AreaEffectEntity entity) =>
			{
				entity.GetLogicComponent<AreaEffect_AttackComponent>().hitDamageId = (CanExcuteC ? samllDamageId_ProC : samllDamageId_ProB);
			});
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent { entityID: var entityID } adventureAreaEffectFinishEvent && CanExcuteB && allWindLogicId.Contains(entityID))
		{
			PlaySmallHit(adventureAreaEffectFinishEvent.sender as LogicEntity);
		}
	}
}
