using System;
using System.Collections.Generic;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Battle.Configs;

public class ConfigAbility
{
	public const int LIST_BITS = 8;

	public const int ID_BITS = 24;

	public const int LIST_MASK = -16777216;

	public const int ID_MASK = 16777215;

	public string name;

	public BuffType buffType;

	public uint debuffName;

	public BuffTag buffTag;

	[Tooltip("支持任意字符串标签，用于通用筛选和条件判断")]
	public string[] customTags;

	[NonSerialized]
	private int[] m_CompiledCustomTagIds;

	[NonSerialized]
	private int[] m_CompiledFilterBlockCustomTagIds;

	[NonSerialized]
	private HashSet<int> m_CustomTagIdSet;

	public bool onCasterDieRemove;

	public bool refreshCaster;

	public bool inheritOnChangeCharacter;

	[Tooltip("把OnAdd挂上的Attach特效换到新角色，不重新播放。需要同时保证OnInheritAdd不要再Attach同一条特效，OnInheritRemove不要ReleaseEffect。duration buff建议关闭removeWhenMotionExit。")]
	public bool inheritAttachedEffect;

	public ConfigFunction<float> abilityCooldown = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public FilterEntityType filterBlockEntityType;

	[Tooltip("当目标有这些Ability时，当前Ability不能加到目标身上")]
	public string[] filterBlockAbilities;

	[Tooltip("当目标有这些Tag之一时，当前Ability不能加到目标身上")]
	public BuffTag filterBlockTags;

	[Tooltip("当目标有这些自定义Tag之一时，当前Ability不能加到目标身上")]
	public string[] filterBlockCustomTags;

	public bool showIcon;

	public int iconID;

	public int iconPriority;

	public BuffIconType iconType;

	public int damageDotIconId;

	public TimeScale timeScale;

	public DurationType durationType;

	public DurationMergeType durationMergeType;

	public StackDurationType stackDurationType;

	[Tooltip("可以配置成动态的持续时间")]
	public DynamicFloat fDuration = new DynamicFloat
	{
		source = ParamSource.Const,
		value = -1f
	};

	[FormerlySerializedAs("fprolongDuration")]
	[Tooltip("可以配置成动态的持续时间")]
	public DynamicFloat fProlongDuration;

	[FormerlySerializedAs("imaxStack")]
	public DynamicFloat iMaxStack = new DynamicFloat
	{
		source = ParamSource.Const,
		value = 1f
	};

	public bool prolongByStack;

	public ConfigMixin[] mixins;

	public ConfigAction[] onTriggerAbility;

	public ConfigAction[] OnAdd;

	public ConfigAction[] OnRemove;

	public ConfigAction[] OnAddStack;

	public ConfigAction[] OnRemoveStack;

	public ConfigAction[] OnInit;

	[Tooltip("属性值计算")]
	public ABProperty[] properties;

	[Tooltip("记录在这个ability中的局部变量")]
	public AbilityConst abilityConst;

	public AbilityBlackboardVariable[] blackboardVariables;

	[HideInInspector]
	[Tooltip("技能修改器,对任意技能的属性修改")]
	public ISkillModifier[] skillModifiers;

	[NonSerialized]
	public int id;

	[NonSerialized]
	public List<ConfigAction[]> cachedActions;

