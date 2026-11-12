using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72014KuiLeiShiTi;

public class Skill_QuanTiQiangHua : SkillSimpleBase
{
	private const int qiangHuaBuffId = 720140130;

	private const string combo_Buff = "Buff";

	private readonly FP rotateBackTime = 0.3;

	private readonly FP anticipationTime = 0.4;

	private FP _initialRotation;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_initialRotation = GetRotation();
	}

	protected override IEnumerator DoMainLogic()
	{
		List<LogicEntity> targetByDataID = GetTargetByDataID(1900705);
		List<LogicEntity> targetByDataID2 = GetTargetByDataID(1900706);
		bool num = targetByDataID != null && targetByDataID.Count > 0;
		bool flag = targetByDataID2 != null && targetByDataID2.Count > 0;
		if (num || flag)
		{
			yield return StartCor(RotateToInitial(rotateBackTime));
			BeginAttack(1, "Buff", flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(anticipationTime);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			EnhanceByDataId(1900705);
			EnhanceByDataId(1900706);
		}
	}

	private IEnumerator RotateToInitial(FP duration)
	{
		FP startRotation = GetRotation();
		FP delta;
		for (delta = _initialRotation - startRotation; delta > 180; delta -= (FP)360)
		{
		}
		for (; delta < -180; delta += (FP)360)
		{
		}
		FP elapsed = 0;
		while (elapsed < duration)
		{
			elapsed += LockStepManager.deltaTime;
			FP fP = elapsed / duration;
			if (fP > 1)
			{
				fP = 1;
			}
			_actor.tsTransform.Rotation = startRotation + delta * fP;
			yield return null;
		}
		_actor.tsTransform.Rotation = _initialRotation;
	}

	private void EnhanceByDataId(int monsterDataId)
	{
		List<LogicEntity> targetByDataID = GetTargetByDataID(monsterDataId);
		if (targetByDataID == null || targetByDataID.Count == 0)
		{
			return;
		}
		for (int i = 0; i < targetByDataID.Count; i++)
		{
			LogicEntity logicEntity = targetByDataID.get_Item(i);
			if (!(logicEntity == null))
			{
				AddBuffToTarget(logicEntity, 720140130);
			}
		}
	}
}
