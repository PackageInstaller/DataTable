using System.Collections;
using TrueSync;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Spawn_Special : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	private static readonly string AreaEffectAlias1 = "fx_common_base_Dark_YuJing_circular_2";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		FuYouJian_Spawn_Special fuYouJian_Spawn_Special = this;
		FuYouJian_Spawn_Special fuYouJian_Spawn_Special2 = this;
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		FP radius = 3;
		FP innerRadius = 2;
		TSVector2 shapeRandomPoint = fuYouJian_Spawn_Special.GetShapeRandomPoint(fuYouJian_Spawn_Special2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
		Teleport(shapeRandomPoint);
		PlayEarlyWarningEffect(AreaEffectAlias1, 0.5f, default, shapeRandomPoint, default, 1f, actorScale: true);
		yield return WaitTime(0.1f);
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitTime(0.4);
		RemoveBuffFromTarget(_actor, 990010040);
		AddBuffToTarget(_actor, 990010050);
		yield return WaitTime(0.03f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
	}
}
