using System;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinContinueEffect : BaseAbilityMixin
{
	private ConfigMixinContinueEffect m_Config;

	public bool toRemove;

	private float timer;

	private int arrayIndex;

	private int arrayLength;

	private float intervalTime;

	private float[] intervalTimeArray;

	private int maxCount = int.MaxValue;

	private int curCount;

	private ActionMemory memory;

	public AbilityMixinContinueEffect(ConfigMixinContinueEffect config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinContinueEffect)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		toRemove = false;
		timer = 0f;
		arrayIndex = 0;
		arrayLength = 0;
		intervalTime = 0f;
		maxCount = int.MaxValue;
		curCount = 0;
		memory = default;
		if (intervalTimeArray != null)
		{
			Array.Clear(intervalTimeArray, 0, intervalTimeArray.Length);
		}
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		if (!owner.IsAlive() || !owner.IsLogicAvailable())
		{
			return;
		}
		if (m_Config.removeMotion != null)
		{
			CompMotion compMotion = owner.GetCompMotion();
			MotionState[] removeMotion = m_Config.removeMotion;
			foreach (MotionState motionState in removeMotion)
			{
				if (compMotion.curMotionState == motionState)
				{
					toRemove = true;
					ability.RemoveStack(ability.stack);
					return;
				}
			}
		}
		if (toRemove)
		{
			return;
		}
		timer -= owner.GetCompTime().fixedDeltaTime;
		if (!(timer < 0f) || curCount >= maxCount)
		{
			return;
		}
		if (arrayLength != 0)
		{
			timer = intervalTimeArray[arrayIndex++ % arrayLength];
			for (int j = 0; j < arrayLength; j++)
			{
				intervalTimeArray[j] = m_Config.intervalFunctionArray[j].Return(memory);
			}
		}
		else
		{
			timer += intervalTime;
		}
		if (m_Config.OnContinueHit != null)
		{
			DoActions(owner, null, m_Config.OnContinueHit);
		}
		curCount++;
	}

	internal override void OnAdd()
	{
		arrayLength = (arrayIndex = 0);
		if (m_Config.intervalFunction != null)
		{
			memory = new ActionMemory(caster, owner, owner, null, ability);
			intervalTime = (m_Config.intervalTime = m_Config.intervalFunction.Return(memory));
			if (m_Config.intervalFunctionArray != null)
			{
				arrayLength = m_Config.intervalFunctionArray.Length;
				if (arrayLength > 0 && (intervalTimeArray == null || intervalTimeArray.Length < arrayLength))
				{
					intervalTimeArray = new float[arrayLength];
				}
				for (int i = 0; i < arrayLength; i++)
				{
					intervalTimeArray[i] = m_Config.intervalFunctionArray[i].Return(memory);
				}
			}
		}
		timer = (m_Config.firstDoNeedIntervalTime ? intervalTime : 0f);
		owner.GetCompAbility().onDie += new Action<Entity>(OnDie);
		curCount = 0;
		if (m_Config.maxCount != null)
		{
			maxCount = (int)m_Config.maxCount.Return(memory);
		}
		else
		{
			maxCount = int.MaxValue;
		}
	}

	internal override void OnRemove()
	{
		RemoveDieListener();
		if (!toRemove && owner.IsAlive())
		{
			Ability ability = base.ability;
			if (ability == null || !ability.casterDieRemove || m_Config.casterDieRemoveDo)
			{
				DoActions(owner, null, m_Config.toRemoveActions);
			}
		}
	}

	private void RemoveDieListener()
	{
		if (owner.TryGetCompAbility(out CompAbility component))
		{
			component.onDie -= new Action<Entity>(OnDie);
		}
	}

	private void OnDie(Entity entityBehave)
	{
		if (m_Config.onDieActions != null)
		{
			DoActions(entityBehave, null, m_Config.onDieActions);
		}
	}
}
