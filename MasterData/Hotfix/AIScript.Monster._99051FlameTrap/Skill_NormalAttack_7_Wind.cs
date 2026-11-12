using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Trap;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._99051FlameTrap;

public class Skill_NormalAttack_7_Wind : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private List<DeterministicCollider> _pullEntityList;

	private List<LogicEntity> _pushTarget;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		TSVector2 position = GetPosition() + TSVector2.Rotate(new TSVector2(0, 3.5f), _actor.tsTransform.Rotation);
		Skill_NormalAttack_7_Wind skill_NormalAttack_7_Wind = this;
		FP width = 6.8f;
		FP length = 1.6;
		FP rotation = 0;
		DeterministicShape selfshape = skill_NormalAttack_7_Wind.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		yield return WaitTime(2.6);
		TSVector2 pushaim = GetPosition() + TSVector2.Rotate(new TSVector2(0, 10), _actor.tsTransform.Rotation);
		float time = 5.6f;
		while (time > 0f)
		{
			_pushTarget = GetTargetsFromShape(selfshape);
			time -= 0.1f;
			Push(_pushTarget, pushaim);
			yield return WaitTime(0.1);
		}
		yield return WaitTime(0.1);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Push(List<LogicEntity> _pushtarget, TSVector2 pushaim)
	{
		if (_pushtarget != null)
		{
			ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, pushaim, _pushTarget, 0.3f, 3, 4, 99, isPull: true, withRadius: true, isCoExist: true, isChangeForward: false);
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
