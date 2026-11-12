#define LOG_ERROR
using System;
using System.Collections.Generic;
using System.Reflection;
using Nova.Hotfix;
using TrueSync;

public class BuffEffectManager : Singleton<BuffEffectManager>
{
	private List<BuffEffectBase> BuffEffects = new List<BuffEffectBase>(10);

	private Dictionary<HotfixEnum.BuffEffectType, Type> _buffEffectDict = new Dictionary<HotfixEnum.BuffEffectType, Type>
	{
		[HotfixEnum.BuffEffectType.OnceDoT] = typeof(BuffEffect_OnceDot),
		[HotfixEnum.BuffEffectType.NormalDoT] = typeof(BuffEffect_NormalDot)
	};

	private BuffEffectBase GetBuffEffect(HotfixEnum.BuffEffectType effectType)
	{
		if (_buffEffectDict.TryGetValue(effectType, out var value))
		{
			return (BuffEffectBase)Activator.CreateInstance(value);
		}
		return null;
	}

	public void AddBuffEffect(AdventureActor fromActor, AdventureActor owner, BuffEntity _buffEntity, int id, int buffUid)
	{
		if (owner == null)
		{
			NovaLogger.Error("BuffEffect.._owner ==null");
			return;
		}
		if (fromActor == null)
		{
			NovaLogger.Error("BuffEffect.._fromActor ==null");
			return;
		}
		BuffEffect buffEffect = Singleton<HotfixDataController>.Instance.GetBuffEffect(id);
		if (buffEffect == null)
		{
			NovaLogger.Error("BuffEffect..buffEffectConfig ==null..id==" + id);
			return;
		}
		FP? fP = _buffEntity?.LeftTime;
		FP fP2 = 0;
		if (fP.HasValue && fP.GetValueOrDefault() <= fP2 && buffEffect.BuffEffectType == 1)
		{
			NovaLogger.Error("BuffEffect time<=0++buffid==" + _buffEntity.buffConfig.Id);
			return;
		}
		BuffEffectBase buffEffect2 = GetBuffEffect((HotfixEnum.BuffEffectType)buffEffect.BuffEffectType);
		if (buffEffect2 == null)
		{
			return;
		}
		if (buffEffect.BuffEffectType == 1 && _buffEntity.buffValueConfig.TimeSuperposition != 2)
		{
			NovaLogger.Error("BuffEffect时间叠加方式错误=" + _buffEntity.buffConfig.Id);
		}
		if (BuffEffects.Count > 0 && buffEffect.BuffEffectType == 1)
		{
			for (int i = 0; i < BuffEffects.Count; i++)
			{
				if (BuffEffects.get_Item(i) is BuffEffect_OnceDot buffEffect_OnceDot && BuffEntityEq(buffEffect_OnceDot.buffEntity, _buffEntity) && buffEffect_OnceDot.buffEntity != null && buffEffect_OnceDot.buffEntity.buffValueConfig.Id == _buffEntity.buffValueConfig.Id)
				{
					long exceptDamage = buffEffect_OnceDot.GetExceptDamage();
					if (exceptDamage > 0)
					{
						(buffEffect2 as BuffEffect_OnceDot).SetExceptDamage(exceptDamage);
						buffEffect_OnceDot.OnEnd();
						BuffEffects.RemoveAt(i);
						break;
					}
				}
			}
		}
		BuffEffects.Add(buffEffect2);
		buffEffect2.OnInit(owner, fromActor, _buffEntity, buffEffect, buffUid);
	}

	public void RemoveBuffEffectByUid(int uid)
	{
		List<BuffEffectBase> buffEffects = BuffEffects;
		if (buffEffects == null || buffEffects.Count <= 0)
		{
			return;
		}
		for (int num = BuffEffects.Count - 1; num > -1; num--)
		{
			if (!(BuffEffects.get_Item(num) is BuffEffect_OnceDot) && BuffEffects.get_Item(num).BuffUid == uid)
			{
				BuffEffects.get_Item(num).OnEnd();
				BuffEffects.RemoveAt(num);
			}
		}
	}

	public void RemoveBuffEffect(BuffEntity BuffEn)
	{
		List<BuffEffectBase> buffEffects = BuffEffects;
		if (buffEffects == null || buffEffects.Count <= 0)
		{
			return;
		}
		for (int num = BuffEffects.Count - 1; num > -1; num--)
		{
			BuffEffectBase buffEffectBase = BuffEffects.get_Item(num);
			if (IsStale(buffEffectBase) || BuffEntityEq(buffEffectBase.buffEntity, BuffEn))
			{
				buffEffectBase?.OnEnd();
				BuffEffects.RemoveAt(num);
			}
		}
	}

	public void Clear()
	{
		if (BuffEffects != null)
		{
			for (int num = BuffEffects.Count - 1; num > -1; num--)
			{
				BuffEffects.get_Item(num)?.OnEnd();
			}
			BuffEffects.Clear();
		}
	}

	public void RefreshOnceDot(BuffEntity _buffEntity, bool iRestart = false)
	{
		List<BuffEffectBase> buffEffects = BuffEffects;
		if (buffEffects == null || buffEffects.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < BuffEffects.Count; i++)
		{
			if (BuffEffects.get_Item(i) is BuffEffect_OnceDot buffEffect_OnceDot && BuffEntityEq(buffEffect_OnceDot.buffEntity, _buffEntity) && buffEffect_OnceDot.buffEntity != null && buffEffect_OnceDot.buffEntity.buffValueConfig.Id == _buffEntity.buffValueConfig.Id)
			{
				if (!iRestart)
				{
					buffEffect_OnceDot.PreCalculateEnd();
				}
				else
				{
					buffEffect_OnceDot.Restart();
				}
				break;
			}
		}
	}

	private bool BuffEntityEq(BuffEntity a, BuffEntity b)
	{
		if (a == null || b == null)
		{
			return false;
		}
		if (a.InPool || b.InPool)
		{
			return false;
		}
		int uid = a.GetUid();
		if (uid != 0)
		{
			return uid == b.GetUid();
		}
		return false;
	}

	private static bool IsStale(BuffEffectBase effect)
	{
		if (effect != null)
		{
			if (effect.buffEntity != null)
			{
				return effect.buffEntity.InPool;
			}
			return false;
		}
		return true;
	}

	public BuffEffectBase CreateBuffEffect(HotfixEnum.BuffEffectType effectType)
	{
		if (_buffEffectDict.TryGetValue(effectType, out var value))
		{
			return (BuffEffectBase)Activator.CreateInstance(value);
		}
		return null;
	}

	private void InitBuffEffectDict()
	{
		_buffEffectDict = new Dictionary<HotfixEnum.BuffEffectType, Type>();
		Type[] types = Assembly.GetExecutingAssembly().GetTypes();
		Type typeFromHandle = typeof(BuffEffectBase);
		foreach (Type type in types)
		{
			Type baseType = type.BaseType;
			if (baseType != null && baseType == typeFromHandle)
			{
				BuffEffectAttribute attribute = GetAttribute(type);
				if (attribute != null)
				{
					_buffEffectDict.Add(attribute.BuffEffectType, type);
				}
			}
		}
	}

	private BuffEffectAttribute GetAttribute(Type type)
	{
		object[] customAttributes = type.GetCustomAttributes(typeof(BuffEffectAttribute), inherit: true);
		if (customAttributes.Length == 0)
		{
			return null;
		}
		return customAttributes[0] as BuffEffectAttribute;
	}
}
