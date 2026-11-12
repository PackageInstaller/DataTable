using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_Fire : SkillSimpleBase
{
	private LogicEntity target;

	private FP distance = 6;

	private List<TSVector2> atkPositionList = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		atkPositionList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(0, "Fire", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		atkPositionList = GainAttackPoint(GetEntityPositionObsoleted(target));
		for (int i = 0; i < atkPositionList.Count; i++)
		{
			PlayAreaEffect("Fire_Area", atkPositionList.get_Item(i));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private List<TSVector2> GainAttackPoint(TSVector2 playerPOS)
	{
		List<TSVector2> list = new List<TSVector2>();
		for (int i = 0; i < 3; i++)
		{
			TSVector2 tSVector = RotateTo(GetForward(), 60 + i * 120);
			for (int j = 0; j < 2; j++)
			{
				TSVector2 tSVector2 = TransLocalPosToWorldPos(playerPOS, RotateTo(tSVector, j * 20 - 10), new TSVector2(0, distance));
				if (QueryPositionReachable(_actor, tSVector2))
				{
					list.Add(tSVector2);
				}
			}
		}
		if (list.Count > 0 && list != null)
		{
			return list;
		}
		list.Add(GetPosition());
		return list;
	}
}
