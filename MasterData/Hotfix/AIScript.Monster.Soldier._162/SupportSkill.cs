using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._162;

public class SupportSkill : SkillAdvancedBase
{
	private const string comboTag = "SupportSkill";

	private const string eventName_Area = "Area";

	private const string areaEffectKey = "AreaEffect";

	private const int loopTimes = 4;

	private const int spawnCountPerArea = 3;

	private static readonly FP spawnRadius = 3;

	private const string eventName_Fire_Potential2 = "162P23JianQi";

	private static readonly List<TSVector2> fireDirections_Potential2 = new List<TSVector2>
	{
		new TSVector2(0, 1),
		new TSVector2(1, 0),
		new TSVector2(0, -1),
		new TSVector2(-1, 0),
		new TSVector2(-1, 1),
		new TSVector2(-1, -1),
		new TSVector2(1, 1),
		new TSVector2(1, -1)
	};

	private static readonly List<string> bulletKeyList_Potential2 = new List<string> { "Bullet_SupSkill_JianQi_P1_Heng_Soldier", "Bullet_SupSkill_JianQi_P1_Shu_Soldier", "Bullet_SupSkill_JianQi_P1_Zuo_Soldier", "Bullet_SupSkill_JianQi_P1_You_Soldier" };

	private static readonly FP bulletRange_Potential2 = 0;

	private const int extraLoopTimes_Potential3 = 2;

	private const string bulletKey_Potential3 = "Bullet_SupSkill_JianQi_Big_P2_Soldier";

	private int _loopTimes;

	private int _totalLoopTimes;

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTimes = 0;
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_totalLoopTimes = 4;
		if (_potentialLv >= 3)
		{
			_totalLoopTimes += 2;
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_loopTimes = 0;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_loopTimes++;
		if (_loopTimes >= _totalLoopTimes)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Area"))
		{
			OnAreaEvent();
		}
		else if (_potentialLv >= 2 && string.Equals(eventName, "162P23JianQi"))
		{
			OnFireEvent_Potential2();
		}
	}

	private void OnAreaEvent()
	{
		TSVector2 position = _actor.tsTransform.Position;
		for (int i = 0; i < 3; i++)
		{
			TSVector2 scatterPoint = GetScatterPoint(position, i, 3);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect", scatterPoint);
		}
	}

	private void OnFireEvent_Potential2()
	{
		if (fireDirections_Potential2.Count == 0)
		{
			return;
		}
		int index = TSRandom.Range(0, fireDirections_Potential2.Count);
		string bulletAlias;
		if (_potentialLv >= 3)
		{
			bulletAlias = "Bullet_SupSkill_JianQi_Big_P2_Soldier";
		}
		else
		{
			if (bulletKeyList_Potential2.Count == 0)
			{
				return;
			}
			bulletAlias = bulletKeyList_Potential2.get_Item(TSRandom.Range(0, bulletKeyList_Potential2.Count));
		}
		TSVector2 tSVector = fireDirections_Potential2.get_Item(index);
		TSVector2 normalized = (_actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y).normalized;
		if (!(normalized.LengthSquared() <= FP.Epsilon))
		{
			TSVector2 position = _actor.tsTransform.Position;
			ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, bulletRange_Potential2, normalized, position);
		}
	}

	private static TSVector2 GetScatterPoint(TSVector2 center, int index, int count)
	{
		if (count <= 1)
		{
			return center;
		}
		FP fP = (FP)360 / (FP)count;
		FP degrees = fP * index + TSRandom.value * fP;
		FP fP2 = spawnRadius * (1 + TSRandom.value) / 2;
		return center + TSVector2.Rotate(new TSVector2(0, 1), degrees) * fP2;
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
