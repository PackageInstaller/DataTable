using System;
using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BilliardGameSpellManager
{
	public static BilliardGameSpellManager Instance;

	private static string SpellBasePath = "BilliardGame/Spell/Spell/Spell_{0}";

	private static string BuffBasePath = "BilliardGame/Spell/Buff/Buff_{0}";

	private Dictionary<int, SpellConfig> spellCfg;

	private Dictionary<int, BuffConfig> buffCfg;

	public void Init()
	{
		spellCfg = new Dictionary<int, SpellConfig>();
		buffCfg = new Dictionary<int, BuffConfig>();
		Instance = this;
	}

	public SpellConfig LoadSpell(int spellId)
	{
		if (spellCfg.ContainsKey(spellId))
		{
			return spellCfg[spellId];
		}
		SpellConfig spellConfig = Asset.Load<SpellConfig>(string.Format(SpellBasePath, spellId));
		spellCfg.Add(spellId, spellConfig);
		return spellConfig;
	}

	public BuffConfig GetBuffConfig(int buffID)
	{
		BuffConfig buffConfig = null;
		if (!buffCfg.ContainsKey(buffID))
		{
			buffConfig = Asset.Load<BuffConfig>(string.Format(BuffBasePath, buffID));
			if (buffConfig == null)
			{
				Debug.LogError($"未找到id为{buffID}的buff");
				return null;
			}
			buffCfg.Add(buffID, buffConfig);
		}
		else
		{
			buffConfig = buffCfg[buffID];
		}
		return buffConfig;
	}

	public void CastSpell<T>(int spellId, T caster) where T : BilliardGameEntityBase
	{
		AnylizeSpell(spellId);
		SpellConfig spellConfig = spellCfg[spellId];
		CastBuff(spellConfig.BuffId, caster);
	}

	public BTEnv CastBuff<T>(int buffId, T caster, int level = 1) where T : BilliardGameEntityBase
	{
		if (buffId == 0)
		{
			return null;
		}
		BuffConfig buffConfig = null;
		if (!buffCfg.ContainsKey(buffId))
		{
			buffConfig = Asset.Load<BuffConfig>(string.Format(BuffBasePath, buffId));
			if (buffConfig == null)
			{
				Debug.LogError($"未找到id为{buffId}的buff");
				return null;
			}
			buffCfg.Add(buffId, buffConfig);
		}
		else
		{
			buffConfig = buffCfg[buffId];
		}
		BTEnv buff = caster.GetBuff(buffId);
		if (buff != null)
		{
			int num = 0;
			if (buff.ContainKey("level"))
			{
				num = buff.GetStruct<int>("level");
			}
			num += level;
			num = Math.Min(buffConfig.maxLevel, num);
			buff.AddStruct("level", num);
			buff.AddStruct("Turn", buffConfig.turn);
			return buff;
		}
		BTEnv bTEnv = BTEnv.Create(buffConfig);
		bTEnv.AddPlayer("Caster", (BilliardGameEntityBase)caster, true);
		bTEnv.AddStruct("BuffId", buffConfig.effectId, isPersistent: true);
		bTEnv.AddStruct("BuffExecuteMode", buffConfig.buffExecuteMode, isPersistent: true);
		bTEnv.AddStruct("BuffResetMode", buffConfig.buffResetMode, isPersistent: true);
		bTEnv.AddStruct("BuffDisposeMode", buffConfig.buffDisposeMode, isPersistent: true);
		bTEnv.AddStruct("level", level, isPersistent: true);
		bTEnv.AddStruct("Turn", buffConfig.turn, isPersistent: true);
		bTEnv.AddObject("Effect", buffConfig, isPersistent: true);
		if (buffConfig.buffExecuteMode == BuffExecuteMode.TickTime)
		{
			bTEnv.AddStruct("BuffTickTime", buffConfig.TickTime, isPersistent: true);
			bTEnv.AddStruct("BuffTickTimeLastStartTime", 0f, isPersistent: true);
			bTEnv.AddStruct("BuffTickTimeDisposeTime", buffConfig.Duration, isPersistent: true);
		}
		if (caster is EntityPlayer)
		{
			(caster as EntityPlayer).AddBuff(bTEnv);
		}
		else if (caster is EntityEnemy)
		{
			if (buffConfig.buffExecuteMode == BuffExecuteMode.EnemyAction)
			{
				(caster as EntityEnemy).AddEnemyStateBuff(bTEnv);
			}
			else if (buffConfig.buffExecuteMode != BuffExecuteMode.Enemy)
			{
				(caster as EntityEnemy).AddBuff(bTEnv);
			}
		}
		if (buffConfig.buffExecuteMode == BuffExecuteMode.Immediate || buffConfig.buffExecuteMode == BuffExecuteMode.Persistent)
		{
			bTEnv.Run();
		}
		return bTEnv;
	}

	private void AnylizeSpell(int spellId)
	{
		if (!spellCfg.ContainsKey(spellId))
		{
			SpellConfig spellConfig = Asset.Load<SpellConfig>(string.Format(SpellBasePath, spellId));
			spellCfg.Add(spellId, spellConfig);
			int buffId = spellConfig.BuffId;
			BuffConfig buffConfig = null;
			if (!buffCfg.ContainsKey(buffId))
			{
				buffConfig = Asset.Load<BuffConfig>(string.Format(BuffBasePath, buffId));
				buffCfg.Add(buffId, buffConfig);
			}
			if (!buffCfg.ContainsKey(buffId))
			{
				BuffConfig value = Asset.Load<BuffConfig>(string.Format(BuffBasePath, buffId));
				buffCfg.Add(buffId, value);
			}
		}
	}

	public void Dispose()
	{
		Instance = null;
	}
}
