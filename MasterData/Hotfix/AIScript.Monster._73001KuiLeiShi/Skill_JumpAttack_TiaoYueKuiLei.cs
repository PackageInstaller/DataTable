using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_JumpAttack_TiaoYueKuiLei : SkillSimpleBase
{
	private const string warningAlias = "fx_warning_circular_2";

	private FP targetRandomRadius = 4;

	private FP warningTime = 1.7;

	private FP jumpStagger = 0.6;

	private const string combo_JumpAttack = "JumpAttack";

	private FP damageImmuneDuration = 0.1;

	protected override IEnumerator DoMainLogic()
	{
		while (!GetLogicTagToggleValue(_actor, Common_73001.PuppetSync_Tag))
		{
			yield return null;
		}
		int num = (int)(long)GetLogicTagFpValue(_actor, Common_73001.PuppetSeqIndex_Tag);
		yield return WaitTime(jumpStagger * num);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		Skill_JumpAttack_TiaoYueKuiLei skill_JumpAttack_TiaoYueKuiLei = this;
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		FP radius = targetRandomRadius;
		DeterministicShape shapeData = skill_JumpAttack_TiaoYueKuiLei.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius);
		TSVector2 landPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		BeginLookAtByPos(landPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(landPos, landPos - GetPosition(), new TSVector2(0, 2.3));
		Skill_JumpAttack_TiaoYueKuiLei skill_JumpAttack_TiaoYueKuiLei2 = this;
		float duration = (float)warningTime;
		TSVector2 position = tSVector;
		skill_JumpAttack_TiaoYueKuiLei2.PlayEarlyWarningEffect("fx_warning_circular_2", duration, default, position, default, 1.7f);
		BeginAttack(1, "JumpAttack", flushInputedKeys: true);
		yield return WaitCustomEvent("JumpStart");
		FP fP = Distance(GetPosition(), landPos);
		yield return CrossJump(landPos, fP / 0.4, 0.4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
