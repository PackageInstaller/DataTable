using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._145;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] comboTag = new ComboInputBuffer.ActionKey[3];

	private const string areaEffectKey = "AreaEffect_Soldier_145_MainSkill";

	private const int triggerPercent = 30;

	private const int triggerPercent_Potential3 = 60;

	private static readonly FP areaDistanceMin = 3;

	private static readonly FP areaDistanceMax = 6;

	private const int sectorCount = 4;

	private int _potentialLv;

	private const string logicTag_SectorIndex = "145_NormalArea_Sector";

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		ComboInputBuffer.ActionKey[] keys = comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		if (!(_actor.buffComponent == null) && _actor.buffComponent.CheckBuffByBuffID(250105301))
		{
			int num = ((_potentialLv < 3) ? 30 : 60);
			if (TSRandom.Range(0, 100) < num)
			{
				PlayNearSideAreaEffect();
			}
		}
	}

	private void PlayNearSideAreaEffect()
	{
		TSVector2 tSVector = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		int num = _actor.logicVariable.GetLogicTagValue("145_NormalArea_Sector").AsInt();
		TSVector2 nearSidePoint = SupportSkill.GetNearSidePoint(_actor, tSVector, areaDistanceMin, areaDistanceMax, SupportSkill.nearSideHalfSpreadAngle, num, 4);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_145_MainSkill", nearSidePoint, (tSVector - nearSidePoint).GetAngle());
		_actor.logicVariable.SetLogicTagValue("145_NormalArea_Sector", (num + 1) % 4);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
