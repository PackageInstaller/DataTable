using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Lifecycle_ShuFuXianJing : SkillSimpleBase
{
	private string fx_Trap_5m = "fx_m72012_loop_skill3_5mtrap";

	private long Play_Trap_5m;

	private FP warningDuration = 1.5;

	private FP activeDuration = 10;

	private FP detectRadius = 4;

	private FP slowApplyInterval = 0.1;

	private FP slowEnterDelay = 0.3;

	private FP slowAddInterval = 1.5f;

	private int bindTriggerStacks = 3;

	private long _activeAreaEffectId;

	private readonly Dictionary<long, FP> _slowCooldowns = new Dictionary<long, FP>();

	private int _summonLevel;

	private int _slowBuffId;

	private int _bindBuffId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetInvincibleEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_slowBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.slowBuffIds);
		_bindBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.bindBuffIds);
		_activeAreaEffectId = 0L;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_activeAreaEffectId > 0)
		{
			StopAreaEffect(_activeAreaEffectId);
			_activeAreaEffectId = 0L;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		FP elapsed = FP.Zero;
		_slowCooldowns.Clear();
		BeginAttack(1, "SilkTrap", flushInputedKeys: true);
		Skill_Lifecycle_ShuFuXianJing skill_Lifecycle_ShuFuXianJing = this;
		Skill_Lifecycle_ShuFuXianJing skill_Lifecycle_ShuFuXianJing2 = this;
		string fxAlias = fx_Trap_5m;
		TSVector2 position = GetPosition();
		skill_Lifecycle_ShuFuXianJing.Play_Trap_5m = skill_Lifecycle_ShuFuXianJing2.PlayEffect(fxAlias, 1f, default, position);
		yield return WaitTime(0.6f);
		for (; elapsed < activeDuration; elapsed += slowApplyInterval)
		{
			ApplyTrapBuffs(GetTargetsByFaction(isFriend: false));
			yield return WaitTime(slowApplyInterval);
		}
		CancelAttack();
		StopEffect(Play_Trap_5m);
		yield return WaitTime(0.5);
	}

	private void ApplyTrapBuffs(List<LogicEntity> enemyTargets)
	{
		if (enemyTargets == null || enemyTargets.Count == 0)
		{
			return;
		}
		TSVector2 position = GetPosition();
		FP radius = detectRadius;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, enemyTargets);
		List<long> list = new List<long>();
		foreach (long key in _slowCooldowns.Keys)
		{
			bool flag = false;
			for (int i = 0; i < targetsFromShape.Count; i++)
			{
				if (targetsFromShape.get_Item(i) != null && targetsFromShape.get_Item(i).Id == key)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				list.Add(key);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			_slowCooldowns.Remove(list.get_Item(j));
		}
		for (int k = 0; k < targetsFromShape.Count; k++)
		{
			LogicEntity logicEntity = targetsFromShape.get_Item(k);
			if (logicEntity == null || (_bindBuffId > 0 && GetBuffNum(logicEntity, _bindBuffId) > 0))
			{
				continue;
			}
			if (!_slowCooldowns.TryGetValue(logicEntity.Id, out var value))
			{
				_slowCooldowns.set_Item(logicEntity.Id, slowEnterDelay);
			}
			else if (value <= FP.Zero)
			{
				if (_slowBuffId > 0)
				{
					AddBuffToTarget(logicEntity, _slowBuffId);
				}
				_slowCooldowns.set_Item(logicEntity.Id, slowAddInterval);
			}
			else
			{
				_slowCooldowns.set_Item(logicEntity.Id, value - slowApplyInterval);
			}
			if (_bindBuffId > 0 && _slowBuffId > 0 && GetBuffNum(logicEntity, _slowBuffId) >= bindTriggerStacks)
			{
				RemoveBuffFromTarget(logicEntity, _slowBuffId);
				AddBuffToTarget(logicEntity, _bindBuffId);
			}
		}
	}
}
