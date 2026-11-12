using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._72011;

public class Skill_Main_1 : SkillAdvancedBase
{
	private readonly string comboTag = "SoldierSkill";

	private readonly FP spawnInterval = 5;

	private readonly string areaEffectKey = "AreaEffect_72011_Skill5_Soldier";

	private const int BUFF_ID_DMG_UP = 100515011;

	private const int BUFF_ID_DMG_UP_OTHER = 100515021;

	private readonly FP buffSwitchTime = 90;

	private FP _spawnTimer;

	private FP _elapsedTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_spawnTimer = 0;
		_elapsedTime = 0;
	}

	public void OnStart()
	{
		_spawnTimer = spawnInterval;
		_elapsedTime = 0;
		string actionTag = comboTag;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	public void OnUpdate()
	{
		_elapsedTime += _actor.LogicDeltaTime;
		_spawnTimer -= _actor.LogicDeltaTime;
		if (!(_spawnTimer > 0))
		{
			SpawnAreaAndStackBuff();
			_spawnTimer = spawnInterval;
		}
	}

	private void SpawnAreaAndStackBuff()
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, _actor.tsTransform.Position);
		if (!(_actor.buffComponent == null))
		{
			int num = ((_elapsedTime < buffSwitchTime) ? 100515011 : 100515021);
			if (num != 0)
			{
				_actor.buffComponent.AddBuff(num, _actor);
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_spawnTimer = 0;
		_elapsedTime = 0;
	}
}
