using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13701;

public static class CommonHelper_137
{
	public static void TryFireGrenade(AdventureActor actor)
	{
		if (CommonUtils.HavePersonalPerk(actor.dataID, 513702, out var _))
		{
			ILRuntimeAPI.Shoot(targetPosition: (!(actor.attackTarget != null)) ? (actor.tsTransform.Position + actor.tsTransform.Forward * Config_MainControl.grenadeNoTargetDistance_513702) : ILRuntimeAPI.GetRandomPointInShape(actor, CommonUtils.GetDeterministicCircleShape(Config_MainControl.grenadeScatterRadius_513702, 0, actor.attackTarget.tsTransform.Position), isReachable: false), bulletAlias: "Bullet_137_P2_ShouLei", actor: actor, range: default, position: actor.tsTransform.Position, positionY: actor.dtCollider.HeightCenter, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
		}
	}

	public static void TryTriggerWindMark(AdventureActor actor, LogicEntity target)
	{
		if (target is MonsterAdventureActor monsterAdventureActor && CommonUtils.CheckElementMark(CommonDefine.Wind, monsterAdventureActor) && CommonUtils.CheckTriggerElementMarkCD(actor, monsterAdventureActor))
		{
			monsterAdventureActor.buffComponent.RemoveBuffByTag(CommonDefine.Wind);
			TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = Config_MainControl.randomRadius_AreaEffect_513707_TriggerWindMark,
				radius = Config_MainControl.randomRadius_AreaEffect_513707_TriggerWindMark,
				position = monsterAdventureActor.tsTransform.Position
			}, isReachable: false);
			ILRuntimeAPI.PlayAreaEffect(actor, "AreaEffect_137_WindMark1_Bloom", randomPointInShape);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Wind, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType2, actor, monsterAdventureActor, "WindMark_Trigger_Effect_01");
		}
	}
}
