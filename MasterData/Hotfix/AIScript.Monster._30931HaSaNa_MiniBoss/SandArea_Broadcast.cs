using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class SandArea_Broadcast : SkillSimpleBase
{
	private readonly string fxKey_AreaHit = "fx_30931JiGuanZhuangZhi_base_attack_6x15";

	private readonly FP duration_AreaHit = 3.2;

	private readonly int hitDamageId_AreaHit = 30931183;

	private readonly string hittedFxKey_AreaHit = "fx_common_hit_earth_magic";

	private readonly FP hitInterval_AreaHit = 0.03;

	private readonly FP innerSideLength_AreaHit = 0;

	private readonly FP outerSideLength_AreaHit_Length = 0.84;

	private readonly FP outerSideLength_AreaHit_Width = 0.336;

	private readonly FP changeSideLength_AreaHit_Length = 0.204;

	private readonly FP changeSideLength_AreaHit_Width = 0.0816;

	private readonly FP AreaPlaybackSpeed = 1.25f;

	protected override IEnumerator DoMainLogic()
	{
		SandArea_Broadcast sandArea_Broadcast = this;
		TSVector2 position = GetPosition();
		sandArea_Broadcast.PlayEffect("fx_m30931_base_area_6x15_end", 1f, default, position);
		yield return WaitTime(0.3);
		PlayEffect(fxKey_AreaHit, position: GetPosition(), playbackSpeed: AreaPlaybackSpeed.AsFloat());
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
			length = outerSideLength_AreaHit_Length,
			width = outerSideLength_AreaHit_Width,
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
				innerShape.length += changeSideLength_AreaHit_Length * AreaPlaybackSpeed;
				innerShape.width += changeSideLength_AreaHit_Width * AreaPlaybackSpeed;
				outerShape.length += changeSideLength_AreaHit_Length * AreaPlaybackSpeed;
				outerShape.width += changeSideLength_AreaHit_Width * AreaPlaybackSpeed;
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
				if (GetBuffNum(item3, 309010300) == 0)
				{
					DirectHeal(item3, (int)((double)adventureActor.actorHealthInfo.hpMax * 0.5), showHud: true);
					AddBuffToTarget(item3, 309310000);
				}
				AddBuffToTarget(item3, 309010300);
				continue;
			}
			break;
		}
	}
}
