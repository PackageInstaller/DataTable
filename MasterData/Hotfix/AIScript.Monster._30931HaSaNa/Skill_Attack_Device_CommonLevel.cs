using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Attack_Device_CommonLevel : SkillSimpleBase
{
	private readonly string fxKey_AreaHit = "fx_30931JiGuanZhuangZhi_base_attack";

	private readonly FP duration_AreaHit = 3.2;

	private readonly int hitDamageId_AreaHit = 30931182;

	private readonly string hittedFxKey_AreaHit = "fx_common_hit_earth_magic";

	private readonly FP hitInterval_AreaHit = 0.03;

	private readonly FP innerSideLength_AreaHit = 0;

	private readonly FP outerSideLength_AreaHit = 0.7;

	private readonly FP changeSideLength_AreaHit = 0.17;

	private readonly FP AreaPlaybackSpeed = 1.25f;

	protected override IEnumerator DoMainLogic()
	{
		Skill_Attack_Device_CommonLevel skill_Attack_Device_CommonLevel = this;
		TSVector2 position = GetPosition();
		skill_Attack_Device_CommonLevel.PlayEffect("ZhuangZhiYuJing", 0.75f, default, position);
		yield return WaitTime(0.3);
		PlayEffect(fxKey_AreaHit, position: GetPosition(), playbackSpeed: (float)AreaPlaybackSpeed);
		FP duration = duration_AreaHit;
		FP hitInterval = hitInterval_AreaHit;
		DeterministicShape innerShape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Rectangle,
			length = innerSideLength_AreaHit,
			width = innerSideLength_AreaHit,
			position = _actor.tsTransform.Position
		};
		DeterministicShape outerShape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Rectangle,
			length = outerSideLength_AreaHit,
			width = outerSideLength_AreaHit,
			position = _actor.tsTransform.Position
		};
		RectangleRingHit(innerShape, outerShape);
		while (duration > 0)
		{
			if (hitInterval > 0)
			{
				hitInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				innerShape.length += changeSideLength_AreaHit * AreaPlaybackSpeed;
				innerShape.width += changeSideLength_AreaHit * AreaPlaybackSpeed;
				outerShape.length += changeSideLength_AreaHit * AreaPlaybackSpeed;
				outerShape.width += changeSideLength_AreaHit * AreaPlaybackSpeed;
				RectangleRingHit(innerShape, outerShape);
				hitInterval = hitInterval_AreaHit;
			}
			duration -= _actor.LogicDeltaTime;
			yield return null;
		}
	}

	private void RectangleRingHit(DeterministicShape innerShape, DeterministicShape outerShape)
	{
		if (outerShape.shapeType != DeterministicShape.ShapeType.Rectangle || !(outerShape.length > 0) || !(outerShape.width > 0))
		{
			return;
		}
		List<LogicEntity> targetsFromShape = ILRuntimeAPI.GetTargetsFromShape(outerShape);
		if (targetsFromShape != null && targetsFromShape.Count > 0 && innerShape.shapeType == DeterministicShape.ShapeType.Rectangle && innerShape.length > 0 && innerShape.width > 0)
		{
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShapeForPoint(list, innerShape, 256);
			if (list.Count > 0)
			{
				List<LogicEntity> list2 = new List<LogicEntity>();
				foreach (DeterministicCollider item in list)
				{
					list2.Add(item.Entity);
				}
				if (list2 != null && list2.Count > 0)
				{
					foreach (LogicEntity item2 in list2)
					{
						targetsFromShape.Remove(item2);
					}
				}
			}
		}
		if (targetsFromShape == null || targetsFromShape.Count <= 0)
		{
			return;
		}
		foreach (LogicEntity item3 in targetsFromShape)
		{
			AdventureActor adventureActor = item3 as AdventureActor;
			if (_actor.IsConfrontWith(item3))
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId_AreaHit, hittedFxKey_AreaHit);
				continue;
			}
			if (GetMonsterTagValue(adventureActor, 3) == "HaSaNa")
			{
				if (GetBuffNum(item3, 309010300) == 0 && CheckTargetIsValid(item3))
				{
					DirectHeal(item3, (int)((double)adventureActor.actorHealthInfo.hpMax * 0.3), showHud: true);
					AddBuffToTarget(item3, 309010100);
					PlayEffect("ZhuangZhiRestore", 1f, position: GetEntityPosition(item3), fxPositionY: 1.5f);
				}
				AddBuffToTarget(item3, 309010300);
				continue;
			}
			if (GetMonsterTagValue(adventureActor, 3) == "Guard" && CheckTargetIsValid(item3))
			{
				if (GetBuffNum(adventureActor, 309010300) == 0)
				{
					DirectDamage(adventureActor, (int)((double)adventureActor.actorHealthInfo.hpMax * 0.1), null);
					AddBuffToTarget(item3, 309010200);
					RemoveBuffFromTarget(item3, 170210010);
					PlayEffect("fx_common_hit_earth_magic", 1f, position: GetEntityPosition(item3), fxPositionY: 1.5f);
				}
				AddBuffToTarget(adventureActor, 309010300);
				continue;
			}
			break;
		}
	}
}