	public void GenerateActionList()
	{
		cachedActions = new List<ConfigAction[]>();
		CacheActionList(cachedActions, onTriggerAbility, this);
		CacheActionList(cachedActions, OnAdd, this);
		CacheActionList(cachedActions, OnRemove, this);
		CacheActionList(cachedActions, OnAddStack, this);
		CacheActionList(cachedActions, OnRemoveStack, this);
		CacheActionList(cachedActions, OnInit, this);
		if (mixins == null)
		{
			return;
		}
		for (int i = 0; i < mixins.Length; i++)
		{
			if (mixins[i] == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(name + " has empty mixins!!!!!!!! Fix it now!!!!");
				}
			}
			else
			{
				mixins[i].CacheActionList(cachedActions, this);
			}
		}
	}

	public static void CacheActionList(List<ConfigAction[]> list, ConfigAction[] actions, ConfigAbility ab)
	{
		if (actions != null && actions.Length != 0)
		{
			if (actions[0] != null)
			{
				int count = list.Count;
				actions[0].cacheIndex = count;
			}
			list.Add(actions);
			for (int i = 0; i < actions.Length; i++)
			{
				actions[i]?.CacheActionList(list, ab);
			}
		}
	}

	public (bool, ConfigAction[]) TryGetActions(int index)
	{
		int count = cachedActions.Count;
		for (int i = 0; i < count; i++)
		{
			ConfigAction[] array = cachedActions[i];
			if (array[0].cacheIndex == index)
			{
				return (true, array);
			}
		}
		return (false, null);
	}

	protected void PrecacheList(List<YooAssetReference> toPrecache)
	{
		if (name == "Role_02_01_PushTear" && LuminApplication.LogEnabled)
		{
			Debug.Log("1");
		}
		for (int i = 0; i < cachedActions.Count; i++)
		{
			ConfigAction[] array = cachedActions[i];
			if (array != null)
			{
				for (int j = 0; j < array.Length; j++)
				{
					array[j]?.Precache(toPrecache);
				}
			}
		}
		if (mixins != null)
		{
			for (int k = 0; k < mixins.Length; k++)
			{
				mixins[k]?.Precache(toPrecache);
			}
		}
	}

	public void Precache()
	{
		try
		{
			PrecacheUtility.Preload<YooAssetReference>(PrecacheList);
		}
		catch (AssetNotFoundException)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("ability \"" + name + "\" 需要预加载的某个资源丢失了.上面应该报了资源信息，查一下修一下");
			}
		}
	}

	public void RemoveCache()
	{
		PrecacheUtility.ReleasePreload<YooAssetReference>(PrecacheList);
	}

	public int[] GetCompiledCustomTagIds()
	{
		if (m_CompiledCustomTagIds != null)
		{
			return m_CompiledCustomTagIds;
		}
		if (customTags == null || customTags.Length == 0)
		{
			m_CompiledCustomTagIds = Array.Empty<int>();
			m_CustomTagIdSet = null;
			return m_CompiledCustomTagIds;
		}
		m_CompiledCustomTagIds = AbilityTagRegistry.CompileCustomTagIds(customTags);
		m_CustomTagIdSet = ((m_CompiledCustomTagIds.Length == 0) ? null : new HashSet<int>(m_CompiledCustomTagIds));
		return m_CompiledCustomTagIds;
	}

	public int[] GetCompiledFilterBlockCustomTagIds()
	{
		if (m_CompiledFilterBlockCustomTagIds != null)
		{
			return m_CompiledFilterBlockCustomTagIds;
		}
		if (filterBlockCustomTags == null || filterBlockCustomTags.Length == 0)
		{
			m_CompiledFilterBlockCustomTagIds = Array.Empty<int>();
			return m_CompiledFilterBlockCustomTagIds;
		}
		m_CompiledFilterBlockCustomTagIds = AbilityTagRegistry.CompileCustomTagIds(filterBlockCustomTags);
		return m_CompiledFilterBlockCustomTagIds;
	}

	public bool HasCustomTag(string tag)
	{
		GetCompiledCustomTagIds();
		if (m_CustomTagIdSet == null)
		{
			return false;
		}
		if (!AbilityTagRegistry.TryGetCustomTagId(tag, out var tagId))
		{
			return false;
		}
		return m_CustomTagIdSet.Contains(tagId);
	}

	public void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		if (collector == null)
		{
			return;
		}
		if (cachedActions == null)
		{
			GenerateActionList();
		}
		for (int i = 0; i < cachedActions.Count; i++)
		{
			ConfigAction[] array = cachedActions[i];
			if (array != null)
			{
				for (int j = 0; j < array.Length; j++)
				{
					array[j]?.CollectEffectPrewarm(collector, mapping);
				}
			}
		}
	}

	public void PrewarmCustomTagCache()
	{
		GetCompiledCustomTagIds();
		GetCompiledFilterBlockCustomTagIds();
	}

	public void MigrateLegacyDurationType()
	{
		switch ((int)durationType)
		{
		case 2:
			durationType = DurationType.Duration;
			durationMergeType = DurationMergeType.Refresh;
			break;
		case 3:
			durationType = DurationType.Duration;
			durationMergeType = DurationMergeType.Prolong;
			break;
		case 4:
			durationType = DurationType.Duration;
			durationMergeType = DurationMergeType.Independent;
			break;
		}
	}
}
