using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_Shui;

public class Skill_TrapWater_LD : SkillSimpleBase
{
	private static LogicEntity target;

	private static readonly int ActionIndex = 0;

	private static readonly string ActionKey = "RayWater";

	private readonly int INTRAngle = 5;

	private List<TSVector2> _targetPOS = new List<TSVector2>();

	private List<long> _AreaFx = new List<long>();

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		_targetPOS.Clear();
		_AreaFx.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		_targetPOS.AddRange(GetAttackPos());
		for (int i = 0; i < _targetPOS.Count; i++)
		{
			_AreaFx.Add(PlayAreaEffect("ShaYuFaShi_WaterArea_MiniBoss", _targetPOS.get_Item(i)));
		}
		_AreaFx.Add(PlayAreaEffect("ShaYuFaShi_WaterArea_MiniBoss", GetEntityPositionObsoleted(GetCurrentPlayer())));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			return GetAttackTarget();
		}
		return GetCurrentPlayer();
	}

	private List<TSVector2> GetAttackPos()
	{
		List<TSVector2> list = new List<TSVector2>();
		TSVector2 entityForward = GetEntityForward(target);
		FP fP = 360 / INTRAngle;
		for (int i = 0; i < INTRAngle; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(GetEntityPositionObsoleted(GetCurrentPlayer()), RotateTo(entityForward, fP * i), new TSVector2(0, 8));
			if (QueryPositionReachable(_actor, position))
			{
				list.Add(TransLocalPosToWorldPos(GetEntityPositionObsoleted(GetCurrentPlayer()), RotateTo(entityForward, fP * i), new TSVector2(0, 8)));
			}
		}
		return list;
	}
}
