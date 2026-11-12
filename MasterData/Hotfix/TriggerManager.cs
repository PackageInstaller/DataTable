#define LOG_DEBUG
using System.Collections.Generic;
using UnityEngine;

public class TriggerManager : Singleton<TriggerManager>
{
	public enum ConditionType
	{
		[InspectorName("碰撞事件")]
		conditionCollider,
		[InspectorName("刷怪容器状态")]
		conditionSpawnMonster,
		[InspectorName("收到交互指令")]
		conditionOperate,
		[InspectorName("角色进入退出战斗状态")]
		conditionAttackState,
		[InspectorName("敌对怪物进入Action状态")]
		conditionMonsterActionState,
		[InspectorName("指定怪物死亡")]
		conditionSpecifyMonsterDeath,
		[InspectorName("怪物状态变化")]
		conditionSpecifyMonsterState,
		[InspectorName("关卡场景加载完毕")]
		conditionLevelLoadComplete,
		[InspectorName("关卡结束")]
		conditionLevelFinish,
		[InspectorName("关卡计数器")]
		conditionLevelCounter,
		[InspectorName("怪物HP变化")]
		conditionMonsterHp,
		[InspectorName("战斗开始后延时触发（强敌挑战专用）")]
		conditionDelayTimeWhenBattleStart,
		[InspectorName("指定Tag的怪物死亡")]
		conditionMonsterDeathByTag,
		[InspectorName("指定气泡对话播放结束")]
		conditionBubbleDialogEnd
	}

	public enum triggerState
	{
		active,
		deActive,
		pause,
		destroy,
		none
	}

	public enum colliderType
	{
		[InspectorName("角色")]
		playerSelf,
		[InspectorName("任意怪物")]
		enemy,
		[InspectorName("任意对象")]
		all
	}

	public Dictionary<string, AdventureFXPlayer> triggerFxs = new Dictionary<string, AdventureFXPlayer>();

	private readonly Dictionary<string, AIAdapter> _triggerAIDict = new Dictionary<string, AIAdapter>();

	public List<TriggerCom> triggerComps { get; protected set; } = new List<TriggerCom>(30);

	public void InitTriggerComps()
	{
		TriggerCom[] array = Object.FindObjectsOfType<TriggerCom>();
		foreach (TriggerCom triggerCom in array)
		{
			if (triggerCom.isActiveAndEnabled)
			{
				triggerComps.Add(triggerCom);
			}
		}
	}

	public void AddTriggerFx(string tag, AdventureFXPlayer fx)
	{
		if (!(fx == null))
		{
			if (string.IsNullOrEmpty(tag))
			{
				tag = fx.token.ToString();
			}
			if (!triggerFxs.ContainsKey(tag))
			{
				triggerFxs.Add(tag, fx);
				return;
			}
			triggerFxs.Add(fx.token.ToString(), fx);
			NovaLogger.Debug("特效标签== trigger repeat Fx Tag==" + tag);
		}
	}

	public void DeletTriggerFx(string tag)
	{
		if (!string.IsNullOrEmpty(tag) && triggerFxs.ContainsKey(tag))
		{
			triggerFxs.get_Item(tag).Stop();
			triggerFxs.Remove(tag);
		}
	}

	public void SetTrigger(TriggerCom triggerComp, bool iAdd)
	{
		if (null == triggerComp)
		{
			return;
		}
		if (iAdd)
		{
			triggerComp.InitializeXY(-1, -1);
			triggerComp.Initialize(-1, -1);
			if (!triggerComps.Contains(triggerComp))
			{
				triggerComps.Add(triggerComp);
			}
		}
		else
		{
			triggerComps.Remove(triggerComp);
		}
	}

	public void AddTriggers(TriggerCom[] triggerComps, int x, int y)
	{
		if (triggerComps != null)
		{
			foreach (TriggerCom obj in triggerComps)
			{
				obj.InitializeXY(x, y);
				obj.Initialize(x, y);
			}
			this.triggerComps.AddRange(triggerComps);
		}
	}

	public void SetTriggerSateByGroup(string groupTitle, triggerState state)
	{
		if (string.IsNullOrEmpty(groupTitle))
		{
			return;
		}
		for (int i = 0; i < triggerComps.Count; i++)
		{
			if (triggerComps.get_Item(i).CheckGroup(groupTitle))
			{
				triggerComps.get_Item(i).SetTriggerState(state);
			}
		}
	}

	public void StartTriggerAI(string aiTypeString)
	{
		if (_triggerAIDict.TryGetValue(aiTypeString, out var value))
		{
			value.Stop();
			value.Disable();
			value.Start();
		}
		else if (!string.IsNullOrEmpty(aiTypeString))
		{
			AIAdapter aIAdapter = new AIAdapter();
			if (aIAdapter.Initialize(aiTypeString, ModuleController<AdventureModuleController>.Instance.gameObject))
			{
				_triggerAIDict.set_Item(aiTypeString, aIAdapter);
				aIAdapter.Start();
			}
		}
	}

	public void DisableTriggerAI(string aiTypeString)
	{
		if (_triggerAIDict.TryGetValue(aiTypeString, out var value))
		{
			value.Stop();
			value.Disable();
		}
		else
		{
			Debug.LogError("触发器中配置关闭了一个不存在的AI脚本：" + aiTypeString);
		}
	}

	public void LogicUpdate()
	{
		foreach (AIAdapter value in _triggerAIDict.Values)
		{
			value.Update();
		}
	}

	public void ClearTrigger()
	{
		foreach (AdventureFXPlayer value in triggerFxs.Values)
		{
			value.Stop();
		}
		triggerFxs.Clear();
		foreach (AIAdapter value2 in _triggerAIDict.Values)
		{
			value2.Stop();
			value2.Disable();
		}
		_triggerAIDict.Clear();
	}
}
