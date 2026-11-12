using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_MeleeCombo : SkillSimpleBase
{
	private readonly string[] normalCombos = new string[3] { "Melee1", "Melee2", "Melee3" };

	private readonly string[] phantomCombos = new string[3] { "Melee1_Phantom", "Melee2_Phantom", "Melee3_Phantom" };

	private FP turnTime = 0.4;

	private readonly int[] _order = new int[3] { 0, 1, 2 };

	private bool finished;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!finished)
		{
			ClearOwnerBullet();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		TSVector2 entityPosition = GetEntityPosition(target);
		Skill_MeleeCombo skill_MeleeCombo = this;
		FP radius = 5.5f;
		FP innerRadius = 4;
		DeterministicShape shapeData = skill_MeleeCombo.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 telepos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 8)
		{
			BeginAttack(1, "Teleport", flushInputedKeys: true);
			yield return WaitCustomEvent("TeleportStart");
			Teleport(telepos);
			yield return WaitTime(0.1f);
			BeginLookAt_NotWait(target, 0.2, 1000);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginLookAt_NotWait(target, turnTime, 300);
			yield return WaitTime(turnTime);
		}
		for (int num = _order.Length - 1; num > 0; num--)
		{
			int num2 = TSRandom.Range(0, num + 1);
			ref int reference = ref _order[num];
			ref int reference2 = ref _order[num2];
			int num3 = _order[num2];
			int num4 = _order[num];
			reference = num3;
			reference2 = num4;
		}
		for (int i = 0; i < _order.Length; i++)
		{
			string actionKey = ((i == _order.Length - 1) ? phantomCombos[_order[i]] : normalCombos[_order[i]]);
			int combokey = 1;
			BeginAttack(combokey, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("StartLook");
			BeginLookAt_NotWait(target, 0.4, 480);
			yield return WaitCustomEvent("StopLook");
			StopLookAt();
			yield return WaitCustomEvent("ChangeCombo");
		}
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
